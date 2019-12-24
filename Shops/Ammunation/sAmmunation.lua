--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("buy:ammuweapons",true)
addEventHandler("buy:ammuweapons",root,function(weapon,ammu)
	if(syncGetElementData(client,"GunLicense")==1)then
		if(weapon=="colt45")then
			if(tonumber(syncGetElementData(client,"Money"))>=settings.shop.weaponprices.colt45)then
				if(getPedWeapon(client)~=22)then
					giveWeapon(client,22,1,true)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.weaponprices.colt45)
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir die Waffe erfolgreich gekauft!")
					outputLog(getPlayerName(client).." hat sich eine Col45 im Ammunation gekauft!","Shop")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..settings.shop.weaponprices.colt45..")")
			end
		elseif(weapon=="deagle")then
			if(tonumber(syncGetElementData(client,"Money"))>=settings.shop.weaponprices.deagle)then
				if(getPedWeapon(client)~=24)then
					giveWeapon(client,24,1,true)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.weaponprices.deagle)
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir die Waffe erfolgreich gekauft!")
					outputLog(getPlayerName(client).." hat sich eine Deagle im Ammunation gekauft!","Shop")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..settings.shop.weaponprices.deagle..")")
			end
		elseif(weapon=="mp5")then
			if(tonumber(syncGetElementData(client,"Money"))>=settings.shop.weaponprices.mp5)then
				if(getPedWeapon(client)~=29)then
					giveWeapon(client,29,1,true)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.weaponprices.mp5)
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir die Waffe erfolgreich gekauft!")
					outputLog(getPlayerName(client).." hat sich eine MP5 im Ammunation gekauft!","Shop")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..settings.shop.weaponprices.mp5..")")
			end
		elseif(weapon=="ak")then
			if(tonumber(syncGetElementData(client,"Money"))>=settings.shop.weaponprices.ak)then
				if(getPedWeapon(client)~=30)then
					giveWeapon(client,30,1,true)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.weaponprices.ak)
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir die Waffe erfolgreich gekauft!")
					outputLog(getPlayerName(client).." hat sich eine AK im Ammunation gekauft!","Shop")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..settings.shop.weaponprices.ak..")")
			end
		elseif(weapon=="m4")then
			if(tonumber(syncGetElementData(client,"Money"))>=settings.shop.weaponprices.m4)then
				if(getPedWeapon(client)~=31)then
					giveWeapon(client,31,1,true)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.weaponprices.m4)
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir die Waffe erfolgreich gekauft!")
					outputLog(getPlayerName(client).." hat sich eine M4 im Ammunation gekauft!","Shop")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..settings.shop.weaponprices.m4..")")
			end
		end
		
		
		if(ammu=="colt45")then
			if(tonumber(syncGetElementData(client,"Money"))>=settings.shop.weaponprices.ammo.colt45)then
				if(getPedWeapon(client)==22)then
					giveWeapon(client,22,17)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.weaponprices.ammo.colt45)
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir das Magazin erfolgreich gekauft!")
					outputLog(getPlayerName(client).." hat sich ein Colt45 Magazin im Ammunation gekauft!","Shop")
				else
					triggerClientEvent(client,"draw:infobox",root,"warning","Du musst zuerst die Waffe auswählen/ausrüsten!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..settings.shop.weaponprices.ammo.colt45..")")
			end
		elseif(ammu=="deagle")then
			if(tonumber(syncGetElementData(client,"Money"))>=settings.shop.weaponprices.ammo.deagle)then
				if(getPedWeapon(client)==24)then
					giveWeapon(client,24,7)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.weaponprices.ammo.deagle)
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir das Magazin erfolgreich gekauft!")
					outputLog(getPlayerName(client).." hat sich ein Deagle Magazin im Ammunation gekauft!","Shop")
				else
					triggerClientEvent(client,"draw:infobox",root,"warning","Du musst zuerst die Waffe auswählen/ausrüsten!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..settings.shop.weaponprices.ammo.deagle..")")
			end
		elseif(ammu=="mp5")then
			if(tonumber(syncGetElementData(client,"Money"))>=settings.shop.weaponprices.ammo.mp5)then
				if(getPedWeapon(client)==29)then
					giveWeapon(client,29,30)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.weaponprices.ammo.mp5)
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir das Magazin erfolgreich gekauft!")
					outputLog(getPlayerName(client).." hat sich ein MP5 Magazin im Ammunation gekauft!","Shop")
				else
					triggerClientEvent(client,"draw:infobox",root,"warning","Du musst zuerst die Waffe auswählen/ausrüsten!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..settings.shop.weaponprices.ammo.mp5..")")
			end
		elseif(ammu=="ak")then
			if(tonumber(syncGetElementData(client,"Money"))>=settings.shop.weaponprices.ammo.ak)then
				if(getPedWeapon(client)==30)then
					giveWeapon(client,30,30)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.weaponprices.ammo.ak)
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir das Magazin erfolgreich gekauft!")
					outputLog(getPlayerName(client).." hat sich ein AK Magazin im Ammunation gekauft!","Shop")
				else
					triggerClientEvent(client,"draw:infobox",root,"warning","Du musst zuerst die Waffe auswählen/ausrüsten!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..settings.shop.weaponprices.ammo.ak..")")
			end
		elseif(ammu=="m4")then
			if(tonumber(syncGetElementData(client,"Money"))>=settings.shop.weaponprices.ammo.m4)then
				if(getPedWeapon(client)==31)then
					giveWeapon(client,31,50)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.shop.weaponprices.ammo.m4)
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir das Magazin erfolgreich gekauft!")
					outputLog(getPlayerName(client).." hat sich ein M4 Magazin im Ammunation gekauft!","Shop")
				else
					triggerClientEvent(client,"draw:infobox",root,"warning","Du musst zuerst die Waffe auswählen/ausrüsten!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..settings.shop.weaponprices.ammo.m4..")")
			end
		elseif(ammu=="armor")then
			if(tonumber(syncGetElementData(client,"Money"))>=200)then
				syncSetElementData(client,"Weste",tonumber(syncGetElementData(client,"Weste"))+1)
				syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-200)
				triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir erfolgreich Weste x1 gekauft!")
				outputLog(getPlayerName(client).." hat sich eine Weste im Ammunation gekauft!","Shop")
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($200)")
			end
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","Du hast keinen Waffenschein!")
	end
end)