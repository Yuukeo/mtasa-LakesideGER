--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local validItemsTable={
["Ausweis"]=true,
["Fahrzeugschlüssel"]=true,
["Apfel"]=true,
["Burger"]=true,
["Pizza"]=true,
["Zuckerstange"]=true,
["Cola"]=true,
["ChestWood"]=true,
["ChestIron"]=true,
["TicketSilver"]=true,
["TicketBronze"]=true,
["TicketGold"]=true,
["Repairkit"]=true,
["Kokain"]=true,
["Weed"]=true,
["Mats"]=true,
["Hanfsamen"]=true,
["Apfelsamen"]=true,
["Zigarette"]=true,
["Weste"]=true,
["Spitzhacke"]=true,
["Mondstein"]=true,
["Geschenk"]=true,
["Fishingrod"]=true,
["Fishinghook"]=true,
["Köder"]=true,
["Forelle"]=true,
["Benzinkanister"]=true,
["Barrikade"]=true,
["Brechstange"]=true
}

local itemTextsTable={
["Ausweis"]="Ausweis:\nUm alle Infos über dich zu sehen.",
["Fahrzeugschlüssel"]="Fahrzeugschlüssel:\nUm deine Fahrzeuge zu verwalten.",
["Apfel"]="Apfel:\nUm deinen Hunger zu befriedigen.",
["Burger"]="Burger:\nUm deinen Hunger zu befriedigen.",
["Pizza"]="Pizza:\nUm deinen Hunger zu befriedigen.",
["Zuckerstange"]="Zuckerstange:\nUm dein Hunger aufzufüllen oder\num es einzutauschen.",
["Cola"]="Cola:\nUm deinen Hunger zu befriedigen.",
["ChestWood"]="Wood Chest:\na chest with a present.",
["ChestIron"]="Iron Chest:\na chest with a present.",
["TicketBronze"]="Bronze Ticket:",
["TicketSilver"]="Silver Ticket:",
["TicketGold"]="Gold Ticket:",
["Repairkit"]="Repairkit:\nUm ein Fahrzeug zu reparieren.",
["Kokain"]="Kokain:\nZum verkaufen oder zum benutzen.",
["Weed"]="Weed:\nZum verkaufen oder zum benutzen.",
["Mats"]="Mats:\nUm Waffen herzustellen.",
["Hanfsamen"]="Hanfsamen:\nZum anpflanzen.",
["Apfelsamen"]="Apfelsamen:\nZum anpflanzen.",
["Zigarette"]="Zigarette:\nZum rauchen um Leben zu regenerieren.",
["Weste"]="Weste:\nUm deine Weste auf aufzufüllen.",
["Spitzhacke"]="Spitzhacke:\nUm Mondstein auf dem Mond zu farmen.",
["Mondstein"]="Mondstein:\nZum verkaufen auf dem Mond",
["Geschenk"]="Geschenk:\nUm tolle Preise zu erhalten.",
["Fishingrod"]="Fishingrod:\nUm Fische zu Angeln.",
["Fishinghook"]="Fishinghook:\nBraucht man, um Fische zu Angeln.",
["Köder"]="Köder:\nBraucht man, um Fische zu Angeln.",
["Forelle"]="Forelle:\nZum verkaufen oder\num deinen Hunger zu befriedigen.",
["Benzinkanister"]="Benzinkanister:\nUm Fahrzeuge wieder aufzutanken.",
["Barrikade"]="Barrikade:\nZum platzieren.",
["Brechstange"]="Brechstange:\nUm einen ATM oder sonstiges zu knacken."
}

local itemImagesTable={
["Ausweis"]="IDcard.png",
["Fahrzeugschlüssel"]="VehicleKey.png",
["Apfel"]="Apple.png",
["Burger"]="Burger.png",
["Pizza"]="Pizza.png",
["Zuckerstange"]="Candycane.png",
["Cola"]="Cola.png",
["ChestWood"]="ChestWood.png",
["ChestIron"]="ChestIron.png",
["TicketBronze"]="TicketBronze.png",
["TicketSilver"]="TicketSilver.png",
["TicketGold"]="TicketGold.png",
["Repairkit"]="Repairkit.png",
["Kokain"]="Cocaine.png",
["Weed"]="Weed.png",
["Mats"]="Mats.png",
["Hanfsamen"]="WeedSeeds.png",
["Apfelsamen"]="AppleSeeds.png",
["Zigarette"]="Cigarette.png",
["Weste"]="Armor.png",
["Spitzhacke"]="Pickaxe.png",
["Mondstein"]="Moonstone.png",
["Geschenk"]="Present.png",
["Fishingrod"]="Fishingrod.png",
["Fishinghook"]="Fishinghook.png",
["Köder"]="Bait.png",
["Forelle"]="Trout.png",
["Benzinkanister"]="Benzinkanister.png",
["Barrikade"]="Barrikade.png",
["Brechstange"]="Brechstange.png"
}
local standartInventoryTXT="Kein Items ausgewählt!"

bindKey("i","down",function()
	if(isLoggedin())then
		if(not isPedDead(lp))then
			local veh=getPedOccupiedVehicle(lp)
			if(getPedOccupiedVehicleSeat(lp)==0 and getElementData(veh,"Owner")~=nil and getElementData(veh,"Owner")~=syncClientGetElementData("Faction")and getElementData(veh,"Owner")~=syncClientGetElementData("Company")and getElementData(veh,"Slot")~=nil)then
				triggerEvent("open:trunk",lp)
			else
				triggerEvent("open:inventory",lp)
			end
		end
	end
end)

addEvent("open:inventory",true)
addEventHandler("open:inventory",root,function()
	if(getElementData(lp,"ElementClicked")==false)then
		setWindowData("add","cursor_clicked",true)
		Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-500/2,GLOBALscreenY/2-400/2,500,400,settings.general.servername.." - Inventar",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,settings.general.guibgcolor,nil,true)
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
		
		Lakeside.Gridlist[1]=dgsCreateGridList(5,5,250,365,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
		Lakeside.ScrollBar[1]=dgsGridListGetScrollBar(Lakeside.Gridlist[1])
		dgsSetProperty(Lakeside.ScrollBar[1],"troughColor",tocolor(50,50,50,255))
		dgsSetProperty(Lakeside.ScrollBar[1],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
		dgsSetProperty(Lakeside.Gridlist[1],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
		item=dgsGridListAddColumn(Lakeside.Gridlist[1],"Item",0.6)
		amount=dgsGridListAddColumn(Lakeside.Gridlist[1],"Anzahl",0.24)
		
		Lakeside.Label[1]=dgsCreateLabel(265,10,100,20,standartInventoryTXT,false,Lakeside.Window[1])
		
		
		dgsCreateLabel(260,200,100,10,"Gebe ein Zahl an, um ein Item\nzu benutzen/wegzuwerfen.",false,Lakeside.Window[1])
		Lakeside.Edit[1]=dgsCreateEdit(260,230,235,40,0,false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
		Lakeside.Button[2]=dgsCreateButton(260,275,235,45,"Item benutzen",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
		Lakeside.Button[3]=dgsCreateButton(260,325,235,45,"Item wegwerfen",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
		
		
		dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
		
		addEventHandler("onDgsMouseClick",Lakeside.Gridlist[1],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item1=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
					if(item1>0)then
						local selectedGrid,_=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
						local selectedItem=dgsGridListGetItemText(Lakeside.Gridlist[1],selectedGrid,item)
						if(selectedItem)then
							if(validItemsTable[selectedItem])then
								dgsSetText(Lakeside.Label[1],itemTextsTable[selectedItem])
								if(isElement(Lakeside.Image[1]))then
									Lakeside.Image[1]:destroy()
								end
								Lakeside.Image[1]=dgsCreateImage(315,70,120,120,":"..settings.general.scriptname.."/Files/Images/Inventory/"..itemImagesTable[selectedItem],false,Lakeside.Window[1])
								if(selectedItem=="Ausweis" or selectedItem=="Repairkit" or selectedItem=="ChestWood" or selectedItem=="ChestIron" or selectedItem=="TicketBronze" or selectedItem=="TicketSilver" or selectedItem=="TicketGold" or selectedItem=="Fahrzeugschlüssel" or selectedItem=="Hanfsamen" or selectedItem=="Apfelsamen" or selectedItem=="Weste" or selectedItem=="Geschenk" or selectedItem=="Benzinkanister" or selectedItem=="Barrikade" or selectedItem=="Brechstange")then
									dgsSetEnabled(Lakeside.Edit[1],false)
								else
									dgsSetEnabled(Lakeside.Edit[1],true)
								end
								if(selectedItem=="TicketBronze" or selectedItem=="TicketSilver" or selectedItem=="TicketGold")then
									dgsSetEnabled(Lakeside.Button[2],false)
									dgsSetEnabled(Lakeside.Button[3],false)
								else
									dgsSetEnabled(Lakeside.Button[2],true)
									dgsSetEnabled(Lakeside.Button[3],true)
								end
								if(selectedItem=="Fishingrod" or selectedItem=="Köder" or selectedItem=="Fishinghook")then
									dgsSetEnabled(Lakeside.Button[2],false)
								else
									dgsSetEnabled(Lakeside.Button[2],true)
								end
								if(selectedItem=="Ausweis" or selectedItem=="Fahrzeugschlüssel")then
									dgsSetEnabled(Lakeside.Button[3],false)
								else
									dgsSetEnabled(Lakeside.Button[3],true)
								end
							end
						end
					else
						if(isElement(Lakeside.Image[1]))then
							Lakeside.Image[1]:destroy()
						end
						dgsSetText(Lakeside.Label[1],standartInventoryTXT)
					end
				end
			end,
		false)
		
		addEventHandler("onDgsMouseClick",Lakeside.Button[3],
			function(btn,state)
				if(btn=="left" and state=="down")then
					local item1=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
					if(item1>0)then
						local amount=tonumber(dgsGetText(Lakeside.Edit[1]))or 0
						if(isOnlyNumbers(amount)and tonumber(amount)>=1)then
							local selectedGrid,_=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
							local selectedItem=dgsGridListGetItemText(Lakeside.Gridlist[1],selectedGrid,item)
							if(selectedItem)then
								if(validItemsTable[selectedItem])then
									triggerServerEvent("destroy:item",lp,selectedItem,tonumber(amount))
									if(isElement(Lakeside.Image[1]))then
										Lakeside.Image[1]:destroy()
									end
									dgsSetText(Lakeside.Label[1],standartInventoryTXT)
								end
							end
						end
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",Lakeside.Button[2],
			function(btn,state)
				if(btn=="left" and state=="down")then
					local item1=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
					if(item1>0)then
						local selectedGrid,_=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
						local selectedItem=dgsGridListGetItemText(Lakeside.Gridlist[1],selectedGrid,item)
						if(selectedItem)then
							if(validItemsTable[selectedItem])then
								if(selectedItem=="Ausweis")then
									dgsCloseWindow(Lakeside.Window[1])
									setWindowData("remove","cursor_clicked",true)
									triggerServerEvent("use:item",lp,selectedItem,1)
								elseif(selectedItem=="Repairkit")then
									triggerServerEvent("use:item",lp,selectedItem,1)
								elseif(selectedItem=="ChestWood")then
									triggerServerEvent("use:item",lp,selectedItem,1)
								elseif(selectedItem=="ChestIron")then
									triggerServerEvent("use:item",lp,selectedItem,1)
								elseif(selectedItem=="Kokain")then
									triggerServerEvent("use:item",lp,selectedItem,2)
								elseif(selectedItem=="Weed")then
									triggerServerEvent("use:item",lp,selectedItem,3)
								elseif(selectedItem=="Hanfsamen")then
									triggerServerEvent("use:item",lp,selectedItem,1)
								elseif(selectedItem=="Apfelsamen")then
									triggerServerEvent("use:item",lp,selectedItem,1)
								elseif(selectedItem=="Weste")then
									triggerServerEvent("use:item",lp,selectedItem,1)
								elseif(selectedItem=="Geschenk")then
									triggerServerEvent("use:item",lp,selectedItem,1)
								elseif(selectedItem=="Fishingrod")then
									triggerServerEvent("use:item",lp,selectedItem,1)
								elseif(selectedItem=="Brechstange")then
									triggerServerEvent("use:item",lp,selectedItem,1)
									dgsCloseWindow(Lakeside.Window[1])
									setWindowData("remove","cursor_clicked",false)
								elseif(selectedItem=="Benzinkanister")then
									triggerServerEvent("use:item",lp,selectedItem,1)
								elseif(selectedItem=="Barrikade")then
									triggerServerEvent("use:item",lp,selectedItem,1)
									dgsCloseWindow(Lakeside.Window[1])
									setWindowData("remove","cursor_clicked",false)
								elseif(selectedItem=="Fahrzeugschlüssel")then
									triggerServerEvent("use:item",lp,selectedItem,1)
									dgsCloseWindow(Lakeside.Window[1])
									setWindowData("remove","cursor_clicked",false)
								else
									local amount=dgsGetText(Lakeside.Edit[1])or 0
									if(isOnlyNumbers(amount)and math.floor(amount)>=1)then
										triggerServerEvent("use:item",lp,selectedItem,math.floor(amount))
										if(isElement(Lakeside.Image[1]))then
											Lakeside.Image[1]:destroy()
										end
										dgsSetText(Lakeside.Label[1],standartInventoryTXT)
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
		fillInventoryList()
	end
end)

addEvent("open:trunk",true)
addEventHandler("open:trunk",root,function()
	if(getElementData(lp,"ElementClicked")==false)then
		setWindowData("add","cursor_clicked",true)
		Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-700/2,GLOBALscreenY/2-400/2,700,400,settings.general.servername.." - Kofferraum",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,settings.general.guibgcolor,nil,true)
		dgsWindowSetSizable(Lakeside.Window[1],false)
		dgsWindowSetMovable(Lakeside.Window[1],false)
		Lakeside.Button[1]=dgsCreateButton(674,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
		dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
		dgsCreateImage(0,0,700,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
		Lakeside.Blurbox[1]=dgsCreateBlurBox()
		dgsSetProperty(Lakeside.Window[1],"functions",[[
			local arguments = {...}
			local blurbox = arguments[1]
			local renderArguments = renderArguments
			local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
			dgsBlurBoxRender(blurbox,x,y,w,h)
		]],Lakeside.Blurbox[1])
		
		dgsCreateLabel(65,4,100,10,"Dein Inventar",false,Lakeside.Window[1])
		Lakeside.Gridlist[1]=dgsCreateGridList(5,20,210,350,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
		Lakeside.ScrollBar[1]=dgsGridListGetScrollBar(Lakeside.Gridlist[1])
		dgsSetProperty(Lakeside.ScrollBar[1],"troughColor",tocolor(50,50,50,255))
		dgsSetProperty(Lakeside.ScrollBar[1],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
		dgsSetProperty(Lakeside.Gridlist[1],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
		item=dgsGridListAddColumn(Lakeside.Gridlist[1],"Item",0.62)
		amount=dgsGridListAddColumn(Lakeside.Gridlist[1],"Anzahl",0.24)
		
		dgsCreateLabel(275,4,100,10,"Fahrzeug Inventar",false,Lakeside.Window[1])
		Lakeside.Gridlist[2]=dgsCreateGridList(220,20,210,350,false,Lakeside.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
		Lakeside.ScrollBar[2]=dgsGridListGetScrollBar(Lakeside.Gridlist[2])
		dgsSetProperty(Lakeside.ScrollBar[2],"troughColor",tocolor(50,50,50,255))
		dgsSetProperty(Lakeside.ScrollBar[2],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
		dgsSetProperty(Lakeside.Gridlist[2],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
		item=dgsGridListAddColumn(Lakeside.Gridlist[2],"Item",0.62)
		amount=dgsGridListAddColumn(Lakeside.Gridlist[2],"Anzahl",0.24)
		
		
		dgsCreateLabel(445,215,100,10,"Gebe ein Zahl an, um ein Item ein/auszulagern.",false,Lakeside.Window[1])
		Lakeside.Edit[1]=dgsCreateEdit(435,230,260,40,0,false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
		Lakeside.Button[2]=dgsCreateButton(435,275,260,45,"Item einlagern",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
		Lakeside.Button[3]=dgsCreateButton(435,325,260,45,"Item auslagern",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
		
		triggerServerEvent("get:trunkitems",lp,lp)
		fillInventoryList()
		
		dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
		dgsGridListSetSortEnabled(Lakeside.Gridlist[2],false)
		
		addEventHandler("onDgsMouseClick",Lakeside.Button[3],
			function(btn,state)
				if(btn=="left" and state=="down")then
					local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[2])
					if(item>0)then
						local clicked=dgsGridListGetItemText(Lakeside.Gridlist[2],dgsGridListGetSelectedItem(Lakeside.Gridlist[2]),1)
						if(clicked~="")then
							local amount=dgsGetText(Lakeside.Edit[1])
							if(isOnlyNumbers(amount)and tonumber(amount)>=1)then
								triggerServerEvent("trunk:putout",lp,getPlayerName(lp),clicked,amount)
							end
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
							local amount=dgsGetText(Lakeside.Edit[1])
							if(isOnlyNumbers(amount)and tonumber(amount)>=1)then
								triggerServerEvent("trunk:putin",lp,getPlayerName(lp),clicked,amount)
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
end)


addEvent("set:trunkitems",true)
addEventHandler("set:trunkitems",root,function(tbl)
	dgsGridListClear(Lakeside.Gridlist[2])
	if(#tbl>=1)then
		for _,v in pairs(tbl)do
			local row=dgsGridListAddRow(Lakeside.Gridlist[2])
			dgsGridListSetItemText(Lakeside.Gridlist[2],row,item,v[1],false,false)
			dgsGridListSetItemText(Lakeside.Gridlist[2],row,amount,v[2],false,false)
		end
	end
end)

function fillInventoryList()
	fillWithItems(Lakeside.Gridlist[1],item,amount)
end
addEvent("refresh:inventory",true)
addEventHandler("refresh:inventory",root,fillInventoryList)

function fillWithItems(grid,itemName,itemCount)
	dgsGridListClear(grid)
	
	--//General
	local IDcard=tonumber(syncClientGetElementData("Ausweis"))
	local Benzinkanister=tonumber(syncClientGetElementData("Benzinkanister"))
	local VehicleKey=tonumber(syncClientGetElementData("Fahrzeugschlüssel"))
	local Repairkit=tonumber(syncClientGetElementData("Repairkit"))
	if(IDcard>=1 or Benzinkanister>=1 or VehicleKey>=1 or Repairkit>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"General",true,false)
		dgsGridListSetItemColor(grid,row,itemName,0,100,255,255)
		
		if(IDcard>=1)then
			local row=dgsGridListAddRow(grid)
			dgsGridListSetItemText(grid,row,itemName,"Ausweis",false,false)
			dgsGridListSetItemText(grid,row,itemCount,tonumber(IDcard),false,false)
		end
		if(Benzinkanister>=1)then
			local row=dgsGridListAddRow(grid)
			dgsGridListSetItemText(grid,row,itemName,"Benzinkanister",false,false)
			dgsGridListSetItemText(grid,row,itemCount,tonumber(Benzinkanister),false,false)
		end
		if(VehicleKey>=1)then
			local row=dgsGridListAddRow(grid)
			dgsGridListSetItemText(grid,row,itemName,"Fahrzeugschlüssel",false,false)
			dgsGridListSetItemText(grid,row,itemCount,tonumber(VehicleKey),false,false)
		end
		if(Repairkit>=1)then
			local row=dgsGridListAddRow(grid)
			dgsGridListSetItemText(grid,row,itemName,"Repairkit",false,false)
			dgsGridListSetItemText(grid,row,itemCount,tonumber(Repairkit),false,false)
		end
	end
	--//Essen/Trinken
	local Apple=tonumber(syncClientGetElementData("Apfel"))
	local Burger=tonumber(syncClientGetElementData("Burger"))
	local Cola=tonumber(syncClientGetElementData("Cola"))
	local Pizza=tonumber(syncClientGetElementData("Pizza"))
	local Candycane=tonumber(syncClientGetElementData("Zuckerstange"))
	local Trout=tonumber(syncClientGetElementData("Forelle"))
	if(Apple>=1 or Burger>=1 or Cola>=1 or Pizza>=1 or Candycane>=1 or Trout>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Essen/Trinken",true,false)
		dgsGridListSetItemColor(grid,row,itemName,0,200,0,255)
		if(Apple>=1)then
			local row=dgsGridListAddRow(grid)
			dgsGridListSetItemText(grid,row,itemName,"Apfel",false,false)
			dgsGridListSetItemText(grid,row,itemCount,tonumber(Apple),false,false)
		end
		if(Burger>=1)then
			local row=dgsGridListAddRow(grid)
			dgsGridListSetItemText(grid,row,itemName,"Burger",false,false)
			dgsGridListSetItemText(grid,row,itemCount,tonumber(Burger),false,false)
		end
		if(Cola>=1)then
			local row=dgsGridListAddRow(grid)
			dgsGridListSetItemText(grid,row,itemName,"Cola",false,false)
			dgsGridListSetItemText(grid,row,itemCount,tonumber(Cola),false,false)
		end
		if(Pizza>=1)then
			local row=dgsGridListAddRow(grid)
			dgsGridListSetItemText(grid,row,itemName,"Pizza",false,false)
			dgsGridListSetItemText(grid,row,itemCount,tonumber(Pizza),false,false)
		end
		if(Candycane>=1)then
			local row=dgsGridListAddRow(grid)
			dgsGridListSetItemText(grid,row,itemName,"Zuckerstange",false,false)
			dgsGridListSetItemText(grid,row,itemCount,tonumber(Candycane),false,false)
		end
		if(Trout>=1)then
			local row=dgsGridListAddRow(grid)
			dgsGridListSetItemText(grid,row,itemName,"Forelle",false,false)
			dgsGridListSetItemText(grid,row,itemCount,tonumber(Trout),false,false)
		end
	end
	--//Illegales
	local Cocaine=tonumber(syncClientGetElementData("Kokain"))
	local Weed=tonumber(syncClientGetElementData("Weed"))
	local Mats=tonumber(syncClientGetElementData("Mats"))
	local Brechstange=tonumber(syncClientGetElementData("Brechstange"))
	if(Cocaine>=1 or Weed>=1 or Mats>=1 or Brechstange>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Illegales",true,false)
		dgsGridListSetItemColor(grid,row,itemName,220,0,0,255)
		if(Cocaine>=1)then
			local row=dgsGridListAddRow(grid)
			dgsGridListSetItemText(grid,row,itemName,"Kokain",false,false)
			dgsGridListSetItemText(grid,row,itemCount,tonumber(Cocaine),false,false)
		end
		if(Weed>=1)then
			local row=dgsGridListAddRow(grid)
			dgsGridListSetItemText(grid,row,itemName,"Weed",false,false)
			dgsGridListSetItemText(grid,row,itemCount,tonumber(Weed),false,false)
		end
		if(Mats>=1)then
			local row=dgsGridListAddRow(grid)
			dgsGridListSetItemText(grid,row,itemName,"Mats",false,false)
			dgsGridListSetItemText(grid,row,itemCount,tonumber(Mats),false,false)
		end
		if(Brechstange>=1)then
			local row=dgsGridListAddRow(grid)
			dgsGridListSetItemText(grid,row,itemName,"Brechstange",false,false)
			dgsGridListSetItemText(grid,row,itemCount,tonumber(Brechstange),false,false)
		end
	end
	--//Samen
	local WeedSeeds=tonumber(syncClientGetElementData("Hanfsamen"))
	local AppleSeeds=tonumber(syncClientGetElementData("Apfelsamen"))
	if(WeedSeeds>=1 or AppleSeeds>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Samen",true,false)
		dgsGridListSetItemColor(grid,row,itemName,255,80,0,255)
		if(WeedSeeds>=1)then
			local row=dgsGridListAddRow(grid)
			dgsGridListSetItemText(grid,row,itemName,"Hanfsamen",false,false)
			dgsGridListSetItemText(grid,row,itemCount,tonumber(WeedSeeds),false,false)
		end
		if(AppleSeeds>=1)then
			local row=dgsGridListAddRow(grid)
			dgsGridListSetItemText(grid,row,itemName,"Apfelsamen",false,false)
			dgsGridListSetItemText(grid,row,itemCount,tonumber(AppleSeeds),false,false)
		end
	end
	--//Angelsachen
	local Fishingrod=tonumber(syncClientGetElementData("Fishingrod"))
	local Fishinghook=tonumber(syncClientGetElementData("Fishinghook"))
	local Bait=tonumber(syncClientGetElementData("Köder"))
	if(Fishingrod>=1 or Fishinghook>=1 or Bait>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Angelsachen",true,false)
		dgsGridListSetItemColor(grid,row,itemName,0,0,255,255)
		if(Fishingrod>=1)then
			local row=dgsGridListAddRow(grid)
			dgsGridListSetItemText(grid,row,itemName,"Fishingrod",false,false)
			dgsGridListSetItemText(grid,row,itemCount,tonumber(Fishingrod),false,false)
		end
		if(Fishinghook>=1)then
			local row=dgsGridListAddRow(grid)
			dgsGridListSetItemText(grid,row,itemName,"Fishinghook",false,false)
			dgsGridListSetItemText(grid,row,itemCount,tonumber(Fishinghook),false,false)
		end
		if(Bait>=1)then
			local row=dgsGridListAddRow(grid)
			dgsGridListSetItemText(grid,row,itemName,"Köder",false,false)
			dgsGridListSetItemText(grid,row,itemCount,tonumber(Bait),false,false)
		end
	end
	
	local row=dgsGridListAddRow(grid)
	dgsGridListSetItemText(grid,row,itemName,"Anderes",true,false)
	local Cigarette=tonumber(syncClientGetElementData("Zigarette"))
	if(Cigarette>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Zigarette",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Cigarette),false,false)
	end
	local Armor=tonumber(syncClientGetElementData("Weste"))
	if(Armor>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Weste",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Armor),false,false)
	end
	local ChestWood=tonumber(syncClientGetElementData("ChestWood"))
	if(ChestWood>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"ChestWood",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(ChestWood),false,false)
	end
	local ChestIron=tonumber(syncClientGetElementData("ChestIron"))
	if(ChestIron>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"ChestIron",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(ChestIron),false,false)
	end
	local TicketBronze=tonumber(syncClientGetElementData("TicketBronze"))
	if(TicketBronze>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"TicketBronze",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(TicketBronze),false,false)
	end
	local TicketSilver=tonumber(syncClientGetElementData("TicketSilver"))
	if(TicketSilver>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"TicketSilver",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(TicketSilver),false,false)
	end
	local TicketGold=tonumber(syncClientGetElementData("TicketGold"))
	if(TicketGold>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"TicketGold",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(TicketGold),false,false)
	end
	local Pickaxe=tonumber(syncClientGetElementData("Spitzhacke"))
	if(Pickaxe>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Spitzhacke",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Pickaxe),false,false)
	end
	local Moonstone=tonumber(syncClientGetElementData("Mondstein"))
	if(Moonstone>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Mondstein",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Moonstone),false,false)
	end
	
	local Present=tonumber(syncClientGetElementData("Geschenk"))
	if(Present>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Geschenk",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Present),false,false)
	end
	local Barrikade=tonumber(syncClientGetElementData("Barrikade"))
	if(Barrikade>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Barrikade",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Barrikade),false,false)
	end
end



addEvent("open:idcard",true)
addEventHandler("open:idcard",root,function()
	if(isLoggedin())then
		setWindowData("add","cursor_clicked",false)
		Lakeside.Window[1]=dgsCreateImage(GLOBALscreenX/2-460/2,GLOBALscreenY/2-300/2,460,300,"Files/Images/IDcard.png",false)
		
		Lakeside.Button[1]=dgsCreateButton(440,0,20,20,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
		
		local pname=getPlayerName(lp)
		local skin=getElementModel(lp)
		local bankpin=tonumber(syncClientGetElementData("Bankpin"))
		local carlicense=tonumber(syncClientGetElementData("CarLicense"))
		local bikelicense=tonumber(syncClientGetElementData("BikeLicense"))
		local gunlicense=tonumber(syncClientGetElementData("GunLicense"))
		local panote=tonumber(syncClientGetElementData("Note"))
		if(bankpin~=0)then
			bankpin=bankpin
		else
			bankpin="Du besitzt kein Bankaccount!"
		end
		if(carlicense==1)then
			carlicense="Vorhanden"
		else
			carlicense="nicht Vorhanden"
		end
		if(bikelicense==1)then
			bikelicense="Vorhanden"
		else
			bikelicense="nicht Vorhanden"
		end
		if(gunlicense==1)then
			gunlicense="Vorhanden"
		else
			gunlicense="nicht Vorhanden"
		end
		if(panote~=0)then
			panote=panote
		else
			panote="Du hast kein Academy Note!"
		end
		
		Lakeside.Label[1]=dgsCreateLabel(15,60,100,10,"Benutzername: "..pname,false,Lakeside.Window[1])
		Lakeside.Label[2]=dgsCreateLabel(15,80,100,10,"Geburtsdatum: "..syncClientGetElementData("BirthDate"),false,Lakeside.Window[1])
		Lakeside.Label[3]=dgsCreateLabel(15,100,100,10,"Bankpin: "..bankpin,false,Lakeside.Window[1])
		Lakeside.Label[4]=dgsCreateLabel(15,120,100,10,"PA Note: "..panote,false,Lakeside.Window[1])
		Lakeside.Label[5]=dgsCreateLabel(15,160,100,10,"Joblevel: "..tonumber(syncClientGetElementData("Joblevel")),false,Lakeside.Window[1])
		Lakeside.Label[6]=dgsCreateLabel(15,180,100,10,"Jobexp: "..tonumber(syncClientGetElementData("Jobexp")).."/"..settings.level.job[tonumber(syncClientGetElementData("Joblevel"))],false,Lakeside.Window[1])
		
		Lakeside.Label[7]=dgsCreateLabel(15,210,100,10,"Lizenzen:",false,Lakeside.Window[1])
		Lakeside.Label[8]=dgsCreateLabel(15,230,100,10,"Auto-Führerschein: "..carlicense.." (StVO Punkte: "..syncClientGetElementData("CarLicensePoints").."/15)",false,Lakeside.Window[1])
		Lakeside.Label[9]=dgsCreateLabel(15,245,100,10,"Motorrad-Führerschein: "..bikelicense.." (StVO Punkte: "..syncClientGetElementData("BikeLicensePoints").."/15)",false,Lakeside.Window[1])
		Lakeside.Label[12]=dgsCreateLabel(15,280,100,10,"Waffen-Schein: "..gunlicense.."",false,Lakeside.Window[1])
		dgsLabelSetColor(Lakeside.Label[1],0,0,0)
		dgsLabelSetColor(Lakeside.Label[2],0,0,0)
		dgsLabelSetColor(Lakeside.Label[3],0,0,0)
		dgsLabelSetColor(Lakeside.Label[4],0,0,0)
		dgsLabelSetColor(Lakeside.Label[5],0,0,0)
		dgsLabelSetColor(Lakeside.Label[6],0,0,0)
		dgsLabelSetColor(Lakeside.Label[7],0,0,0)
		dgsLabelSetColor(Lakeside.Label[8],0,0,0)
		dgsLabelSetColor(Lakeside.Label[9],0,0,0)
		dgsLabelSetColor(Lakeside.Label[12],0,0,0)
		dgsSetProperty(Lakeside.Label[7],"textSize",{1.2,1.2})
		
		
		addEventHandler("onDgsMouseClick",Lakeside.Button[1],
			function(btn,state)
				if(btn=="left" and state=="down")then
					Lakeside.Window[1]:destroy()
					setWindowData("remove","cursor_clicked",false)
				end
			end,
		false)
	end
end)














local lsdColorsTable={{255,0,255},{0,255,0},{255,255,255},{255,255,0},{151,255,255},{255,0,0},{255,20,147},{0,250,154},{0,255,255}}
local drugColorsTable={{0,200,0},{0,100,0},{0,220,0},{0,80,0}}
local drugLight

function drawDrugEffects_Func()
	for i=100,350,1 do
		local color,x,y=math.random(1,#drugColorsTable),math.random(3,15),math.random(3,17)
		local posx,posy=math.random(1,GLOBALscreenX-x),math.random(1,GLOBALscreenY-y)
		dxDrawRectangle(posx,posy,x,y,tocolor(drugColorsTable[color][1],drugColorsTable[color][2],drugColorsTable[color][3],math.random(1,160)),false,true)
	end
end

function drawCocaineEffects_Func()
	for i=1200,3000,1 do
		local color,x,y=math.random(1,#drugColorsTable),math.random(16,30),math.random(25,50)
		local posx,posy=math.random(1,GLOBALscreenX-x),math.random(1,GLOBALscreenY-y)
		dxDrawRectangle(posx,posy,x,y,tocolor(drugColorsTable[color][1],drugColorsTable[color][2],drugColorsTable[color][3],math.random(1,160)),false,true)
	end
	
	local x,y,z=getElementPosition(lp)
	setSearchLightStartPosition(drugLight,x,y,z+10)
	setSearchLightEndPosition(drugLight,x,y,z-0.95)
end

addEvent("use:weedeffect",true)
addEventHandler("use:weedeffect",root,function()
	if(not(isTimer(CocaineTimer)))then
		if(not(isTimer(WeedTimer)))then
			local WeedCounter=0
			WeedTimer=setTimer(function()
				WeedCounter=WeedCounter+1
				if(WeedCounter==8)then
					local x,y,z=getElementPosition(lp)
					setGameSpeed(0.8)
					setElementHealth(lp,getElementHealth(lp)+1)
					addEventHandler("onClientRender",root,drawDrugEffects_Func)
				end
				if(WeedCounter>=14)then
					setCameraShakeLevel(80)
					if(isElement(WeedSound))then
						WeedSound:destroy()
					end
					WeedSound=playSound(":"..settings.general.scriptname.."/Files/Sounds/Weedeffects.mp3",true)
					setSoundVolume(WeedSound,1)
				end
				if(WeedCounter>=60)then
					setCameraShakeLevel(0)
					setGameSpeed(1)
					WeedTimer:destroy()
					if(isElement(WeedSound))then
						WeedSound:destroy()
					end
					removeEventHandler("onClientRender",root,drawDrugEffects_Func)
				end
			end,1000,63)
		end
	end
end)

addEvent("use:cocaineeffect",true)
addEventHandler("use:cocaineeffect",root,function()
	if(not(isTimer(WeedTimer)))then
		if(not(isTimer(CocaineTimer)))then
			local CocaineCounter=0
			CocaineTimer=setTimer(function()
				CocaineCounter=CocaineCounter+1
				if(CocaineCounter==8)then
					local x,y,z=getElementPosition(lp)
					setGameSpeed(1.7)
					setElementHealth(lp,getElementHealth(lp)+8)
					addEventHandler("onClientRender",root,drawCocaineEffects_Func)
				end
				if(CocaineCounter>=10)then
					setCameraShakeLevel(165)
					if(isElement(CocaineSound))then
						CocaineSound:destroy()
					end
					CocaineSound=playSound(":"..settings.general.scriptname.."/Files/Sounds/Weedeffects.mp3",true)
					setSoundVolume(CocaineSound,1)
				end
				if(CocaineCounter>=70)then
					setCameraShakeLevel(0)
					setGameSpeed(1)
					setElementHealth(lp,getElementHealth(lp)+12)
					CocaineTimer:destroy()
					if(isElement(CocaineSound))then
						CocaineSound:destroy()
					end
					removeEventHandler("onClientRender",root,drawCocaineEffects_Func)
				end
			end,1000,73)
		end
	end
end)