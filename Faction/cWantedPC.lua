--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local wantedReason={
	--1
	{"Körperverletzung",1},
	{"Beleidigung",1},
	{"Verweigerung zur Durchsuchung",1},
	{"Beamtenbehinderung",1},
	{"Drogenbesitz (10-49)",1},
	{"Versuchter Diebstahl",1},
	{"Sachbeschädigung",1},
	{"illegale Werbung",1},
	{"Waffennutzung",1},
	{"Drogenkonsum",1},
	{"Fahren ohne Führerschein",1},
	--2
	{"Flucht vor/aus Kontrolle",2},
	{"Beihilfe zur Flucht",2},
	{"Schusswaffen gebrauch",2},
	{"Bestechungsversuch",2},
	{"Diebstahl",2},
	{"Erpressung/Drohung",2},
	{"Drogen Anbau/Abbau",2},
	{"Drogenbesitz (50-149)",2},
	{"ATM Raub",2},
	--3
	{"Drogenbesitz (150+)",3},
	{"Mord",3},
	--4
	{"Geiselnahme",4},
	{"Sniper-Nutzung",4},
	{"Weedtruck",4},
	{"Matstruck",4},
	--6
	{"Raketenwerfer-Nutzung",6},
}
local stvoReason={
	{"Burnout",1},
	{"Falschparken",1},
	{"Gefährlicher Eingriff in den Straßenverkehr",1},
	{"Halten und/oder Parken auf der Straße",1},
	{"Sachbeschädigung von Objekten",2},
	{"Missachtung der Vorfahrtsregeln",2},
	{"Missachtung von Fahrverboten",3},
	{"Fluggerät auf der Straße landen",3},
	{"Verursachen eines Unfalls",4},
	{"Fahren abseits der Straße",4},
	{"Verwendung von NOS (Nitro)",4},
	{"Rasen innerhalb der Stadt (ab 100 km/h)",5},
	{"An- und Überfahren von Passanten",6},
	{"Geisterfahrten",6},
}

addEvent("open:wantedpc",true)
addEventHandler("open:wantedpc",root,function()
	if(isLoggedin())then
		local veh=getPedOccupiedVehicle(lp)
		local id=getElementModel(veh)
		if(id==597 or id==596 or id==490 or id==528)then
			if(getElementData(lp,"ElementClicked")==false)then
				if(not isElement(Lakeside.Window[1]))then
					setWindowData("add","cursor_clicked",true)
					dgsSetInputMode("no_binds")
					dgsSetInputMode("no_binds_when_editing")
					Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-880/2,GLOBALscreenY/2-600/2,880,600,settings.general.servername.." - Wanted PC",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,settings.general.guibgcolor,nil,true)
					dgsWindowSetSizable(Lakeside.Window[1],false)
					dgsWindowSetMovable(Lakeside.Window[1],false)
					Lakeside.Button[1]=dgsCreateButton(854,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
					dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
					dgsCreateImage(0,0,880,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
					Lakeside.Blurbox[1]=dgsCreateBlurBox()
					dgsSetProperty(Lakeside.Window[1],"functions",[[
						local arguments = {...}
						local blurbox = arguments[1]
						local renderArguments = renderArguments
						local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
						dgsBlurBoxRender(blurbox,x,y,w,h)
					]],Lakeside.Blurbox[1])
					
					Lakeside.Gridlist[1]=dgsCreateGridList(5,7,270,560,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
					Lakeside.ScrollBar[1]=dgsGridListGetScrollBar(Lakeside.Gridlist[1])
					dgsSetProperty(Lakeside.ScrollBar[1],"troughColor",tocolor(50,50,50,255))
					dgsSetProperty(Lakeside.ScrollBar[1],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
					dgsSetProperty(Lakeside.Gridlist[1],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
					players=dgsGridListAddColumn(Lakeside.Gridlist[1],"Spieler",0.62)
					wanteds=dgsGridListAddColumn(Lakeside.Gridlist[1],"Wanteds",0.2)
					
					Lakeside.Gridlist[2]=dgsCreateGridList(280,7,295,470,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
					Lakeside.ScrollBar[2]=dgsGridListGetScrollBar(Lakeside.Gridlist[2])
					dgsSetProperty(Lakeside.ScrollBar[2],"troughColor",tocolor(50,50,50,255))
					dgsSetProperty(Lakeside.ScrollBar[2],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
					dgsSetProperty(Lakeside.Gridlist[2],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
					wantedss=dgsGridListAddColumn(Lakeside.Gridlist[2],"Wanteds",0.25)
					reason=dgsGridListAddColumn(Lakeside.Gridlist[2],"Grund",0.7)
					
					Lakeside.Gridlist[3]=dgsCreateGridList(580,7,295,470,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
					Lakeside.ScrollBar[3]=dgsGridListGetScrollBar(Lakeside.Gridlist[2])
					dgsSetProperty(Lakeside.ScrollBar[3],"troughColor",tocolor(50,50,50,255))
					dgsSetProperty(Lakeside.ScrollBar[3],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
					dgsSetProperty(Lakeside.Gridlist[3],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
					stvos=dgsGridListAddColumn(Lakeside.Gridlist[3],"StVO",0.15)
					stvoreason=dgsGridListAddColumn(Lakeside.Gridlist[3],"Grund",0.74)
					
					Lakeside.Button[2]=dgsCreateButton(280,480,160,40,"Wanted(s) geben",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[3]=dgsCreateButton(280,525,160,40,"Wanted(s) löschen  [R3+]",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[4]=dgsCreateButton(445,480,160,40,"StVO(s) geben",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[5]=dgsCreateButton(445,525,160,40,"Spieler orten",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					Lakeside.Radio[1]=dgsCreateRadioButton(700,485,11,11,"Autoschein",false,Lakeside.Window[1])
					Lakeside.Radio[2]=dgsCreateRadioButton(700,505,11,11,"Motorradschein",false,Lakeside.Window[1])
					
					
					if(getElementData(lp,"Factionrank")>=3)then
						dgsSetEnabled(Lakeside.Button[3],true)
					else
						dgsSetEnabled(Lakeside.Button[3],false)
					end
					
					
					for _,v in pairs(getElementsByType("player"))do
						if(isLoggedin(v))then
							local row=dgsGridListAddRow(Lakeside.Gridlist[1])
							dgsGridListSetItemText(Lakeside.Gridlist[1],row,players,getPlayerName(v),false,false)
							dgsGridListSetItemText(Lakeside.Gridlist[1],row,wanteds,tonumber(getElementData(v,"Wanteds")),false,false)
						end
					end
					
					for i,_ in ipairs(wantedReason)do
						local row=dgsGridListAddRow(Lakeside.Gridlist[2])
						dgsGridListSetItemText(Lakeside.Gridlist[2],row,wantedss,wantedReason[i][2],false,false)
						dgsGridListSetItemText(Lakeside.Gridlist[2],row,reason,wantedReason[i][1],false,false)
					end
					for i,_ in ipairs(stvoReason)do
						local row=dgsGridListAddRow(Lakeside.Gridlist[3])
						dgsGridListSetItemText(Lakeside.Gridlist[3],row,stvos,stvoReason[i][2],false,false)
						dgsGridListSetItemText(Lakeside.Gridlist[3],row,stvoreason,stvoReason[i][1],false,false)
					end
					
					--dgsGridListSetSortColumn(Lakeside.Gridlist[1],1)
					dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
					dgsGridListSetSortEnabled(Lakeside.Gridlist[2],false)
					dgsGridListSetSortEnabled(Lakeside.Gridlist[3],false)
					dgsRadioButtonSetSelected(Lakeside.Radio[1],true)
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[5],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
								if(item>0)then
									local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
									if(clicked~="")then
										triggerServerEvent("locate:player",lp,clicked)
									end
								end
							end
						end,
					false)
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[4],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
								if(item>0)then
									local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
									if(clicked~="")then
										local item2=dgsGridListGetSelectedItem(Lakeside.Gridlist[3])
										if(item2>0)then
											local reason=dgsGridListGetItemText(Lakeside.Gridlist[3],dgsGridListGetSelectedItem(Lakeside.Gridlist[3]),2)
											if(reason~="")then
												local item3=dgsGridListGetSelectedItem(Lakeside.Gridlist[3])
												if(item3>0)then
													local amount=dgsGridListGetItemText(Lakeside.Gridlist[3],dgsGridListGetSelectedItem(Lakeside.Gridlist[3]),1)
													if(amount~="")then
														if(dgsRadioButtonGetSelected(Lakeside.Radio[1]))then
															license="Car"
														elseif(dgsRadioButtonGetSelected(Lakeside.Radio[2]))then
															license="Bike"
														end
														triggerServerEvent("give:stvos",lp,clicked,reason,amount,license)
													end
												end
											end
										end
									end
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[3],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
								if(item>0)then
									local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
									if(clicked~="")then
										triggerServerEvent("delete:wanteds",lp,clicked)
									end
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[2],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
								if(item>0)then
									local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
									if(clicked~="")then
										local item2=dgsGridListGetSelectedItem(Lakeside.Gridlist[2])
										if(item2>0)then
											local reason=dgsGridListGetItemText(Lakeside.Gridlist[2],dgsGridListGetSelectedItem(Lakeside.Gridlist[2]),2)
											if(reason~="")then
												local item3=dgsGridListGetSelectedItem(Lakeside.Gridlist[2])
												if(item3>0)then
													local amount=dgsGridListGetItemText(Lakeside.Gridlist[2],dgsGridListGetSelectedItem(Lakeside.Gridlist[2]),1)
													if(amount~="")then
														triggerServerEvent("give:wanteds",lp,clicked,reason,amount)
													end
												end
											end
										end
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

addEvent("create:locateblip",true)
addEventHandler("create:locateblip",root,function(target)
	if(isElement(locateBlip))then
		locateBlip:destroy()
	end
	if(not locateTimer)then
		locateBlip=createBlipAttachedTo(target,0,2,255,0,200)
		locateTimer=setTimer(function()
			locateBlip:destroy()
			locateTimer:destroy()
		end,25*1000,1)
		triggerEvent("draw:infobox",lp,"info","Spieler '"..getPlayerName(target).."' wurde für 25sek. geortet!")
	else
		triggerEvent("draw:infobox",lp,"error","Du kannst einen Spieler nur\nalle 25 Sekunden orten!")
	end
end)