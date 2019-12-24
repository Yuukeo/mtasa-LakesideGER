--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local fdepots={
	{-2028.2,-113.1,1035.1,0,0,0,3,100},--Mech&Tow
	{-2028.2,-113.1,1035.1,0,0,0,3,110},--Fahrschule
}

addEventHandler("onResourceStart",resourceRoot,function()
	local Depot={}
	for i,v in pairs(fdepots)do
		Depot[i]=createObject(2332,v[1],v[2],v[3],v[4],v[5],v[6])
		Depot[i]:setInterior(v[7])
		Depot[i]:setDimension(v[8])
		Depot[i]:setDoubleSided(true)
		
		setElementData(Depot[i],"companydepot",true)
	end
end)

function loadCompanyDepotState(player)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","companydepots","Company",tonumber(syncGetElementData(player,"Company"))),-1)
	if(result or result[1])then
		Money=result[1]["Money"]
		
		triggerClientEvent(player,"open:companydepot",player,Money)
	end
end

addEvent("payin_payout:companyitems",true)
addEventHandler("payin_payout:companyitems",root,function(typ,item,amount)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","companydepots","Company",tonumber(getElementData(client,"Company"))),-1)
	if(result or result[1])then
		if(typ=="payin")then
			if(item=="Money")then
				if(tonumber(syncGetElementData(client,"Money"))>=tonumber(amount))then
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-amount)
					handler:exec("UPDATE ?? SET ??=? WHERE ??=?","companydepots","Money",tonumber(result[1]["Money"])+amount,"Company",tonumber(syncGetElementData(client,"Company")))
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast Geld eingezahlt! (x"..amount..")")
					outputLog(getPlayerName(client).." hat $"..amount.." eingelagert","Unternehmen")
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du besitzt dieses Item nicht! (x"..amount..")")
				end
			end
		elseif(typ=="payout")then
			if(tonumber(syncGetElementData(client,"Companyrank"))>=4)then
				if(item=="Money")then
					if(tonumber(result[1]["Money"])>=tonumber(amount))then
						syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))+amount)
						handler:exec("UPDATE ?? SET ??=? WHERE ??=?","companydepots","Money",tonumber(result[1]["Money"])-amount,"Company",tonumber(syncGetElementData(client,"Company")))
						triggerClientEvent(client,"draw:infobox",root,"success","Du hast Geld ausgezahlt! (x"..amount..")")
						outputLog(getPlayerName(client).." hat $"..amount.." ausgelagert!","Unternehmen")
					else
						triggerClientEvent(client,"draw:infobox",root,"error","Soviel Geld ist nicht in der Kasse! (x"..amount..")")
					end
				end
			end
		end
		refreshCompanyDepot(client)
	end
end)

function refreshCompanyDepot(player)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","companydepots","Company",tonumber(getElementData(client,"Company"))),-1)
	if(result or result[1])then
		triggerClientEvent(client,"refresh:companydepot",client,result[1]["Money"])
	end
end