--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local function goInIntDrivingschool_Func(player)
	if(not isPedInVehicle(player))then
		if(not gotLastHit[player] or gotLastHit[player]+lastHitMarkerTimer<=getTickCount())then
			if(getElementInterior(player)==0 and getElementDimension(player)==0)then
				fadeElementInterior(player,-2027,-105.2,1035.2,180,3,110,true)
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Warte 30 Sekunden nach dem letzten hit/schuss!")
		end
	end
end
local function goOutIntDrivingschool_Func(player)
	if(not isPedInVehicle(player))then
		if(not gotLastHit[player] or gotLastHit[player]+lastHitMarkerTimer<=getTickCount())then
			if(getElementInterior(player)==3 and getElementDimension(player)==110)then
				fadeElementInterior(player,1365.3,-1669.7,13.7,270,0,0,true)
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Warte 30 Sekunden nach dem letzten hit/schuss!")
		end
	end
end

--Marker
createCmarker(1364.5,-1669.7,13.7,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,goInIntDrivingschool_Func)
createCmarker(-2027,-103.8,1035.2,3,110,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,goOutIntDrivingschool_Func)