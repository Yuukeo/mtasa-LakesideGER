--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function buySkin(skin,price)
	if(syncGetElementData(client,"DrivingschoolDuty")==false and syncGetElementData(client,"MechTowDuty")==false and syncGetElementData(client,"CopDuty")==false)then
		if(tonumber(syncGetElementData(client,"Money"))>=tonumber(price))then
			handler:exec("UPDATE ?? SET ??=? WHERE ??=?","userdata","SkinID",skin,"UID",playerUID[getPlayerName(client)])
			setElementModel(client,skin)
			syncSetElementData(client,"SkinID",skin)
			syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-price)
			triggerClientEvent(client,"draw:infobox",root,"success","Du hat dir den Skin: "..skin.." erfolgreich gekauft!")
			outputLog(getPlayerName(client).." hat sich Skin ID "..skin.." gekauft!","Shop")
		else
			setElementModel(client,syncGetElementData(client,"SkinID"))
			triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..price..")")
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","Gehe zuerst aus dem Dienst!")
	end
end
addEvent("buy:skin",true)
addEventHandler("buy:skin",root,buySkin)