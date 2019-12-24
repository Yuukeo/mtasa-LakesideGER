--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

bindKey("f4","down",function()
	if(isLoggedin())then
		if(not isPedDead(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				if(getElementData(lp,"Company")~=0)then
					setWindowData("add","cursor_clicked",true)
					Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-500/2,GLOBALscreenY/2-380/2,500,380,settings.general.servername.." - Companypanel ("..settings.company.ranknames.levelnames[tonumber(getElementData(lp,"Company"))]..")",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,settings.general.guibgcolor,nil,true)
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
					
					Lakeside.Gridlist[1]=dgsCreateGridList(5,7,280,305,false,Lakeside.Tab[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
					Lakeside.ScrollBar[1]=dgsGridListGetScrollBar(Lakeside.Gridlist[1])
					dgsSetProperty(Lakeside.ScrollBar[1],"troughColor",tocolor(50,50,50,255))
					dgsSetProperty(Lakeside.ScrollBar[1],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
					dgsSetProperty(Lakeside.Gridlist[1],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
					members=dgsGridListAddColumn(Lakeside.Gridlist[1],"Member",0.5)
					rank=dgsGridListAddColumn(Lakeside.Gridlist[1],"Rank",0.4)
					
					dgsCreateLabel(300,12,100,20,"Spielername eingeben:",false,Lakeside.Tab[1],_,_,_,_,_,_,"center",_)
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
					memberss=dgsGridListAddColumn(Lakeside.Gridlist[3],"Member",0.5)
					hours=dgsGridListAddColumn(Lakeside.Gridlist[3],"Stunden",0.4)
					
					
					if(getElementData(lp,"Companyrank")==5)then
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
					
					if(getElementData(lp,"Companyrank")>=4)then
						dgsSetEnabled(Lakeside.Edit[1],true)
						dgsSetEnabled(Lakeside.Button[2],true)
						dgsSetEnabled(Lakeside.Button[3],true)
						dgsMemoSetReadOnly(Lakeside.Memo[1],false)
					else
						dgsSetEnabled(Lakeside.Edit[1],false)
						dgsSetEnabled(Lakeside.Button[2],false)
						dgsSetEnabled(Lakeside.Button[3],false)
						dgsMemoSetReadOnly(Lakeside.Memo[1],true)
					end
					
					if(getElementData(lp,"Companyrank")>=3)then
						dgsSetEnabled(Lakeside.Button[26],true)
					else
						dgsSetEnabled(Lakeside.Button[26],false)
					end
					
					triggerServerEvent("get:companypanelmembers",lp)
					triggerServerEvent("get:companypanelmembersaktiviti",lp)
					triggerServerEvent("load:companyvehicles",lp)
					triggerServerEvent("get:companynotes",lp)
					triggerServerEvent("get:companyranksalary",lp)
					
					dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
					
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[44],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local amount=dgsGetText(Lakeside.Edit[12])
								if(amount~="" and #amount>=1 and #amount<=4)then
									triggerServerEvent("change:companyranksalary",lp,"Rank5",amount)
									triggerEvent("show:companyranksalary",lp)
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[43],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local amount=dgsGetText(Lakeside.Edit[11])
								if(amount~="" and #amount>=1 and #amount<=4)then
									triggerServerEvent("change:companyranksalary",lp,"Rank4",amount)
									triggerEvent("show:companyranksalary",lp)
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[42],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local amount=dgsGetText(Lakeside.Edit[10])
								if(amount~="" and #amount>=1 and #amount<=4)then
									triggerServerEvent("change:companyranksalary",lp,"Rank3",amount)
									triggerEvent("show:companyranksalary",lp)
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[41],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local amount=dgsGetText(Lakeside.Edit[9])
								if(amount~="" and #amount>=1 and #amount<=4)then
									triggerServerEvent("change:companyranksalary",lp,"Rank2",amount)
									triggerEvent("show:companyranksalary",lp)
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[40],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local amount=dgsGetText(Lakeside.Edit[8])
								if(amount~="" and #amount>=1 and #amount<=4)then
									triggerServerEvent("change:companyranksalary",lp,"Rank1",amount)
									triggerEvent("show:companyranksalary",lp)
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[39],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local amount=dgsGetText(Lakeside.Edit[7])
								if(amount~="" and #amount>=1 and #amount<=4)then
									triggerServerEvent("change:companyranksalary",lp,"Rank0",amount)
									triggerEvent("show:companyranksalary",lp)
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
										triggerServerEvent("respawn:1companyvehicle",lp,clicked)
									end
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[26],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("respawn:companyvehicles",lp)
							end
						end,
					false)
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[18],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local notes=dgsGetText(Lakeside.Memo[1])or ""
								triggerServerEvent("change:companynotes",lp,notes)
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
										triggerServerEvent("rankdown:Cplayer",lp,clicked)
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
										triggerServerEvent("rankup:Cplayer",lp,clicked)
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
										triggerServerEvent("uninvite:Cplayer",lp,clicked)
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
									triggerServerEvent("invite:Cplayer",lp,target)
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


addEvent("set:companypanelmembers",true)
addEventHandler("set:companypanelmembers",root,function(member)
	dgsGridListClear(Lakeside.Gridlist[1])
	if(member and #member>=1)then
		for _,v in pairs(member)do
			local row=dgsGridListAddRow(Lakeside.Gridlist[1])
			dgsGridListSetItemText(Lakeside.Gridlist[1],row,members,v[1],false,false)
			dgsGridListSetItemText(Lakeside.Gridlist[1],row,rank,settings.company.ranknames[v[2]][v[3]].."("..v[3]..")",false,false)
		end
	end
end)
addEvent("set:companypanelmembersaktiviti",true)
addEventHandler("set:companypanelmembersaktiviti",root,function(memberr)
	dgsGridListClear(Lakeside.Gridlist[3])
	if(memberr and #memberr>=1)then
		for _,v in pairs(memberr)do
			local row=dgsGridListAddRow(Lakeside.Gridlist[3])
			dgsGridListSetItemText(Lakeside.Gridlist[3],row,memberss,v[1],false,false)
			dgsGridListSetItemText(Lakeside.Gridlist[3],row,hours,v[2],false,false)
		end
	end
end)

addEvent("show:companynotes",true)
addEventHandler("show:companynotes",root,function(tbl)
	for _,v in pairs(tbl)do
		dgsSetText(Lakeside.Memo[1],v[1])
	end
end)

addEvent("show:companyvehicles",true)
addEventHandler("show:companyvehicles",root,function(tbl)
	dgsGridListClear(Lakeside.Gridlist[2])
	if(tbl and #tbl>=1)then
		for _,v in ipairs(tbl)do
			local row=dgsGridListAddRow(Lakeside.Gridlist[2])
			dgsGridListSetItemText(Lakeside.Gridlist[2],row,vehid,v[1],false,false)
			dgsGridListSetItemText(Lakeside.Gridlist[2],row,vehs,v[2],false,false)
		end
	end
end)

addEvent("show:companyranksalary",true)
addEventHandler("show:companyranksalary",root,function(tbl)
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