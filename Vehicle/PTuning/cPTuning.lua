--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local function deleteAllUIItems()
	if(isElement(Lakeside.Button[30]))then
		Lakeside.Button[30]:destroy()
	end
	if(isElement(Lakeside.Button[31]))then
		Lakeside.Button[31]:destroy()
	end
end

local lackTable={
	{"STICKER_1",50000,"n/a"},
	{"STICKER_2",50000,"n/a"},
	{"HIPSTER_1",45000,"n/a"},
	{"HIPSTER_2",45000,"n/a"},
	{"SPACE_1",55000,"n/a"},
	{"SPACE_2",55000,"n/a"},
	{"SPACE_3",55000,"n/a"},
	{"WEED_1",50000,"n/a"},
	{"WEED_2",50000,"n/a"},
	{"CAMOUFLAGE_1",60000,"n/a"},
	{"CAMOUFLAGE_2",60000,"n/a"},
	{"CAMOUFLAGE_3",60000,"n/a"},
	{"CAMOUFLAGE_4",60000,"n/a"},
	{"NEXUS_1",55000,"n/a"},
}
local lightTable={
	{"1",10000},
	{"2",10000},
	{"3",10000},
	{"4",10000},
	{"5",10000},
	{"6",10000},
	{"7",10000},
	{"8",10000},
	{"9",14000},
	{"10",14000},
	{"11",14000},
	{"12",14000},
	{"13",14000},
	{"14",18000},
}
local otherTunings={
	{"Flügeltüren"},
}

function ptuningUI()
	if(getElementData(lp,"ElementClicked")==false)then
		Tuningsystem.kameraPos=1
		
		setWindowData("add","cursor_clicked",true)
		if(not isElement(Lakeside.Music[1]))then
			Lakeside.Music[1]=playSound(":"..settings.general.scriptname.."/Files/Sounds/Tuningshop.mp3",true)
			setSoundVolume(Lakeside.Music[1],0.6)
			setSoundEffectEnabled(Lakeside.Music[1],"reverb",true)
		end
		Lakeside.Window[1]=dgsCreateWindow(5,5,600,410,settings.general.servername.." - Spezialtuning",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,settings.general.guibgcolor,nil,true)
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
		
		setVehicleDoorOpenRatio(getPedOccupiedVehicle(lp),0,0)
		setVehicleDoorOpenRatio(getPedOccupiedVehicle(lp),1,0)
		setVehicleDoorOpenRatio(getPedOccupiedVehicle(lp),2,0)
		setVehicleDoorOpenRatio(getPedOccupiedVehicle(lp),3,0)
		setVehicleDoorOpenRatio(getPedOccupiedVehicle(lp),4,0)
		setVehicleDoorOpenRatio(getPedOccupiedVehicle(lp),5,0)
		
		Lakeside.Tabpanel[1]=dgsCreateTabPanel(5,10,590,370,false,Lakeside.Window[1])
		Lakeside.Tab[1]=dgsCreateTab("Speziallack",Lakeside.Tabpanel[1])
		
		Lakeside.Gridlist[1]=dgsCreateGridList(5,5,325,340,false,Lakeside.Tab[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
		Lakeside.ScrollBar[1]=dgsGridListGetScrollBar(Lakeside.Gridlist[1])
		dgsSetProperty(Lakeside.ScrollBar[1],"troughColor",tocolor(50,50,50,255))
		dgsSetProperty(Lakeside.ScrollBar[1],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
		dgsSetProperty(Lakeside.Gridlist[1],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
		local lack=dgsGridListAddColumn(Lakeside.Gridlist[1],"Lack",0.4)
		local lackprice=dgsGridListAddColumn(Lakeside.Gridlist[1],"Preis",0.22)
		local lackowner=dgsGridListAddColumn(Lakeside.Gridlist[1],"Ersteller",0.4)
		
		Lakeside.Button[2]=dgsCreateButton(340,10,115,35,"Lackierung einbauen",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
		Lakeside.Button[3]=dgsCreateButton(465,10,115,35,"Lackierung ausbauen",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
		
		dgsCreateLabel(345,90,100,20,"ACHTUNG: Einige Lackierung könnten\nnicht richtig angezeigt werden, da dies\nam Jeweiligem Auto liegt.",false,Lakeside.Tab[1])
		dgsCreateLabel(420,240,100,20,"Drücke <- oder ->\num die Kamera zu drehen",false,Lakeside.Tab[1],_,_,_,_,_,_,"center",_)
		
		Lakeside.Tab[2]=dgsCreateTab("Speziallichter",Lakeside.Tabpanel[1])
		
		Lakeside.Gridlist[2]=dgsCreateGridList(5,5,280,340,false,Lakeside.Tab[2],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
		Lakeside.ScrollBar[1]=dgsGridListGetScrollBar(Lakeside.Gridlist[2])
		dgsSetProperty(Lakeside.ScrollBar[1],"troughColor",tocolor(50,50,50,255))
		dgsSetProperty(Lakeside.ScrollBar[1],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
		dgsSetProperty(Lakeside.Gridlist[2],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
		local light=dgsGridListAddColumn(Lakeside.Gridlist[2],"Licht",0.4)
		local lightprice=dgsGridListAddColumn(Lakeside.Gridlist[2],"Preis",0.22)
		
		Lakeside.Button[4]=dgsCreateButton(340,10,115,35,"Lichter einbauen",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
		Lakeside.Button[5]=dgsCreateButton(465,10,115,35,"Lichter ausbauen",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
		
		dgsCreateLabel(395,240,100,20,"Drücke <- oder ->\num die Kamera zu drehen",false,Lakeside.Tab[2],_,_,_,_,_,_,"center",_)
		
		Lakeside.Tab[6]=dgsCreateTab("Anderes",Lakeside.Tabpanel[1])
		
		Lakeside.Gridlist[6]=dgsCreateGridList(5,5,280,340,false,Lakeside.Tab[6],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
		Lakeside.ScrollBar[1]=dgsGridListGetScrollBar(Lakeside.Gridlist[6])
		dgsSetProperty(Lakeside.ScrollBar[1],"troughColor",tocolor(50,50,50,255))
		dgsSetProperty(Lakeside.ScrollBar[1],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
		dgsSetProperty(Lakeside.Gridlist[6],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
		local tuning=dgsGridListAddColumn(Lakeside.Gridlist[6],"Tuning",0.6)
		
		
		
		for _,v in pairs(lackTable)do
			local row=dgsGridListAddRow(Lakeside.Gridlist[1])
			dgsGridListSetItemText(Lakeside.Gridlist[1],row,lack,v[1],false,false)
			dgsGridListSetItemText(Lakeside.Gridlist[1],row,lackprice,v[2],false,false)
			dgsGridListSetItemText(Lakeside.Gridlist[1],row,lackowner,v[3],false,false)
		end
		for _,v in pairs(lightTable)do
			local row=dgsGridListAddRow(Lakeside.Gridlist[2])
			dgsGridListSetItemText(Lakeside.Gridlist[2],row,light,v[1],false,false)
			dgsGridListSetItemText(Lakeside.Gridlist[2],row,lightprice,v[2],false,false)
		end
		for _,v in pairs(otherTunings)do
			local row=dgsGridListAddRow(Lakeside.Gridlist[6])
			dgsGridListSetItemText(Lakeside.Gridlist[6],row,tuning,v[1],false,false)
		end
		
		dgsGridListSetSortEnabled(Lakeside.Gridlist[1],false)
		dgsGridListSetSortEnabled(Lakeside.Gridlist[2],false)
		dgsGridListSetSortEnabled(Lakeside.Gridlist[6],false)
		
		bindKey("arrow_r","down",bindRightTuningsys_Func)
		bindKey("arrow_l","down",bindLeftTuningsys_Func)
		setCameraTuningsys_Func()
		
		
		addEventHandler("onDgsMouseClick",Lakeside.Gridlist[6],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[6])
					if(item>0)then
						local clicked=dgsGridListGetItemText(Lakeside.Gridlist[6],dgsGridListGetSelectedItem(Lakeside.Gridlist[6]),1)
						if(clicked=="Flügeltüren")then
							deleteAllUIItems()
							setVehicleDoorOpenRatio(getPedOccupiedVehicle(lp),2,1)
							setVehicleDoorOpenRatio(getPedOccupiedVehicle(lp),3,1)
							Lakeside.Button[30]=dgsCreateButton(340,10,115,35,"Türen einbauen\n$80.000",false,Lakeside.Tab[6],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
							Lakeside.Button[31]=dgsCreateButton(465,10,115,35,"Türen ausbauen\n50% erstattung",false,Lakeside.Tab[6],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
							
							addEventHandler("onDgsMouseClick",Lakeside.Button[30],
								function(btn,state)
									if(btn=="left" and state=="up")then
										triggerServerEvent("buy:ptuningdoors",lp,lp,getPedOccupiedVehicle(lp))
									end
								end,
							false)
							addEventHandler("onDgsMouseClick",Lakeside.Button[31],
								function(btn,state)
									if(btn=="left" and state=="up")then
										triggerServerEvent("sell:ptuningdoors",lp,lp,getPedOccupiedVehicle(lp))
									end
								end,
							false)
						end
					end
				end
			end,
		false)
		
		addEventHandler("onDgsMouseClick",Lakeside.Button[5],
			function(btn,state)
				if(btn=="left" and state=="up")then
					triggerServerEvent("sell:ptuningLight",lp,lp,getPedOccupiedVehicle(lp))
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",Lakeside.Button[4],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[2])
					if(item>0)then
						local clicked=dgsGridListGetItemText(Lakeside.Gridlist[2],dgsGridListGetSelectedItem(Lakeside.Gridlist[2]),1)
						if(clicked~="")then
							local clickedpreis=dgsGridListGetItemText(Lakeside.Gridlist[2],dgsGridListGetSelectedItem(Lakeside.Gridlist[2]),2)
							if(clickedpreis)then
								triggerServerEvent("buy:ptuningLight",lp,lp,getPedOccupiedVehicle(lp),clicked,clickedpreis)
								setVehicleDoorOpenRatio(getPedOccupiedVehicle(lp),2,0)
								setVehicleDoorOpenRatio(getPedOccupiedVehicle(lp),3,0)
							end
						end
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",Lakeside.Button[3],
			function(btn,state)
				if(btn=="left" and state=="up")then
					triggerServerEvent("sell:ptuningPaintjob",lp,lp,getPedOccupiedVehicle(lp))
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",Lakeside.Gridlist[2],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[2])
					if(item>0)then
						local clicked=dgsGridListGetItemText(Lakeside.Gridlist[2],dgsGridListGetSelectedItem(Lakeside.Gridlist[2]),1)
						if(clicked~="")then
							triggerServerEvent("show:ptuningLight",lp,lp,getPedOccupiedVehicle(lp),clicked)
							setVehicleDoorOpenRatio(getPedOccupiedVehicle(lp),2,0)
							setVehicleDoorOpenRatio(getPedOccupiedVehicle(lp),3,0)
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
						local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
						if(clicked~="")then
							local clickedpreis=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),2)
							if(clickedpreis)then
								triggerServerEvent("buy:ptuningPaintjob",lp,lp,getPedOccupiedVehicle(lp),clicked,clickedpreis)
								setVehicleDoorOpenRatio(getPedOccupiedVehicle(lp),2,0)
								setVehicleDoorOpenRatio(getPedOccupiedVehicle(lp),3,0)
							end
						end
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",Lakeside.Gridlist[1],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local item=dgsGridListGetSelectedItem(Lakeside.Gridlist[1])
					if(item>0)then
						local clicked=dgsGridListGetItemText(Lakeside.Gridlist[1],dgsGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
						if(clicked~="")then
							triggerServerEvent("show:ptuningPaintjob",lp,lp,getPedOccupiedVehicle(lp),clicked)
							setVehicleDoorOpenRatio(getPedOccupiedVehicle(lp),2,0)
							setVehicleDoorOpenRatio(getPedOccupiedVehicle(lp),3,0)
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
					triggerServerEvent("leave:ptuning",lp,lp)
					unbindKey("arrow_r","down",bindRightTuningsys_Func)
					unbindKey("arrow_l","down",bindLeftTuningsys_Func)
					if(Lakeside.Music[1])then
						Lakeside.Music[1]:destroy()
					end
				end
			end,
		false)
	end
end
addEvent("show:ptuningUI",true)
addEventHandler("show:ptuningUI",root,ptuningUI)



function loadVehiclePaintjob(paintjobname,vehicle)
	if(vehicle)then
		if(paintjobname)then
			if(paintjobname==nil or paintjobname=="" or paintjobname=="1" or paintjobname=="2" or paintjobname=="3")then
				paintjobname="0"
			else
				myTexture=dxCreateTexture(":"..settings.general.scriptname.."/Files/Textures/Paintjobs/"..paintjobname..".png")
				shader_cars=dxCreateShader(":"..settings.general.scriptname.."/Files/Textures/Paintjobs/Paintjob.fx")
				engineRemoveShaderFromWorldTexture(shader_cars,"vehiclegrunge256",vehicle)
				engineApplyShaderToWorldTexture(shader_cars,"vehiclegrunge256",vehicle)
				engineApplyShaderToWorldTexture(shader_cars,"?emap*",vehicle)
				dxSetShaderValue(shader_cars,"import_texture",myTexture)
			end
		end
	end
end
addEvent("load:vehiclePaintjob",true)
addEventHandler("load:vehiclePaintjob",root,loadVehiclePaintjob)
function loadvehicleLight(lightname,vehicle)
	if(vehicle)then
		if(lightname)then
			if(lightname==nil or lightname=="" or lightname=="0")then
			else
				myTexture=dxCreateTexture(":"..settings.general.scriptname.."/Files/Textures/Lights/"..lightname..".png","dxt3")
				shader_cars=dxCreateShader(":"..settings.general.scriptname.."/Files/Textures/Lights/Light.fx")
				engineRemoveShaderFromWorldTexture(shader_cars,"vehiclelights128",vehicle)
				engineRemoveShaderFromWorldTexture(shader_cars,"vehiclelightson128",vehicle)
				engineApplyShaderToWorldTexture ( shader_cars,"vehiclelights128",vehicle)
				engineApplyShaderToWorldTexture(shader_cars,"vehiclelightson128",vehicle)
				dxSetShaderValue(shader_cars,"gTexture",myTexture)
			end
		end
	end
end
addEvent("load:vehicleLight",true)
addEventHandler("load:vehicleLight",root,loadvehicleLight)

local oldDoorRatios={}
local doorStatus={}
local doorTimers={}
vehiclesWithScissorDoor={}
local doorAnimTime=250

function isVehicle(vehicle)
	if vehicle and isElement(vehicle)and getElementType(vehicle)=="vehicle" then
		return true
	end
end
addEventHandler("onClientResourceStart",resourceRoot,function()
	for _,vehicle in pairs(getElementsByType("vehicle"))do
		if isElementStreamedIn(vehicle) then
			if getElementData(vehicle,"Fluegeldoors")==1 or getElementData(vehicle,"Previewdoors")==1 then
				vehiclesWithScissorDoor[vehicle]=true
			end
		end
	end
end)
addEventHandler("onClientElementStreamIn",root,function()
	if isVehicle(source)then
		if getElementData(source,"Fluegeldoors")==1 or getElementData(source,"Previewdoors")==1 then
			vehiclesWithScissorDoor[source]=true
		end
	end
end)
addEventHandler("onClientElementDataChange",root,function(data)
	if isVehicle(source)then
		if data=="Fluegeldoors" or data=="Previewdoors" then
			if isElementStreamedIn(source)then
				vehiclesWithScissorDoor[source]=getElementData(source,"Fluegeldoors")==1
				vehiclesWithScissorDoor[source]=getElementData(source,"Previewdoors")==1
				
				if not vehiclesWithScissorDoor[source] then
					removeVehicleFromTable(source)
				end
			end
		end
	end
end)

addEventHandler("onClientPreRender",root,function()
	for vehicle in pairs(vehiclesWithScissorDoor)do
		if isElement(vehicle)then
			if not doorTimers[vehicle] then
				doorTimers[vehicle]={}
			end
			local doorRatios={}
			for i=1,4 do
				local i=i+1
				local doorRatio=getVehicleDoorOpenRatio(vehicle,i)
				if doorRatio and oldDoorRatios[vehicle] and oldDoorRatios[vehicle][i] then
					local oldDoorRatio=oldDoorRatios[vehicle][i]
					if not doorStatus[vehicle] then
						doorStatus[vehicle]={}
					end
					
					local doorPreviousState=doorStatus[vehicle][i]
					
					if not doorPreviousState then
						doorPreviousState="closed"
					end
					
					if doorPreviousState=="closed" and doorRatio>oldDoorRatio then
						doorStatus[vehicle][i]="opening"
						doorTimers[vehicle][i]=setTimer(function(vehicle,i)
							doorStatus[vehicle][i]="open"
							doorTimers[vehicle][i]=nil
						end, doorAnimTime,1,vehicle,i)
					elseif doorPreviousState=="open" and doorRatio<oldDoorRatio then
						doorStatus[vehicle][i]="closing"
						doorTimers[vehicle][i]=setTimer(function(vehicle,i)
							doorStatus[vehicle][i]="closed"
							doorTimers[vehicle][i]=nil
						end, doorAnimTime,1,vehicle,i)
					end
				elseif not oldDoorRatios[vehicle] then
					oldDoorRatios[vehicle]={}
				end
				
				if doorRatio then
					oldDoorRatios[vehicle][i]=doorRatio
				end
			end
		else
			vehiclesWithScissorDoor[vehicle]=nil
			oldDoorRatios[vehicle]=nil
			doorStatus[vehicle]=nil
			doorTimers[vehicle]=nil
		end
	end
	
	for vehicle,doors in pairs(doorStatus)do
		if vehiclesWithScissorDoor[vehicle] then
			local doorX,doorY,doorZ=-72,-25,0
			for i,v in pairs(doors) do
				local ratio=0
				
				if v=="open" then
					ratio=1
				end
				
				local doorTimer=doorTimers[vehicle][i]
				
				if doorTimer and isTimer(doorTimer)then
					local timeLeft=getTimerDetails(doorTimer)
					
					ratio=timeLeft/doorAnimTime
					
					if v=="opening" then
						ratio=1-ratio
					end
				end
				local dummyName=(i==2 and "door_lf_dummy")or(i==3 and "door_rf_dummy")
				if dummyName then
					local doorX,doorY,doorZ=doorX*ratio,doorY*ratio,doorZ*ratio
					if string.find(dummyName,"rf")then
						doorY,doorZ=doorY*-1,doorZ*-1
					end
					setVehicleComponentRotation(vehicle,dummyName,doorX,doorY,doorZ)
				end
			end
		end
	end
end)
addEventHandler("onClientVehicleDamage",root,function()
	local leftDoor=getVehicleDoorState(source,2)
	local rightDoor=getVehicleDoorState(source,3)
	if leftDoor==1 then
		setVehicleDoorOpenRatio(source,2,0,500)
	end
	if rightDoor==1 then
		setVehicleDoorOpenRatio(source,3,0,500)
	end
end)
function removeVehicleFromTable(vehicle)
	if isVehicle(vehicle)then
		oldDoorRatios[vehicle]=nil
		doorStatus[vehicle]=nil
		doorTimers[vehicle]=nil
		vehiclesWithScissorDoor[vehicle]=nil
	end
end