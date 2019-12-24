--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local function goInIntRescue_Func(player)
	if(getElementInterior(player)==0 and getElementDimension(player)==0)then
		if(not isPedInVehicle(player))then
			fadeElementInterior(player,436.9,230.8,996.8,90,3,0,true)
		end
	end
end
local function goOutIntRescue_Func(player)
	if(getElementInterior(player)==3 and getElementDimension(player)==0)then
		if(not isPedInVehicle(player))then
			fadeElementInterior(player,1173,-1325.4,15.4,270,0,0,true)
		end
	end
end

createCmarker(1172.3,-1321.5,15.4,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,goInIntRescue_Func)
createCmarker(437.8,230.8,996.8,3,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,goOutIntRescue_Func)