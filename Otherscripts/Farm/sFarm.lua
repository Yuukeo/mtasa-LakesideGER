--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("buy:farmitems",true)
addEventHandler("buy:farmitems",root,function(typ,amount)
	local amount=tonumber(amount)
	if(amount>=1)then
		if(typ=="AppleSeeds")then
			if(tonumber(syncGetElementData(client,"Money"))>=amount*settings.shop.farmItems.appleSeedPrice)then
				syncSetElementData(client,"Apfelsamen",tonumber(syncGetElementData(client,"Apfelsamen"))+amount)
				syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-amount*settings.shop.farmItems.appleSeedPrice)
				triggerClientEvent(client,"draw:infobox",root,"success","Du hast Apfelsamen gekauft! (x"..amount..")")
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! (x"..amount*settings.shop.farmItems.appleSeedPrice..")")
			end
		elseif(typ=="WeedSeeds")then
			if(tonumber(syncGetElementData(client,"Money"))>=amount*settings.shop.farmItems.weedSeedPrice)then
				syncSetElementData(client,"Hanfsamen",tonumber(syncGetElementData(client,"Hanfsamen"))+amount)
				syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-amount*settings.shop.farmItems.weedSeedPrice)
				triggerClientEvent(client,"draw:infobox",root,"success","Du hast Weedsamen gekauft! (x"..amount..")")
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! (x"..amount*settings.shop.farmItems.weedSeedPrice..")")
			end
		end
	end
end)

addEvent("sell:farmitems",true)
addEventHandler("sell:farmitems",root,function(typ,amount)
	local amount=tonumber(amount)
	if(amount>=1)then
		if(typ=="Apple")then
			if(tonumber(syncGetElementData(client,"Apfel"))>=amount)then
				syncSetElementData(client,"Apfel",tonumber(syncGetElementData(client,"Apfel"))-amount)
				syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))+amount*settings.shop.farmItems.applePrice)
				triggerClientEvent(client,"draw:infobox",root,"success","Du hast Apfel verkauft! (x"..amount..")")
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Äpfel! (x"..amount..")")
			end
		end
	end
end)