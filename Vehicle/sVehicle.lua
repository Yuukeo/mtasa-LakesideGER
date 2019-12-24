--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

--//Tables
VehicleSoundNEW={
[411]=true,
[415]=true,
[451]=true,
[560]=true,
[541]=true,
[480]=true,
[494]=true,
[502]=true,
[503]=true,
[402]=true,
[429]=true,
[477]=true,
}

VehicleSoundBIKE={
[522]=true,
[521]=true,
[461]=true,
[581]=true,
[463]=true,
}

VehicleSoundLKW={
[403]=true,
[406]=true,
[407]=true,
[408]=true,
[414]=true,
[431]=true,
[437]=true,
[443]=true,
[455]=true,
[456]=true,
[514]=true,
[515]=true,
[524]=true,
[544]=true,
[578]=true,
}

function setSeatbeltState(player,typ)
	if(typ=="true")then
		setElementData(player,"seatbelt",true)
		triggerClientEvent(player,"stop:seatbeltsound",player)
		triggerClientEvent(player,"start:seatbeltclicksound",player)
	elseif(typ=="false")then
		setElementData(player,"seatbelt",false)
		triggerClientEvent(player,"start:seatbeltsound",player)
	end
end

function Seatbelt_Func(player,key,state)
	local veh=getPedOccupiedVehicle(player)
	local id=getElementModel(veh)
	if(cars[id]or lkws[id]or bus[id])then
		if(veh and isPedInVehicle(player))then
			if(getElementData(player,"seatbelt")==true)then
				setSeatbeltState(player,"false")
			else
				setSeatbeltState(player,"true")
			end
		end
	end
end

--//Light Function
function Light_Func(player,key,state)
	if(getPedOccupiedVehicleSeat(player)==0)then
		local veh=getPedOccupiedVehicle(player)
		if(getVehicleOverrideLights(veh)~=2)then
			veh:setOverrideLights(2)
			setElementData(veh,"light",true)
		else
			veh:setOverrideLights(1)
			setElementData(veh,"light",false)
		end
	end
end

function lockVehicle(player)
	if(player:getDimension()==0 and player:getInterior()==0)then
		for _,v in pairs(getElementsByType("vehicle"))do
			if(getElementData(v,"Owner")==getPlayerName(player)or getElementData(v,"Owner")==tonumber(syncGetElementData(player,"Faction"))or getElementData(v,"Owner")==tonumber(syncGetElementData(player,"Company"))or getElementData(v,"KeyTarget1")==getPlayerName(player)or getElementData(v,"KeyTarget2")==getPlayerName(player))then
				if(getElementDimension(v)==getElementDimension(player))then
					local x,y,z=getElementPosition(v)
					local lightstate=getVehicleOverrideLights(v)
					if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(player))<=3.2)then
						if(isVehicleLocked(v)==false)then
							setVehicleLocked(v,true)
							triggerClientEvent(player,"draw:infobox",root,"info","Fahrzeug '"..getVehicleName(v).."' abgeschlossen!")
							if(x)and(y)and(z)then
								triggerClientEvent(root,"playSound3D_mp3",root,player,"Vehicle/Carlock_Out",x,y,z,false,1)
							end
						else
							setVehicleLocked(v,false)
							triggerClientEvent(player,"draw:infobox",root,"info","Fahrzeug '"..getVehicleName(v).."' aufgeschlossen!")
							if(x)and(y)and(z)then
								triggerClientEvent(root,"playSound3D_mp3",root,player,"Vehicle/Carlock_Out",x,y,z,false,1)
							end
						end
						if(lightstate==1)then
							setVehicleOverrideLights(v,2)
							setTimer(setVehicleOverrideLights,200,1,v,1)
						else
							setVehicleOverrideLights(v,1)
							setTimer(setVehicleOverrideLights,200,1,v,2)
						end
					end
				end
			end
		end
	end
end

function parkVehicle(player)
	if(isPedInVehicle(player))then
		local veh=getPedOccupiedVehicle(player)
		local seat=getPedOccupiedVehicleSeat(player)
		if(seat==0)then
			local owner=getElementData(veh,"Owner")
			local slot=tonumber(getElementData(veh,"Slot"))
			local fuel=getElementData(veh,"Fuel")
			local vx,vy,vz=getElementVelocity(getPedOccupiedVehicle(player))
			local speed=math.sqrt(vx^2+vy^2+vz^2)
			if(speed<5*0.00464)then
			else
				return
			end
			if(owner==getPlayerName(player))then
				local x,y,z=getElementPosition(veh)
				local rx,ry,rz=getElementRotation(veh)
				
				if(owner and slot)then
					handler:exec("UPDATE ?? SET ??=?,??=?,??=?,??=?,??=?,??=?,??=? WHERE ??=? AND ??=?","uservehicles","SpawnX",x,"SpawnY",y,"SpawnZ",z,"RotX",rx,"RotY",ry,"RotZ",rz,"Fuel",fuel,"Owner",owner,"Slot",slot)
					triggerClientEvent(player,"draw:infobox",root,"success","Du hast dein Fahrzeug erfolgreich geparkt!")
				end
			end
		end
	end
end
addCommandHandler("park",parkVehicle)

--//Engine Function
function Engine_Func(player,key,state)
	local veh=getPedOccupiedVehicle(player)
	if(isPedInVehicle(player))then
	local rdm=math.random(1,16)
		if(getPedOccupiedVehicleSeat(player)==0)then
		if getElementData(veh,"motorworking")==true then return end
			local x,y,z=getElementPosition(veh)
			local enginestate=getVehicleEngineState(veh)
			if(not getElementData(veh,"Fuel"))then
				setElementData(veh,"Fuel",100)
				setElementData(veh,"engine",false)
				setElementData(veh,"light",false)
				veh:setEngineState(false)
				veh:setOverrideLights(1)
			end
			if(getVehicleEngineState(veh))then
				setElementData(veh,"engine",false)
				veh:setEngineState(false)
				triggerClientEvent(root,"playSound3D_mp3",root,player,"Motor_Stop",x,y,z,false)
			elseif(getElementData(veh,"Owner")==getPlayerName(player)or getElementData(veh,"KeyTarget1")==getPlayerName(player)or getElementData(veh,"KeyTarget2")==getPlayerName(player))then
				if(tonumber(getElementData(veh,"Fuel"))>=2)then
					if(tonumber(getElementData(veh,"Totalloss"))==0)then
						if(rdm==4)then
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Notstarted",x,y,z,false)
						else
							if(VehicleSoundNEW[getElementModel(veh)])then
								triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_New",x,y,z,false)
							elseif(VehicleSoundBIKE[getElementModel(veh)])then
								triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Bike",x,y,z,false)
							elseif(VehicleSoundLKW[getElementModel(veh)])then
								triggerClientEvent(root,"playSound3D_mp3",root,player,"Motor_LKW",x,y,z,false)
							else
								triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Old",x,y,z,false)
							end
						end
						if(getVehicleType(veh)~="Automobile" and getVehicleType(veh)~="Bike" and getVehicleType(veh)~="Monster Truck" and getVehicleType(veh)~="Quad")then
							if(rdm~=4)then
								setElementData(veh,"motorworking",true)
								setTimer(function()
									setElementData(veh,"motorworking",false)
									setElementData(veh,"engine",true)
									veh:setEngineState(true)
									if not getElementData(veh,"timerrunning")then
										setElementData(veh,"timerrunning",true)
										setVehicleNewFuelState(veh)
									end
								end,2000,1)
							end
						else
							triggerClientEvent(player,"start:engine",player,rdm)
						end
					else
						triggerClientEvent(player,"draw:infobox",root,"error","Das Fahrzeug hat einen Totalschaden!\nKaufe dir ein Repairkit!")
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","Das Fahrzeug hat kein Benzin mehr.")
				end
			elseif(getElementData(veh,"Owner")==tonumber(syncGetElementData(player,"Faction")))then
				if tonumber(getElementData(veh,"Fuel"))>=2 then
					if(rdm==4)then
						triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Notstarted",x,y,z,false)
					else
						if(VehicleSoundNEW[getElementModel(veh)])then
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_New",x,y,z,false)
						elseif(VehicleSoundBIKE[getElementModel(veh)])then
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Bike",x,y,z,false)
						elseif(VehicleSoundLKW[getElementModel(veh)])then
							triggerClientEvent(root,"playSound3D_mp3",root,player,"Motor_LKW",x,y,z,false)
						else
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Old",x,y,z,false)
						end
					end
					if(getVehicleType(veh)~="Automobile" and getVehicleType(veh)~="Bike" and getVehicleType(veh)~="Monster Truck" and getVehicleType(veh)~="Quad")then
						if(rdm~=4)then
							setElementData(veh,"motorworking",true)
							setTimer(function()
								setElementData(veh,"motorworking",false)
								setElementData(veh,"engine",true)
								veh:setEngineState(true)
								if not getElementData(veh,"timerrunning")then
									setElementData(veh,"timerrunning",true)
									setVehicleNewFuelState(veh)
								end
							end,2000,1)
						end
					else
						triggerClientEvent(player,"start:engine",player,rdm)
					end
				end
			elseif(getElementData(veh,"Owner")==tonumber(syncGetElementData(player,"Company")))then
				if tonumber(getElementData(veh,"Fuel"))>=2 then
					if(rdm==4)then
						triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Notstarted",x,y,z,false)
					else
						if(VehicleSoundNEW[getElementModel(veh)])then
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_New",x,y,z,false)
						elseif(VehicleSoundBIKE[getElementModel(veh)])then
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Bike",x,y,z,false)
						elseif(VehicleSoundLKW[getElementModel(veh)])then
							triggerClientEvent(root,"playSound3D_mp3",root,player,"Motor_LKW",x,y,z,false)
						else
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Old",x,y,z,false)
						end
					end
					if(getVehicleType(veh)~="Automobile" and getVehicleType(veh)~="Bike" and getVehicleType(veh)~="Monster Truck" and getVehicleType(veh)~="Quad")then
						if(rdm~=4)then
							setElementData(veh,"motorworking",true)
							setTimer(function()
								setElementData(veh,"motorworking",false)
								setElementData(veh,"engine",true)
								veh:setEngineState(true)
								if not getElementData(veh,"timerrunning")then
									setElementData(veh,"timerrunning",true)
									setVehicleNewFuelState(veh)
								end
							end,2000,1)
						end
					else
						triggerClientEvent(player,"start:engine",player,rdm)
					end
				end
			elseif(getElementData(veh,"Owner")==2 and getElementData(player,"inpruefung")==true)then
				if tonumber(getElementData(veh,"Fuel"))>=2 then
					if(rdm==4)then
						triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Notstarted",x,y,z,false)
					else
						if(VehicleSoundNEW[getElementModel(veh)])then
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_New",x,y,z,false)
						elseif(VehicleSoundBIKE[getElementModel(veh)])then
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Bike",x,y,z,false)
						elseif(VehicleSoundLKW[getElementModel(veh)])then
							triggerClientEvent(root,"playSound3D_mp3",root,player,"Motor_LKW",x,y,z,false)
						else
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Old",x,y,z,false)
						end
					end
					if(getVehicleType(veh)~="Automobile" and getVehicleType(veh)~="Bike" and getVehicleType(veh)~="Monster Truck" and getVehicleType(veh)~="Quad")then
						if(rdm~=4)then
							setElementData(veh,"motorworking",true)
							setTimer(function()
								setElementData(veh,"motorworking",false)
								setElementData(veh,"engine",true)
								veh:setEngineState(true)
								if not getElementData(veh,"timerrunning")then
									setElementData(veh,"timerrunning",true)
									setVehicleNewFuelState(veh)
								end
							end,2000,1)
						end
					else
						triggerClientEvent(player,"start:engine",player,rdm)
					end
				end
			elseif(not getElementData(veh,"Owner"))then
				if tonumber(getElementData(veh,"Fuel"))>=2 then
					if(rdm==4)then
						triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Notstarted",x,y,z,false)
					else
						if(VehicleSoundNEW[getElementModel(veh)])then
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_New",x,y,z,false)
						elseif(VehicleSoundBIKE[getElementModel(veh)])then
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Bike",x,y,z,false)
						elseif(VehicleSoundLKW[getElementModel(veh)])then
							triggerClientEvent(root,"playSound3D_mp3",root,player,"Motor_LKW",x,y,z,false)
						else
							triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Old",x,y,z,false)
						end
					end
					if(getVehicleType(veh)~="Automobile" and getVehicleType(veh)~="Bike" and getVehicleType(veh)~="Monster Truck" and getVehicleType(veh)~="Quad")then
						if(rdm~=4)then
							setElementData(veh,"motorworking",true)
							setTimer(function()
								setElementData(veh,"motorworking",false)
								setElementData(veh,"engine",true)
								veh:setEngineState(true)
								if not getElementData(veh,"timerrunning")then
									setElementData(veh,"timerrunning",true)
								end
							end,2000,1)
						end
					else
						triggerClientEvent(player,"start:engine",player,rdm)
					end
				end
			end
		end
	end
end

function startVehicle(veh)
local veh=getPedOccupiedVehicle(source)
	if(veh)then
		setElementData(veh,"motorworking",true)
		setElementData(veh,"motorworking",false)
		veh:setEngineState(true)
		setElementData(veh,"engine",true)
		if not getElementData(veh,"timerrunning")then
			setElementData(veh,"timerrunning",true)
			setVehicleNewFuelState(veh)
		end
	end
end
addEvent("startVehicle",true)
addEventHandler("startVehicle",root,startVehicle)

function moveVehicle(veh)
local veh=getPedOccupiedVehicle(source)
	if(veh)then
		local rotX,rotY,rotZ=getElementRotation(veh)
		setElementAngularVelocity(veh,math.random(-2,2)/100,math.random(-2,2)/100,math.random(-1,1)/100)
	end
end
addEvent("moveVehicle",true)
addEventHandler("moveVehicle",root,moveVehicle)

addEventHandler("onPlayerVehicleEnter",root,function(veh,seat)
	if(seat==0)then
		if(not getElementData(veh,"engine"))then
			setElementData(veh,"engine",false)
			veh:setEngineState(false)
		end
		if(getElementType(source)=="player")then
			if(not isKeyBound(source,"x","down",Engine_Func))then
				bindKey(source,"x","down",Engine_Func,"Engine an/aus")
			end
			if(not isKeyBound(source,"l","down",Light_Func))then
				bindKey(source,"l","down",Light_Func,"Light an/aus")
			end
			local id=getElementModel(veh)
			if(cars[id]or lkws[id]or bus[id])then
				if(not isKeyBound(source,"z","down",Seatbelt_Func))then
					bindKey(source,"z","down",Seatbelt_Func)
				end
			end
			if(not isKeyBound(source,"num_1","down",leftBlinker_statechange))then
				bindKey(source,"num_1","down",leftBlinker_statechange)
			end
			if(not isKeyBound(source,"num_3","down",rightBlinker_statechange))then
				bindKey(source,"num_3","down",rightBlinker_statechange)
			end
			if(not isKeyBound(source,"num_2","down",allBlinker_statechange))then
				bindKey(source,"num_2","down",allBlinker_statechange)
			end
			setBlinker_func(source)
		end
		
		local owner=getElementData(veh,"Owner")
		local slot=tonumber(getElementData(veh,"Slot"))
		local fuel=getElementData(veh,"Fuel")
		local totalloss=getElementData(veh,"Totalloss")
		local health=getElementHealth(veh)
		if(owner and slot)then
			handler:exec("UPDATE ?? SET ??=?,??=?,??=? WHERE ??=? AND ??=?","uservehicles","Fuel",fuel,"Health",health,"Totalloss",totalloss,"Owner",owner,"Slot",slot)
		end
	elseif(seat==1 or seat==2 or seat==3)then
		local id=getElementModel(veh)
		if(cars[id]or lkws[id]or bus[id])then
			if(getElementType(source)=="player")then
				if(not isKeyBound(source,"z","down",Seatbelt_Func))then
					bindKey(source,"z","down",Seatbelt_Func)
				end
			end
		end
	end
end)
addEventHandler("onPlayerVehicleExit",root,function(veh,seat)
	if(seat==0)then
		local id=getElementData(veh,"ID")
		local owner=getElementData(veh,"Owner")
		local slot=tonumber(getElementData(veh,"Slot"))
		local fuel=getElementData(veh,"Fuel")
		local totalloss=getElementData(veh,"Totalloss")
		local keytarget1=getElementData(veh,"KeyTarget1")
		local keytarget2=getElementData(veh,"KeyTarget2")
		local health=getElementHealth(veh)
		if(owner and slot)then
			handler:exec("UPDATE ?? SET ??=?,??=?,??=? WHERE ??=? AND ??=?","uservehicles","Fuel",fuel,"Health",health,"Totalloss",totalloss,"Owner",owner,"Slot",slot)
		elseif(owner==tonumber(syncGetElementData(source,"Faction"))and id)then
			handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","factionvehicles","Fuel",fuel,"Owner",owner,"ID",id)
		elseif(owner==tonumber(syncGetElementData(source,"Company"))and id)then
			handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","companyvehicles","Fuel",fuel,"Owner",owner,"ID",id)
		elseif(owner==keytarget1 and id)then
			handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Fuel",fuel,"KeyTarget1",keytarget1,"ID",id)
		elseif(owner==keytarget2 and id)then
			handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Fuel",fuel,"KeyTarget2",keytarget2,"ID",id)
		end
		if(getElementType(source)=="player")then
			if(isKeyBound(source,"x","down",Engine_Func))then
				unbindKey(source,"x","down",Engine_Func)
			end
			if(isKeyBound(source,"l","down",Light_Func))then
				unbindKey(source,"l","down",Light_Func)
			end
			if(isKeyBound(source,"z","down",Seatbelt_Func))then
				unbindKey(source,"z","down",Seatbelt_Func)
			end
			if(isKeyBound(source,"num_1","down",leftBlinker_statechange))then
				unbindKey(source,"num_1","down",leftBlinker_statechange)
			end
			if(isKeyBound(source,"num_3","down",rightBlinker_statechange))then
				unbindKey(source,"num_3","down",rightBlinker_statechange)
			end
			if(isKeyBound(source,"num_2","down",allBlinker_statechange))then
				unbindKey(source,"num_2","down",allBlinker_statechange)
			end
		end
	elseif(seat==1 or seat==2 or seat==3)then
		if(getElementType(source)=="player")then
			if(isKeyBound(source,"z","down",Seatbelt_Func))then
				unbindKey(source,"z","down",Seatbelt_Func)
			end
		end
	end
	if(getElementData(source,"seatbelt")==true)then
		setElementData(source,"seatbelt",false)
	end
end)
function remSeatbelt_Func(player,seat)
	if(seat)then
		if(getElementData(player,"seatbelt")==true)then
			setElementData(player,"seatbelt",false)
		end
	end
end
addEventHandler("onVehicleStartExit",root,remSeatbelt_Func)



--//Fueltimer Function
function setVehicleNewFuelState(veh)
	if(isElement(veh))then
		if(getVehicleEngineState(veh)==true)then
			vehfactor=450
			if(vehfactor)then
				local speed=getElementSpeed(veh)
				if(VehicleSoundNEW[getElementModel(veh)])then
					if(speed>=0)then
						speed=getElementSpeed(veh)/vehfactor+0.10
					elseif(speed>=15)then
						speed=getElementSpeed(veh)/vehfactor+0.30
					elseif(speed>=45)then
						speed=getElementSpeed(veh)/vehfactor+0.45
					elseif(speed>=100)then
						speed=getElementSpeed(veh)/vehfactor+0.55
					elseif(speed>=160)then
						speed=getElementSpeed(veh)/vehfactor+0.65
					end
				else
					if(speed>=0)then
						speed=getElementSpeed(veh)/vehfactor+0.25
					elseif(speed>=15)then
						speed=getElementSpeed(veh)/vehfactor+0.40
					elseif(speed>=45)then
						speed=getElementSpeed(veh)/vehfactor+0.52
					elseif(speed>=100)then
						speed=getElementSpeed(veh)/vehfactor+0.60
					elseif(speed>=160)then
						speed=getElementSpeed(veh)/vehfactor+0.68
					end
				end
				
				local newFuel=tonumber(getElementData(veh,"Fuel"))-speed
				setElementData(veh,"Fuel",newFuel)
				if(getElementData(veh,"Fuel")<1)then
					saveBenzinForPrivVeh(veh)
					veh:setEngineState(false)
					setElementData(veh,"engine",false)
					setElementData(veh,"timerrunning",false)
				elseif math.floor(getElementData(veh,"Fuel"))/5==math.floor(getElementData(veh,"Fuel")/5)then
					saveBenzinForPrivVeh(veh)
					setTimer(setVehicleNewFuelState,8000,1,veh)
				else
					setTimer(setVehicleNewFuelState,8000,1,veh)
				end
			end
		else
			setElementData(veh,"timerrunning",false)
		end
	end
end
function saveBenzinForPrivVeh(veh)
	local owner=getElementData(veh,"Owner")
	local slot=getElementData(veh,"Slot")
	local fuel=getElementData(veh,"Fuel")
	local totalloss=getElementData(veh,"Totalloss")
	local health=getElementHealth(veh)
	if(owner and slot)then
		handler:exec("UPDATE ?? SET ??=?,??=? WHERE ??=? AND ??=?","uservehicles","Fuel",fuel,"Health",health,"Totalloss",totalloss,"Owner",pname,"Slot",slot)
	end
end


addEventHandler("onVehicleDamage",root,function(loss)
	if(isElement(source))then
		if(source:getOccupant(0))then
			source:setHealth(source:getHealth()-loss)
		else
			if(source:getHealth(loss)>1000)then
				source:setHealth(1000)
			else
				source:setHealth(source:getHealth()+loss)
			end
		end
		if(getElementData(source,"Owner")and getElementData(source,"Slot"))then
			if((getElementHealth(source)-loss)<=280)then
				setTotalloss(source)
			end
		end
	end
end)
function setTotalloss(veh)
    if(veh)then
		setElementHealth(veh,275)
		setVehicleDamageProof(veh,true)
        setVehicleEngineState(veh,false)
        setElementData(veh,"engine",false)
		setElementData(veh,"Totalloss",1)
		local driver=getVehicleOccupant(veh)
		if(driver)then
			outputChatBox("Das Fahrzeug hat einen Totalschaden! Rufe einen Mech&Tow oder nutze ein Repairkit.",driver,255,255,0)
		end
		handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Totalloss",1,"Owner",getElementData(veh,"Owner"),"Slot",getElementData(veh,"Slot"))
    end
end


local respawntime=25000
addEventHandler("onVehicleExplode",root,function()
	if(isElement(source))then
		if(getElementData(source,"Owner")and getElementData(source,"Slot"))then
			toggleVehicleRespawn(source,true)
			setVehicleRespawnDelay(source,respawntime)
		elseif(getElementData(source,"Owner"))then
			toggleVehicleRespawn(source,true)
			setVehicleRespawnDelay(source,respawntime)
		else
			source:destroy()
		end
	end
end)

FallingOutofVehicleTimer={}
function throwPlayerThroughWindow(x,y,z)  
    if(isVehicleLocked(source))then
        setVehicleLocked(source,false)
    end
    removePedFromVehicle(client,vehicle)
    setElementPosition(client,x,y,z)
    setPedAnimation(client,"CRACK","crckdeth2",15000,true,false,false)
    FallingOutofVehicleTimer[client]=setTimer(function(client)
		setPedAnimation(client)
	end,15*1000,1,client)
end
addEvent("kick:playeroutofvehiclewhennotseatbelt",true)
addEventHandler("kick:playeroutofvehiclewhennotseatbelt",root,throwPlayerThroughWindow)

local locateBlipTimer={}
addEvent("locate:pivvehicle",true)
addEventHandler("locate:pivvehicle",root,function(slot)
	local pname=getPlayerName(client)
	if(slot)then
		if(isElement(Vehicles[pname..slot]))then
			if(getElementData(Vehicles[pname..slot],"Towed")==0)then
				if(not isTimer(locateBlipTimer[client]))then
					if(not isElement(locateBlip))then
						local x,y,z=getElementPosition(Vehicles[pname..slot])
						locateBlip=createBlip(x,y,z,0,2.5,255,0,0,255,0,99999.0,client)
						
						triggerClientEvent(client,"draw:infobox",root,"info","Fahrzeug für 25 Sekunden geortet!")
						locateBlipTimer[client]=setTimer(function()
							locateBlip:destroy()
							if(isTimer(locateBlipTimer[client]))then
								locateBlipTimer[client]:destroy()
							end
						end,25000,1)
					end
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"info","Das Fahrzeug ist abgeschleppt worden!")
			end
		end
	end
end)

local activeSellcar={}
local activeSellcarSave={}
local activeSellcarSlot={}
local activeSellcarPrice={}
local activeSellcarTimer={}
addEvent("selltoplayer:pivvehicle",true)
addEventHandler("selltoplayer:pivvehicle",root,function(slot,kplayer,price)
	local price=tonumber(price)
	local pname=getPlayerName(client)
	local target=getPlayerFromName(kplayer)
	if(isElement(target))then
		if(isLoggedin(target))then
			if(isElement(Vehicles[pname..slot]))then
				if(getElementData(Vehicles[pname..slot],"Towed")==0)then
					if(activeSellcar[client]==nil)then
						local model=getElementModel(Vehicles[pname..slot])
						local modelname=getVehicleNameFromModel(model)
						local getslot=getElementData(Vehicles[pname..slot],"Slot")
						local x,y,z=getElementPosition(target)
						if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(client))<=5)then
							
							activeSellcarSave[target]=getPlayerName(client)
							activeSellcarSlot[target]=getslot
							activeSellcarPrice[target]=price
							
							activeSellcar[client]=true
							activeSellcar[target]=true
							
							outputChatBox(getPlayerName(client).." bietet dir seinen "..modelname.." für $"..price.." an! Drücke 'J', um zu akzeptieren oder 'K' um es abzulehnen.",target,0,200,0)
							triggerClientEvent(client,"draw:infobox",root,"info","Du hast "..getPlayerName(target).." deinen "..modelname.." Slot "..getslot.." für $"..price.." angeboten!")
							bindKey(target,"J","down",sellVehicleAccept)
							bindKey(target,"K","down",rejectVehicleAccept)
							
							if(not isTimer(activeSellcarTimer[client]))then
								activeSellcarTimer[client]=setTimer(function()
									if(isElement(client))then
										triggerClientEvent(client,"draw:infobox",root,"info","Der Spieler hat dein Angebot nicht angenommen!")
										activeSellcar[client]=nil
									end
									if(isElement(target))then 
										activeSellcar[target]=nil
									end
								end,60*1000,1)
							end
							
						else
							triggerClientEvent(client,"draw:infobox",root,"error","Der ausgewählte Spieler ist nicht in deiner Nähe!")
						end
					else
						triggerClientEvent(client,"draw:infobox",root,"warning","Du hast bereits ein aktives Angebot!")
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Das Fahrzeug wurde abgeschleppt!")
				end
			end
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"warning","Der Spieler ist offline!")
	end
end)
function sellVehicleAccept(player)
	if(activeSellcar[player]==true)then
		for i=1,tonumber(syncGetElementData(player,"Vehicleslots"))do
			if(not(Vehicles[getPlayerName(player)..i]))then
				freeslot=i
				break
			end
		end
		
		if(not(freeslot==0))then
			if(tonumber(syncGetElementData(player,"Money"))>=tonumber(activeSellcarPrice[player]))then
				local seller=getPlayerFromName(activeSellcarSave[player])
				local slot=activeSellcarSlot[player]
				
				if(isElement(Vehicles[getPlayerName(seller)..slot]))then
					setElementData(Vehicles[getPlayerName(seller)..slot],"Owner",getPlayerName(player))
					setElementData(Vehicles[getPlayerName(seller)..slot],"Slot",freeslot)
					
					
					if(isTimer(activeSellcarTimer[getPlayerName(seller)]))then
						destroyElement(activeSellcarTimer[getPlayerName(seller)])
					end
					
					syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))-activeSellcarPrice[player])
					syncSetElementData(seller,"Money",tonumber(syncGetElementData(seller,"Money"))+activeSellcarPrice[player])
					outputChatBox("Du hast "..getPlayerName(seller).." sein Fahrzeug abgekauft. Es befindet sich nun in Slot "..freeslot..".",player,0,200,0)
					triggerClientEvent(seller,"draw:infobox",root,"info",getPlayerName(player).." hat dir dein Fahrzeug abgekauft.")
					handler:exec("UPDATE ?? SET ??=?,??=? WHERE ??=? AND ??=?","uservehicles","Owner",getPlayerName(player),"Slot",freeslot,"Slot",slot,"Owner",getPlayerName(seller))
					
					activeSellcar[player]=nil
					activeSellcar[seller]=nil
					
					unbindKey(player,"J","down",sellVehicleAccept)
					unbindKey(player,"K","down",rejectVehicleAccept)
				else
					triggerClientEvent(player,"draw:infobox",root,"error","Das Fahrzeug existiert nicht mehr!")
				end
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..activeSellcarPrice[player]..")")
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Du hast keinen freien Fahrzeugslot!")
		end
	end
end
function rejectVehicleAccept(player)
	if(activeSellcar[player]==true)then
		local seller=getPlayerFromName(activeSellcarSave[player])
		
		triggerClientEvent(seller,"draw:infobox",root,"info",getPlayerName(player).." hat dir dein Fahrzeug nicht abgekauft.")
		
		activeSellcar[player]=nil
		activeSellcar[seller]=nil
	end
end

addEvent("respawn:pivvehicle",true)
addEventHandler("respawn:pivvehicle",root,function(slot)
	local pname=getPlayerName(client)
	if(tonumber(syncGetElementData(client,"Money"))>=80)then
		if(slot)then
			if(isElement(Vehicles[pname..slot]))then
				if(getElementData(Vehicles[pname..slot],"Towed")==0)then
					if(not getVehicleOccupant(Vehicles[pname..slot]))then
						local x=getVVdata("uservehicles","Owner",pname,"Slot",slot,"SpawnX")
						local y=getVVdata("uservehicles","Owner",pname,"Slot",slot,"SpawnY")
						local z=getVVdata("uservehicles","Owner",pname,"Slot",slot,"SpawnZ")
						local rx=getVVdata("uservehicles","Owner",pname,"Slot",slot,"RotX")
						local ry=getVVdata("uservehicles","Owner",pname,"Slot",slot,"RotY")
						local rz=getVVdata("uservehicles","Owner",pname,"Slot",slot,"RotZ")
						
						respawnVehicle(Vehicles[pname..slot])
						setElementPosition(Vehicles[pname..slot],x,y,z)
						setElementRotation(Vehicles[pname..slot],rx,ry,rz)
						setVehicleLocked(Vehicles[pname..slot],true)
						setElementData(Vehicles[pname..slot],"engine",false)
						Vehicles[pname..slot]:setEngineState(false)
						
						triggerClientEvent(client,"draw:infobox",root,"success","Dein Fahrzeug wurde erfolgreich respawnt!")
						syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-80)
					else
						triggerClientEvent(client,"draw:infobox",root,"error","Das Fahrzeug ist nicht leer!")
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Das Fahrzeug ist abgeschleppt worden!")
				end
			end
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bardgeld! ($80)")
	end
end)
addEvent("sell:pivvehicle",true)
addEventHandler("sell:pivvehicle",root,function(slot)
	local pname=getPlayerName(client)
	if(slot)then
		if(isElement(Vehicles[pname..slot]))then
			if(getElementData(Vehicles[pname..slot],"Towed")==0)then
				local id=getElementModel(Vehicles[pname..slot])
				local price=carPrices[id]
				syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))+price/100*75)
				destroyElement(Vehicles[pname..slot])
				handler:exec("DELETE FROM ?? WHERE ??=? AND ??=?","uservehicles","Owner",getPlayerName(client),"Slot",slot)
				triggerClientEvent(client,"draw:infobox",root,"info","Fahrzeug erfolgreich an den Server verkauft!\nDu hast $"..price/100*75 .." bekommen!")
			else
				triggerClientEvent(client,"draw:infobox",root,"info","Das Fahrzeug ist abgeschleppt worden!")
			end
		end
	end
end)
addEvent("give:vehiclekey",true)
addEventHandler("give:vehiclekey",root,function(typ,slot,kplayer)
	local pname=getPlayerName(client)
	local target=getPlayerFromName(kplayer)
	if(isElement(target))then
		if(typ=="Key1")then
			if(slot)then
				if(target and target~=client)then
					if(isElement(Vehicles[pname..slot]))then
						handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","KeyTarget1",getPlayerName(target),"Owner",pname,"Slot",slot)
						setElementData(Vehicles[pname..slot],"KeyTarget1",getPlayerName(target))
						triggerClientEvent(client,"draw:infobox",root,"success","Fahrzeugschlüssel von Slot "..slot.." an "..getPlayerName(target).." gegeben.")
					end
				end
			end
		elseif(typ=="Key2")then
			if(slot)then
				if(target and target~=client)then
					if(isElement(Vehicles[pname..slot]))then
						handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","KeyTarget2",getPlayerName(target),"Owner",pname,"Slot",slot)
						setElementData(Vehicles[pname..slot],"KeyTarget2",getPlayerName(target))
						triggerClientEvent(client,"draw:infobox",root,"success","Fahrzeugschlüssel von Slot "..slot.." an "..getPlayerName(target).." gegeben.")
					end
				end
			end
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","Der Spieler ist offline!")
	end
end)
addEvent("get:vehiclekeyTargets",true)
addEventHandler("get:vehiclekeyTargets",root,function(slot)
	local pname=getPlayerName(client)
	if(isElement(Vehicles[pname..slot]))then
		outputChatBox("Schlüssel 1: "..getElementData(Vehicles[pname..slot],"KeyTarget1"),client)
		outputChatBox("Schlüssel 2: "..getElementData(Vehicles[pname..slot],"KeyTarget2"),client)
	end
end)

local targetTableToEject={}
function ejectTarget(player,cmd,kplayer)
	if(getPedOccupiedVehicleSeat(player)==0)then
		local target=getPlayerFromName(kplayer)
		local veh=getPedOccupiedVehicle(player)
		if(target)then
			if(target~=player)then
				if(getPedOccupiedVehicle(target)==veh)then
					triggerClientEvent(player,"draw:infobox",root,"success","Du hast den Spieler "..getPlayerName(target).." aus dem\nFahrzeug geworfen!")
					triggerClientEvent(target,"draw:infobox",root,"info","Du wurdest von "..getPlayerName(player).." aus dem\nFahrzeug geworfen!")
					removePedFromVehicle(target)
					setElementData(target,"seatbelt",false)
				else
					triggerClientEvent(player,"draw:infobox",root,"error","Der Spieler ist nicht im Fahrzeug!")
				end
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Du kannst dich selber nicht rauswerfen!")
			end
		end
	else
		triggerClientEvent(player,"draw:infobox",root,"error","Der bist nicht der Fahrer des Fahrzeugs!")
	end
end
addCommandHandler("eject",ejectTarget)

function openVehpanel(player)
	local tbl={}
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","uservehicles","Owner",getPlayerName(player)),-1)
	if(#result>=1)then
		for _,v in pairs(result)do
			table.insert(tbl,{v["ID"],getVehicleNameFromModel(v["VehID"]),v["Slot"],v["Totalloss"]})
		end
		triggerClientEvent(player,"open:uservehpanel",player,tbl)
	else
		triggerClientEvent(player,"draw:infobox",root,"error","Du besitzt keine Fahrzeuge!")
	end
end



--[[function giveVehicleKey(player,cmd,kplayer)
	local target=getPlayerFromName(kplayer)
	local veh=getPedOccupiedVehicle(player)
	if(getPedOccupiedVehicleSeat(player)==0)then
		if(veh)then
			if(getElementData(veh,"Slot"))then
				if(getElementData(veh,"Owner")==getPlayerName(player))then
					if(target and target~=player)then
						handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","KeyTarget1",getPlayerName(target),"Owner",getPlayerName(player),"Slot",getElementData(veh,"Slot"))
						setElementData(veh,"KeyTarget1",getPlayerName(target))
						triggerClientEvent(player,"draw:infobox",root,"success","Fahrzeugschlüssel von Slot "..getElementData(veh,"Slot").." an "..getPlayerName(target).." gegeben.")
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","Das Fahrzeug gehört dir nicht!")
				end
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Das Fahrzeug gehört dir nicht!")
			end
		end
	else
		triggerClientEvent(player,"draw:infobox",root,"error","Du sitzt in keinem Fahrzeug!")
	end
end
addCommandHandler("givekey",giveVehicleKey)]]