--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local function goInIntVagos_Func(player)
	if(isVAGOS(player))then
		if(not isPedInVehicle(player))then
			if(not gotLastHit[player] or gotLastHit[player]+lastHitMarkerTimer<=getTickCount())then
				if(getElementInterior(player)==0 and getElementDimension(player)==0)then
					fadeElementInterior(player,1212.1,-27.7,1001,180,3,40,true)
				end
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Warte 30 Sekunden nach dem letzten hit/schuss!")
			end
		end
	end
end
local function goOutIntVagos_Func(player)
	if(not isPedInVehicle(player))then
		if(not gotLastHit[player] or gotLastHit[player]+lastHitMarkerTimer<=getTickCount())then
			if(getElementInterior(player)==3 and getElementDimension(player)==40)then
				fadeElementInterior(player,2887.6,-2144.6,4.2,80,0,0,true)
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Warte 30 Sekunden nach dem letzten hit/schuss!")
		end
	end
end


createCmarker(2889.4,-2144.9,4.4,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,goInIntVagos_Func)
createCmarker(1212.1,-26,1001,3,40,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,goOutIntVagos_Func)