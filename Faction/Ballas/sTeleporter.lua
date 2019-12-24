--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local function goInIntBallas_Func(player)
	if(isBALLAS(player))then
		if(not isPedInVehicle(player))then
			if(not gotLastHit[player] or gotLastHit[player]+lastHitMarkerTimer<=getTickCount())then
				if(getElementInterior(player)==0 and getElementDimension(player)==0)then
					fadeElementInterior(player,1212.1,-27.7,1001,180,3,27,true)
				end
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Warte 30 Sekunden nach dem letzten hit/schuss!")
			end
		end
	end
end
local function goOutIntBallas_Func(player)
	if(not isPedInVehicle(player))then
		if(not gotLastHit[player] or gotLastHit[player]+lastHitMarkerTimer<=getTickCount())then
			if(getElementInterior(player)==3 and getElementDimension(player)==27)then
				fadeElementInterior(player,2225,-1436.6,25,90,0,0,true)
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Warte 30 Sekunden nach dem letzten hit/schuss!")
		end
	end
end


createCmarker(2226.3,-1436.6,25,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,goInIntBallas_Func)
createCmarker(1212.1,-26,1001,3,27,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,goOutIntBallas_Func)