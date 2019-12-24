--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("open:reportUI",true)
addEventHandler("open:reportUI",root,function()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			if(not isElement(Lakeside.Window[1]))then
				setWindowData("add","cursor_clicked",true)
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-450/2,GLOBALscreenY/2-300/2,450,300,settings.general.servername.." - Reporthalle",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,settings.general.guibgcolor,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(424,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,450,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=dgsCreateBlurBox()
				dgsSetProperty(Lakeside.Window[1],"functions",[[
					local arguments = {...}
					local blurbox = arguments[1]
					local renderArguments = renderArguments
					local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
					dgsBlurBoxRender(blurbox,x,y,w,h)
				]],Lakeside.Blurbox[1])
				
				dgsCreateLabel(10,20,200,60,"Willkommen in der "..settings.general.servername.." Reporthalle.\nWenn du Hilfe benötigst, klicke auf 'Hilfe anfordern' .\n\nAnsonsten wünschen wir dir Viel Spaß auf "..settings.general.servername.." Reallife.\n\n\nINFO: Fragen über das Script werden nicht beantwortet.",false,Lakeside.Window[1])
				
				Lakeside.Button[2]=dgsCreateButton(5,175,440,45,"Hilfe anfordern",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[3]=dgsCreateButton(5,225,440,45,"Reporthalle verlassen",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[3],
					function(btn,state)
						if btn=="left" and state=="up" then
							dgsCloseWindow(Lakeside.Window[1])
							setWindowData("remove","cursor_clicked",true)
							triggerServerEvent("reporthalle:leave",lp,lp)
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[2],
					function(btn,state)
						if btn=="left" and state=="up" then
							dgsCloseWindow(Lakeside.Window[1])
							setWindowData("remove","cursor_clicked",true)
							triggerServerEvent("reporthalle:hilfe",lp,lp)
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
end)