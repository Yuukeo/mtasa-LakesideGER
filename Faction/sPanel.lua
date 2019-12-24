--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("invite:Fplayer",true)
addEventHandler("invite:Fplayer",root,function(target)
	local targetPlayer=getPlayerFromName(target)
	if(tonumber(syncGetElementData(client,"Factionrank"))>=4)then
		if(isElement(targetPlayer)and isLoggedin(targetPlayer))then
			if(tonumber(syncGetElementData(targetPlayer,"Faction"))==0)then
				syncSetElementData(targetPlayer,"Faction",tonumber(syncGetElementData(client,"Faction")))
				syncSetElementData(targetPlayer,"Factionrank",0)
				dbExec(handler,"UPDATE ?? SET ??=?,??=? WHERE ??=?","userdata","Faction",tonumber(syncGetElementData(targetPlayer,"Faction")),"Factionrank",tonumber(syncGetElementData(targetPlayer,"Factionrank")),"UID",playerUID[getPlayerName(targetPlayer)])
				triggerClientEvent(targetPlayer,"draw:infobox",root,"info","Du wurdest von "..getPlayerName(client).." invited!")
				triggerClientEvent(client,"draw:infobox",root,"success","Du hast "..getPlayerName(targetPlayer).." invited!")
				
				outputLog(getPlayerName(client).." hat "..getPlayerName(targetPlayer).." in seine Fraktion invited!","Fraktion")
			else
				triggerClientEvent(client,"draw:infobox",root,"error","The player is already in a Faction!")
			end
		else
			triggerClientEvent(client,"draw:infobox",root,"warning","Der Spieler ist offline!")
		end
		updateFactionBlip(client)
	getFactionPanelMembers(client)
	end
end)
addEvent("uninvite:Fplayer",true)
addEventHandler("uninvite:Fplayer",root,function(target)
	local targetPlayer=getPlayerFromName(target)
	if(tonumber(syncGetElementData(client,"Factionrank"))>=4)then
		if(isElement(targetPlayer)and isLoggedin(targetPlayer))then
			if(tonumber(syncGetElementData(targetPlayer,"Faction"))~=0)then
				if(tonumber(syncGetElementData(targetPlayer,"Faction"))==tonumber(syncGetElementData(client,"Faction")))then
					if(tonumber(syncGetElementData(targetPlayer,"Factionrank"))<=4)then
						syncSetElementData(targetPlayer,"Faction",0)
						syncSetElementData(targetPlayer,"Factionrank",0)
						setElementModel(targetPlayer,syncGetElementData(targetPlayer,"SkinID"))
						syncSetElementData(targetPlayer,"CopDuty",false)
						dbExec(handler,"UPDATE ?? SET ??=?,??=? WHERE ??=?","userdata","Faction",0,"Factionrank",0,"Username",getPlayerName(targetPlayer))
						triggerClientEvent(targetPlayer,"draw:infobox",root,"info","Du wurdest von "..getPlayerName(client).." uninvited!")
						triggerClientEvent(client,"draw:infobox",root,"success","Du hast "..getPlayerName(targetPlayer).." uninvited!")
						
						outputLog(getPlayerName(client).." hat "..getPlayerName(targetPlayer).." aus seine Fraktion uninvited!","Fraktion")
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Der Spieler ist nicht in deiner Fraktion!")
				end
			end
		else
			local targetFaction=getData("userdata","Username",target,"Faction")
			if(tonumber(targetFaction)==tonumber(syncGetElementData(client,"Faction")))then
				if(tonumber(getData("userdata","Username",target,"Factionrank"))<5)then
					dbExec(handler,"UPDATE ?? SET ??=?,??=? WHERE ??=?","userdata","Faction",0,"Factionrank",0,"Username",target)
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast "..target.." uninvited!")
					
					offlineMSG(target,"Du wurdest von "..getPlayerName(client).." aus der Fraktion uninvited!")
					outputLog(getPlayerName(client).." hat "..getPlayerName(target).." aus seiner Fraktion uninvited! (offline)","Fraktion")
				end
			end
		end
	updateFactionBlip(client)
	getFactionPanelMembers(client)
	end
end)

addEvent("rankup:Fplayer",true)
addEventHandler("rankup:Fplayer",root,function(target)
	local targetPlayer=getPlayerFromName(target)
	if(isElement(targetPlayer)and isLoggedin(targetPlayer))then
		if(tonumber(syncGetElementData(client,"Factionrank"))>=4)then
			if(tonumber(syncGetElementData(targetPlayer,"Faction"))==tonumber(syncGetElementData(client,"Faction")))then
				if(tonumber(syncGetElementData(targetPlayer,"Factionrank"))<4)then
					syncSetElementData(targetPlayer,"Factionrank",tonumber(syncGetElementData(targetPlayer,"Factionrank"))+1)
					dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","userdata","Factionrank",tonumber(syncGetElementData(targetPlayer,"Factionrank")),"Username",getPlayerName(targetPlayer))
					
					triggerClientEvent(targetPlayer,"draw:infobox",root,"info","Du wurdest von "..getPlayerName(client).." befördert!")
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Der Spieler hat bereits den höchsten Rang!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Der Spieler ist nicht in deiner Fraktion!")
			end
		end
	else
		local targetFactionRank=getData("userdata","Username",target,"Factionrank")
		if(tonumber(getData("userdata","Username",target,"Factionrank"))<4)then
			if(tonumber(getData("userdata","Username",target,"Faction"))==tonumber(syncGetElementData(client,"Faction")))then
				dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","userdata","Factionrank",targetFactionRank+1,"Username",target)
				triggerClientEvent(client,"draw:infobox",root,"success","Du hast "..target.." einen Rankup gegeben! (offline)")
				
				offlineMSG(target,"Du hast von "..getPlayerName(client).." ein Rankup erhalten!")
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Der Spieler ist nicht in deiner Fraktion!")
			end
		else
			triggerClientEvent(client,"draw:infobox",root,"error","Der Spieler hat bereits den Höchsten Rang!")
		end
	end
end)

addEvent("rankdown:Fplayer",true)
addEventHandler("rankdown:Fplayer",root,function(target)
	local targetPlayer=getPlayerFromName(target)
	if(isElement(targetPlayer)and isLoggedin(targetPlayer))then
		if(tonumber(syncGetElementData(client,"Factionrank"))>=4)then
			if(tonumber(syncGetElementData(targetPlayer,"Faction"))==tonumber(syncGetElementData(client,"Faction")))then
				if(tonumber(syncGetElementData(targetPlayer,"Factionrank"))>0)then
					syncSetElementData(targetPlayer,"Factionrank",tonumber(syncGetElementData(targetPlayer,"Factionrank"))-1)
					dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","userdata","Factionrank",tonumber(syncGetElementData(targetPlayer,"Factionrank")),"Username",getPlayerName(targetPlayer))
					
					triggerClientEvent(targetPlayer,"draw:infobox",root,"info","Du wurdest von "..getPlayerName(client).." degradiert!")
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Der Spieler hat bereits den Niedrigsten Rang!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Der Spieler ist nicht in deiner Fraktion!")
			end
		end
	else
		local targetFactionRank=getData("userdata","Username",target,"Factionrank")
		if(tonumber(getData("userdata","Username",target,"Factionrank"))>0)then
			if(tonumber(getData("userdata","Username",target,"Faction"))==tonumber(syncGetElementData(client,"Faction")))then
				dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","userdata","Factionrank",targetFactionRank-1,"Username",target)
				triggerClientEvent(client,"draw:infobox",root,"success","Du hast "..target.." einen Rankdown gegeben! (offline)")
				
				offlineMSG(target,"Du hast von "..getPlayerName(client).." ein Rankdown erhalten!")
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Der Spieler ist nicht in deiner Fraktion!")
			end
		else
			triggerClientEvent(client,"draw:infobox",root,"error","Der Spieler hat bereits den Niedrigsten Rang!")
		end
	end
end)


--//Panel
function getFactionPanelMembers()
	if(tonumber(syncGetElementData(client,"Faction"))~=0)then
		local tbl={}
		local result=dbPoll(dbQuery(handler,"SELECT * FROM userdata"),-1)
		if(#result>=1)then
			for _,v in pairs(result)do
				if(v["Faction"]==tonumber(syncGetElementData(client,"Faction")))then
					table.insert(tbl,{v["Username"],v["Faction"],v["Factionrank"]})
				end
			end
			triggerClientEvent(client,"set:factionpanelmembers",client,tbl)
		end
	end
end
addEvent("get:factionpanelmembers",true)
addEventHandler("get:factionpanelmembers",root,getFactionPanelMembers)

addEvent("get:factionpanelmembersaktiviti",true)
addEventHandler("get:factionpanelmembersaktiviti",root,function()
	if(tonumber(syncGetElementData(client,"Faction"))~=0)then
		local tbl={}
		local result=dbPoll(dbQuery(handler,"SELECT * FROM userdata"),-1)
		if(#result>=1)then
			for _,v in pairs(result)do
				if(v["Faction"]==tonumber(syncGetElementData(client,"Faction")))then
					table.insert(tbl,{v["Username"],math.floor(v["Weeklytime"]/60)})
				end
			end
			triggerClientEvent(client,"set:factionpanelmembersaktiviti",client,tbl)
		end
	end
end)

addEvent("change:factionnotes",true)
addEventHandler("change:factionnotes",root,function(notes)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",tonumber(syncGetElementData(client,"Faction"))),-1)
	if(result or result[1])then
		if(tonumber(syncGetElementData(client,"Faction"))>=1 and tonumber(syncGetElementData(client,"Factionrank"))>=4)then
			handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Notes",notes,"Faction",tonumber(syncGetElementData(client,"Faction")))
			triggerClientEvent(client,"draw:infobox",root,"success","Du hast die Fraktionsnotizen geändert!")
		end
	end
end)
addEvent("get:factionnotes",true)
addEventHandler("get:factionnotes",root,function()
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ??","factiondepots"),-1)
	if(#result>=1)then
		local tbl={}
		for _,v in pairs(result)do
			if(v["Faction"]==tonumber(syncGetElementData(client,"Faction")))then
				table.insert(tbl,{v["Notes"]})
			end
		end
		triggerClientEvent(client,"show:factionnotes",client,tbl)
	end
end)

addEvent("get:factionranksalary",true)
addEventHandler("get:factionranksalary",root,function()
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ??","factiondepots"),-1)
	if(#result>=1)then
		local tbl={}
		for _,v in pairs(result)do
			if(v["Faction"]==tonumber(syncGetElementData(client,"Faction")))then
				table.insert(tbl,{v["Rang0"],v["Rang1"],v["Rang2"],v["Rang3"],v["Rang4"],v["Rang5"]})
			end
		end
		triggerClientEvent(client,"show:factionranksalary",client,tbl)
	end
end)
addEvent("change:factionranksalary",true)
addEventHandler("change:factionranksalary",root,function(typ,amount)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",tonumber(syncGetElementData(client,"Faction"))),-1)
	if(result or result[1])then
		if(tonumber(syncGetElementData(client,"Faction"))>=1 and tonumber(syncGetElementData(client,"Factionrank"))>=5)then
			if(typ=="Rank0")then
				handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Rang0",amount,"Faction",tonumber(syncGetElementData(client,"Faction")))
				triggerClientEvent(client,"draw:infobox",root,"success","Fraktionsrang 0 Gehalt geändert!")
			elseif(typ=="Rank1")then
				handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Rang1",amount,"Faction",tonumber(syncGetElementData(client,"Faction")))
				triggerClientEvent(client,"draw:infobox",root,"success","Fraktionsrang 1 Gehalt geändert!")
			elseif(typ=="Rank2")then
				handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Rang2",amount,"Faction",tonumber(syncGetElementData(client,"Faction")))
				triggerClientEvent(client,"draw:infobox",root,"success","Fraktionsrang 2 Gehalt geändert!")
			elseif(typ=="Rank3")then
				handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Rang3",amount,"Faction",tonumber(syncGetElementData(client,"Faction")))
				triggerClientEvent(client,"draw:infobox",root,"success","Fraktionsrang 3 Gehalt geändert!")
			elseif(typ=="Rank4")then
				handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Rang4",amount,"Faction",tonumber(syncGetElementData(client,"Faction")))
				triggerClientEvent(client,"draw:infobox",root,"success","Fraktionsrang 4 Gehalt geändert!")
			elseif(typ=="Rank5")then
				handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Rang5",amount,"Faction",tonumber(syncGetElementData(client,"Faction")))
				triggerClientEvent(client,"draw:infobox",root,"success","Fraktionsrang 5 Gehalt geändert!")
			end
		end
	end
end)


addEvent("load:factionvehicles",true)
addEventHandler("load:factionvehicles",root,function()
	local tbl={}
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factionvehicles","Owner",tonumber(syncGetElementData(client,"Faction"))),-1)
	if(#result>=1)then
		for _,v in pairs(result)do
			if(v["Owner"]==tonumber(syncGetElementData(client,"Faction")))then
				table.insert(tbl,{v["ID"],getVehicleNameFromModel(v["VehID"])})
			end
		end
		triggerClientEvent(client,"show:factionvehicles",client,tbl)
	end
end)
addEvent("load:factiongangwar",true)
addEventHandler("load:factiongangwar",root,function()
	local Gcount=0
	local Bcount=0
	local Vcount=0
	local tbl={}
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ??","gangareas"),-1)
	for i=1,#result do
		local row=result[i]
		if(row["BesitzerFraktion"]==3)then
			Gcount=Gcount+1
		end
		if(row["BesitzerFraktion"]==4)then
			Bcount=Bcount+1
		end
		if(row["BesitzerFraktion"]==5)then
			Vcount=Vcount+1
		end
		table.insert(tbl,{Gcount,Bcount,Vcount})
	end
	triggerClientEvent(client,"show:factiongangwar",client,tbl)
end)
addEvent("load:factiongangwarkd",true)
addEventHandler("load:factiongangwarkd",root,function()
	if(tonumber(syncGetElementData(client,"Faction"))~=0)then
		local tbl={}
		local result=dbPoll(dbQuery(handler,"SELECT * FROM userstats"),-1)
		if(#result>=1)then
			for _,v in pairs(result)do
				if(v["GangwarKills"]>=1 or v["GangwarDamageGemacht"]>=1)then
					table.insert(tbl,{v["Username"],v["GangwarKills"],v["GangwarDeaths"],v["GangwarDamageGemacht"]})
				end
			end
			triggerClientEvent(client,"show:factiongangwarkd",client,tbl)
		end
	end
end)

addEvent("sell:factionvehicle",true)
addEventHandler("sell:factionvehicle",root,function(id)
	local faction=tonumber(syncGetElementData(client,"Faction"))
	if(faction and id)then
		if(isElement(FactionVehicles[faction..id]))then
			local idd=getElementModel(FactionVehicles[faction..id])
			local price=carPrices[idd]
			local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",faction),-1)
			if(result and result[1])then
				handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Money",tonumber(result[1]["Money"])+price/100*75,"Faction",faction)
				triggerClientEvent(client,"draw:infobox",root,"info","Fraktionsfahrzeug erfolgreich an den Server verkauft!\nIhr habt $"..price/100*75 .." bekommen!")
				FactionVehicles[faction..id]:destroy()
				handler:exec("DELETE FROM ?? WHERE ??=? AND ??=?","factionvehicles","Owner",faction,"ID",id)
			end
		end
	end
end)
addEvent("respawn:1factionvehicle",true)
addEventHandler("respawn:1factionvehicle",root,function(id)
	local faction=tonumber(syncGetElementData(client,"Faction"))
	if(faction and faction>=1 and id)then
		if(isElement(FactionVehicles[faction..id]))then
			local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",faction),-1)
			if(result and result[1])then
				handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Money",tonumber(result[1]["Money"])-250,"Faction",faction)
				FactionVehicles[faction..id]:destroy()
				loadFactionVehicles(faction)
				triggerClientEvent(client,"draw:infobox",root,"success","Fraktionsfahrzeug erfolgreich respawnt!")
			end
		end
	end
end)