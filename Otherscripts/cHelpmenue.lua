--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local helpmenueText={
	["Willkommen"]="Willkommen auf "..settings.general.servername..".\nEine neue Generation unter Deutschen Reallife Servern.",
	["Binds/Commands"]="Binds:\n\n'M' - Um den Mauszeiger zu öffnen\n'I' - Um Das Inventar/den Kofferraum zu öffnen\n'F' - Um Hanf zu ernten\n'T' - Um in den Local chat zu schreiben\n',' - Um Privat/Fraktionsfahrzeuge zu/abzuschliessen\n'.' - Um dein Fahrzeug zu parken\n'X'(halten) - Um ein Fahrzeug zu starten\n'RALT'(halten) - Um über ein Fahrzeug Infos zu sehen\n'Z' - Um dich an/abzuschnallen\n'U' - Um dein Handy zu öffnen(wenn du es besitzt)\n'F3' - Um das Fraktionsmenü zu öffnen\n'F4' - Um das Unternehmensmenü zu öffnen\n'F7' - Um das Animationsmenü zu öffnen\n'Numpad_1' - Um den Linkenblinker zu nutzen\n'Numpad_2' - Um den Warnblinker zu nutzen\n'Numpad_3' - Um den Rechtenblinker zu nutzen\n\nCommands:\n'/park' - Um dein Privatfahrzeug zu parken\n'/me' - Um in den me Chat zu schreiben\n'/mv' oder '/gate' - Um Fraktionstore zu öffnen\n'/fpark' - Um ein Fraktionsfahrzeug zu parken\n'/settings' - Um das Einstellungesfenster zu öffnen",
	["Daten"]="Teamspeak IP: "..settings.general.teamspeakip.."\n\nForum URL: "..settings.general.forumurl.."",
}
local standartHelpmenuTXT="Hilfemenü von "..settings.general.servername..""

local function deleteAllUIItems()
	if(isElement(Lakeside.Button[2]))then
		Lakeside.Button[2]:destroy()
	end
	if(isElement(Lakeside.Button[3]))then
		Lakeside.Button[3]:destroy()
	end
	if(isElement(Lakeside.Button[4]))then
		Lakeside.Button[4]:destroy()
	end
end

bindKey("f1","down",function()
	if(isLoggedin())then
		if(not isPedDead(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				triggerServerEvent("set:task",lp,lp,"OpenHelpmenue")
				setWindowData("add","cursor_clicked",true)
				dgsSetInputMode("no_binds")
				dgsSetInputMode("no_binds_when_editing")
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-600/2,GLOBALscreenY/2-460/2,600,460,settings.general.servername.." - Hilfemenü",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,settings.general.guibgcolor,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(574,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,600,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=dgsCreateBlurBox()
				dgsSetProperty(Lakeside.Window[1],"functions",[[
					local arguments = {...}
					local blurbox = arguments[1]
					local renderArguments = renderArguments
					local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
					dgsBlurBoxRender(blurbox,x,y,w,h)
				]],Lakeside.Blurbox[1])
				
				Lakeside.Gridlist[1]=dgsCreateGridList(5,7,205,422,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
				Lakeside.ScrollBar[1]=dgsGridListGetScrollBar(Lakeside.Gridlist[1])
				dgsSetProperty(Lakeside.ScrollBar[1],"troughColor",tocolor(50,50,50,255))
				dgsSetProperty(Lakeside.ScrollBar[1],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
				dgsSetProperty(Lakeside.Gridlist[1],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
				local category=dgsGridListAddColumn(Lakeside.Gridlist[1],"category",0.9)
				local grid1=dgsGridListAddRow(Lakeside.Gridlist[1],"Willkommen")
				local grid2=dgsGridListAddRow(Lakeside.Gridlist[1],"Binds/Commands")
				local grid3=dgsGridListAddRow(Lakeside.Gridlist[1],"Daten")
				
				Lakeside.Label[1]=dgsCreateLabel(220,15,160,200,standartHelpmenuTXT,false,Lakeside.Window[1])
				
				
				dgsGridListSetItemText(Lakeside.Gridlist[1],grid1,category,"Willkommen")
				dgsGridListSetItemText(Lakeside.Gridlist[1],grid2,category,"Binds/Commands")
				dgsGridListSetItemText(Lakeside.Gridlist[1],grid3,category,"Daten")
				
				dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
				
				addEventHandler("onDgsMouseClick",Lakeside.Gridlist[1],
					function(btn,state)
						if(btn=="left" and state=="up")then
							local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
								if(helpmenueText[clicked])then
									dgsSetText(Lakeside.Label[1],helpmenueText[clicked])
									if(item==grid3)then
										deleteAllUIItems()
										Lakeside.Button[2]=dgsCreateButton(490,10,100,20,"Kopieren",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
										Lakeside.Button[3]=dgsCreateButton(490,40,100,20,"Kopieren",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
										addEventHandler("onDgsMouseClick",Lakeside.Button[2],
											function(btn,state)
												if(btn=="left" and state=="up")then
													setClipboard(settings.general.teamspeakip)
												end
											end,
										false)
										addEventHandler("onDgsMouseClick",Lakeside.Button[3],
											function(btn,state)
												if(btn=="left" and state=="up")then
													setClipboard(settings.general.forumurl)
												end
											end,
										false)
									else
										deleteAllUIItems()
									end
								end
							else
								dgsSetText(Lakeside.Label[1],standartHelpmenuTXT)
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
end)