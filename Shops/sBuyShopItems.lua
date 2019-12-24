--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("buy:shopitem",true)
addEventHandler("buy:shopitem",root,function(typ,amount)
	if(amount)then
		if(typ=="Burger")then
			if(amount:len()>=1)then
				if(tonumber(syncGetElementData(client,"Money"))>=tonumber(settings.shop.burgerPrice*amount))then
					if(syncGetElementData(client,"Burger")+amount<=50)then
						syncSetElementData(client,"Burger",tonumber(syncGetElementData(client,"Burger"))+amount)
						syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.burgerPrice*amount)
						triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir Burger x"..amount.." gekauft!")
						outputLog(getPlayerName(client).." hat sich Burger x"..amount.." gekauft!","Shop")
					else
						triggerClientEvent(client,"draw:infobox",root,"error","Du kannst nicht mehr als x50 Burger besitzen!")
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..amount*settings.shop.burgerPrice..")")
				end
			end
		elseif(typ=="Pizza")then
			if(amount:len()>=1)then
				if(tonumber(syncGetElementData(client,"Money"))>=tonumber(settings.shop.pizzaPrice*amount))then
					if(syncGetElementData(client,"Pizza")+amount<=50)then
						syncSetElementData(client,"Pizza",tonumber(syncGetElementData(client,"Pizza"))+amount)
						syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.pizzaPrice*amount)
						triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir Pizza x"..amount.." gekauft!")
						outputLog(getPlayerName(client).." hat sich Pizza x"..amount.." gekauft!","Shop")
					else
						triggerClientEvent(client,"draw:infobox",root,"error","Du kannst nicht mehr als x50 Pizza besitzen!")
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..amount*settings.shop.pizzaPrice..")")
				end
			end
		elseif(typ=="Mobilephone")then
			--if(#amount:len()>=1)then
				if(tonumber(syncGetElementData(client,"Money"))>=tonumber(amount*settings.shop.mobilephonePrice*amount))then
					if(syncGetElementData(client,"Mobilephone")==0)then
						local rdmNumber=math.random(10000000,99999999)
						syncSetElementData(client,"Mobilephone",tonumber(syncGetElementData(client,"Mobilephone"))+amount)
						syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.mobilephonePrice)
						triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir ein Handy gekauft!\n(Drücke: U)\nDeine Nummer: "..rdmNumber.."")
						syncSetElementData(client,"Telenr",rdmNumber)
						triggerEvent("set:task",client,client,"BuyMobilephone")
						outputLog(getPlayerName(client).." hat sich Handy x"..amount.." gekauft!","Shop")
					else
						triggerClientEvent(client,"draw:infobox",root,"error","Du kannst nicht mehr als x1 Handy besitzen!")
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..amount*settings.shop.mobilephonePrice..")")
				end
			--end
		elseif(typ=="ChestWood")then
			if(tonumber(syncGetElementData(client,"TicketBronze"))>=tonumber(1))then
				syncSetElementData(client,"ChestWood",tonumber(syncGetElementData(client,"ChestWood"))+1)
				syncSetElementData(client,"TicketBronze",tonumber(syncGetElementData(client,"TicketBronze"))-1)
				triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir Holzkiste x1 gekauft!")
				outputLog(getPlayerName(client).." hat sich Holzkiste x"..amount.." gekauft!","Shop")
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bronzetickets! (x1)")
			end
		elseif(typ=="ChestIron")then
			if(tonumber(syncGetElementData(client,"TicketSilver"))>=tonumber(1))then
				syncSetElementData(client,"ChestIron",tonumber(syncGetElementData(client,"ChestIron"))+1)
				syncSetElementData(client,"TicketSilver",tonumber(syncGetElementData(client,"TicketSilver"))-1)
				triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir EisenKiste x1 gekauft.")
				outputLog(getPlayerName(client).." hat sich Eisenkiste x"..amount.." gekauft!","Shop")
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Silbertickets! (x1)")
			end
		--//Normal shop items
		elseif(typ=="Repairkit")then
			if(tonumber(syncGetElementData(client,"Money"))>=tonumber(settings.shop.repairkitPrice*amount))then
				if(tonumber(syncGetElementData(client,"Repairkit"))+amount<=5)then
					syncSetElementData(client,"Repairkit",tonumber(syncGetElementData(client,"Repairkit"))+amount)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.repairkitPrice*amount)
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir Repairkit(s) x"..amount.." gekauft.")
					outputLog(getPlayerName(client).." hat sich Repairkit(s) x"..amount.." gekauft!","Shop")
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du kannst nicht mehr als x5 Repairkits besitzen!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..settings.shop.repairkitPrice..")")
			end
		elseif(typ=="Cola")then
			if(tonumber(syncGetElementData(client,"Money"))>=tonumber(settings.shop.colaPrice*amount))then
				if(syncGetElementData(client,"Cola")+amount<=50)then
					syncSetElementData(client,"Cola",tonumber(syncGetElementData(client,"Cola"))+amount)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.colaPrice*amount)
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir Cola x"..amount.." gekauft.")
					outputLog(getPlayerName(client).." hat sich Cola x"..amount.." gekauft!","Shop")
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du kannst nicht mehr als x50 Cola besitzen!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..amount*settings.shop.colaPrice..")")
			end
		elseif(typ=="Cigarette")then
			if(tonumber(syncGetElementData(client,"Money"))>=tonumber(settings.shop.cigarettePrice*amount))then
				if(syncGetElementData(client,"Zigarette")+amount<=25)then
					syncSetElementData(client,"Zigarette",tonumber(syncGetElementData(client,"Zigarette"))+amount)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.cigarettePrice*amount)
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir Zigarette(n) x"..amount.." gekauft.")
					outputLog(getPlayerName(client).." hat sich Zigarette(n) x"..amount.." gekauft!","Shop")
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du kannst nicht mehr als x25 Zigaretten besitzen!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..amount*settings.shop.cigarettePrice..")")
			end
		elseif(typ=="AppleSeeds")then
			if(tonumber(syncGetElementData(client,"Money"))>=tonumber(settings.shop.appleseedPrice*amount))then
				syncSetElementData(client,"Apfelsamen",tonumber(syncGetElementData(client,"Apfelsamen"))+amount)
				syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.appleseedPrice*amount)
				triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir Apfelsame(n) x"..amount.." gekauft.")
				outputLog(getPlayerName(client).." hat sich Apfelsame(n) x"..amount.." gekauft!","Shop")
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..amount*settings.shop.appleseedPrice..")")
			end
		elseif(typ=="Present")then
			if(tonumber(syncGetElementData(client,"Zuckerstange"))>=tonumber(5))then
				syncSetElementData(client,"Geschenk",tonumber(syncGetElementData(client,"Geschenk"))+amount)
				syncSetElementData(client,"Zuckerstange",tonumber(syncGetElementData(client,"Zuckerstange"))-5)
				triggerClientEvent(client,"draw:infobox",root,"success","Du hast x5 Zuckerstangen gegen Geschenk x"..amount.." eingetauscht!")
				outputLog(getPlayerName(client).." hat sich Geschenk x"..amount.." gekauft!","Shop")
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Zuckerstangen! (x5)")
			end
		elseif(typ=="Benzinkanister")then
			if(tonumber(syncGetElementData(client,"Money"))>=tonumber(settings.shop.benzinkanisterPrice*amount))then
				if(syncGetElementData(client,"Benzinkanister")+amount<=4)then
					syncSetElementData(client,"Benzinkanister",tonumber(syncGetElementData(client,"Benzinkanister"))+amount)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.benzinkanisterPrice*amount)
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir Benzinkanister x"..amount.." gekauft.")
					outputLog(getPlayerName(client).." hat sich Benzinkanister x"..amount.." gekauft!","Shop")
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du kannst nicht mehr als x4 Benzinkanister besitzen!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..amount*settings.shop.benzinkanisterPrice..")")
			end
		end
	end
end)