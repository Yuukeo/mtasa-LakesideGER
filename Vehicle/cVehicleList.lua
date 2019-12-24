--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("open:uservehpanel",true)
addEventHandler("open:uservehpanel",root,function(tbl)
	if(isLoggedin())then
		dgsSetInputMode("no_binds")
		dgsSetInputMode("no_binds_when_editing")
		setWindowData("add","cursor_clicked",false)
		Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-440/2,GLOBALscreenY/2-440/2,440,440,settings.general.servername.." - Fahrzeugliste",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,settings.general.guibgcolor,nil,true)
		dgsWindowSetSizable(Lakeside.Window[1],false)
		dgsWindowSetMovable(Lakeside.Window[1],false)
		Lakeside.Button[1]=dgsCreateButton(414,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
		dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
		dgsCreateImage(0,0,440,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
		Lakeside.Blurbox[1]=dgsCreateBlurBox()
		dgsSetProperty(Lakeside.Window[1],"functions",[[
			local arguments = {...}
			local blurbox = arguments[1]
			local renderArguments = renderArguments
			local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
			dgsBlurBoxRender(blurbox,x,y,w,h)
		]],Lakeside.Blurbox[1])
		
		Lakeside.Gridlist[1]=dgsCreateGridList(5,5,300,405,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
		Lakeside.ScrollBar[1]=dgsGridListGetScrollBar(Lakeside.Gridlist[1])
		dgsSetProperty(Lakeside.ScrollBar[1],"troughColor",tocolor(50,50,50,255))
		dgsSetProperty(Lakeside.ScrollBar[1],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
		dgsSetProperty(Lakeside.Gridlist[1],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
		local id=dgsGridListAddColumn(Lakeside.Gridlist[1],"ID",0.13)
		local veh=dgsGridListAddColumn(Lakeside.Gridlist[1],"Fahrzeug",0.4)
		local slot=dgsGridListAddColumn(Lakeside.Gridlist[1],"Slot",0.12)
		local totalloss=dgsGridListAddColumn(Lakeside.Gridlist[1],"Totalschaden",0.24)
		
		dgsCreateLabel(310,5,0,0,"Spielername:",false,Lakeside.Window[1])
		Lakeside.Edit[1]=dgsCreateEdit(310,20,125,35,"",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
		Lakeside.Button[3]=dgsCreateButton(310,60,125,35,"1 Schlüssel\nvergeben",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
		Lakeside.Button[4]=dgsCreateButton(310,100,125,35,"2 Schlüssel\nvergeben",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
		
		dgsCreateLabel(310,150,0,0,"Preis:",false,Lakeside.Window[1])
		Lakeside.Edit[2]=dgsCreateEdit(310,165,125,35,"",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
		Lakeside.Button[7]=dgsCreateButton(310,205,125,35,"Fahrzeug verkaufen\nan Spieler",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
		Lakeside.Button[6]=dgsCreateButton(310,245,125,35,"Fahrzeug respawnen\n$80",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
		Lakeside.Button[5]=dgsCreateButton(310,285,125,35,"Fahrzeug orten",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
		Lakeside.Button[2]=dgsCreateButton(310,325,125,35,"Fahrzeug verkaufen\n75% erstattung",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
		
		dgsCreateLabel(310,362,0,0,"Doppelklick auf ein\nFahrzeug um Schlüssel-\nbesitzer zu sehen",false,Lakeside.Window[1])
		
		if(#tbl>=1)then
			for _,v in pairs(tbl)do 
				local row=dgsGridListAddRow(Lakeside.Gridlist[1])
				dgsGridListSetItemText(Lakeside.Gridlist[1],row,id,v[1],false,false)
				dgsGridListSetItemText(Lakeside.Gridlist[1],row,veh,v[2],false,false)
				dgsGridListSetItemText(Lakeside.Gridlist[1],row,slot,v[3],false,false)
				if(v[4]==1)then
					dgsGridListSetItemText(Lakeside.Gridlist[1],row,totalloss,"Ja",false,false)
				elseif(v[4]==0)then
					dgsGridListSetItemText(Lakeside.Gridlist[1],row,totalloss,"Nein",false,false)	
				end
			end
		end
		
		dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
		
		
		addEventHandler("onDgsMouseClick",Lakeside.Button[7],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
					if(item>0)then
						local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),3)
						if(clicked~="")then
							local target=dgsGetText(Lakeside.Edit[1])
							local price=tonumber(dgsGetText(Lakeside.Edit[2]))
							if(target~="")then
								if(price>=1)then
									triggerServerEvent("selltoplayer:pivvehicle",lp,clicked,target,tonumber(price))
								end
							end
						end
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",Lakeside.Button[6],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
					if(item>0)then
						local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),3)
						if(clicked~="")then
							triggerServerEvent("respawn:pivvehicle",lp,clicked)
						end
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",Lakeside.Button[5],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
					if(item>0)then
						local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),3)
						if(clicked~="")then
							triggerServerEvent("locate:pivvehicle",lp,clicked)
						end
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",Lakeside.Button[4],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
					if(item>0)then
						local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),3)
						if(clicked~="")then
							local target=dgsGetText(Lakeside.Edit[1])or "none"
							if(target~="")then
								triggerServerEvent("give:vehiclekey",lp,"Key2",clicked,target)
							end
						end
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",Lakeside.Button[3],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
					if(item>0)then
						local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),3)
						if(clicked~="")then
							local target=dgsGetText(Lakeside.Edit[1])or "none"
							if(target~="")then
								triggerServerEvent("give:vehiclekey",lp,"Key1",clicked,target)
							end
						end
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",Lakeside.Button[2],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
					if(item>0)then
						local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),3)
						if(clicked~="")then
							triggerServerEvent("sell:pivvehicle",lp,clicked)
						end
					end
				end
			end,
		false)
		
		addEventHandler("onDgsMouseDoubleClick",Lakeside.Gridlist[1],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
					if(item>0)then
						local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),3)
						if(clicked~="")then
							triggerServerEvent("get:vehiclekeyTargets",lp,clicked)
						end
					end
				end
			end,
		false)
		
		addEventHandler("onDgsMouseClick",Lakeside.Button[1],
			function(btn,state)
				if btn=="left" and state=="up" then
					dgsCloseWindow(Lakeside.Window[1])
					setWindowData("remove","cursor_clicked",true)
				end
			end,
		false)
	end
end)