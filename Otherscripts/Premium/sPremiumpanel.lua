--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

--//Alte Möchtegern OOP zeiten

addEvent("premium:heal",true)
addEventHandler("premium:heal",root,function()
	if(isLoggedin(client))then
		if(tonumber(getElementData(client,"AdminLvL"))>=2)then
			if(not gotLastHit[client] or gotLastHit[client]+lastHitTimer<=getTickCount())then
				if(not client:isDead())then
					if(client:getHealth()<100 or client:getArmor()<100)then
						if(getPlayerSelfMoney(client,"money")>=settings.premiumsys.healprice)then
							client:setArmor(100)
							client:setHealth(100)
							takePlayerSelfMoney(client,"money",settings.premiumsys.healprice)
							outputLog(getPlayerName(client).." has healed itself!","Premiumsys")
						else
							notificationShow(client,"warning","wait 2 minutes after the last damage before you can eat/use items")
						end
					end
				end
			else
				notificationShow(client,"warning","wait 2 minutes after the last damage before you can use this function!")
			end
		end
	end
end)