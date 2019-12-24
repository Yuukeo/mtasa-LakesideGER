--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo) & Xendom       ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local AFKPlayerTable={}

setTimer(function()
	for _,v in pairs(getElementsByType("player"))do
		if(isLoggedin(v))then
			if(getPlayerIdleTime(v)>15*60*1000)then
				if(getElementData(v,"AFK")==false)then
					AFKPlayerTable[v]=math.random(1000,9999)
					outputChatBox("Du wurdest AFK gesetzt! Tippe '/afk "..AFKPlayerTable[v].."' um diesen zu verlassen!",v,255,255,255)
					triggerClientEvent(v,"show:desktopnotify",root,"info","Du wurdest AFK gesetzt!")
					setElementData(v,"AFK",true)
					if(isPedInVehicle(v))then
						local veh=getPedOccupiedVehicle(v)
						setElementFrozen(veh,true)
						
						addEventHandler("onVehicleStartExit",veh,function(player)
							if(getElementData(player,"AFK")==true)then
								cancelEvent()
								triggerClientEvent(player,"draw:infobox",root,"warning","Du bist AFK! Tippe '/afk "..AFKPlayerTable[player].."' um diesen zu verlassen!")
							end
						end)
					else
						setElementFrozen(v,true)
					end
				end
			end
		end
	end
end,1000*60,0)

addCommandHandler("afk",function(player,cmd,number)
	if(getElementData(player,"AFK")==true)then
		if(AFKPlayerTable[player])then
			if(number)then
				if(tonumber(number)==AFKPlayerTable[player])then
					setElementData(player,"AFK",false)
					setElementFrozen(player,false)
					triggerClientEvent(player,"draw:infobox",root,"info","Du hast den AFK-modus verlassen!")
					if(isPedInVehicle(player))then
						setElementFrozen(getPedOccupiedVehicle(player),false)
					end
					AFKPlayerTable[player]=nil
				end
			end
		end
	end
end)