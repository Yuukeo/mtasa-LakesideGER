--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function openADui()
	if(isLoggedin())then
		if(not isPedDead(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				setWindowData("add","cursor_clicked",true)
				dgsSetInputMode("no_binds")
				dgsSetInputMode("no_binds_when_editing")
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-450/2,GLOBALscreenY/2-260/2,450,260,settings.general.servername.." - Werbung",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,settings.general.guibgcolor,nil,true)
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
				
				dgsCreateLabel(10,10,390,60,"Hier hast du die Möglichkeit, eine Werbung zu schalten, welche für alle Spieler\nim öffentlichen Chat einsehbar sein wird. Der Grundpreis einer\nWerbung beträgt "..settings.general.adnormalprice.."$, für jeden Buchstaben zahlst du 2$. Falls du\ndeine Werbung hervorheben möchtest, kannst du dies für einen\nGrundpreis von "..settings.general.adspecialprice.."$ tun.",false,Lakeside.Window[1])
				
				dgsCreateLabel(10,100,100,10,"Text:",false,Lakeside.Window[1])
				Lakeside.Edit[1]=dgsCreateEdit(5,115,440,35,"",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
				
				Lakeside.Button[2]=dgsCreateButton(5,155,440,35,"Werbung normal",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[3]=dgsCreateButton(5,195,440,35,"Werbung hervorgehoben",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[3],
					function(btn,state)
						if(btn=="left" and state=="up")then
							local text=dgsGetText(Lakeside.Edit[1])
							local costs=#dgsGetText(Lakeside.Edit[1])*2
							
							if(#dgsGetText(Lakeside.Edit[1])>=3)then
								triggerServerEvent("write:ad",lp,text,"special",costs)
								dgsCloseWindow(Lakeside.Window[1])
								setWindowData("remove","cursor_clicked",true)
							end
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[2],
					function(btn,state)
						if(btn=="left" and state=="up")then
							local text=dgsGetText(Lakeside.Edit[1])
							local costs=#dgsGetText(Lakeside.Edit[1])*2
							
							if(#dgsGetText(Lakeside.Edit[1])>=3)then
								triggerServerEvent("write:ad",lp,text,"normal",costs)
								dgsCloseWindow(Lakeside.Window[1])
								setWindowData("remove","cursor_clicked",true)
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
addCommandHandler("ad",openADui)
addCommandHandler("werbung",openADui)