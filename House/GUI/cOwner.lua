--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("open:houseowner",true)
addEventHandler("open:houseowner",root,function()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			setWindowData("add","cursor_clicked",true)
			if(isElement(Lakeside.Window[1]))then
				Lakeside.Window[1]:destroy()
			end
			Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-300/2,GLOBALscreenY/2-300/2,300,300,settings.general.servername.." - Hausmenü",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,settings.general.guibgcolor,nil,true)
			dgsWindowSetSizable(Lakeside.Window[1],false)
			dgsWindowSetMovable(Lakeside.Window[1],false)
			Lakeside.Button[1]=dgsCreateButton(274,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,180),true)
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
			
			Lakeside.Button[2]=dgsCreateButton(5,235,135,35,"Haus betreten",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[3]=dgsCreateButton(160,235,135,35,"Haus verkaufen",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[4]=dgsCreateButton(5,195,135,35,"Türe Auf/Abschliessen",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			local house=getElementData(lp,"house")
			id=getElementData(house,"ID")
			owner=getElementData(house,"Owner")
			locked=getElementData(house,"State")
			price=getElementData(house,"Price")
			
			
			if(locked=="true")then
				locked="Offen"
			elseif(locked=="false")then
				locked="Abgeschlossen"
			end
			
			
			dgsCreateLabel(10,10,200,40,"Hausnummer: "..id,false,Lakeside.Window[1])
			dgsCreateLabel(10,40,200,40,"Besitzer: "..owner,false,Lakeside.Window[1])
			dgsCreateLabel(10,70,200,40,"Hauspreis: $"..price,false,Lakeside.Window[1])
			dgsCreateLabel(10,100,200,40,"Türe: "..locked,false,Lakeside.Window[1])
			
			addEventHandler("onDgsMouseClick",Lakeside.Button[4],
				function(btn,state)
					if(btn=="left" and state=="down")then
						dgsCloseWindow(Lakeside.Window[1])
						setWindowData("remove","cursor_clicked",true)
						triggerServerEvent("unlock_lock:house",lp,lp)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[3],
				function(btn,state)
					if(btn=="left" and state=="down")then
						dgsCloseWindow(Lakeside.Window[1])
						setWindowData("remove","cursor_clicked",true)
						triggerServerEvent("sell:house",lp,lp)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[2],
				function(btn,state)
					if(btn=="left" and state=="down")then
						dgsCloseWindow(Lakeside.Window[1])
						setWindowData("remove","cursor_clicked",true)
						triggerServerEvent("enter:house",lp,lp)
					end
				end,
			false)
			
			addEventHandler("onDgsMouseClick",Lakeside.Button[1],
				function(btn,state)
					if(btn=="left" and state=="down")then
						dgsCloseWindow(Lakeside.Window[1])
						setWindowData("remove","cursor_clicked",true)
					end
				end,
			false)
		end
	end
end)