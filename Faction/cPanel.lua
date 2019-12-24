--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

bindKey("f3","down",function()
	if(isLoggedin())then
		if(not isPedDead(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				if(getElementData(lp,"Faction")~=0)then
					setWindowData("add","cursor_clicked",true)
					Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-500/2,GLOBALscreenY/2-380/2,500,380,settings.general.servername.." - Fraktionsmenü ("..settings.faction.ranknames.levelnames[tonumber(getElementData(lp,"Faction"))]..")",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,settings.general.guibgcolor,nil,true)
					dgsWindowSetSizable(Lakeside.Window[1],false)
					dgsWindowSetMovable(Lakeside.Window[1],false)
					Lakeside.Button[1]=dgsCreateButton(474,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
					dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
					dgsCreateImage(0,0,500,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
					Lakeside.Blurbox[1]=dgsCreateBlurBox()
					dgsSetProperty(Lakeside.Window[1],"functions",[[
						local arguments = {...}
						local blurbox = arguments[1]
						local renderArguments = renderArguments
						local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
						dgsBlurBoxRender(blurbox,x,y,w,h)
					]],Lakeside.Blurbox[1])
					
					Lakeside.Tabpanel[1]=dgsCreateTabPanel(10,10,480,335,false,Lakeside.Window[1])
					Lakeside.Tab[1]=dgsCreateTab("Mitglieder",Lakeside.Tabpanel[1])
					
					Lakeside.Gridlist[1]=dgsCreateGridList(5,7,280,300,false,Lakeside.Tab[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
					Lakeside.ScrollBar[1]=dgsGridListGetScrollBar(Lakeside.Gridlist[1])
					dgsSetProperty(Lakeside.ScrollBar[1],"troughColor",tocolor(50,50,50,255))
					dgsSetProperty(Lakeside.ScrollBar[1],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
					dgsSetProperty(Lakeside.Gridlist[1],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
					members=dgsGridListAddColumn(Lakeside.Gridlist[1],"Mitglied",0.5)
					rank=dgsGridListAddColumn(Lakeside.Gridlist[1],"Rank",0.4)
					
					dgsCreateLabel(290,12,100,20,"Spielername eingeben:",false,Lakeside.Tab[1])
					Lakeside.Edit[1]=dgsCreateEdit(290,30,185,35,"",false,Lakeside.Tab[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
					
					Lakeside.Button[2]=dgsCreateButton(290,70,185,35,"Invite  [R4+]",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[3]=dgsCreateButton(290,110,185,35,"Uninvite  [R4+]",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[4]=dgsCreateButton(290,150,185,35,"Rank up  [R5]",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[5]=dgsCreateButton(290,190,185,35,"Rank down  [R5]",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					Lakeside.Tab[2]=dgsCreateTab("Notizen",Lakeside.Tabpanel[1])
					
					Lakeside.Memo[1]=dgsCreateMemo(5,7,280,300,"",false,Lakeside.Tab[2],_,_,_,_,tocolor(50,50,50,255))
					Lakeside.Button[18]=dgsCreateButton(290,7,185,35,"Notizen Speichern  [R4+]",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					Lakeside.Tab[3]=dgsCreateTab("Fahrzeuge",Lakeside.Tabpanel[1])
					
					Lakeside.Gridlist[2]=dgsCreateGridList(5,7,280,300,false,Lakeside.Tab[3],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
					Lakeside.ScrollBar[2]=dgsGridListGetScrollBar(Lakeside.Gridlist[2])
					dgsSetProperty(Lakeside.ScrollBar[2],"troughColor",tocolor(50,50,50,255))
					dgsSetProperty(Lakeside.ScrollBar[2],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
					dgsSetProperty(Lakeside.Gridlist[2],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
					vehid=dgsGridListAddColumn(Lakeside.Gridlist[2],"ID",0.15)
					vehs=dgsGridListAddColumn(Lakeside.Gridlist[2],"Vehicle",0.62)
					
					Lakeside.Button[26]=dgsCreateButton(290,7,185,35,"Alle Fahrzeuge respawnen  [R3+]\nKosten: $2500",false,Lakeside.Tab[3],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[27]=dgsCreateButton(290,47,185,35,"Ausgewähltes Fahrzeug respawen\n[R3+] Kosten: $250",false,Lakeside.Tab[3],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[28]=dgsCreateButton(290,87,185,35,"Ausgewähltes Fahrzeug verkaufen\n[R4+] 75% erstattung",false,Lakeside.Tab[3],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					Lakeside.Tab[4]=dgsCreateTab("Einstellungen",Lakeside.Tabpanel[1])
					
					Lakeside.Label[7]=dgsCreateLabel(5,5,100,20,"Rank 0 Gehalt:",false,Lakeside.Tab[4])
					Lakeside.Edit[7]=dgsCreateEdit(5,20,95,30,"",false,Lakeside.Tab[4],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
					Lakeside.Label[8]=dgsCreateLabel(5,55,100,20,"Rank 1 Gehalt:",false,Lakeside.Tab[4])
					Lakeside.Edit[8]=dgsCreateEdit(5,70,95,30,"",false,Lakeside.Tab[4],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
					Lakeside.Label[9]=dgsCreateLabel(5,105,100,20,"Rank 2 Gehalt:",false,Lakeside.Tab[4])
					Lakeside.Edit[9]=dgsCreateEdit(5,120,95,30,"",false,Lakeside.Tab[4],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
					Lakeside.Label[10]=dgsCreateLabel(5,155,100,20,"Rank 3 Gehalt:",false,Lakeside.Tab[4])
					Lakeside.Edit[10]=dgsCreateEdit(5,170,95,30,"",false,Lakeside.Tab[4],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
					Lakeside.Label[11]=dgsCreateLabel(5,205,100,20,"Rank 4 Gehalt:",false,Lakeside.Tab[4])
					Lakeside.Edit[11]=dgsCreateEdit(5,220,95,30,"",false,Lakeside.Tab[4],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
					Lakeside.Label[12]=dgsCreateLabel(5,255,100,20,"Rank 5 Gehalt:",false,Lakeside.Tab[4])
					Lakeside.Edit[12]=dgsCreateEdit(5,270,95,30,"",false,Lakeside.Tab[4],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
					
					Lakeside.Button[39]=dgsCreateButton(110,20,120,30,"Gehalt von\ndem rang ändern",false,Lakeside.Tab[4],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[40]=dgsCreateButton(110,70,120,30,"Gehalt von\ndem rang ändern",false,Lakeside.Tab[4],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[41]=dgsCreateButton(110,120,120,30,"Gehalt von\ndem rang ändern",false,Lakeside.Tab[4],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[42]=dgsCreateButton(110,170,120,30,"Gehalt von\ndem rang ändern",false,Lakeside.Tab[4],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[43]=dgsCreateButton(110,220,120,30,"Gehalt von\ndem rang ändern",false,Lakeside.Tab[4],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[44]=dgsCreateButton(110,270,120,30,"Gehalt von\ndem rang ändern",false,Lakeside.Tab[4],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					Lakeside.Tab[5]=dgsCreateTab("Wochenaktivität",Lakeside.Tabpanel[1])
					
					Lakeside.Gridlist[3]=dgsCreateGridList(5,7,280,300,false,Lakeside.Tab[5],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
					Lakeside.ScrollBar[3]=dgsGridListGetScrollBar(Lakeside.Gridlist[3])
					dgsSetProperty(Lakeside.ScrollBar[3],"troughColor",tocolor(50,50,50,255))
					dgsSetProperty(Lakeside.ScrollBar[3],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
					dgsSetProperty(Lakeside.Gridlist[3],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
					memberss=dgsGridListAddColumn(Lakeside.Gridlist[3],"Mitglied",0.5)
					hours=dgsGridListAddColumn(Lakeside.Gridlist[3],"Stunden",0.4)
					
					Lakeside.Tab[6]=dgsCreateTab("Gangwar",Lakeside.Tabpanel[1])
					Lakeside.Label[65]=dgsCreateLabel(5,1,100,20,"Statistik Ganggebiete",false,Lakeside.Tab[6])
					Lakeside.Label[66]=dgsCreateLabel(5,40,100,20,"Grove Street:",false,Lakeside.Tab[6])
					Lakeside.Label[67]=dgsCreateLabel(5,60,100,20,"Ballas:",false,Lakeside.Tab[6])
					Lakeside.Label[68]=dgsCreateLabel(5,80,100,20,"Vagos:",false,Lakeside.Tab[6])
					
					Lakeside.Label[72]=dgsCreateLabel(190,1,100,20,"Statistik Gangwar K/D  (Generel)",false,Lakeside.Tab[6])
					Lakeside.Gridlist[5]=dgsCreateGridList(190,30,285,280,false,Lakeside.Tab[6],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
					Lakeside.ScrollBar[5]=dgsGridListGetScrollBar(Lakeside.Gridlist[5])
					dgsSetProperty(Lakeside.ScrollBar[5],"troughColor",tocolor(50,50,50,255))
					dgsSetProperty(Lakeside.ScrollBar[5],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
					dgsSetProperty(Lakeside.Gridlist[5],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
					gwkdplayer=dgsGridListAddColumn(Lakeside.Gridlist[5],"Spieler",0.5)
					gwkdplayerkills=dgsGridListAddColumn(Lakeside.Gridlist[5],"Kills",0.13)
					gwkdplayerdeaths=dgsGridListAddColumn(Lakeside.Gridlist[5],"Tode",0.13)
					gwkdplayerdamage=dgsGridListAddColumn(Lakeside.Gridlist[5],"Damage",0.2)
					
					
					if(getElementData(lp,"Factionrank")>=5)then
						dgsSetEnabled(Lakeside.Button[5],true)
						dgsSetEnabled(Lakeside.Button[4],true)
						dgsSetEnabled(Lakeside.Button[39],true)
						dgsSetEnabled(Lakeside.Button[40],true)
						dgsSetEnabled(Lakeside.Button[41],true)
						dgsSetEnabled(Lakeside.Button[42],true)
						dgsSetEnabled(Lakeside.Button[43],true)
						dgsSetEnabled(Lakeside.Button[44],true)
					else
						dgsSetEnabled(Lakeside.Button[5],false)
						dgsSetEnabled(Lakeside.Button[4],false)
						dgsSetEnabled(Lakeside.Button[39],false)
						dgsSetEnabled(Lakeside.Button[40],false)
						dgsSetEnabled(Lakeside.Button[41],false)
						dgsSetEnabled(Lakeside.Button[42],false)
						dgsSetEnabled(Lakeside.Button[43],false)
						dgsSetEnabled(Lakeside.Button[44],false)
					end
					
					if(getElementData(lp,"Factionrank")>=4)then
						dgsSetEnabled(Lakeside.Edit[1],true)
						dgsSetEnabled(Lakeside.Button[2],true)
						dgsSetEnabled(Lakeside.Button[3],true)
						dgsSetEnabled(Lakeside.Button[18],true)
						dgsMemoSetReadOnly(Lakeside.Memo[1],false)
						dgsSetEnabled(Lakeside.Button[28],true)
					else
						dgsSetEnabled(Lakeside.Edit[1],false)
						dgsSetEnabled(Lakeside.Button[2],false)
						dgsSetEnabled(Lakeside.Button[3],false)
						dgsSetEnabled(Lakeside.Button[18],false)
						dgsMemoSetReadOnly(Lakeside.Memo[1],true)
						dgsSetEnabled(Lakeside.Button[28],false)
					end
					
					if(getElementData(lp,"Factionrank")>=3)then
						dgsSetEnabled(Lakeside.Button[26],true)
						dgsSetEnabled(Lakeside.Button[27],true)
					else
						dgsSetEnabled(Lakeside.Button[26],false)
						dgsSetEnabled(Lakeside.Button[27],false)
					end
					
					dgsSetProperty(Lakeside.Label[65],"textSize",{1.2,1.2})
					dgsSetProperty(Lakeside.Label[72],"textSize",{1.2,1.2})
					
					triggerServerEvent("get:factionpanelmembers",lp)
					triggerServerEvent("get:factionpanelmembersaktiviti",lp)
					triggerServerEvent("load:factionvehicles",lp)
					triggerServerEvent("load:factiongangwar",lp)
					triggerServerEvent("load:factiongangwarkd",lp)
					triggerServerEvent("get:factionnotes",lp)
					triggerServerEvent("get:factionranksalary",lp)
					
					dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
					dgsGridListSetSortEnabled(Lakeside.Gridlist[2],false)
					dgsGridListSetSortEnabled(Lakeside.Gridlist[3],false)
					dgsGridListSetSortEnabled(Lakeside.Gridlist[5],false)
					
					
					
					local sortfnc=[[
						local arg = {...}
						local a = arg[1]
						local b = arg[2]
						local column = dgsElementData[self].sortColumn
						local texta,textb = a[column][1],b[column][1]
						return texta > textb
					]]
					dgsGridListSetSortFunction(Lakeside.Gridlist[1],sortfnc)
					dgsGridListSetSortFunction(Lakeside.Gridlist[3],sortfnc)
					dgsGridListSetSortFunction(Lakeside.Gridlist[5],sortfnc)
					dgsGridListSetSortColumn(Lakeside.Gridlist[1],2)
					dgsGridListSetSortColumn(Lakeside.Gridlist[3],2)
					dgsGridListSetSortColumn(Lakeside.Gridlist[5],2)
					
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[44],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local amount=dgsGetText(Lakeside.Edit[12])
								if(amount~="" and #amount>=1 and #amount<=4)then
									triggerServerEvent("change:factionranksalary",lp,"Rank5",amount)
									triggerEvent("show:factionranksalary",lp)
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[43],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local amount=dgsGetText(Lakeside.Edit[11])
								if(amount~="" and #amount>=1 and #amount<=4)then
									triggerServerEvent("change:factionranksalary",lp,"Rank4",amount)
									triggerEvent("show:factionranksalary",lp)
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[42],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local amount=dgsGetText(Lakeside.Edit[10])
								if(amount~="" and #amount>=1 and #amount<=4)then
									triggerServerEvent("change:factionranksalary",lp,"Rank3",amount)
									triggerEvent("show:factionranksalary",lp)
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[41],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local amount=dgsGetText(Lakeside.Edit[9])
								if(amount~="" and #amount>=1 and #amount<=4)then
									triggerServerEvent("change:factionranksalary",lp,"Rank2",amount)
									triggerEvent("show:factionranksalary",lp)
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[40],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local amount=dgsGetText(Lakeside.Edit[8])
								if(amount~="" and #amount>=1 and #amount<=4)then
									triggerServerEvent("change:factionranksalary",lp,"Rank1",amount)
									triggerEvent("show:factionranksalary",lp)
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[39],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local amount=dgsGetText(Lakeside.Edit[7])
								if(amount~="" and #amount>=1 and #amount<=4)then
									triggerServerEvent("change:factionranksalary",lp,"Rank0",amount)
									triggerEvent("show:factionranksalary",lp)
								end
							end
						end,
					false)
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[28],
						function(btn,state)
							if(btn=="left" and state=="up")then
								local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[2])
								if(item>0)then
									local clicked=dgsGridListGetItemText(Lakeside.Gridlist[2],dgsGridListGetSelectedItem(Lakeside.Gridlist[2]),1)
									if(clicked~="")then
										triggerServerEvent("sell:factionvehicle",lp,clicked)
									end
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[27],
						function(btn,state)
							if(btn=="left" and state=="up")then
								local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[2])
								if(item>0)then
									local clicked=dgsGridListGetItemText(Lakeside.Gridlist[2],dgsGridListGetSelectedItem(Lakeside.Gridlist[2]),1)
									if(clicked~="")then
										triggerServerEvent("respawn:1factionvehicle",lp,clicked)
									end
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[26],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("respawn:factionvehicles",lp)
							end
						end,
					false)
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[18],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local notes=dgsGetText(Lakeside.Memo[1])or ""
								triggerServerEvent("change:factionnotes",lp,notes)
							end
						end,
					false)
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[5],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
								if(item>0)then
									local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
									if(clicked~="")then
										triggerServerEvent("rankdown:Fplayer",lp,clicked)
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
										triggerServerEvent("rankup:Fplayer",lp,clicked)
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
										triggerServerEvent("uninvite:Fplayer",lp,clicked)
									end
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[2],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local target=dgsGetText(Lakeside.Edit[1])or ""
								if(target~="")then
									triggerServerEvent("invite:Fplayer",lp,target)
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


addEvent("set:factionpanelmembers",true)
addEventHandler("set:factionpanelmembers",root,function(member)
	dgsGridListClear(Lakeside.Gridlist[1])
	if(member and #member>=1)then
		for _,v in pairs(member)do
			local row=dgsGridListAddRow(Lakeside.Gridlist[1])
			dgsGridListSetItemText(Lakeside.Gridlist[1],row,members,v[1],false,false)
			dgsGridListSetItemText(Lakeside.Gridlist[1],row,rank,v[3].." - "..settings.faction.ranknames[v[2]][v[3]],false,false)
		end
	end
end)
addEvent("set:factionpanelmembersaktiviti",true)
addEventHandler("set:factionpanelmembersaktiviti",root,function(memberr)
	dgsGridListClear(Lakeside.Gridlist[3])
	if(memberr and #memberr>=1)then
		for _,v in pairs(memberr)do
			local row=dgsGridListAddRow(Lakeside.Gridlist[3])
			dgsGridListSetItemText(Lakeside.Gridlist[3],row,memberss,v[1],false,false)
			dgsGridListSetItemText(Lakeside.Gridlist[3],row,hours,v[2],false,false)
		end
	end
end)

addEvent("show:factionnotes",true)
addEventHandler("show:factionnotes",root,function(tbl)
	for _,v in pairs(tbl)do
		dgsSetText(Lakeside.Memo[1],v[1])
	end
end)

addEvent("show:factionvehicles",true)
addEventHandler("show:factionvehicles",root,function(tbl)
	dgsGridListClear(Lakeside.Gridlist[2])
	if(tbl and #tbl>=1)then
		for _,v in ipairs(tbl)do
			local row=dgsGridListAddRow(Lakeside.Gridlist[2])
			dgsGridListSetItemText(Lakeside.Gridlist[2],row,vehid,v[1],false,false)
			dgsGridListSetItemText(Lakeside.Gridlist[2],row,vehs,v[2],false,false)
		end
	end
end)

addEvent("show:factiongangwar",true)
addEventHandler("show:factiongangwar",root,function(tbl)
	if(tbl and #tbl>=1)then
		for _,v in ipairs(tbl)do
			dgsSetText(Lakeside.Label[66],"Grove Street: "..v[1])
			dgsSetText(Lakeside.Label[67],"Ballas: "..v[2])
			dgsSetText(Lakeside.Label[68],"Vagos: "..v[3])
		end
	end
end)
addEvent("show:factiongangwarkd",true)
addEventHandler("show:factiongangwarkd",root,function(tbl)
	dgsGridListClear(Lakeside.Gridlist[5])
	if(tbl and #tbl>=1)then
		for _,v in ipairs(tbl)do
			local row=dgsGridListAddRow(Lakeside.Gridlist[5])
			dgsGridListSetItemText(Lakeside.Gridlist[5],row,gwkdplayer,v[1],false,false)
			dgsGridListSetItemText(Lakeside.Gridlist[5],row,gwkdplayerkills,v[2],false,false)
			dgsGridListSetItemText(Lakeside.Gridlist[5],row,gwkdplayerdeaths,v[3],false,false)
			dgsGridListSetItemText(Lakeside.Gridlist[5],row,gwkdplayerdamage,v[4],false,false)
		end
	end
end)

addEvent("show:factionranksalary",true)
addEventHandler("show:factionranksalary",root,function(tbl)
	if(tbl and #tbl>=1)then
		for _,v in ipairs(tbl)do
			dgsSetText(Lakeside.Label[7],"Rank 0 Gehalt: $"..v[1])
			dgsSetText(Lakeside.Label[8],"Rank 1 Gehalt: $"..v[2])
			dgsSetText(Lakeside.Label[9],"Rank 2 Gehalt: $"..v[3])
			dgsSetText(Lakeside.Label[10],"Rank 3 Gehalt: $"..v[4])
			dgsSetText(Lakeside.Label[11],"Rank 4 Gehalt: $"..v[5])
			dgsSetText(Lakeside.Label[12],"Rank 5 Gehalt: $"..v[6])
		end
	end
end)