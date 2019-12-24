--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("buy:gangweapons",true)
addEventHandler("buy:gangweapons",root,function(weapon,ammu,amount)
	if(isEVIL(client))then
		local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",tonumber(syncGetElementData(client,"Faction"))),-1)
		if(result and result[1])then
			if(weapon=="colt45")then
				if(tonumber(result[1]["Mats"])>=tonumber(settings.faction.weaponprices.mats.colt45))then
					--if(tonumber(syncGetElementData(client,"Money"))>=settings.faction.weaponprices.colt45)then
						if(getPedWeapon(client)~=22)then
							giveWeapon(client,22,1,true)
							--syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.faction.weaponprices.colt45)
							handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Mats",tonumber(result[1]["Mats"])-settings.faction.weaponprices.mats.colt45,"Faction",tonumber(syncGetElementData(client,"Faction")))
							triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir die Waffe erfolgreich gekauft!")
						end
					--else
					--	triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..settings.faction.weaponprices.colt45..")")
					--end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Es sind nicht genug Mats in der Kasse! (x"..settings.faction.weaponprices.mats.colt45..")")
				end
			elseif(weapon=="deagle")then
				if(tonumber(result[1]["Mats"])>=tonumber(settings.faction.weaponprices.mats.deagle))then
					--if(tonumber(syncGetElementData(client,"Money"))>=settings.faction.weaponprices.deagle)then
						if(getPedWeapon(client)~=24)then
							giveWeapon(client,24,1,true)
							--syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.faction.weaponprices.deagle)
							handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Mats",tonumber(result[1]["Mats"])-settings.faction.weaponprices.mats.deagle,"Faction",tonumber(syncGetElementData(client,"Faction")))
							triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir die Waffe erfolgreich gekauft!")
						end
					--else
					--	triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..settings.faction.weaponprices.deagle..")")
					--end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Es sind nicht genug Mats in der Kasse! (x"..settings.faction.weaponprices.mats.deagle..")")
				end
			elseif(weapon=="mp5")then
				if(tonumber(result[1]["Mats"])>=tonumber(settings.faction.weaponprices.mats.mp5))then
					--if(tonumber(syncGetElementData(client,"Money"))>=settings.faction.weaponprices.mp5)then
						if(getPedWeapon(client)~=29)then
							giveWeapon(client,29,1,true)
							--syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.faction.weaponprices.mp5)
							handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Mats",tonumber(result[1]["Mats"])-settings.faction.weaponprices.mats.mp5,"Faction",tonumber(syncGetElementData(client,"Faction")))
							triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir die Waffe erfolgreich gekauft!")
						end
					--else
					--	triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..settings.faction.weaponprices.mp5..")")
					--end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Es sind nicht genug Mats in der Kasse! (x"..settings.faction.weaponprices.mats.mp5..")")
				end
			elseif(weapon=="ak")then
				if(tonumber(result[1]["Mats"])>=tonumber(settings.faction.weaponprices.mats.ak))then
					--if(tonumber(syncGetElementData(client,"Money"))>=settings.faction.weaponprices.ak)then
						if(getPedWeapon(client)~=30)then
							giveWeapon(client,30,1,true)
							--syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.faction.weaponprices.ak)
							handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Mats",tonumber(result[1]["Mats"])-settings.faction.weaponprices.mats.ak,"Faction",tonumber(syncGetElementData(client,"Faction")))
							triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir die Waffe erfolgreich gekauft!")
						end
					--else
					--	triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..settings.faction.weaponprices.ak..")")
					--end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Es sind nicht genug Mats in der Kasse! (x"..settings.faction.weaponprices.mats.ak..")")
				end
			elseif(weapon=="m4")then
				if(tonumber(result[1]["Mats"])>=tonumber(settings.faction.weaponprices.mats.m4))then
					--if(tonumber(syncGetElementData(client,"Money"))>=settings.faction.weaponprices.m4)then
						if(getPedWeapon(client)~=31)then
							giveWeapon(client,31,1,true)
							--syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.faction.weaponprices.m4)
							handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Mats",tonumber(result[1]["Mats"])-settings.faction.weaponprices.mats.m4,"Faction",tonumber(syncGetElementData(client,"Faction")))
							triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir die Waffe erfolgreich gekauft!")
						end
					--else
					--	triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..settings.faction.weaponprices.m4..")")
					--end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Es sind nicht genug Mats in der Kasse! (x"..settings.faction.weaponprices.mats.m4..")")
				end
			elseif(weapon=="sniper")then
				if(tonumber(result[1]["Mats"])>=tonumber(settings.faction.weaponprices.mats.sniper))then
					--if(tonumber(syncGetElementData(client,"Money"))>=settings.faction.weaponprices.sniper)then
						if(getPedWeapon(client)~=34)then
							giveWeapon(client,34,1,true)
							--syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.faction.weaponprices.sniper)
							handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Mats",tonumber(result[1]["Mats"])-settings.faction.weaponprices.mats.sniper,"Faction",tonumber(syncGetElementData(client,"Faction")))
							triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir die Waffe erfolgreich gekauft!")
						end
					--else
					--	triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..settings.faction.weaponprices.sniper..")")
					--end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Es sind nicht genug Mats in der Kasse! (x"..settings.faction.weaponprices.mats.sniper..")")
				end
			elseif(weapon=="spraycan")then
				if(tonumber(result[1]["Mats"])>=tonumber(settings.faction.weaponprices.mats.spraycan))then
					--if(tonumber(syncGetElementData(client,"Money"))>=settings.faction.weaponprices.sniper)then
						if(getPedWeapon(client)~=41)then
							giveWeapon(client,41,1,true)
							--syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.faction.weaponprices.sniper)
							handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Mats",tonumber(result[1]["Mats"])-settings.faction.weaponprices.mats.spraycan,"Faction",tonumber(syncGetElementData(client,"Faction")))
							triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir die Sprühflasche erfolgreich gekauft!")
						end
					--else
					--	triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..settings.faction.weaponprices.sniper..")")
					--end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Es sind nicht genug Mats in der Kasse! (x"..settings.faction.weaponprices.mats.spraycan..")")
				end
			end
		end
		
		
		
		local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",tonumber(syncGetElementData(client,"Faction"))),-1)
		if(result and result[1])then
			if(ammu=="colt45")then
				if(tonumber(result[1]["Mats"])>=tonumber(amount*settings.faction.weaponprices.ammomats.colt45))then
					--if(tonumber(syncGetElementData(client,"Money"))>=settings.faction.weaponprices.ammo.colt45)then
						if(getPedWeapon(client)==22)then
							giveWeapon(client,22,amount*17)
							--syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.faction.weaponprices.ammo.colt45)
							handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Mats",tonumber(result[1]["Mats"])-amount*settings.faction.weaponprices.ammomats.colt45,"Faction",tonumber(syncGetElementData(client,"Faction")))
							triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir das Magazin erfolgreich gekauft!")
						else
							triggerClientEvent(client,"draw:infobox",root,"warning","Du musst zuerst die Waffe auswählen/ausrüsten!")
						end
					--else
					--	triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..settings.faction.weaponprices.ammo.colt45..")")
					--end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Es sind nicht genug Mats in der Kasse! (x"..amount*settings.faction.weaponprices.ammomats.colt45..")")
				end
			elseif(ammu=="deagle")then
				if(tonumber(result[1]["Mats"])>=tonumber(amount*settings.faction.weaponprices.ammomats.deagle))then
					--if(tonumber(syncGetElementData(client,"Money"))>=settings.faction.weaponprices.ammo.deagle)then
						if(getPedWeapon(client)==24)then
							giveWeapon(client,24,amount*7)
							--syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.faction.weaponprices.ammo.deagle)
							handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Mats",tonumber(result[1]["Mats"])-amount*settings.faction.weaponprices.ammomats.deagle,"Faction",tonumber(syncGetElementData(client,"Faction")))
							triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir das Magazin erfolgreich gekauft!")
						else
							triggerClientEvent(client,"draw:infobox",root,"warning","Du musst zuerst die Waffe auswählen/ausrüsten!")
						end
					--else
					--	triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..settings.faction.weaponprices.ammo.deagle..")")
					--end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Es sind nicht genug Mats in der Kasse! (x"..amount*settings.faction.weaponprices.ammomats.deagle..")")
				end
			elseif(ammu=="mp5")then
				if(tonumber(result[1]["Mats"])>=tonumber(amount*settings.faction.weaponprices.ammomats.mp5))then
					--if(tonumber(syncGetElementData(client,"Money"))>=settings.faction.weaponprices.ammo.mp5)then
						if(getPedWeapon(client)==29)then
							giveWeapon(client,29,amount*30)
							--syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.faction.weaponprices.ammo.mp5)
							handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Mats",tonumber(result[1]["Mats"])-amount*settings.faction.weaponprices.ammomats.mp5,"Faction",tonumber(syncGetElementData(client,"Faction")))
							triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir das Magazin erfolgreich gekauft!")
						else
							triggerClientEvent(client,"draw:infobox",root,"warning","Du musst zuerst die Waffe auswählen/ausrüsten!")
						end
					--else
					--	triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..settings.faction.weaponprices.ammo.mp5..")")
					--end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Es sind nicht genug Mats in der Kasse! (x"..amount*settings.faction.weaponprices.ammomats.mp5..")")
				end
			elseif(ammu=="ak")then
				if(tonumber(result[1]["Mats"])>=tonumber(amount*settings.faction.weaponprices.ammomats.ak))then
					--if(tonumber(syncGetElementData(client,"Money"))>=settings.faction.weaponprices.ammo.ak)then
						if(getPedWeapon(client)==30)then
							giveWeapon(client,30,amount*30)
							--syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.faction.weaponprices.ammo.ak)
							handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Mats",tonumber(result[1]["Mats"])-amount*settings.faction.weaponprices.ammomats.ak,"Faction",tonumber(syncGetElementData(client,"Faction")))
							triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir das Magazin erfolgreich gekauft!")
						else
							triggerClientEvent(client,"draw:infobox",root,"warning","Du musst zuerst die Waffe auswählen/ausrüsten!")
						end
					--else
					--	triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..settings.faction.weaponprices.ammo.ak..")")
					--end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Es sind nicht genug Mats in der Kasse! (x"..amount*settings.faction.weaponprices.ammomats.ak..")")
				end
			elseif(ammu=="m4")then
				if(tonumber(result[1]["Mats"])>=tonumber(amount*settings.faction.weaponprices.ammomats.m4))then
					--if(tonumber(syncGetElementData(client,"Money"))>=settings.faction.weaponprices.ammo.m4)then
						if(getPedWeapon(client)==31)then
							giveWeapon(client,31,amount*50)
							--syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.faction.weaponprices.ammo.m4)
							handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Mats",tonumber(result[1]["Mats"])-amount*settings.faction.weaponprices.ammomats.m4,"Faction",tonumber(syncGetElementData(client,"Faction")))
							triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir das Magazin erfolgreich gekauft!")
						else
							triggerClientEvent(client,"draw:infobox",root,"warning","Du musst zuerst die Waffe auswählen/ausrüsten!")
						end
					--else
					--	triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..settings.faction.weaponprices.ammo.m4..")")
					--end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Es sind nicht genug Mats in der Kasse! (x"..amount*settings.faction.weaponprices.ammomats.m4..")")
				end
			elseif(ammu=="sniper")then
				if(tonumber(result[1]["Mats"])>=tonumber(amount*settings.faction.weaponprices.ammomats.sniper))then
					--if(tonumber(syncGetElementData(client,"Money"))>=settings.faction.weaponprices.ammo.sniper)then
						if(getPedWeapon(client)==34)then
							giveWeapon(client,34,amount*1)
							--syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.faction.weaponprices.ammo.sniper)
							handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Mats",tonumber(result[1]["Mats"])-amount*settings.faction.weaponprices.ammomats.sniper,"Faction",tonumber(syncGetElementData(client,"Faction")))
							triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir das Magazin erfolgreich gekauft!")
						else
							triggerClientEvent(client,"draw:infobox",root,"warning","Du musst zuerst die Waffe auswählen/ausrüsten!")
						end
					--else
					--	triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..settings.faction.weaponprices.ammo.sniper..")")
					--end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Es sind nicht genug Mats in der Kasse! (x"..amount*settings.faction.weaponprices.ammomats.sniper..")")
				end
			elseif(ammu=="armor")then
				if(tonumber(syncGetElementData(client,"Money"))>=100)then
					syncSetElementData(client,"Weste",tonumber(syncGetElementData(client,"Weste"))+1)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-100)
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir erfolgreich Weste x1 gekauft!")
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($100)")
				end
			end
		end
	end
end)

addEvent("select:factionskin",true)
addEventHandler("select:factionskin",root,function(skin)
	if(isEVIL(client))then
		setElementModel(client,skin)
	end
end)