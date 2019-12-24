--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local fdepots={
	{251.7,71.3,1003.7,0,0,0,6,20},--LSPD
	{2498.2,-1703.4,1014.6,0,0,270,3,30},--Grove
	{1209.1,-25.6,1000.6,0,0,0,3,27},--Ballas
	{1209.1,-25.6,1000.6,0,0,0,3,40},--Vagos
}

addEventHandler("onResourceStart",resourceRoot,function()
	local Depot={}
	for i,v in pairs(fdepots)do
		Depot[i]=createObject(2332,v[1],v[2],v[3],v[4],v[5],v[6])
		Depot[i]:setInterior(v[7])
		Depot[i]:setDimension(v[8])
		Depot[i]:setDoubleSided(true)
		
		setElementData(Depot[i],"factiondepot",true)
	end
end)

function loadFactionDepotState(player)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",tonumber(syncGetElementData(player,"Faction"))),-1)
	if(result or result[1])then
		Money=result[1]["Money"]
		Weed=result[1]["Weed"]
		Mats=result[1]["Mats"]
		Kokain=result[1]["Kokain"]
		
		triggerClientEvent(player,"open:factiondepot",player,Money,Weed,Mats,Kokain)
	end
end

addEvent("payin_payout:factionitems",true)
addEventHandler("payin_payout:factionitems",root,function(typ,item,amount)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",tonumber(getElementData(client,"Faction"))),-1)
	if(result or result[1])then
		if(typ=="payin")then
			if(item=="Money")then
				if(tonumber(syncGetElementData(client,item))>=tonumber(amount))then
					syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
					handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots",item,tonumber(result[1][item])+amount,"Faction",tonumber(syncGetElementData(client,"Faction")))
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast Geld eingelagert! (x"..amount..")")
					outputLog(getPlayerName(client).." hat $"..amount.." eingelagert","Fraktion")
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du besitzt dieses Item nicht! (x"..amount..")")
				end
			elseif(item=="Weed")then
				if(tonumber(syncGetElementData(client,item))>=tonumber(amount))then
					syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
					handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots",item,tonumber(result[1][item])+amount,"Faction",tonumber(syncGetElementData(client,"Faction")))
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast Weed eingelagert! (x"..amount..")")
					outputLog(getPlayerName(client).." hat x"..amount.." Weed eingelagert","Fraktion")
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du besitzt dieses Item nicht! (x"..amount..")")
				end
			elseif(item=="Mats")then
				if(tonumber(syncGetElementData(client,item))>=tonumber(amount))then
					syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
					handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots",item,tonumber(result[1][item])+amount,"Faction",tonumber(syncGetElementData(client,"Faction")))
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast Mats eingelagert! (x"..amount..")")
					outputLog(getPlayerName(client).." hat x"..amount.." Mats eingelagert","Fraktion")
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du besitzt dieses Item nicht! (x"..amount..")")
				end
			elseif(item=="Kokain")then
				if(tonumber(syncGetElementData(client,item))>=tonumber(amount))then
					syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
					handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots",item,tonumber(result[1][item])+amount,"Faction",tonumber(syncGetElementData(client,"Faction")))
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast Kokain eingelagert! (x"..amount..")")
					outputLog(getPlayerName(client).." hat x"..amount.." Kokain eingelagert","Fraktion")
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du besitzt dieses Item nicht! (x"..amount..")")
				end
			end
		elseif(typ=="payout")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=4)then
				if(item=="Money")then
					if(tonumber(result[1][item])>=tonumber(amount))then
						syncSetElementData(client,item,tonumber(syncGetElementData(client,item))+amount)
						handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots",item,tonumber(result[1][item])-amount,"Faction",tonumber(syncGetElementData(client,"Faction")))
						triggerClientEvent(client,"draw:infobox",root,"success","Du hast Geld ausgezahlt! (x"..amount..")")
						outputLog(getPlayerName(client).." hat $"..amount.." ausgelagert!","Fraktion")
					else
						triggerClientEvent(client,"draw:infobox",root,"error","Soviel Geld ist nicht in der Kasse! (x"..amount..")")
					end
				elseif(item=="Weed")then
					if(tonumber(result[1][item])>=tonumber(amount))then
						syncSetElementData(client,item,tonumber(syncGetElementData(client,item))+amount)
						handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots",item,tonumber(result[1][item])-amount,"Faction",tonumber(syncGetElementData(client,"Faction")))
						triggerClientEvent(client,"draw:infobox",root,"success","Du hast Weed ausgezahlt! (x"..amount..")")
						outputLog(getPlayerName(client).." hat x"..amount.." Weed ausgelagert!","Fraktion")
					else
						triggerClientEvent(client,"draw:infobox",root,"error","Soviel Weed ist nicht in der Kasse! (x"..amount..")")
					end
				elseif(item=="Mats")then
					if(tonumber(result[1][item])>=tonumber(amount))then
						syncSetElementData(client,item,tonumber(syncGetElementData(client,item))+amount)
						handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots",item,tonumber(result[1][item])-amount,"Faction",tonumber(syncGetElementData(client,"Faction")))
						triggerClientEvent(client,"draw:infobox",root,"success","Du hast Mats ausgezahlt! (x"..amount..")")
						outputLog(getPlayerName(client).." hat x"..amount.." Mats ausgelagert!","Fraktion")
					else
						triggerClientEvent(client,"draw:infobox",root,"error","Soviel Mats ist nicht in der Kasse! (x"..amount..")")
					end
				elseif(item=="Kokain")then
					if(tonumber(result[1][item])>=tonumber(amount))then
						syncSetElementData(client,item,tonumber(syncGetElementData(client,item))+amount)
						handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots",item,tonumber(result[1][item])-amount,"Faction",tonumber(syncGetElementData(client,"Faction")))
						triggerClientEvent(client,"draw:infobox",root,"success","Du hast Kokain ausgezahlt! (x"..amount..")")
						outputLog(getPlayerName(client).." hat x"..amount.." Kokain ausgelagert!","Fraktion")
					else
						triggerClientEvent(client,"draw:infobox",root,"error","Soviel Kokain ist nicht in der Kasse! (x"..amount..")")
					end
				end
			end
		end
		refreshFactionDepot(client)
	end
end)

function refreshFactionDepot(player)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",tonumber(getElementData(client,"Faction"))),-1)
	if(result or result[1])then
		triggerClientEvent(client,"refresh:factiondepot",client,result[1]["Money"],result[1]["Weed"],result[1]["Mats"],result[1]["Kokain"])
	end
end