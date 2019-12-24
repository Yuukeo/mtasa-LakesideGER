--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo) & Xendom       ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local WeaponlicenseLSPD=createPickup(249.3,71.2,1003.6,3,348,50)
setElementInterior(WeaponlicenseLSPD,6)
setElementDimension(WeaponlicenseLSPD,20)

function openWeaponlicenseUI(player)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"GunLicense"))==0)then
			if(tonumber(syncGetElementData(player,"Money"))>=15000)then
				triggerClientEvent(player,"open:weaponlicenseUI",player)
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($15.000)")
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Du hast bereits einen Waffenschein!")
		end
	end
end
addEventHandler("onPickupHit",WeaponlicenseLSPD,openWeaponlicenseUI)

addEvent("give:weaponlicense",true)
addEventHandler("give:weaponlicense",root,function()
	if(tonumber(syncGetElementData(client,"GunLicense"))==0)then
		if(tonumber(syncGetElementData(client,"Money"))>=15000)then
			syncSetElementData(client,"GunLicense",1)
			syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-15000)
			outputChatBox("Gratulation, du hast den Waffenschein erhalten!",client,0,200,0)
		end
	end
end)