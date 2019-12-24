--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("invite:Cplayer",true)
addEventHandler("invite:Cplayer",root,function(target)
	local targetPlayer=getPlayerFromName(target)
	if(tonumber(syncGetElementData(client,"Companyrank"))>=4)then
		if(isElement(targetPlayer)and isLoggedin(targetPlayer))then
			if(tonumber(syncGetElementData(targetPlayer,"Company"))==0)then
				syncSetElementData(targetPlayer,"Company",tonumber(syncGetElementData(client,"Company")))
				syncSetElementData(targetPlayer,"Companyrank",0)
				dbExec(handler,"UPDATE ?? SET ??=?,??=? WHERE ??=?","userdata","Company",tonumber(syncGetElementData(targetPlayer,"Company")),"Companyrank",tonumber(syncGetElementData(targetPlayer,"Companyrank")),"UID",playerUID[getPlayerName(targetPlayer)])
				triggerClientEvent(targetPlayer,"draw:infobox",root,"info","Du wurdest von "..getPlayerName(client).." invited!")
				triggerClientEvent(client,"draw:infobox",root,"success","Du hast "..getPlayerName(targetPlayer).." invited!")
				
				outputLog(getPlayerName(client).." hat "..getPlayerName(targetPlayer).." in seinem Unternehmen invited!","Unternehmen")
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Der Spieler ist bereits in einem Unternehmen!")
			end
		else
			triggerClientEvent(client,"draw:infobox",root,"warning","Der Spieler ist offline!")
		end
	getCompanyPanelMembers(client)
	end
end)
addEvent("uninvite:Cplayer",true)
addEventHandler("uninvite:Cplayer",root,function(target)
	local targetPlayer=getPlayerFromName(target)
	if(tonumber(syncGetElementData(client,"Companyrank"))>=4)then
		if(isElement(targetPlayer)and isLoggedin(targetPlayer))then
			if(tonumber(syncGetElementData(targetPlayer,"Company"))~=0)then
				if(tonumber(syncGetElementData(targetPlayer,"Company"))==tonumber(syncGetElementData(client,"Company")))then
					if(tonumber(syncGetElementData(targetPlayer,"Companyrank"))<=4)then
						syncSetElementData(targetPlayer,"Company",0)
						syncSetElementData(targetPlayer,"Companyrank",0)
						setElementModel(targetPlayer,syncGetElementData(targetPlayer,"SkinID"))
						syncSetElementData(targetPlayer,"CopDuty",false)
						dbExec(handler,"UPDATE ?? SET ??=?,??=? WHERE ??=?","userdata","Company",0,"Companyrank",0,"UID",playerUID[getPlayerName(targetPlayer)])
						triggerClientEvent(targetPlayer,"draw:infobox",root,"info","Du wurdest von "..getPlayerName(client).." uninvited!")
						triggerClientEvent(client,"draw:infobox",root,"success","Du hast "..getPlayerName(targetPlayer).." uninvited!")
						
						offlineMSG(target,"Du wurdest von "..getPlayerName(client).." aus dem Unternehmen uninvited!")
						outputLog(getPlayerName(client).." hat "..getPlayerName(targetPlayer).." aus seinem Unternehmen uninvited!","Unternehmen")
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Der Spieler ist nicht in deinem Unternehmen!")
				end
			end
		else
			local targetFaction=getData("userdata","Username",target,"Company")
			if(tonumber(targetFaction)==tonumber(syncGetElementData(client,"Company")))then
				if(tonumber(getData("userdata","Username",target,"Companyrank"))<5)then
					dbExec(handler,"UPDATE ?? SET ??=?,??=? WHERE ??=?","userdata","Company",0,"Companyrank",0,"Username",target)
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast "..target.." uninvited!")
					
					offlineMSG(target,"Du wurdest von "..getPlayerName(client).." aus der Fraktion uninvited!")
					outputLog(getPlayerName(client).." hat "..getPlayerName(target).." aus seinem Unternehmen uninvited! (offline)","Unternehmen")
				end
			end
		end
	getCompanyPanelMembers(client)
	end
end)

addEvent("rankup:Cplayer",true)
addEventHandler("rankup:Cplayer",root,function(target)
	local targetPlayer=getPlayerFromName(target)
	if(isElement(targetPlayer)and isLoggedin(targetPlayer))then
		if(tonumber(syncGetElementData(client,"Companyrank"))>=4)then
			if(tonumber(syncGetElementData(targetPlayer,"Company"))==tonumber(syncGetElementData(client,"Company")))then
				if(tonumber(syncGetElementData(targetPlayer,"Companyrank"))<4)then
					syncSetElementData(targetPlayer,"Companyrank",tonumber(syncGetElementData(targetPlayer,"Companyrank"))+1)
					dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","userdata","Companyrank",tonumber(syncGetElementData(targetPlayer,"Companyrank")),"Username",getPlayerName(targetPlayer))
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Der Spieler hat bereits den höchsten Rang!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Der Spieler ist nicht in deinem Unternehmen!")
			end
		end
	else
		local targetCompanyRank=getData("userdata","Username",target,"Companyrank")
		if(tonumber(getData("userdata","Username",target,"Companyrank"))<4)then
			if(tonumber(getData("userdata","Username",target,"Company"))==tonumber(syncGetElementData(client,"Company")))then
				dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","userdata","Companyrank",targetCompanyRank+1,"Username",target)
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

addEvent("rankdown:Cplayer",true)
addEventHandler("rankdown:Cplayer",root,function(target)
	local targetPlayer=getPlayerFromName(target)
	if(isElement(targetPlayer)and isLoggedin(targetPlayer))then
		if(tonumber(syncGetElementData(client,"Companyrank"))>=4)then
			if(tonumber(syncGetElementData(targetPlayer,"Company"))==tonumber(syncGetElementData(client,"Company")))then
				if(tonumber(syncGetElementData(targetPlayer,"Companyrank"))>=0 and tonumber(syncGetElementData(targetPlayer,"Companyrank"))<4)then
					syncSetElementData(targetPlayer,"Companyrank",tonumber(syncGetElementData(client,"Companyrank"))-1)
					dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","userdata","Companyrank",tonumber(syncGetElementData(targetPlayer,"Companyrank")),"Username",getPlayerName(target))
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Der Spieler hat bereits den niedrigsten Rang!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Der Spieler ist nicht in deinem Unternehmen!")
			end
		end
	else
		local targetCompanyRank=getData("userdata","Username",target,"Companyrank")
		if(tonumber(getData("userdata","Username",target,"Companyrank"))>0)then
			if(tonumber(getData("userdata","Username",target,"Company"))==tonumber(syncGetElementData(client,"Company")))then
				dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","userdata","Companyrank",targetCompanyRank-1,"Username",target)
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
function getCompanyPanelMembers()
	if(tonumber(syncGetElementData(client,"Company"))~=0)then
		local tbl={}
		local result=dbPoll(dbQuery(handler,"SELECT * FROM userdata"),-1)
		if(#result>=1)then
			for _,v in pairs(result)do
				if(v["Company"]==tonumber(syncGetElementData(client,"Company")))then
					table.insert(tbl,{v["Username"],v["Company"],v["Companyrank"]})
				end
			end
			triggerClientEvent(client,"set:companypanelmembers",client,tbl)
		end
	end
end
addEvent("get:companypanelmembers",true)
addEventHandler("get:companypanelmembers",root,getCompanyPanelMembers)

addEvent("get:companypanelmembersaktiviti",true)
addEventHandler("get:companypanelmembersaktiviti",root,function()
	if(tonumber(syncGetElementData(client,"Company"))~=0)then
		local tbl={}
		local result=dbPoll(dbQuery(handler,"SELECT * FROM userdata"),-1)
		if(#result>=1)then
			for _,v in pairs(result)do
				if(v["Company"]==tonumber(syncGetElementData(client,"Company")))then
					table.insert(tbl,{v["Username"],math.floor(v["Weeklytime"]/60)})
				end
			end
			triggerClientEvent(client,"set:factionpanelmembersaktiviti",client,tbl)
		end
	end
end)

addEvent("change:companynotes",true)
addEventHandler("change:companynotes",root,function(notes)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","companydepots","Company",tonumber(syncGetElementData(client,"Company"))),-1)
	if(result or result[1])then
		if(tonumber(syncGetElementData(client,"Company"))>=1 and tonumber(syncGetElementData(client,"Companyrank"))>=4)then
			handler:exec("UPDATE ?? SET ??=? WHERE ??=?","companydepots","Notes",notes,"Company",tonumber(syncGetElementData(client,"Company")))
			triggerClientEvent(client,"draw:infobox",root,"success","Du hast die Unternehmensnotizen geändert!")
		end
	end
end)
addEvent("get:companynotes",true)
addEventHandler("get:companynotes",root,function()
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ??","companydepots"),-1)
	if(#result>=1)then
		local tbl={}
		for _,v in pairs(result)do
			if(v["Company"]==tonumber(syncGetElementData(client,"Company")))then
				table.insert(tbl,{v["Notes"]})
			end
		end
		triggerClientEvent(client,"show:companynotes",client,tbl)
	end
end)

addEvent("get:companyranksalary",true)
addEventHandler("get:companyranksalary",root,function()
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ??","companydepots"),-1)
	if(#result>=1)then
		local tbl={}
		for _,v in pairs(result)do
			if(v["Faction"]==tonumber(syncGetElementData(client,"Faction")))then
				table.insert(tbl,{v["Rang0"],v["Rang1"],v["Rang2"],v["Rang3"],v["Rang4"],v["Rang5"]})
			end
		end
		triggerClientEvent(client,"show:companyranksalary",client,tbl)
	end
end)
addEvent("change:companyranksalary",true)
addEventHandler("change:companyranksalary",root,function(typ,amount)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","companydepots","Company",tonumber(syncGetElementData(client,"Company"))),-1)
	if(result or result[1])then
		if(tonumber(syncGetElementData(client,"Company"))>=1 and tonumber(syncGetElementData(client,"Companyrank"))>=5)then
			if(typ=="Rank0")then
				handler:exec("UPDATE ?? SET ??=? WHERE ??=?","companydepots","Rang0",amount,"Company",tonumber(syncGetElementData(client,"Company")))
				triggerClientEvent(client,"draw:infobox",root,"success","Unternehmensrang 0 Gehalt geändert!")
			elseif(typ=="Rank1")then
				handler:exec("UPDATE ?? SET ??=? WHERE ??=?","companydepots","Rang1",amount,"Company",tonumber(syncGetElementData(client,"Company")))
				triggerClientEvent(client,"draw:infobox",root,"success","Unternehmensrang 1 Gehalt geändert!")
			elseif(typ=="Rank2")then
				handler:exec("UPDATE ?? SET ??=? WHERE ??=?","companydepots","Rang2",amount,"Company",tonumber(syncGetElementData(client,"Company")))
				triggerClientEvent(client,"draw:infobox",root,"success","Unternehmensrang 2 Gehalt geändert!")
			elseif(typ=="Rank3")then
				handler:exec("UPDATE ?? SET ??=? WHERE ??=?","companydepots","Rang3",amount,"Company",tonumber(syncGetElementData(client,"Company")))
				triggerClientEvent(client,"draw:infobox",root,"success","Unternehmensrang 3 Gehalt geändert!")
			elseif(typ=="Rank4")then
				handler:exec("UPDATE ?? SET ??=? WHERE ??=?","companydepots","Rang4",amount,"Company",tonumber(syncGetElementData(client,"Company")))
				triggerClientEvent(client,"draw:infobox",root,"success","Unternehmensrang 4 Gehalt geändert!")
			elseif(typ=="Rank5")then
				handler:exec("UPDATE ?? SET ??=? WHERE ??=?","companydepots","Rang5",amount,"Company",tonumber(syncGetElementData(client,"Company")))
				triggerClientEvent(client,"draw:infobox",root,"success","Unternehmensrang 5 Gehalt geändert!")
			end
		end
	end
end)


addEvent("load:companyvehicles",true)
addEventHandler("load:companyvehicles",root,function()
	local tbl={}
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","companyvehicles","Owner",tonumber(syncGetElementData(client,"Company"))),-1)
	if(#result>=1)then
		for _,v in pairs(result)do
			if(v["Owner"]==tonumber(syncGetElementData(client,"Company")))then
				table.insert(tbl,{v["ID"],getVehicleNameFromModel(v["VehID"])})
			end
		end
		triggerClientEvent(client,"show:companyvehicles",client,tbl)
	end
end)

addEvent("respawn:1companyvehicle",true)
addEventHandler("respawn:1companyvehicle",root,function(id)
	local company=tonumber(syncGetElementData(client,"Company"))
	if(company and company>=1 and id)then
		if(isElement(CompanyVehicles[company..id]))then
			local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","companydepots","Company",company),-1)
			if(result and result[1])then
				handler:exec("UPDATE ?? SET ??=? WHERE ??=?","companydepots","Money",tonumber(result[1]["Money"])-250,"Company",company)
				CompanyVehicles[company..id]:destroy()
				loadCompanyVehicles(company)
				triggerClientEvent(client,"draw:infobox",root,"success","Unternehmensfahrzeug erfolgreich respawnt!")
			end
		end
	end
end)