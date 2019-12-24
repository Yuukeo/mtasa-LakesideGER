--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: Bonus                          ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent ( "rechneKILLAnServer", true )
addEvent ( "gangAttack", true )
addEvent ( "triggerActualVehiclePositionForGangwar", true )

--------------------------
-- Tabellen & Variablen --
--------------------------

--- EINSTELLBAR ---

-- Einkommen & Bonus --
local minanzahlfuerbonus = 1   							-- Wieviele Spieler mindestens online sein müssen für die Boni
local hoherbonus = 50    								-- Der höhere Bonus Mats/Drogen je Ganggebiet
local niedrigerbonus = 20    							-- Der niedrigere Bonus Mats/Drogen je Ganggebiet 
local geldbonusfuereroberung = 1500	    				-- Der Bonus (Geld), wenn man ein Gebiet erobert
local geldprodamageimgw = 7     						-- Geld pro Damage
local geldprokillimgw = 250     						-- Geld pro Kill

-- Allgemeine Einstellungen zum Gangwar --
local maxanzahlanattacks = 4   							-- Maximale Anzahl an Attacks pro Tag
local minanzahlangwteilnehmern = 1			   			-- Mindestanzahl an Spielern in beiden Frakis für Attack
local diegangwardimension = 14    						-- Die Dimension, in der der Gangwar stattfinden soll
local minutenzumgwsieg = 15    							-- Minuten zu Halten, um den Gangwar als Angreifer zu gewinnen
local vorbereitungszeit = 3    							-- Minuten zur Vorbereitung vor dem richtigen Gangwar
local reichweitezumtk = 15    							-- Mindestreichweite zum TK, um drin zu sein - ACHTUNG: Clientseitig auch ändern!
local minutennachgwwaffenbekommen = 2   				-- Nach wievielen Minuten nach dem Gangwar man die Waffen zurück bekommen soll. Wenn man nach dem GW sofort am Spawnpunkt spawnt am besten 0, andernfalls 2
local minRankzumattackgeben = 4  						-- MindestRank, um einer gegnerischen Faction ein Attack zu geben
local distanzzumtkfuerbeitreten = 200  					-- min. Distanz zum TK für /joinattack oder /defend
local minRankzumjoinerlaubnisgeben = 3 					-- Mindestrang, um einem gegnerischen Spieler Erlaubnis zum Joinen zu geben - Hohe Zahl eingeben, um es zu deaktivieren
local mindestrangzumattack = 3 							-- Mindestrang, um ein Gangwar starten zu können.
local minrangzumattackgeben = 3 						-- Mindestrang, um dem Gegner einen Attack zu geben.

-- Gangwar-Fahrzeuge --
local tkfahrzeug = 482  								-- Das Fahrzeug für den Totenkopf - 0 für keine
local helikopterid = 487  								-- Der Helikopter für den Gangwar - 0 für keine | ACHTUNG: Alle Helikopter im Gangwar werden gelöscht, falls helikopterid nicht 0 ist, also auch Fraktionsfahrhelikopter. Fraktionshelikopter also nur benutzen, falls Gangwarhelikopter nicht spawnen sollen ( also helikopterid = 0 )

-- Features --
local angreiferkannmehrsein = true    					-- Ob der Angreifer einer mehr als der Verteidiger sein darf
local verteidigerkannmehrsein = false    				-- Ob der Verteidiger einer mehr als der Verteidiger sein darf
local freezeautomatisch = true    						-- Ob die Fahrzeuge nach der Vorbereitung von selbst gebreakt werden sollen - ACHTUNG: Das Fahrzeug ist dann auch nicht abgeschlossen!
local spawnwegnachgw = true    							-- Ob der Spieler nach dem GW wieder am Spawnpunkt spawnen soll
local heilungvorgw = true     							-- Ob die Spieler vor GW Beginn geheilt werden sollen (Leben & Weste) 
local gebewaffenvorgw = false     						-- Ob man die Waffen von der Tabelle givenWeapons vor dem GW bekommen soll
local sofortigerabbruchbeinullverteidigern = true    	-- Ob der GW direkt für Angreifer gewonnen ist, wenn es keine lebenden Verteidiger im GW mehr gibt
local sofortigerabbruchbeinullangreifern = true     	-- Ob der GW direkt für Verteidiger gewonnen ist, wenn es keine lebenden Angreifer im GW mehr gibt


local blocked_cmds = {	["smoke"] = true, ["usedrugs"] = true, ["sellgun"] = true, ["eat"] = true,
	["internet"] = true, ["lay"] = true, ["ground"] = true, ["fish"] = true, ["premium"] = true,
	["quitjob"] = true, ["chairsit"] = true, ["drunk"] = true, ["crack"] = true, ["move"] = true,
	["goto"] = true, ["gethere"] = true, ["self"] = true, ["save"] = true }
local gangCount = 0
local gangArea, gangPickup, gangAllow, allowTimer, erledigteStatistik, allowedToJoin = {}, {}, {}, {}, {}, {}
local gangAttacks = { [3] = maxanzahlanattacks, [4] = maxanzahlanattacks, [5] = maxanzahlanattacks}
local teamBlips = { [3] = {}, [4] = {}, [5] = {}}
local allowedWeapons = { [22] = true, [23] = true, [24] = true, [29] = true, [30] = true,
                         [31] = true, [33] = true, [44] = true, [45] = true }
local givenWeapons = { [24] = 90, [29] = 300, [31] = 450, [33] = 100 }
local gangareaWithHelicopter = {
	[20] = true }
local gangwarHelicopters = {
	{ ["model"] = helikopterid, ["x"] = -2630.29932, ["y"] = 1345.35999, ["z"] = 7.11159, ["rot"] = 270 },
	{ ["model"] = helikopterid, ["x"] = -2630.29932, ["y"] = 1348.35999, ["z"] = 7.11159, ["rot"] = 270 } }
factionGangAreas = { [3] = 0, [4] = 0, [5] = 0}


local gangData = { attacker = 0, defender = 0, attackeralive = 0,
				   defenderalive = 0, attackerfrac, ownerfrac, clonepickup, clonearea,
				   pickup }
local gangTimer = { victory, eroberung, start }
local gangVehicles = {}
local gangAreaAttackbar = true
playerData = {}
local sortierteStatistikTabelle = {}
local spielerSitztImFahrzeug = {}
local vehiclePlayerMoving = {}
local spielerSitztImFahrzeugSitz = {}
local tkfahrzeugtabelle = {}
gangAreaUnderAttack, gangAreaUnderPreparation = false, false
local validID, validIDlast, zeitohnetk, gangwarstartzeit = 0, 0, 0, 0
local zuruckGebenTimer = nil


addEventHandler ( "onResourceStart", resourceRoot, function ()
	local result = dbPoll ( dbQuery ( handler, "SELECT * from ?? WHERE ??=?","gangareas","Aktiviert","1" ), -1 )
	for i=1, #result do
		local row = result[i]
		gangCount = gangCount + 1
		local Besitzer = tonumber ( row["BesitzerFraktion"] )
		factionGangAreas[Besitzer] = factionGangAreas[Besitzer] + 1
		local Einnahmen = tonumber ( row["Einnahmen"] )
		local X1 = tonumber ( row["X1"] )
		local Y1 = tonumber ( row["Y1"] )
		local X2 = tonumber ( row["X2"] )
		local Y2 = tonumber ( row["Y2"] )
		local XS = math.abs(X1-X2)
		local YS = math.abs(Y1-Y2)	
		local X3 = tonumber ( row["X3"] )
		local Y3 = tonumber ( row["Y3"] )
		local Z3 = tonumber ( row["Z3"] )
		local Name = row["Name"]
		local r = settings.faction.ranknames.color[Besitzer][1]
		local g = settings.faction.ranknames.color[Besitzer][2]
		local b = settings.faction.ranknames.color[Besitzer][3]
		gangArea[gangCount] = createRadarArea ( X1, Y1, XS, YS, r, g, b, 130, root )
		gangPickup[gangCount] = {
			["pickup"] = createPickup ( X3, Y3, Z3, 3, 1313, 1, 9999 ),
			["besitzer"] = Besitzer,
			["einnahmen"] = Einnahmen,
			["name"] = Name,
			["blocked"] = false,
			["original"] = row["ID"],
			["tkcolshape"] = createColSphere ( X3, Y3, Z3, reichweitezumtk ),
			["colshape"] = createColCuboid ( X1, Y1, -50, XS, YS, 7500 ) }	
		addEventHandler ( "onPickupHit", gangPickup[gangCount]["pickup"], gangPickupHit )
		addEventHandler ( "onColShapeHit", gangPickup[gangCount]["colshape"], gangAreaColShapeHit_func )
	end
	setTimer(gangAreaEinnahmen,60*60*1000,0)
end)

function gangAreaEinnahmen()
	local belohnungen={}
	for i,_ in pairs(gangAttacks)do
		belohnungen[i]={mats=0,drogen=0,geld=0}
	end
	for i=1,gangCount do
		local besitzer=gangPickup[i]["besitzer"]
		if(gangAttacks[besitzer])then
			local insmats=0
			local insdrogen=0
			local insgeld=0
			if(i<=math.floor(1*(gangCount/4)))then
				belohnungen[besitzer].mats=belohnungen[besitzer].mats+hoherbonus
			elseif(i<=math.floor(2*(gangCount/4)))then
				belohnungen[besitzer].drogen=belohnungen[besitzer].drogen+hoherbonus
			elseif(i<=math.floor(3*(gangCount/4)))then
				belohnungen[besitzer].mats=belohnungen[besitzer].drogen+niedrigerbonus
			else
				belohnungen[besitzer].drogen=belohnungen[besitzer].drogen+niedrigerbonus
			end
			belohnungen[besitzer].geld=belohnungen[besitzer].geld+gangPickup[i]["einnahmen"]
		end
	end
	for i,v in pairs(belohnungen)do
		if(getFactionMembersOnline(i)>=minanzahlfuerbonus)then
			if(v.mats+v.drogen+v.geld>0)then
				for index,_ in pairs(i)do
				--for index,_ in pairs(settings.faction.ranknames.levelnames[i])do
					outputChatBox("|___ Ganggebiete - Boni ___|",index,0,200,0)
					outputChatBox(" ",index,0,0,0)
					outputChatBox("#ffffffMaterialen: #35A327 x"..v.mats,index,0,0,0,true)
					outputChatBox("#ffffffDrogen: #35A327 x"..v.drogen,index,0,0,0,true)
					outputChatBox("#ffffffGeld: #35A327$ "..v.geld.."",index,0,0,0,true)
					outputChatBox("______________________",index,0,200,0)
				end
				
				local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",i),-1)
				if(result and result[1])then
					handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Money",tonumber(result[1]["Money"])+v.geld,"Faction",i)
					handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Weed",tonumber(result[1]["Weed"])+v.drogen,"Faction",i)
					handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Mats",tonumber(result[1]["Mats"])+v.mats,"Faction",i)
				end
			end
		end
	end
end



function gangAreaColShapeHit_func ( hitElement )
	if getElementType ( hitElement ) == "player" and getElementDimension ( hitElement ) ~= diegangwardimension then
		triggerClientEvent(hitElement,"draw:infobox",root,"info","Du bist im Gebiet der "..settings.faction.ranknames.levelnames[getOwnerByColShape(source)])
	end
end


function gangPickupHit(hit)
	local id=getIDByPickup(source)
	local bonus
	
	triggerClientEvent(hit,"draw:infobox",root,"info","Dieses Ganggebiet gehört: "..settings.faction.ranknames.levelnames[gangPickup[id]["besitzer"]])
	if id<=math.floor(1*(gangCount/4))then
		bonus=hoherbonus.." Materialien."
	elseif id<=math.floor(2*(gangCount/4))then
		bonus=hoherbonus.."g Drogen."
	elseif id<=math.floor(3*(gangCount/4))then
		bonus=niedrigerbonus.." Materialien."
	else
		bonus=niedrigerbonus.."g Drogen."
	end
	outputChatBox("Einnahmen/Stunde: "..gangPickup[id]["einnahmen"].."$ und "..bonus,hit,255,255,255)
	
	local Faction=tonumber(syncGetElementData(hit,"Faction"))
	if gangAttacks[Faction] then
		if(syncGetElementData(hit,"Factionrank")>=mindestrangzumattack)then
			triggerClientEvent(hit,"draw:infobox",root,"info","Tippe /attack, um einen Angriff zu starten!")
		end
	end
end
	

function gangattack_func ( player )
	if gangAreaAttackbar then
		if not gangAreaUnderPreparation and not gangAreaUnderAttack then
			gangAreaAttackbar = false
			local attackerfrac = syncGetElementData ( player, "Faction" )
			if gangAttacks[attackerfrac] and syncGetElementData ( player, "Factionrank" ) >= mindestrangzumattack then
				local x1, y1, z1 = getElementPosition ( player )
				sucess = false
				for i = 1, gangCount do
					local x2, y2, z2 = getElementPosition ( gangPickup[i]["pickup"] )
					if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= 3 then
						validID = i
						validIDlast = i
						sucess = true
						break
					end
				end
				if sucess then
					local ownerfrac = gangPickup[validID]["besitzer"]
					if gangAttacks[attackerfrac] > 0 or gangAllow[attackerfrac..ownerfrac] then
						if not gangPickup[validID]["blocked"] then
							if ownerfrac ~= attackerfrac then
								if getFactionMembersOnline ( ownerfrac ) >= minanzahlangwteilnehmern and getFactionMembersOnline( attackerfrac ) >= minanzahlangwteilnehmern then 
									gangData.attackerfrac = attackerfrac
									gangData.ownerfrac = ownerfrac
									gangAllow[attackerfrac..ownerfrac] = nil
									if isTimer ( allowTimer[attackerfrac..ownerfrac] ) then
										killTimer ( allowTimer[attackerfrac..ownerfrac] )
									end
									gangAttacks[attackerfrac] = gangAttacks[attackerfrac] - 1
									startGangAreaAttack()
									triggerClientEvent(player,"draw:infobox",root,"error","Die Vorbereitung für den Gangwar ist gestartet!")
									return true
								else
									triggerClientEvent(player,"draw:infobox",root,"error","Min. "..minanzahlangwteilnehmern.." Spieler online in beiden Fraktionen!")
								end
							else
								triggerClientEvent(player,"draw:infobox",root,"error","Du kannst nicht dein eigenes Gebiet angreifen!")
							end
						else
							triggerClientEvent(player,"draw:infobox",root,"error","Das Gebiet wurde schon mal angegriffen!")
						end
					else
						triggerClientEvent(player,"draw:infobox",root,"error","Ihr habt kein Attack frei!")
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","Du bist an keinem Totenkopf!")
				end				
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Ab Fraktionsrang "..mindestrangzumattack.."+!")
			end
			gangAreaAttackbar=true
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Es läuft schon ein Gangwar!")
		end
	else
		triggerClientEvent(player,"draw:infobox",root,"error","Versuch es in paar Minuten erneut.")
		if not gangAreaUnderAttack and not gangAreaUnderPreparation and not isTimer ( zuruckGebenTimer ) then
			gangAreaAttackbar=true
		end
	end
end


function startGangAreaAttack ( )
	gangAreaUnderPreparation = true
	gangData.clonearea = cloneElement ( gangArea[validID] )
	gangData.clonepickup = cloneElement ( gangPickup[validID]["pickup"]  )
	setElementDimension ( gangData.clonearea, diegangwardimension )
	setElementDimension ( gangData.clonepickup, diegangwardimension )
	outputChatBox ( "Ein Gangwar wird vorbereitet!", getRootElement(), 255, 0, 0 )
	outputLog ( settings.faction.ranknames.levelnames[gangData.attackerfrac].." vs "..settings.faction.ranknames.levelnames[gangData.ownerfrac], "Fraktion" )
	playerData = {}
	for key, thePlayer in pairs ( getElementsWithinColShape ( gangPickup[validID]["colshape"], "player" ) ) do
		if syncGetElementData ( thePlayer, "Faction" ) == gangData.attackerfrac then
			if ( angreiferkannmehrsein and gangData.attacker <= getFactionMembersOnline ( gangData.ownerfrac ) ) or ( not angreiferkannmehrsein and gangData.attacker < getFactionMembersOnline ( gangData.ownerfrac ) ) then
				gangData.attacker = gangData.attacker + 1
				gangwarPreparation ( thePlayer )
			else
				triggerClientEvent(thePlayer,"draw:infobox",root,"warning","Ihr seid schon genug!")
			end
		end
	end
	gangData.attackeralive = gangData.attacker
	createVehicles ()
	for playeritem, tables in pairs ( playerData ) do
		local player = getPlayerFromName ( playeritem )
		if isElement ( player ) and tables["imGW"] then
			triggerClientEvent ( player, "updateAnzeigePrepare", player, 60*vorbereitungszeit, gangData.attacker, gangData.attackerfrac, gangData.ownerfrac, gangPickup[validID]["pickup"] )
		end
	end
	gangTimer.start = setTimer ( function ()
		gangwarstartzeit = getRealTime().timestamp
		for playeritem, tables in pairs ( playerData ) do
			local player = getPlayerFromName ( playeritem )
			if isElement ( player ) and tables["imGW"] then 
				triggerClientEvent ( player, "updateAnzeigeStart", player, 60*minutenzumgwsieg, gangData.attackeralive, gangData.attacker )
				setPedAnimation ( player )
				if heilungvorgw then
					setElementHealth( player, 100 )
					setPedArmor( player, 100 )
				end
				syncSetElementData(player,"Hunger",100)
				addEventHandler ( "onPlayerCommand", player, disableBlockedCMD )
			end			
			removeEventHandler ( "onPlayerClick", player, moveVehicleInGangwar )
		end
		gangAreaUnderAttack = true
		gangAreaUnderPreparation = false
		for index, vehicle in pairs ( gangVehicles ) do
			if freezeautomatisch then
				if isVehicleOccupied ( vehicle ) then
					for seat, thePlayer in pairs ( getVehicleOccupants ( vehicle ) ) do
						if thePlayer and getElementType ( thePlayer ) == "player" then
							removePedFromVehicle ( thePlayer ) 
						end
					end
				end
				if getVehicleType ( vehicle ) ~= "Helicopter" then
					setElementFrozen ( vehicle, true )
					setVehicleLocked ( vehicle, true )
				end
			end
			if getVehicleType ( vehicle ) == "Helicopter" then
				setElementFrozen ( vehicle, false )
			end
			fixVehicle ( vehicle )
		end
		setRadarAreaFlashing ( gangArea[validID], true )
		setRadarAreaColor ( gangArea[validID], 125, 0, 0, 200 )
		setRadarAreaFlashing ( gangData.clonearea, true )
		setRadarAreaColor ( gangData.clonearea, 125, 0, 0, 200 )
		gangTimer.eroberung = setTimer ( areaEroberungsCheck, 5000, 0 )
		gangTimer.victory = setTimer ( gangwarAttackerGewonnen, minutenzumgwsieg*60*1000+50, 1 )
		sendMSGForFaction ( "Die "..settings.faction.ranknames.levelnames[gangData.attackerfrac].." greifen euer Gebiete "..gangPickup[validID]["name"].." an!", gangData.ownerfrac, 150, 0, 0 )
		sendMSGForFaction ( "Verteidigt es mit /defend oder ihr werdet es verlieren! /gwbefehle für alle Befehle.", gangData.ownerfrac, 150, 0, 0 )
		if gangareaWithHelicopter[gangPickup[validID]["original"]] then
			sendMSGForFaction ( "Die Helikopter sind am Jizzy's!", gangData.ownerfrac, 150, 0, 0 )
		end
		sendMSGForFaction ( "Ihr habt "..gangPickup[validID]["name"].." von "..settings.faction.ranknames.levelnames[gangData.ownerfrac].." angegriffen! /gwbefehle für alle Befehle.", gangData.attackerfrac, 0, 150, 0 )
		sendMSGForFaction ( "Haltet sie "..minutenzumgwsieg.." Minuten lang vom Totenkopf fern, um das Gebiet zu erobern!", gangData.attackerfrac, 0, 150, 0 )
		local msg = "[INFO]: Die "..settings.faction.ranknames.levelnames[gangData.attackerfrac].." haben einen Gangwar gegen die "..settings.faction.ranknames.levelnames[gangData.ownerfrac].." gestartet!"
		for index, _ in pairs ( gangAttacks ) do
			if index ~= gangData.attackerfrac and index ~= gangData.ownerfrac then
				sendMSGForFaction ( msg, index, 100, 100, 0 )
			end
		end
	end, 1000 * vorbereitungszeit * 60+100, 1 )
end


function areaEroberungsCheck ( )
	local suc = false
	local x1, y1, z1 = getElementPosition ( gangPickup[validID]["pickup"] )
	for index, player in pairs ( getElementsWithinColShape ( gangPickup[validID]["tkcolshape"], "player" ) ) do
		if syncGetElementData ( player, "Faction" ) == gangData.attackerfrac then	
			local pname = getPlayerName ( player )
			if playerData[pname] and playerData[pname]["imGW"] then
				suc = true
				if zeitohnetk > 0 then
					zeitohnetk = 0
					sendMSGForFaction ( "TK ist wieder besetzt!", gangData.attackerfrac, 0, 200, 0 )
				end
				break
			end
		end
	end
	if not suc then
		zeitohnetk = zeitohnetk+1
		if zeitohnetk == 1 then
			sendMSGForFaction ( "Keiner ist am TK! Ihr habt noch 15 Sekunden!", gangData.attackerfrac, 200, 0, 0 )
		elseif zeitohnetk == 2 then
			sendMSGForFaction ( "Ihr habt noch 10 Sekunden!", gangData.attackerfrac, 200, 0, 0 )
		elseif zeitohnetk == 3 then
			sendMSGForFaction ( "Noch 5 Sekunden!", gangData.attackerfrac, 200, 0, 0 )
		elseif zeitohnetk == 4 then
			gangwarDefenderGewonnen ()
		end
	end
end

function gangwarDefenderGewonnen ()
	local r = settings.faction.ranknames.color[gangData.ownerfrac][1]
	local g = settings.faction.ranknames.color[gangData.ownerfrac][2]
	local b = settings.faction.ranknames.color[gangData.ownerfrac][3]
	setRadarAreaColor ( gangArea[validID], r, g, b, 200 )
	sortierePlayerDataTabelle ()
	sendMSGForFaction ( "Gebiet erfolgreich gegen die "..settings.faction.ranknames.levelnames[gangData.attackerfrac].." verteidigt!", gangData.ownerfrac, 0, 150, 0 )
	outputLog ( "Gebiet erfolgreich gegen die "..settings.faction.ranknames.levelnames[gangData.attackerfrac].." verteidigt!", "Fraktion" )
	outputChatBox ( "[INFO]: Die "..settings.faction.ranknames.levelnames[gangData.ownerfrac].." haben ihr Gebiet "..gangPickup[validID]["name"].." erfolgreich gegen die "..settings.faction.ranknames.levelnames[gangData.attackerfrac].." verteidigt!", root, 100, 150, 0 )
	gangPickup[validID]["blocked"] = true
	for playeritem, tables in pairs ( playerData ) do
		local player = getPlayerFromName ( playeritem )
		if isElement ( player ) and tables["imGW"] and spawnwegnachgw then
			spawnPlayerAfterGangwar ( player )
			gotLastHit[player] = 0
		elseif isElement ( player ) and tables["imGW"] then
			setElementDimension ( player, 0 )
			gotLastHit[player] = 0
		end
		if isElement ( player ) and syncGetElementData ( player, "Faction" ) == gangData.attackerfrac then
			syncSetElementData ( player, "GangwarLoses", ( syncGetElementData ( player, "GangwarLoses" ) or 0 ) + 1 )
		elseif isElement ( player ) then
			syncSetElementData ( player, "GangwarWins", ( syncGetElementData ( player, "GangwarWins" ) or 0 ) + 1 )
		end
	end
	zuruckGebenTimer = setTimer ( function()
		for playeritem, tables in pairs ( playerData ) do
			local player = getPlayerFromName ( playeritem )
			if isElement ( player ) then
				removeEventHandler ( "onPlayerQuit", player, gangwarOfflinefunc )
				removeEventHandler ( "onPlayerCommand", player, disableBlockedCMD )
				local kriegtwaffe = false
				for weapon, ammo in pairs ( tables["weapons"] ) do
					if allowedWeapons[weapon] then
						if not tables["died"] then
							giveWeapon ( player, weapon, ammo )
						end
					else
						giveWeapon ( player, weapon, ammo )
					end
					if ammo > 0 then
						kriegtwaffe = true
					end
				end
				if kriegtwaffe then
					outputChatBox("Du hast deine Waffen zurück bekommen!", player, 200, 200, 0)
				end
				outputChatBox("Damage - " .. math.floor ( tables["damage"] ) .. " | Kills - " .. tables["kills"], player,0,200,0)
				outputChatBox("Bonus: $"..(math.floor(tables["damage"])*geldprodamageimgw)+(tables["kills"]*geldprokillimgw), player,0,200,0)
				syncSetElementData(player,"Money",syncGetElementData(player,"Money")+ math.floor(tables["damage"]*geldprodamageimgw)+(tables["kills"]*geldprokillimgw))
			end
		end
		gangAreaAttackbar = true
	end, minutennachgwwaffenbekommen*60*1000+50, 1 ) 
	emptyEverythingForNewGW ()	
end


function gangwarAttackerGewonnen () 
	local r = settings.faction.ranknames.color[gangData.attackerfrac][1]
	local g = settings.faction.ranknames.color[gangData.attackerfrac][2]
	local b = settings.faction.ranknames.color[gangData.attackerfrac][3]
	setRadarAreaColor ( gangArea[validID], r, g, b, 200 )
	sortierePlayerDataTabelle ()
	sendMSGForFaction ( "Ihr habt euer Gebiet an die "..settings.faction.ranknames.levelnames[gangData.attackerfrac].." verloren!", gangData.ownerfrac, 150, 0, 0 )
	outputLog ( "Gebiet gegen die "..settings.faction.ranknames.levelnames[gangData.attackerfrac].." verloren!", "Fraktion" )
	outputChatBox ( "[INFO]: Die "..settings.faction.ranknames.levelnames[gangData.attackerfrac].." haben das Gebiet "..gangPickup[validID]["name"].." der "..settings.faction.ranknames.levelnames[gangData.ownerfrac].." erfolgreich erobert!", root, 150, 100, 0 )
	gangPickup[validID]["blocked"] = true
	factionGangAreas[gangData.ownerfrac] = factionGangAreas[gangData.ownerfrac] - 1
	factionGangAreas[gangData.attackerfrac] = factionGangAreas[gangData.attackerfrac] + 1
	gangPickup[validID]["besitzer"] = gangData.attackerfrac
	dbExec ( handler, "UPDATE ?? SET ?? = ? WHERE ?? = ?", "gangareas", "BesitzerFraktion", gangData.attackerfrac, "ID", gangPickup[validID]["original"] )
	for playeritem, tables in pairs ( playerData ) do
		local player = getPlayerFromName ( playeritem )
		if isElement ( player ) and syncGetElementData ( player, "Faction" ) == gangData.attackerfrac then
			syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+geldbonusfuereroberung)
		end
		if tables["imGW"] and spawnwegnachgw then
			tables["imGW"] = false
			spawnPlayerAfterGangwar ( player )
			gotLastHit[player] = 0
		elseif tables["imGW"] then
			setElementDimension ( player, 0 )
			gotLastHit[player] = 0
		end
		if isElement ( player ) and syncGetElementData ( player, "Faction" ) == gangData.attackerfrac then
			syncSetElementData ( player, "GangwarWins", ( syncGetElementData ( player, "GangwarWins" ) or 0 ) + 1 )
		elseif isElement ( player ) then
			syncSetElementData ( player, "GangwarLoses", ( syncGetElementData ( player, "GangwarLoses" ) or 0  ) + 1 )
		end
	end
	zuruckGebenTimer = setTimer ( function()
		for playeritem, tables in pairs ( playerData ) do
			local player = getPlayerFromName ( playeritem )
			if isElement ( player ) then
				removeEventHandler ( "onPlayerQuit", player, gangwarOfflinefunc )
				removeEventHandler ( "onPlayerCommand", player, disableBlockedCMD )
				local kriegtwaffe = false
				for weapon, ammo in pairs ( tables["weapons"] ) do
					if allowedWeapons[weapon] then
						if not tables["died"] then
							giveWeapon ( player, weapon, ammo )
						end
					else
						giveWeapon ( player, weapon, ammo )
					end
					if ammo > 0 then
						kriegtwaffe = true
					end
				end
				if kriegtwaffe then
					outputChatBox("Du hast deine Waffen zurück bekommen!", player, 200, 200, 0)
				end
				outputChatBox("Damage - " .. math.floor ( tables["damage"] ) .. " | Kills - " .. tables["kills"], player,0,200,0)
				outputChatBox("Bonus: $"..(math.floor(tables["damage"])*geldprodamageimgw)+(tables["kills"]*geldprokillimgw), player,0,200,0)
				syncSetElementData(player,"Money",syncGetElementData(player,"Money")+ math.floor(tables["damage"]*geldprodamageimgw)+(tables["kills"]*geldprokillimgw))
			end
		end
		gangAreaAttackbar = true
	end, 1000*minutennachgwwaffenbekommen*60+50, 1 ) 
	emptyEverythingForNewGW ()	
end



local function dontLetOthersUseIt ( player )
	if syncGetElementData ( player, "Faction" ) ~= gangData.ownerfrac then
		cancelEvent()
	end
end


function createVehicles ( )
	local counter = 0
	local x, y, z = getElementPosition ( gangPickup[validID]["pickup"] )
	if tkfahrzeug ~= 0 then
		counter = counter + 1
		gangVehicles[counter] = createVehicle ( tkfahrzeug, x-2, y-3, z+0.5 )
		tkfahrzeugtabelle[gangVehicles[counter]] = true
		counter = counter + 1
		gangVehicles[counter] = createVehicle ( tkfahrzeug, x-2, y+3, z+0.5 )
		tkfahrzeugtabelle[gangVehicles[counter]] = true
		counter = counter + 1
		gangVehicles[counter] = createVehicle ( tkfahrzeug, x+2, y-3, z+0.5 )
		tkfahrzeugtabelle[gangVehicles[counter]] = true
		counter = counter + 1
		gangVehicles[counter] = createVehicle ( tkfahrzeug, x+2, y+3, z+0.5 )
		tkfahrzeugtabelle[gangVehicles[counter]] = true
	end
	local ar, ag, ab = settings.faction.ranknames.color[gangData.attackerfrac][1], settings.faction.ranknames.color[gangData.attackerfrac][2], settings.faction.ranknames.color[gangData.attackerfrac][3]
	for _, vehicle in pairs ( gangVehicles ) do
		setElementDimension ( vehicle, diegangwardimension )
		setVehicleDamageProof ( vehicle, true )
		setVehicleColor ( vehicle, ar, ag, ab )
	end
	for _, vehicle in pairs ( getElementsWithinColShape ( gangPickup[validID]["colshape"], "vehicle" ) ) do
		--if factionVehicles[gangData.attackerfrac][vehicle] then
		if(FactionVehicles[gangData.attackerfrac..getElementData(vehicle,"ID")])then
			if isVehicleOnGround ( vehicle ) then
				for seat, occupant in pairs ( getVehicleOccupants ( vehicle ) ) do
					removePedFromVehicle ( occupant )
				end
				setElementDimension ( vehicle, diegangwardimension )
				fixVehicle ( vehicle )
				counter = counter + 1
				gangVehicles[counter] = vehicle
				setVehicleDamageProof ( vehicle, true )
			end
		end
	end
	if gangareaWithHelicopter[gangPickup[validID]["original"]] and helikopterid ~= 0 then
		for index, data in pairs ( gangwarHelicopters ) do
			counter = counter + 1
			gangVehicles[counter] = createVehicle ( data["model"], data["x"], data["y"], data["z"], 0, 0, data["rot"], settings.faction.ranknames.levelnames[gangData.ownerfrac] )
			tkfahrzeugtabelle[gangVehicles[counter]] = true
			setVehicleColor ( gangVehicles[counter], settings.faction.ranknames.color[gangData.ownerfrac][1], settings.faction.ranknames.color[gangData.ownerfrac][2], settings.faction.ranknames.color[gangData.ownerfrac][3] )
			setElementFrozen ( gangVehicles[counter], true )
			addEventHandler ( "onVehicleStartEnter", gangVehicles[counter], dontLetOthersUseIt ) 
			setElementDimension ( gangVehicles[counter], diegangwardimension )
			setVehicleDamageProof ( gangVehicles[counter], true )
		end
	end
end


function moveVehicleInGangwar ( button, state, element, x, y, z )
	if gangAreaUnderPreparation then
		if button == "left" then
			if state == "down" then
				if isElement ( element ) and getElementType ( element ) == "vehicle" then
					if not vehiclePlayerMoving[element] then
						if not isVehicleOccupied ( element ) then
							triggerClientEvent ( source, "moveVehicleInGangwar", source, element )	
							setElementCollisionsEnabled ( element, false )
							vehiclePlayerMoving[element] = source
						end
					end
				end
			end
		end
	end
end


addEventHandler ( "triggerActualVehiclePositionForGangwar", root, function ( vehicle, x, y, z, rz )
	setElementPosition ( vehicle, x, y, z )
	setElementRotation ( vehicle, 0, 0, rz )
	setElementCollisionsEnabled ( vehicle, true )
	vehiclePlayerMoving[vehicle] = nil
end )


function setBurritosBackInGangwar ( player )
	if gangAreaUnderPreparation and syncGetElementData ( player, "Faction" ) == gangData.attackerfrac then
		local x, y, z = getElementPosition ( gangPickup[validID]["pickup"] )
		setElementCollisionsEnabled ( gangVehicles[1], true )
		setElementCollisionsEnabled ( gangVehicles[2], true )
		setElementCollisionsEnabled ( gangVehicles[3], true )
		setElementCollisionsEnabled ( gangVehicles[4], true )
		setElementPosition ( gangVehicles[1], x-2, y-3, z+0.5 )
		setElementPosition ( gangVehicles[2], x-2, y+3, z+0.5 )
		setElementPosition ( gangVehicles[3], x+2, y-3, z+0.5 )
		setElementPosition ( gangVehicles[4], x+2, y+3, z+0.5 )
		sendMSGForFaction ( getPlayerName ( player ) .. " hat die Burritos respawnt", gangData.attackerfrac, 0, 200, 0 )
	end
end


function gangwarPreparation ( player )
	if gangAreaUnderPreparation then
		if isPedInVehicle ( player ) then
			removePedFromVehicle ( player )		
		end
		addEventHandler ( "onPlayerClick", player, moveVehicleInGangwar )
	elseif isPedInVehicle ( player ) then
		local seat = getPedOccupiedVehicleSeat ( player )
		if seat == 0 then
			local vehicle = getPedOccupiedVehicle ( player )
			if(FactionVehicles[syncGetElementData(player,"Faction")..getElementData(vehicle,"ID")])then
				isfracvehicle = true
				spielerSitztImFahrzeug[player] = vehicle
				spielerSitztImFahrzeugSitz[player] = 0
				for seat, occupant in pairs ( getVehicleOccupants ( vehicle ) ) do
					if seat ~= 0 then
						if syncGetElementData ( occupant, "Faction" ) == syncGetElementData ( player, "Faction" ) then
							if syncGetElementData ( occupant, "Faction" ) == gangData.ownerfrac then
								local alloweddefender = gangData.attacker
								if verteidigerkannmehrsein then
									alloweddefender = alloweddefender + 1
								end
								if ( gangData.defender < alloweddefender ) or allowedToJoin[player] then
									spielerSitztImFahrzeug[occupant] = vehicle
									spielerSitztImFahrzeugSitz[occupant] = seat
									gangwarDefend ( occupant )
								else
									removePedFromVehicle ( occupant )
									triggerClientEvent(player,"draw:infobox",root,"warning","Ihr seid schon genug!")
								end
							elseif syncGetElementData ( occupant, "Faction" ) == gangData.attackerfrac then
								local allowedattacker = gangData.defender
								if angreiferkannmehrsein then
									allowedattacker = allowedattacker + 1
								end
								if ( gangData.attacker < allowedattacker ) or allowedToJoin[player] then
									spielerSitztImFahrzeug[occupant] = vehicle
									spielerSitztImFahrzeugSitz[occupant] = seat
									gangwarAttack ( occupant )
								else
									removePedFromVehicle ( occupant )
									triggerClientEvent(player,"draw:infobox",root,"warning","Ihr seid schon genug!")
								end
							end
						else
							removePedFromVehicle ( occupant )
						end
					end
				end
				setElementDimension ( vehicle, diegangwardimension )
				gangVehicles[#gangVehicles+1] = vehicle
			else
				removePedFromVehicle ( player )	
			end
		end
	end
	local pname = getPlayerName ( player )
	if not playerData[pname] then
		playerData[pname] = {}
		playerData[pname]["name"] = pname
		syncSetElementData ( player, "GangwarRounds", ( syncGetElementData ( player, "GangwarRounds" ) or 0 ) + 1 )
	end
	playerData[pname]["imGW"] = true
	playerData[pname]["hatDMGbekommen"] = false
	playerData[pname]["damage"] = 0
	playerData[pname]["kills"] = 0
	playerData[pname]["attacker"] = ( syncGetElementData ( player, "Faction" ) == gangData.attackerfrac )
	playerData[pname]["weapons"] = {}
	playerData[pname]["died"] = false
	gotLastHit[player] = 0
	outputLog ( pname.." macht beim GW mit - "..tostring(playerData[pname]["attacker"]), "Fraktion" )
	local frac = syncGetElementData(player,"Faction")
	if isElement ( teamBlips[frac][player] ) then
		destroyElement ( teamBlips[frac][player] )
	end
	teamBlips[frac][player] = createBlipAttachedTo ( player, 0, 1, 255, 0, 0, 255, 0, 99999, player )
	for playeritem, blip in pairs ( teamBlips[frac] ) do
		if isElement ( playeritem ) then
			setElementVisibleTo ( teamBlips[frac][player], playeritem, true )
			setElementVisibleTo ( blip, player, true )
		end
	end
	for i = 0, 12 do
		playerData[pname]["weapons"][getPedWeapon ( player,i )] = getPedTotalAmmo ( player, i )
	end
	takeAllWeapons ( player )
	triggerClientEvent ( player, "startGWAnzeige", player )
	local x, y, z = getElementPosition(player)
	local rx, ry, rz = getElementRotation(player)
	local theskin = getElementModel (player)
	local theteam = getPlayerTeam (player)
	spawnPlayer ( player, x, y, z, rz, theskin, 0, diegangwardimension, theteam )
	addEventHandler ( "onPlayerQuit", player, gangwarOfflinefunc )
	if not gebewaffenvorgw then
		for weapon, ammo in pairs ( playerData[pname]["weapons"] ) do
			if allowedWeapons[weapon] then
				giveWeapon ( player, weapon, ammo )	
			end
		end
	else
		for weapon, ammo in pairs ( givenWeapons ) do
			giveWeapon ( player, weapon, ammo )
		end
	end
	if spielerSitztImFahrzeug[player] then
		warpPedIntoVehicle ( player, spielerSitztImFahrzeug[player], spielerSitztImFahrzeugSitz[player] ) 
	end
	if heilungvorgw then
		setElementHealth( player, 100 )
		setPedArmor( player, 100 )
	end
	syncSetElementData(player,"Hunger",100)
end


function gangwarDeathfunc ( attacker )
	local pname = getPlayerName ( client )
	if playerData[pname] and playerData[pname]["imGW"] then
		playerData[pname]["imGW"] = false
		playerData[pname]["died"] = true
		removeEventHandler ( "onPlayerQuit", client, gangwarOfflinefunc )
		removeEventHandler ( "onPlayerCommand", client, disableBlockedCMD )
		local frac = syncGetElementData(client,"Faction")
		if isElement ( teamBlips[frac][client] ) then
			destroyElement ( teamBlips[frac][client] )
			local x, y, z = getElementPosition ( client )
			teamBlips[frac][client] = createBlip ( x, y, z, 22, 1 )
			setElementDimension ( teamBlips[frac][client], diegangwardimension )
			setElementVisibleTo ( teamBlips[frac][client], root, false )
			for playeritem, blip in pairs ( teamBlips[frac] ) do
				if isElement ( playeritem ) then
					setElementVisibleTo ( teamBlips[frac][client], playeritem, true )
				end
			end
		end
		local isattacker = syncGetElementData ( client, "Faction" ) == gangData.attackerfrac
		if gangAreaUnderPreparation then
			if isattacker then
				gangData.attacker = gangData.attacker - 1
				gangData.attackeralive = gangData.attackeralive - 1
				for playeritem, tables in pairs ( playerData ) do
					local thePlayer = getPlayerFromName ( playeritem )
					if isElement ( thePlayer ) then
						triggerClientEvent ( thePlayer, "attackereinerofflineohnezaehlen", thePlayer )
					end
				end
				if sofortigerabbruchbeinullangreifern and gangData.attackeralive <= 0 then
					setTimer ( gangwarDefenderGewonnen, 1000, 1 )
				end
			else 
				gangData.defender = gangData.defender - 1
				gangData.defenderalive = gangData.defenderalive - 1
				for playeritem, tables in pairs ( playerData ) do
					local thePlayer = getPlayerFromName ( playeritem )
					if isElement ( thePlayer ) then
						triggerClientEvent ( thePlayer, "defendereinerofflineohnezaehlen", thePlayer )
					end
				end
				if sofortigerabbruchbeinullverteidigern and gangData.defenderalive <= 0 then
					setTimer ( gangwarAttackerGewonnen, 1000, 1 )
				end
			end
		elseif gangAreaUnderAttack then
			if isattacker then
				local gotnodmg = false
				gangData.attackeralive = gangData.attackeralive - 1
				if not playerData[pname]["hatDMGbekommen"] then
					gangData.attacker = gangData.attacker - 1
					gotnodmg = true
				end
				if gotnodmg then
					for thePlayer, tables in pairs ( playerData ) do
						local player = getPlayerFromName ( thePlayer )
						if player then
							triggerClientEvent ( player, "attackereinerofflineohnezaehlen", player )
						end
					end
				else
					for thePlayer, tables in pairs ( playerData ) do
						local player = getPlayerFromName ( thePlayer )
						if player then
							triggerClientEvent ( player, "attackereinergestorben", player )
						end
					end
				end
				if sofortigerabbruchbeinullangreifern and gangData.attackeralive <= 0 then
					setTimer ( gangwarDefenderGewonnen, 1000, 1 )
				end
			else 
				gangData.defenderalive = gangData.defenderalive - 1
				local gotnodmg = false
				if not playerData[pname]["hatDMGbekommen"] then
					gangData.defender = gangData.defender - 1
					gotnodmg = true
				end
				if gotnodmg then
					for thePlayer, tables in pairs ( playerData ) do
						local player = getPlayerFromName ( thePlayer )
						if player then
							triggerClientEvent ( player, "defendereinerofflineohnezaehlen", source )
						end
					end
				else
					for thePlayer, tables in pairs ( playerData ) do
						local player = getPlayerFromName ( thePlayer )
						if player then
							triggerClientEvent ( player, "defendereinergestorben", source )
						end
					end
				end
				if sofortigerabbruchbeinullverteidigern and gangData.defenderalive <= 0 then
					setTimer ( gangwarAttackerGewonnen, 1000, 1 )
				end
			end
			local attackername = getPlayerName ( attacker )
			if isElement ( attacker ) and getElementType ( attacker ) == "player" and attackername and playerData[attackername] and playerData[attackername]["imGW"] and syncGetElementData ( attacker, "Faction" ) ~= syncGetElementData ( client, "Faction" ) then
				playerData[attackername]["kills"] = playerData[attackername]["kills"] + 1
				syncSetElementData ( attacker, "GangwarKills",syncGetElementData ( attacker, "GangwarKills" )+1)
				triggerClientEvent ( attacker, "rechneKillAn", attacker, playerData[attackername]["kills"] )
				if syncGetElementData ( client, "lasthp" ) then
					triggerClientEvent ( attacker, "rechneDMGAn", attacker, syncGetElementData ( client, "lasthp" ) )
					playerData[attackername]["damage"] = playerData[attackername]["damage"] + syncGetElementData ( client, "lasthp" )
					syncSetElementData ( attacker, "GangwarDamageGemacht", ( syncGetElementData ( attacker, "GangwarDamageGemacht" ) or 0 ) + syncGetElementData ( client, "lasthp" ) )
					syncSetElementData ( client, "GangwarDamageBekommen", ( syncGetElementData ( client, "GangwarDamageBekommen" ) or 0 ) + syncGetElementData ( client, "lasthp" ) )
				end
				playerData[pname]["hatDMGbekommen"] = attacker	
			elseif playerData[pname]["hatDMGbekommen"] and playerData[playerData[pname]["hatDMGbekommen"]] then
				local attacker = playerData[pname]["hatDMGbekommen"]
				if isElement ( attacker ) then
					playerData[attackername]["kills"] = playerData[attackername]["kills"] + 1
					syncSetElementData ( attacker, "GangwarKills",syncGetElementData ( attacker, "GangwarKills" )+1)
					triggerClientEvent ( attacker, "rechneKillAn", attacker, playerData[attackername]["kills"] )
				end
				playerData[pname]["hatDMGbekommen"] = true
				if syncGetElementData ( client, "lasthp" ) then
					if isElement ( attacker ) then
						triggerClientEvent ( attacker, "rechneDMGAn", attacker, syncGetElementData ( client, "lasthp" ) )
						playerData[attackername]["damage"] = playerData[attackername]["damage"] + syncGetElementData ( client, "lasthp" )
						syncSetElementData ( attacker, "GangwarDamageGemacht", ( syncGetElementData ( attacker, "GangwarDamageGemacht" ) or 0 ) + syncGetElementData ( client, "lasthp" ) )
					end
					syncSetElementData ( client, "GangwarDamageBekommen", ( syncGetElementData ( client, "GangwarDamageBekommen" ) or 0 ) + syncGetElementData ( client, "lasthp" ) )
				end
			end
		end
		setElementDimension ( client, 0 )
		syncSetElementData ( client, "GangwarDeaths", ( syncGetElementData ( client, "GangwarDeaths" ) or 0 ) + 1 )
	end		
end
addEventHandler ( "rechneKILLAnServer", root, gangwarDeathfunc )


function gangwarOfflinefunc ( )
	local pname = getPlayerName ( source )
	if playerData[pname] then
		playerData[pname]["imGW"] = false
		if gebewaffenvorgw then
			takeAllWeapons ( source )
		end
		if isElement ( teamBlips[syncGetElementData(source,"Faction")][source] ) then
			destroyElement ( teamBlips[syncGetElementData(source,"Faction")][source] )
		end
		local isattacker = syncGetElementData ( source, "Faction" ) == gangData.attackerfrac
		if gangAreaUnderPreparation then
			if isattacker then
				gangData.attacker = gangData.attacker - 1
				gangData.attackeralive = gangData.attackeralive - 1
				for thePlayer, tables in pairs ( playerData ) do
					local player = getPlayerFromName ( thePlayer )
					if player then
						triggerClientEvent ( player, "attackereinerofflineohnezaehlen", player )
					end
				end
				if sofortigerabbruchbeinullangreifern and gangData.attackeralive <= 0 then
					setTimer ( gangwarDefenderGewonnen, 1000, 1 )
				end
			else 
				gangData.defender = gangData.defender - 1
				gangData.defenderalive = gangData.defenderalive - 1
				for thePlayer, tables in pairs ( playerData ) do
					local player = getPlayerFromName ( thePlayer )
					if player then
						triggerClientEvent ( player, "defendereinerofflineohnezaehlen", player )
					end
				end
				if sofortigerabbruchbeinullverteidigern and gangData.defenderalive <= 0 then
					setTimer ( gangwarAttackerGewonnen, 1000, 1 )
				end
			end
		elseif gangAreaUnderAttack then
			if isattacker then
				local gotnodmg = false
				gangData.attackeralive = gangData.attackeralive - 1
				if not playerData[pname]["hatDMGbekommen"] then
					gangData.attacker = gangData.attacker - 1
					gotnodmg = true
				end
				if gotnodmg then
					for thePlayer, tables in pairs ( playerData ) do
						local player = getPlayerFromName ( thePlayer )
						if player then
							triggerClientEvent ( player, "attackereinerofflineohnezaehlen", player )
						end
					end
				else
					for thePlayer, tables in pairs ( playerData ) do
						local player = getPlayerFromName ( thePlayer )
						if player then
							triggerClientEvent ( player, "attackereinergestorben", player )
						end
					end
				end
				if sofortigerabbruchbeinullangreifern and gangData.attackeralive <= 0 then
					setTimer ( gangwarDefenderGewonnen, 1000, 1 )
				end
			else 
				gangData.defenderalive = gangData.defenderalive - 1
				local gotnodmg = false
				if not playerData[pname]["hatDMGbekommen"] then
					gangData.defender = gangData.defender - 1
					gotnodmg = true
				end
				if gotnodmg then
					for thePlayer, tables in pairs ( playerData ) do
						local player = getPlayerFromName ( thePlayer )
						if player then
							triggerClientEvent ( player, "defendereinerofflineohnezaehlen", source )
						end
					end
				else
					for thePlayer, tables in pairs ( playerData ) do
						local player = getPlayerFromName ( thePlayer )
						if player then
							triggerClientEvent ( player, "defendereinergestorben", source )
						end
					end
				end
				if sofortigerabbruchbeinullverteidigern and gangData.defenderalive <= 0 then
					setTimer ( gangwarAttackerGewonnen, 1000, 1 )
				end
			end
		end
	end
end


function gangwarDefend ( player )
	if gangAreaUnderAttack then
		if syncGetElementData ( player, "Faction" ) == gangData.ownerfrac then
			local x, y, z = getElementPosition ( gangPickup[validID]["pickup"] ) 
			local xp, yp, zp = getElementPosition ( player ) 
			if getDistanceBetweenPoints3D ( xp, yp, zp, x, y, z ) >= distanzzumtkfuerbeitreten then
				local alloweddefender = gangData.attacker
				if verteidigerkannmehrsein then
					alloweddefender = alloweddefender + 1
				end
				if ( gangData.defender < alloweddefender ) or allowedToJoin[player] then
					local pname = getPlayerName ( player )
					if not playerData[pname] or ( not playerData[pname]["hatDMGbekommen"] and not playerData[pname]["imGW"] ) or allowedToJoin[player] then
						allowedToJoin[player] = nil
						gangData.defender = gangData.defender + 1
						gangData.defenderalive = gangData.defenderalive + 1
						sendMSGForFaction ( getPlayerName ( player ) .. " macht bei der Verteidigung mit ("..gangData.defender.." von "..alloweddefender..")!", gangData.attackerfrac, 255, 20, 20 )
						sendMSGForFaction ( getPlayerName ( player ) .. " macht bei der Verteidigung mit ("..gangData.defender.." von "..alloweddefender..")!", gangData.ownerfrac, 20, 255, 20 )
						for thePlayer, tables in pairs ( playerData ) do
							local playeritem = getPlayerFromName ( thePlayer )
							if playeritem then
								triggerClientEvent ( playeritem, "defendereinerdazugekommen", playeritem )
							end
						end 
						gangwarPreparation ( player )
						triggerClientEvent ( player, "updateAnzeigeNachJoinen", player, 60*minutenzumgwsieg - (getRealTime().timestamp-gangwarstartzeit), gangData.attacker, gangData.attackeralive, gangData.defender, gangData.defenderalive, gangData.attackerfrac, gangData.ownerfrac, gangPickup[validID]["pickup"] )
					else
						triggerClientEvent(player,"draw:infobox",root,"warning","Du warst bereits im Gangwar!")
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"warning","Ihr seid schon genug!")
				end	
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Du bist zu nahe am TK!")
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Du gehörst nicht zu der vert.Fraktion!")
		end
	else
		triggerClientEvent(player,"draw:infobox",root,"error","Es läuft kein Gangwar!")
	end
end


function gangwarAttack ( player )
	if gangAreaUnderAttack then
		if syncGetElementData ( player, "Faction" ) == gangData.attackerfrac then
			local x, y, z = getElementPosition ( gangPickup[validID]["pickup"] ) 
			local xp, yp, zp = getElementPosition ( player ) 
			if getDistanceBetweenPoints3D ( xp, yp, zp, x, y, z ) >= distanzzumtkfuerbeitreten then
				local allowedattacker = gangData.defender
				if angreiferkannmehrsein then
					allowedattacker = allowedattacker + 1
				end
				if ( gangData.attacker < allowedattacker ) or allowedToJoin[player] then
					local pname = getPlayerName ( player )
					if not playerData[pname] or ( not playerData[pname]["hatDMGbekommen"] and not playerData[pname]["imGW"] ) or allowedToJoin[player] then
						allowedToJoin[player] = nil
						gangData.attacker = gangData.attacker + 1
						gangData.attackeralive = gangData.attackeralive + 1
						sendMSGForFaction ( getPlayerName ( player ) .. " macht beim Angriff mit ("..gangData.attacker.." von "..allowedattacker..")!", gangData.attackerfrac, 20, 255, 20 )
						sendMSGForFaction ( getPlayerName ( player ) .. " macht beim Angriff mit ("..gangData.attacker.." von "..allowedattacker..")!", gangData.ownerfrac, 255, 20, 20 )
						for thePlayer, tables in pairs ( playerData ) do
							local playeritem = getPlayerFromName ( thePlayer )
							if playeritem then
								triggerClientEvent ( playeritem, "attackereinerdazugekommen", playeritem )
							end
						end
						gangwarPreparation ( player )
						triggerClientEvent ( player, "updateAnzeigeNachJoinen", player, 60*minutenzumgwsieg - (getRealTime().timestamp-gangwarstartzeit), gangData.attacker, gangData.attackeralive, gangData.defender, gangData.defenderalive, gangData.attackerfrac, gangData.ownerfrac, gangPickup[validID]["pickup"] )
					else
						triggerClientEvent(player,"draw:infobox",root,"error","Du warst bereits im Gangwar!")
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"warning","Ihr seid schon genug!")
				end
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Du bist zu nahe am TK!")
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Du gehörst nicht zu der vert.Fraktion!")
		end
	else
		triggerClientEvent(player,"draw:infobox",root,"error","Es läuft kein Gangwar!")
	end
end


function disableBlockedCMD ( cmd )
	if getElementDimension ( source ) == diegangwardimension then
   	 	if blocked_cmds[cmd] then
    	    cancelEvent()
    	end
	else
		removeEventHandler ( "onPlayerCommand", source, disableBlockedCMD )
    end
end


function getOwnerByColShape ( colshape )
	for index, tables in pairs ( gangPickup ) do
		if colshape == tables["colshape"] then
			return tables["besitzer"]
		end
	end
	return false
end


function getIDByPickup ( pickup )
	for i, v in pairs ( gangPickup ) do 
		if v["pickup"] == pickup then
			return i
		end
	end
	return false
end

function emptyEverythingForNewGW ()
	setRadarAreaFlashing ( gangArea[validID], false )
	gangAreaUnderAttack, gangAreaUnderPreparation = false, false
	if gangData.clonepickup and isElement ( gangData.clonepickup ) then
		destroyElement ( gangData.clonepickup )
		destroyElement ( gangData.clonearea )
	end
	for i, array in pairs ( teamBlips ) do
		for _, blip in pairs ( array ) do
			if isElement ( blip ) then
				destroyElement ( blip )
			end
		end
	end
	teamBlips = { [3] = {}, [4] = {}, [5] = {} }
	gangData = { attacker = 0, defender = 0, attackeralive = 0, defenderalive = 0, 
				 attackerfrac, ownerfrac, clonepickup, clonearea, pickup }	
	for timervar, timer in pairs ( gangTimer ) do 
		if isTimer ( timer ) then
			killTimer ( timer )
		end
	end
	gangTimer = { victory, eroberung, start } 	
	for index, vehicle in pairs ( gangVehicles ) do
		setElementDimension ( vehicle, 0 )
		setVehicleLocked ( vehicle, false )
		setElementFrozen ( vehicle, false )
		setVehicleDamageProof ( vehicle, false )
	end
	for vehicle, _ in pairs ( tkfahrzeugtabelle ) do
		destroyElement ( vehicle )
	end
	erledigteStatistik, allowedToJoin, gangVehicles, tkfahrzeugtabelle, vehiclePlayerMoving = {}, {}, {}, {}, {}
	spielerSitztImFahrzeug, spielerSitztImFahrzeugSitz = {}, {}
	validID, zeitohnetk, gangwarstartzeit = 0, 0, 0
end	


function sortierePlayerDataTabelle ()
	local hilfsvariable = 1
	local hilfstabelle
	local erledigteStatistik = {}
	local theplayer = nil
	for _, _ in pairs ( playerData ) do
		for player, tables in pairs ( playerData ) do
			if not erledigteStatistik[player] then
				hilfstabelle = { ["player"] = tables["name"], ["damage"] = tables["damage"], ["kills"] = tables["kills"], ["attacker"] = tables["attacker"] }
				theplayer = player
				for player2, tables2 in pairs ( playerData ) do
					if not erledigteStatistik[player2] then
						if ( hilfstabelle["damage"] + hilfstabelle["kills"]*100 ) < ( tables2["damage"] + tables2["kills"]*100 ) then
							hilfstabelle = { ["player"] = tables2["name"], ["damage"] = tables2["damage"], ["kills"] = tables2["kills"], ["attacker"] = tables2["attacker"]  }
							theplayer = player2
						end
					end
				end
				erledigteStatistik[theplayer] = true
				sortierteStatistikTabelle[hilfsvariable] = { ["Player"] = hilfstabelle["player"], ["Damage"] = math.floor(hilfstabelle["damage"]), ["Kills"] = hilfstabelle["kills"], ["Attacker"] = hilfstabelle["attacker"] }
				hilfsvariable = hilfsvariable + 1
			end
		end
	end
	for player, tables in pairs ( playerData ) do
		local playeritem = getPlayerFromName ( player )
		if playeritem then
			triggerClientEvent ( playeritem, "stopGWAnzeige", playeritem, sortierteStatistikTabelle )
		end
	end
	sortierteStatistikTabelle = {}
end

function isVehicleOccupied(vehicle)
    assert(isElement(vehicle) and getElementType(vehicle) == "vehicle", "Bad argument @ isVehicleOccupied [expected vehicle, got " .. tostring(vehicle) .. "]")
    local _, occupant = next(getVehicleOccupants(vehicle))
    return occupant and true, occupant
end

local function getFactionByName ( name )
	if name and name ~= "" then
		local name = string.lower ( name )
		for i=1, #settings.faction.ranknames.levelnames do
			local fname = string.lower ( settings.faction.ranknames.levelnames[i] )
			if string.find ( fname, name ) then
				return i, fname 
			end
		end
	end
	return false
end


function spawnPlayerAfterGangwar ( player )
	if isElement ( player ) then
		local pname=getPlayerName(player)
		local faction=tonumber(syncGetElementData(player,"Faction"))
		if(faction~=0 and faction>=1)then
			local x,y,z,rot,int,dim=globalTables["Faction"][faction]["Spawn"][1],globalTables["Faction"][faction]["Spawn"][2],globalTables["Faction"][faction]["Spawn"][3],globalTables["Faction"][faction]["Spawn"][4],globalTables["Faction"][faction]["Spawn"][5],globalTables["Faction"][faction]["Spawn"][6]
			spawnPlayer(player,x,y,z,rot,getData("userdata","Username",pname,"SkinID"),int,dim)
		end
	end
end


function GangAreasOverview_func ( player )
	outputChatBox ( "Ganggebiete:", player, 200, 200, 0 )
	for i=1, gangCount do
		local name = gangPickup[i]["name"]
		local besitzer = gangPickup[i]["besitzer"]
		local r, g, b = 0, 150, 0
		if gangPickup[i]["blocked"] then
			r, g, b = 150, 0, 0
		end
		outputChatBox ( i..". "..name..": "..settings.faction.ranknames.levelnames[besitzer]..", ", player, r, g, b )
	end					
end


function allowAttack ( player, cmd, targetfrac )
	local eigenefrac = syncGetElementData ( player, "Faction" )
	if gangAttacks[eigenefrac] and syncGetElementData ( player, "Factionrank" ) >= minrangzumattackgeben then
		if targetfrac then
			local fraczahl = nil
			local fracname = ""
			if tonumber ( targetfrac ) ~= nil and gangAttacks[tonumber ( targetfrac )] then
				fraczahl = tonumber ( targetfrac )
				fracname = settings.faction.ranknames.levelnames[fraczahl]
			else
				fraczahl, fracname = getFactionByName ( targetfrac )
				if not fraczahl then
					triggerClientEvent(player,"draw:infobox",root,"error","Die Fraktion existiert nicht oder ist keine böse Faction")
					return false
				end
			end
			if not gangAllow[fraczahl..eigenefrac] then
				gangAllow[fraczahl..eigenefrac] = true
				if isTimer ( allowTimer[fraczahl..eigenefrac] ) then
					killTimer ( allowTimer[fraczahl..eigenefrac] )
				end
				allowTimer[fraczahl..eigenefrac] = setTimer ( function ( fraczahl, eigenefrac ) 
					gangAllow[fraczahl..eigenefrac] = nil 
					sendMSGForFaction ( "Eure Erlaubnis zum Attacken der "..settings.faction.ranknames.levelnames[eigenefrac].." ist abgelaufen.", fraczahl, 255, 0, 0 )
					sendMSGForFaction ( "Die Erlaubnis der "..settings.faction.ranknames.levelnames[fraczahl].. " euch Attacken zu können ist abgelaufen.", eigenefrac, 255, 0, 0 )
				end, 1000 * 60 * 10, 1, fraczahl, eigenefrac )
				sendMSGForFaction ( "Euch wurde die Erlaubnis zum Attacken der "..settings.faction.ranknames.levelnames[eigenefrac].." gegeben.", fraczahl, 100, 100, 0 )
				sendMSGForFaction ( getPlayerName(player).." hat der "..fracname.." die Erlaubnis zum Attacken gegeben.", eigenefrac, 100, 100, 0 )
			else
				killTimer ( allowTimer[fraczahl..eigenefrac] )
				gangAllow[fraczahl..eigenefrac] = nil
				sendMSGForFaction ( "Eure Erlaubnis zum Attacken der "..settings.faction.ranknames.levelnames[eigenefrac].." wurde zurückgezogen!", fraczahl, 100, 100, 0 )
				sendMSGForFaction ( getPlayerName(player).." hat die Erlaubnis an die "..settings.faction.ranknames.levelnames[fraczahl].." zurückgezogen!", eigenefrac, 100, 100, 0 )
			end
		end
	else
		triggerClientEvent(player,"draw:infobox",root,"error","Ab Fraktionsrang "..minrangzumattackgeben.."+!")
	end
end


function gangwarBreakFahrzeug ( player )
	local pname = getPlayerName ( player )
	if playerData[pname] and playerData[pname]["imGW"] then
		if gangAreaUnderPreparation then
			if isPedInVehicle ( player ) then
				local veh = getPedOccupiedVehicle ( player )
				setElementFrozen ( veh, not isElementFrozen ( veh ) )
				local status = "entbreakt"
				if isElementFrozen ( veh ) then
					status = "gebraket"
				end
				triggerClientEvent(player,"draw:infobox",root,"error","Fahrzeug "..status.."!")
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Du bist in keinem Fahrzeug!")
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Es läuft kein Gangwar!")
		end
	else
		triggerClientEvent(player,"draw:infobox",root,"error","Du bist nicht im Gangwar!")
	end
end

function gangwarAllowToJoinPluzBattlexChampStinkt ( player, cmd, targetpl )
	if gangAreaUnderAttack then
		if syncGetElementData ( player, "Faction" ) == gangData.attackerfrac or syncGetElementData ( player, "Faction" ) == gangData.ownerfrac then
			if syncGetElementData ( player, "Factionrank" ) >= minrangzumjoinerlaubnisgeben then
				if targetpl and findPlayerByName ( targetpl ) then
					local targetpl = findPlayerByName ( targetpl )
					if syncGetElementData ( targetpl, "Faction" ) == gangData.attackerfrac or syncGetElementData ( targetpl, "Faction" ) == gangData.ownerfrac then
						if syncGetElementData ( targetpl, "Faction" ) ~= syncGetElementData ( player, "Faction" ) then
							allowedToJoin[targetpl] = true
							triggerClientEvent(player,"draw:infobox",root,"success","Erlaubnis gegeben!")
							sendMSGForFaction ( getPlayerName(player).." hat "..getPlayerName(targetpl).." die Erlaubnis zum Joinen gegeben!", gangData.attackerfrac, 255, 255, 255 )
							sendMSGForFaction ( getPlayerName(player).." hat "..getPlayerName(targetpl).." die Erlaubnis zum Joinen gegeben!", gangData.ownerfrac, 255, 255, 255 )
						else
							triggerClientEvent(player,"draw:infobox",root,"error","Der Spieler muss in der gegnerischen Fraktion sein!")
						end
					else
						infobox ( player, "Die Faction des\nSpieler ist nicht\nin der Faction\ntätig!", 4500, 255, 0, 0 )
					end
				end
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Du bist nicht befugt!")
			end	
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Du bist nicht befugt!")
		end	
	else
		triggerClientEvent(player,"draw:infobox",root,"error","Es läuft kein Gangwar!")
	end	
end

function alleGangwarBefehle (player)
	outputChatBox ("/attack - Attacken", player, 255, 255, 255)
	outputChatBox ("/joinattack - Attack teilnehmen", player, 255, 255, 255)
	outputChatBox ("/defend - Verteidigung teilnehmen", player, 255, 255, 255)
	outputChatBox ("/ganggebiete - Ganggebiete anzeigen", player, 255, 255, 255)
	outputChatBox ("/allowattack - Attack erlauben", player, 255, 255, 255)
	outputChatBox ("/allowjoin - Gegner erlauben zum Gangwar zu Joinen", player, 255, 255, 255)
	outputChatBox ("/burritoback - Stellt die Burritos zurück", player, 255, 255, 255 )
	outputChatBox ("/gwbreak - Ein Fahrzeug breaken", player, 255, 255, 255)
end


addCommandHandler ( "attack", gangattack_func )
addCommandHandler ( "defend", gangwarDefend )
addCommandHandler ( "joinattack", gangwarAttack )
addCommandHandler ( "ganggebiete", GangAreasOverview_func )
addCommandHandler ( "allowattack", allowAttack )
addCommandHandler ( "gwbefehle", alleGangwarBefehle )
addCommandHandler ( "gwbreak", gangwarBreakFahrzeug )
addCommandHandler ( "allowjoin", gangwarAllowToJoinPluzBattlexChampStinkt )
addCommandHandler ( "burritoback", setBurritosBackInGangwar )
