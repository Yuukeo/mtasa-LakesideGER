--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("give:wanteds",true)
addEventHandler("give:wanteds",root,function(kplayer,reason,amount)
	if(isSTATE(client)and syncGetElementData(client,"CopDuty")==true)then
		local target=getPlayerFromName(kplayer)
		if(target)then
			if(isElement(target))then
				if(tonumber(syncGetElementData(target,"Jailtime"))==0)then
					if(tonumber(syncGetElementData(target,"Wanteds"))<6)then
						outputChatBox(""..getPlayerName(client).." hat dir x"..amount.." Wanted(s) gegeben! Grund: " ..reason,target,200,0,0)
						outputChatBox("Du hast "..getPlayerName(target).." x"..amount .." Wanted(s) gegeben! Grund: "..reason,client,0,200,0)
						syncSetElementData(target,"Wanteds",tonumber(syncGetElementData(target,"Wanteds"))+amount)
						sendMSGForFaction("#008cff[DEPARTMENT] #ffffff"..getPlayerName(client).." hat "..getPlayerName(target).." x"..amount.." Wanted(s) gegeben! Grund: "..reason,1,200,200,0)
						sendMSGForFaction("#008cff[DEPARTMENT] #ffffff"..getPlayerName(client).." hat "..getPlayerName(target).." x"..amount.." Wanted(s) gegeben! Grund: "..reason,2,200,200,0)
						if(tonumber(syncGetElementData(target,"Wanteds"))>=6)then
							syncSetElementData(target,"Wanteds",6)
						end
					else
						triggerClientEvent(client,"draw:infobox",root,"error","Der Spieler hat bereits 6 Wanteds!")
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Der Spieler ist bereits im Knast!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"warning","Der Spieler ist offline!")
			end
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","Du bist nicht im Dienst!")
	end
end)
addEvent("delete:wanteds",true)
addEventHandler("delete:wanteds",root,function(target)
	if(isSTATE(client)and tonumber(syncGetElementData(client,"Factionrank"))>=3 and syncGetElementData(client,"CopDuty")==true)then
		if(target)then
			local target=getPlayerFromName(target)
			if(isElement(target))then
				if(tonumber(syncGetElementData(target,"Wanteds"))>=1)then
					syncSetElementData(target,"Wanteds",0)
					sendMSGForFaction("#008cff[DEPARTMENT] #ffffff"..getPlayerName(client).." hat die Wanteds von "..getPlayerName(target).." gelöscht!",1,200,200,0)
					sendMSGForFaction("#008cff[DEPARTMENT] #ffffff"..getPlayerName(client).." hat die Wanteds von "..getPlayerName(target).." gelöscht!",2,200,200,0)
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Der Spieler hat keine Wanteds!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"warning","Der Spieler ist offline!")
			end
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","Du bist kein Polizist Rang 3+ oder nicht im Dienst!")
	end
end)

addEvent("give:stvos",true)
addEventHandler("give:stvos",root,function(kplayer,reason,amount,license)
	if(isSTATE(client)and syncGetElementData(client,"CopDuty")==true)then
		local target=getPlayerFromName(kplayer)
		if(target)then
			if(isElement(target))then
				if(license=="Car")then
					if(tonumber(syncGetElementData(target,"CarLicensePoints"))<15)then
						outputChatBox(""..getPlayerName(client).." hat dir x"..amount.." StVO's gegeben! Grund: " ..reason,target,200,0,0)
						outputChatBox("Du hast "..getPlayerName(target).." x"..amount .." StVO's gegeben! Grund: "..reason,client,0,200,0)
						syncSetElementData(target,"CarLicensePoints",tonumber(syncGetElementData(target,"CarLicensePoints"))+amount)
						sendMSGForFaction("#008cff[DEPARTMENT] #ffffff"..getPlayerName(client).." hat "..getPlayerName(target).." x"..amount.." StVO's gegeben! Grund: "..reason,1,200,200,0)
						sendMSGForFaction("#008cff[DEPARTMENT] #ffffff"..getPlayerName(client).." hat "..getPlayerName(target).." x"..amount.." StVO's gegeben! Grund: "..reason,2,200,200,0)
						if(tonumber(syncGetElementData(target,"CarLicensePoints"))>=15)then
							syncSetElementData(target,"CarLicensePoints",15)
						end
					else
						triggerClientEvent(client,"draw:infobox",root,"error","Der Spieler hat bereits 15 StVO's auf\nseinen Auto-Führerschein!")
					end
				elseif(license=="Bike")then
					if(tonumber(syncGetElementData(target,"BikeLicensePoints"))<15)then
						outputChatBox(""..getPlayerName(client).." hat dir x"..amount.." StVO's gegeben! Grund: " ..reason,target,200,0,0)
						outputChatBox("Du hast "..getPlayerName(target).." x"..amount .." StVO's gegeben! Grund: "..reason,client,0,200,0)
						syncSetElementData(target,"BikeLicensePoints",tonumber(syncGetElementData(target,"BikeLicensePoints"))+amount)
						sendMSGForFaction("#008cff[DEPARTMENT] #ffffff"..getPlayerName(client).." hat "..getPlayerName(target).." x"..amount.." StVO's gegeben! Grund: "..reason,1,200,200,0)
						sendMSGForFaction("#008cff[DEPARTMENT] #ffffff"..getPlayerName(client).." hat "..getPlayerName(target).." x"..amount.." StVO's gegeben! Grund: "..reason,2,200,200,0)
						if(tonumber(syncGetElementData(target,"BikeLicensePoints"))>=15)then
							syncSetElementData(target,"BikeLicensePoints",15)
						end
					else
						triggerClientEvent(client,"draw:infobox",root,"error","Der Spieler hat bereits 15 StVO's auf\nseinen Motorrad-Führerschein!")
					end
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"warning","Der Spieler ist offline!")
			end
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","Du bist nicht im Dienst!")
	end
end)

addEvent("locate:player",true)
addEventHandler("locate:player",root,function(kplayer)
	if(isSTATE(client)and syncGetElementData(client,"CopDuty")==true)then
		local target=getPlayerFromName(kplayer)
		if(target)then
			if(isElement(target))then
				if(getElementInterior(target)==0 and getElementDimension(target)==0)then
					if(tonumber(syncGetElementData(target,"Mobilephone"))==1 and syncGetElementData(target,"PhoneState")==1)then
						triggerClientEvent(client,"create:locateblip",client,target)
					else
						triggerClientEvent(client,"draw:infobox",root,"error","Das Handy des Spielers ist aus!")
					end
				end
			end
		end
	end
end)


local wantedReasons={
	--1
	["kpv"]={"Körperverletzung",1},
	["belei"]={"Beleidigung",1},
	["beleidigung"]={"Beleidigung",1},
	["verweigerung"]={"Verweigerung zur Durchsuchung",1},
	["durchsuchung"]={"Verweigerung zur Durchsuchung",1},
	["verweig"]={"Verweigerung zur Durchsuchung",1},
	["behinderung"]={"Beamtenbehinderung",1},
	["beh"]={"Beamtenbehinderung",1},
	["drogen1"]={"Drogenbesitz (10-49)",1},
	["vdieb"]={"Versuchter Diebstahl",1},
	["vd"]={"Versuchter Diebstahl",1},
	["sach"]={"Sachbeschädigung",1},
	["sb"]={"Sachbeschädigung",1},
	["beschädigung"]={"Sachbeschädigung",1},
	["illad"]={"illegale Werbung",1},
	["ad"]={"illegale Werbung",1},
	["waffe"]={"Waffennutzung",1},
	["konsum"]={"Drogenkonsum",1},
	["fof"]={"Fahren ohne Führerschein",1},
	["fahren"]={"Fahren ohne Führerschein",1},
	--2
	["flucht"]={"Flucht vor/aus Kontrolle",2},
	["bei"]={"Beihilfe zur Flucht",2},
	["beihilfe"]={"Beihilfe zur Flucht",2},
	["schuss"]={"Schusswaffen gebrauch",2},
	["stech"]={"Bestechungsversuch",2},
	["bestech"]={"Bestechungsversuch",2},
	["dieb"]={"Diebstahl",2},
	["diebstahl"]={"Diebstahl",2},
	["erpressung"]={"Erpressung/Drohung",2},
	["droh"]={"Erpressung/Drohung",2},
	["drohung"]={"Erpressung/Drohung",2},
	["anbau"]={"Drogen Anbau/Abbau",2},
	["abbau"]={"Drogen Anbau/Abbau",2},
	["drogen2"]={"Drogenbesitz (50-149)",2},
	["atm"]={"ATM Raub",2},
	["atmrob"]={"ATM Raub",2},
	--3
	["drogen3"]={"Drogenbesitz (150+)",3},
	["mord"]={"Mord",3},
	["rd"]={"Mord",3},
	--4
	["gn"]={"Geiselnahme",4},
	["geisel"]={"Geiselnahme",4},
	["snp"]={"Sniper-Nutzung",4},
	["sniper"]={"Sniper-Nutzung",4},
	["weedtruck"]={"Weedtruck",4},
	["weedt"]={"Weedtruck",4},
	["matstruck"]={"Matstruck",4},
	["matst"]={"Matstruck",4},
	--6
	["rpg"]={"Raketenwerfer-Nutzung",6},
	["raketenwerfer"]={"Raketenwerfer-Nutzung",6},
}

function giveWantedsSU(player,cmd,kplayer,reason)
	if(isLSPD(player)and syncGetElementData(player,"CopDuty")==true or isFBI(player)and syncGetElementData(player,"CopDuty")==true)then
		local target=getPlayerFromName(kplayer)
		if(target and isLoggedin(target))then
			if(syncGetElementData(target,"Jailtime")==0)then
				local reason=string.lower(reason)
				if(wantedReasons[reason])then
					syncSetElementData(target,"Wanteds",tonumber(syncGetElementData(target,"Wanteds"))+wantedReasons[reason][2])
					if(tonumber(syncGetElementData(target,"Wanteds"))>=6)then
						syncSetElementData(target,"Wanteds",6)
					end
					sendMSGForFaction("#008cff[DEPARTMENT] #ffffff"..getPlayerName(player).." hat "..getPlayerName(target).." x"..wantedReasons[reason][2].." Wanted(s) gegeben! Grund: "..wantedReasons[reason][1].."",1,200,200,0)
					sendMSGForFaction("#008cff[DEPARTMENT] #ffffff"..getPlayerName(player).." hat "..getPlayerName(target).." x"..wantedReasons[reason][2].." Wanted(s) gegeben! Grund: "..wantedReasons[reason][1].."",2,200,200,0)
				else
					triggerClientEvent(player,"draw:infobox",root,"warning","Ungültiger Grund!")
				end
			end
		end
	else
		triggerClientEvent(player,"draw:infobox",root,"error","Du bist nich im Dienst!")
	end
end
addCommandHandler("su",giveWantedsSU)
addCommandHandler("suspect",giveWantedsSU)