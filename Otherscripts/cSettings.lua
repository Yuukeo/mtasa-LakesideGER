--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local function deleteAllUIItems()
	--//Grid 1
	if(isElement(Lakeside.Combo[1]))then
		Lakeside.Combo[1]:destroy()
	end
	if(isElement(Lakeside.Button[10]))then
		Lakeside.Button[10]:destroy()
	end
	if(isElement(Lakeside.Label[10]))then
		Lakeside.Label[10]:destroy()
	end
	--//Grid 2
	if(isElement(Lakeside.Button[20]))then
		Lakeside.Button[20]:destroy()
	end
	if(isElement(Lakeside.Label[20]))then
		Lakeside.Label[20]:destroy()
	end
	if(isElement(Lakeside.Edit[20]))then
		Lakeside.Edit[20]:destroy()
	end
	if(isElement(Lakeside.Button[21]))then
		Lakeside.Button[21]:destroy()
	end
	if(isElement(Lakeside.Label[21]))then
		Lakeside.Label[21]:destroy()
	end
	if(isElement(Lakeside.Edit[21]))then
		Lakeside.Edit[21]:destroy()
	end
	--//Grid 3
	if(isElement(Lakeside.Button[40]))then
		Lakeside.Button[40]:destroy()
	end
	if(isElement(Lakeside.Label[40]))then
		Lakeside.Label[40]:destroy()
	end
	if(isElement(Lakeside.Button[41]))then
		Lakeside.Button[41]:destroy()
	end
	if(isElement(Lakeside.Label[41]))then
		Lakeside.Label[41]:destroy()
	end
	--//Grid 4
	if(isElement(Lakeside.Combo[50]))then
		Lakeside.Combo[50]:destroy()
	end
	if(isElement(Lakeside.Button[50]))then
		Lakeside.Button[50]:destroy()
	end
	if(isElement(Lakeside.Label[50]))then
		Lakeside.Label[50]:destroy()
	end
	if(isElement(Lakeside.Button[51]))then
		Lakeside.Button[51]:destroy()
	end
	if(isElement(Lakeside.Label[51]))then
		Lakeside.Label[51]:destroy()
	end
end

addCommandHandler("settings",function()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			setWindowData("add","cursor_clicked",true)
			Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-500/2,GLOBALscreenY/2-500/2,500,500,settings.general.servername.." - Settings",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,settings.general.guibgcolor,nil,true)
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
			
			Lakeside.Gridlist[1]=dgsCreateGridList(5,5,200,465,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
			Lakeside.ScrollBar[1]=dgsGridListGetScrollBar(Lakeside.Gridlist[1])
			dgsSetProperty(Lakeside.ScrollBar[1],"troughColor",tocolor(50,50,50,255))
			dgsSetProperty(Lakeside.ScrollBar[1],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
			dgsSetProperty(Lakeside.Gridlist[1],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
			local gridlist=dgsGridListAddColumn(Lakeside.Gridlist[1],"Settings",0.92)
			local grid1=dgsGridListAddRow(Lakeside.Gridlist[1],"Radar")
			local grid2=dgsGridListAddRow(Lakeside.Gridlist[1],"Account")
			local grid3=dgsGridListAddRow(Lakeside.Gridlist[1],"Shader")
			local grid4=dgsGridListAddRow(Lakeside.Gridlist[1],"Anderes")
			
			
			dgsGridListSetItemText(Lakeside.Gridlist[1],grid1,gridlist,"Radar")
			dgsGridListSetItemText(Lakeside.Gridlist[1],grid2,gridlist,"Account")
			dgsGridListSetItemText(Lakeside.Gridlist[1],grid3,gridlist,"Shader")
			dgsGridListSetItemText(Lakeside.Gridlist[1],grid4,gridlist,"Anderes")
			
			dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
			
			
			addEventHandler("onDgsMouseClick",Lakeside.Gridlist[1],
				function(btn,state)
					if(btn=="left" and state=="up")then
						local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
						if(item>0)then
							local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
							if(item==grid1)then
								deleteAllUIItems()
								
								Lakeside.Label[10]=dgsCreateLabel(220,25,160,20,"Radar: n/a",false,Lakeside.Window[1])
								Lakeside.Combo[1]=dgsCreateComboBox(220,45,260,35,"Radar auswählen",false,Lakeside.Window[1],20,tocolor(0,0,0,255),_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255))
								dgsComboBoxAddItem(Lakeside.Combo[1],"GTA:V")
								dgsComboBoxAddItem(Lakeside.Combo[1],"GTA:SA")
								
								Lakeside.Button[10]=dgsCreateButton(220,100,260,40,"Set Radar",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
								
								
								if(tonumber(syncClientGetElementData("Radar"))==1)then
									dgsSetText(Lakeside.Label[10],"Radar: GTA:V")
								elseif(tonumber(syncClientGetElementData("Radar"))==2)then
									dgsSetText(Lakeside.Label[10],"Radar: GTA:SA")
								end
								
								
								addEventHandler("onDgsMouseClick",Lakeside.Button[10],
									function(btn,state)
										if(btn=="left" and state=="down")then
											local amount=dgsComboBoxGetSelectedItem(Lakeside.Combo[1])
											if(tonumber(amount)>=1 and tonumber(amount)<=2)then
												triggerServerEvent("set:settings",lp,"Radar",tonumber(amount))
											end
										end
									end,
								false)
							elseif(item==grid2)then
								deleteAllUIItems()
								
								Lakeside.Label[20]=dgsCreateLabel(220,25,160,20,"Benutzername ändern (Unter 3Stunden kostenlos)",false,Lakeside.Window[1])
								Lakeside.Edit[20]=dgsCreateEdit(220,45,260,40,"",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
								Lakeside.Button[20]=dgsCreateButton(220,95,260,40,"Benutzername ändern ($100.000)",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
								
								Lakeside.Label[21]=dgsCreateLabel(220,155,160,20,"Passwort ändern",false,Lakeside.Window[1])
								Lakeside.Edit[21]=dgsCreateEdit(220,175,260,40,"",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
								Lakeside.Button[21]=dgsCreateButton(220,225,260,40,"Passwort ändern",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
								
								addEventHandler("onDgsMouseClick",Lakeside.Button[20],
									function(btn,state)
										if(btn=="left" and state=="down")then
											local username=dgsGetText(Lakeside.Edit[20])
											if(username~="")then
												triggerServerEvent("change:accountsettings",lp,"Nickchange",username)
											end
										end
									end,
								false)
								addEventHandler("onDgsMouseClick",Lakeside.Button[21],
									function(btn,state)
										if(btn=="left" and state=="down")then
											local password=dgsGetText(Lakeside.Edit[21])
											if(password~="")then
												triggerServerEvent("change:accountsettings",lp,"Password",password)
											end
										end
									end,
								false)
							elseif(item==grid3)then
								deleteAllUIItems()
								
								Lakeside.Label[40]=dgsCreateLabel(220,25,160,20,"Blurshader:",false,Lakeside.Window[1])
								Lakeside.Button[40]=dgsCreateButton(220,45,260,40,"Blurshader an/aus",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
								Lakeside.Label[41]=dgsCreateLabel(220,100,160,20,"Snowshader:",false,Lakeside.Window[1])
								Lakeside.Button[41]=dgsCreateButton(220,120,260,40,"Snowshader an/aus",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
								
								if(settings.general.christmas==true)then
									dgsSetEnabled(Lakeside.Button[41],true)
								else
									dgsSetEnabled(Lakeside.Button[41],false)
								end
								
								if(tonumber(syncClientGetElementData("Blurshader"))==1)then
									dgsSetText(Lakeside.Label[40],"Blurshader: Off")
								elseif(tonumber(syncClientGetElementData("Blurshader"))==2)then
									dgsSetText(Lakeside.Label[40],"Blurshader: On")
								end
								if(tonumber(syncClientGetElementData("Snowshader"))==1)then
									dgsSetText(Lakeside.Label[41],"Snowshader: Off")
								elseif(tonumber(syncClientGetElementData("Snowshader"))==2)then
									dgsSetText(Lakeside.Label[41],"Snowshader: On")
								end
								
								
								addEventHandler("onDgsMouseClick",Lakeside.Button[40],
									function(btn,state)
										if(btn=="left" and state=="down")then
											triggerServerEvent("set:settings",lp,"Blurshader",_)
										end
									end,
								false)
								addEventHandler("onDgsMouseClick",Lakeside.Button[41],
									function(btn,state)
										if(btn=="left" and state=="down")then
											triggerServerEvent("set:settings",lp,"Snowshader",_)
										end
									end,
								false)
							elseif(item==grid4)then
								deleteAllUIItems()
								
								Lakeside.Label[50]=dgsCreateLabel(220,25,160,20,"Hitglocke: n/a",false,Lakeside.Window[1])
								Lakeside.Combo[50]=dgsCreateComboBox(220,45,260,35,"Hitglocke auswählen",false,Lakeside.Window[1],20,tocolor(0,0,0,255),_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255))
								dgsComboBoxAddItem(Lakeside.Combo[50],"1")
								dgsComboBoxAddItem(Lakeside.Combo[50],"2")
								dgsComboBoxAddItem(Lakeside.Combo[50],"3")
								
								Lakeside.Button[50]=dgsCreateButton(220,100,260,40,"Set Hitglocke",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
								
								Lakeside.Label[51]=dgsCreateLabel(220,170,160,20,"Autologin:",false,Lakeside.Window[1])
								Lakeside.Button[51]=dgsCreateButton(220,190,260,40,"Autologin an/aus",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
								
								if(tonumber(syncClientGetElementData("Hitglocke"))==1)then
									dgsSetText(Lakeside.Label[50],"Hitglocke: 1")
								elseif(tonumber(syncClientGetElementData("Hitglocke"))==2)then
									dgsSetText(Lakeside.Label[50],"Hitglocke: 2")
								elseif(tonumber(syncClientGetElementData("Hitglocke"))==3)then
									dgsSetText(Lakeside.Label[50],"Hitglocke: 3")
								end
								
								if(tonumber(syncClientGetElementData("Autologin"))==1)then
									dgsSetText(Lakeside.Label[51],"Autologin: Off")
								elseif(tonumber(syncClientGetElementData("Autologin"))==2)then
									dgsSetText(Lakeside.Label[51],"Autologin: On")
								end
								
								
								addEventHandler("onDgsMouseClick",Lakeside.Button[51],
									function(btn,state)
										if(btn=="left" and state=="down")then
											triggerServerEvent("set:settings",lp,"Autologin",_)
										end
									end,
								false)
								addEventHandler("onDgsMouseClick",Lakeside.Button[50],
									function(btn,state)
										if(btn=="left" and state=="down")then
											local amount=dgsComboBoxGetSelectedItem(Lakeside.Combo[50])
											if(tonumber(amount)>=1 and tonumber(amount)<=3)then
												triggerServerEvent("set:settings",lp,"Hitglocke",tonumber(amount))
											end
										end
									end,
								false)
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
end)


addEvent("refresh:settingsmenu",true)
addEventHandler("refresh:settingsmenu",root,function(typ)
	if(typ=="Radar")then
		if(tonumber(syncClientGetElementData("Radar"))==1)then
			dgsSetText(Lakeside.Label[10],"Radar: GTA:V")
		elseif(tonumber(syncClientGetElementData("Radar"))==2)then
			dgsSetText(Lakeside.Label[10],"Radar: GTA:SA")
		end
	elseif(typ=="Blurshader")then
		if(tonumber(syncClientGetElementData("Blurshader"))==1)then
			dgsSetText(Lakeside.Label[40],"Blurshader: Off")
		elseif(tonumber(syncClientGetElementData("Blurshader"))==2)then
			dgsSetText(Lakeside.Label[40],"Blurshader: On")
		end
	elseif(typ=="Snowshader")then
		if(tonumber(syncClientGetElementData("Snowshader"))==1)then
			dgsSetText(Lakeside.Label[41],"Snowshader: Off")
			--triggerEvent("switchGoundSnow",root,true)
		elseif(tonumber(syncClientGetElementData("Snowshader"))==2)then
			dgsSetText(Lakeside.Label[41],"Snowshader: On")
			--triggerEvent("switchGoundSnow",root,false)
		end
	elseif(typ=="Autologin")then
		if(tonumber(syncClientGetElementData("Autologin"))==1)then
			dgsSetText(Lakeside.Label[51],"Autologin: Off")
		elseif(tonumber(syncClientGetElementData("Autologin"))==2)then
			dgsSetText(Lakeside.Label[51],"Autologin: On")
		end
	elseif(typ=="Hitglocke")then
		if(tonumber(syncClientGetElementData("Hitglocke"))==1)then
			dgsSetText(Lakeside.Label[50],"Hitglocke: 1")
		elseif(tonumber(syncClientGetElementData("Hitglocke"))==2)then
			dgsSetText(Lakeside.Label[50],"Hitglocke: 2")
		elseif(tonumber(syncClientGetElementData("Hitglocke"))==3)then
			dgsSetText(Lakeside.Label[50],"Hitglocke: 3")
		end
	end
end)