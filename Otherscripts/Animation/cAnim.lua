--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local animationListTable={
	"Händehoch",
	"Winken",
	"Fuck you",
	"Lachen",
	"Etwas zeigen",
	"Arme verschränken",
	"Masturbieren",
	"Tanzen orientalisch",
	"Tanzen chillig",
	"Tanzen rhythmisch",
	"Tanzen wild",
	"Tanzen HipHop",
	"Tanzen sexy",
	"Tanzen nuttig",
	"Tanzen strip 1",
	"Tanzen strip 2",
}

bindKey("f7","down",function()
	if(isLoggedin())then
		if(not isPedDead(lp))then
			if(not isPedInVehicle(lp))then
				if(getElementData(lp,"ElementClicked")==false)then
					setWindowData("add","cursor_clicked",true)
					Lakeside.Window[1]=dgsCreateWindow(20,GLOBALscreenY/2-400/2,300,400,settings.general.servername.." - Animationmenü",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,settings.general.guibgcolor,nil,true)
					dgsWindowSetSizable(Lakeside.Window[1],false)
					dgsWindowSetMovable(Lakeside.Window[1],false)
					Lakeside.Button[1]=dgsCreateButton(274,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
					dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
					dgsCreateImage(0,0,300,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
					Lakeside.Blurbox[1]=dgsCreateBlurBox()
					dgsSetProperty(Lakeside.Window[1],"functions",[[
						local arguments = {...}
						local blurbox = arguments[1]
						local renderArguments = renderArguments
						local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
						dgsBlurBoxRender(blurbox,x,y,w,h)
					]],Lakeside.Blurbox[1])
					
					dgsCreateLabel(5,5,100,10,"Doppelklick auf eine Animation zum starten.\nDrücke 'Leertaste' zum stoppen.",false,Lakeside.Window[1])
					
					Lakeside.Gridlist[1]=dgsCreateGridList(5,40,290,330,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
					Lakeside.ScrollBar[1]=dgsGridListGetScrollBar(Lakeside.Gridlist[1])
					dgsSetProperty(Lakeside.ScrollBar[1],"troughColor",tocolor(50,50,50,255))
					dgsSetProperty(Lakeside.ScrollBar[1],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
					dgsSetProperty(Lakeside.Gridlist[1],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
					local anim=dgsGridListAddColumn(Lakeside.Gridlist[1],"Animation",0.95)
					
					for i,_ in pairs(animationListTable)do
						local row=dgsGridListAddRow(Lakeside.Gridlist[1])
						dgsGridListSetItemText(Lakeside.Gridlist[1],row,anim,animationListTable[i],false,false)
					end
					
					
					dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
					
					
					addEventHandler("onDgsMouseDoubleClick",Lakeside.Gridlist[1],
						function(btn,state)
							if(btn=="left" and state=="up")then
								local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
								if(item>0)then
									local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
									if(clicked~="")then
										triggerServerEvent("start:animation",lp,clicked)
									end
								end
							end
						end,
					false)
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[1],
						function(btn,state)
							if(btn=="left" and state=="up")then
								dgsCloseWindow(Lakeside.Window[1])
								setWindowData("remove","cursor_clicked",true)
							end
						end,
					false)
				end
			end
		end
	end
end)