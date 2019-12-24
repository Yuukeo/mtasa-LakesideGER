--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local function goInIntComerceShop_Func(player)
	if(not isPedInVehicle(player))then
		if(not gotLastHit[player] or gotLastHit[player]+lastHitMarkerTimer<=getTickCount())then
			if(getElementInterior(player)==0 and getElementDimension(player)==0)then
				fadeElementInterior(player,-31,-91,1003.5,0,18,70,true)
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Warte 30 Sekunden nach dem letzten hit/schuss!")
		end
	end
end
local function goOutIntComerceShop_Func(player)
	if(not isPedInVehicle(player))then
		if(not gotLastHit[player] or gotLastHit[player]+lastHitMarkerTimer<=getTickCount())then
			if(getElementInterior(player)==18 and getElementDimension(player)==70)then
				fadeElementInterior(player,1352.4,-1757.7,13.5,0,0,0,true)
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Warte 30 Sekunden nach dem letzten hit/schuss!")
		end
	end
end

local function goInIntMulhollandTankstationShop_Func(player)
	if(not isPedInVehicle(player))then
		if(not gotLastHit[player] or gotLastHit[player]+lastHitMarkerTimer<=getTickCount())then
			if(getElementInterior(player)==0 and getElementDimension(player)==0)then
				fadeElementInterior(player,-31,-91,1003.5,0,18,71,true)
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Warte 30 Sekunden nach dem letzten hit/schuss!")
		end
	end
end
local function goOutIntMulhollandTankstationShop_Func(player)
	if(not isPedInVehicle(player))then
		if(not gotLastHit[player] or gotLastHit[player]+lastHitMarkerTimer<=getTickCount())then
			if(getElementInterior(player)==18 and getElementDimension(player)==71)then
				fadeElementInterior(player,999.5,-920.2,42.2,0,0,0,true)
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Warte 30 Sekunden nach dem letzten hit/schuss!")
		end
	end
end

local function goInIntMulhollandShop_Func(player)
	if(not isPedInVehicle(player))then
		if(not gotLastHit[player] or gotLastHit[player]+lastHitMarkerTimer<=getTickCount())then
			if(getElementInterior(player)==0 and getElementDimension(player)==0)then
				fadeElementInterior(player,-31,-91,1003.5,0,18,72,true)
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Warte 30 Sekunden nach dem letzten hit/schuss!")
		end
	end
end
local function goOutIntMulhollandShop_Func(player)
	if(not isPedInVehicle(player))then
		if(not gotLastHit[player] or gotLastHit[player]+lastHitMarkerTimer<=getTickCount())then
			if(getElementInterior(player)==18 and getElementDimension(player)==72)then
				fadeElementInterior(player,1315.5,-898.9,39.6,180,0,0,true)
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Warte 30 Sekunden nach dem letzten hit/schuss!")
		end
	end
end

local function goInIntMontgomeryShop_Func(player)
	if(not isPedInVehicle(player))then
		if(not gotLastHit[player] or gotLastHit[player]+lastHitMarkerTimer<=getTickCount())then
			if(getElementInterior(player)==0 and getElementDimension(player)==0)then
				fadeElementInterior(player,-31,-91,1003.5,0,18,73,true)
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Warte 30 Sekunden nach dem letzten hit/schuss!")
		end
	end
end
local function goOutIntMontgomeryShop_Func(player)
	if(not isPedInVehicle(player))then
		if(not gotLastHit[player] or gotLastHit[player]+lastHitMarkerTimer<=getTickCount())then
			if(getElementInterior(player)==18 and getElementDimension(player)==73)then
				fadeElementInterior(player,1360,206.2,19.6,328,0,0,true)
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Warte 30 Sekunden nach dem letzten hit/schuss!")
		end
	end
end

local function goInIntIdlewoodShop_Func(player)
	if(not isPedInVehicle(player))then
		if(not gotLastHit[player] or gotLastHit[player]+lastHitMarkerTimer<=getTickCount())then
			if(getElementInterior(player)==0 and getElementDimension(player)==0)then
				fadeElementInterior(player,-31,-91,1003.5,0,18,74,true)
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Warte 30 Sekunden nach dem letzten hit/schuss!")
		end
	end
end
local function goOutIntIdlewoodShop_Func(player)
	if(not isPedInVehicle(player))then
		if(not gotLastHit[player] or gotLastHit[player]+lastHitMarkerTimer<=getTickCount())then
			if(getElementInterior(player)==18 and getElementDimension(player)==74)then
				fadeElementInterior(player,1929,-1776.9,13.5,270,0,0,true)
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Warte 30 Sekunden nach dem letzten hit/schuss!")
		end
	end
end

createCmarker(1352.4,-1759.1,13.5,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,goInIntComerceShop_Func)
createCmarker(-31,-91.9,1003.5,18,70,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,goOutIntComerceShop_Func)

createCmarker(1000.3,-920,42.3,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,goInIntMulhollandTankstationShop_Func)
createCmarker(-31,-91.9,1003.5,18,71,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,goOutIntMulhollandTankstationShop_Func)

createCmarker(1315.5,-897.9,39.6,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,goInIntMulhollandShop_Func)
createCmarker(-31,-91.9,1003.5,18,72,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,goOutIntMulhollandShop_Func)

createCmarker(1359.6,205.3,19.8,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,goInIntMontgomeryShop_Func)
createCmarker(-31,-91.9,1003.5,18,73,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,goOutIntMontgomeryShop_Func)

createCmarker(1928.8,-1775.9,13.5,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,goInIntIdlewoodShop_Func)
createCmarker(-31,-91.9,1003.5,18,74,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,goOutIntIdlewoodShop_Func)