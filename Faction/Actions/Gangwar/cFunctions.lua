--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: Bonus                          ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent ( "startGWAnzeige", true )
addEvent ( "updateAnzeigePrepare", true )
addEvent ( "updateAnzeigeStart", true )
addEvent ( "updateAnzeigeNachJoinen", true )
addEvent ( "rechneDMGAn", true )
addEvent ( "attackereinerdazugekommen", true )
addEvent ( "defendereinerdazugekommen", true )
addEvent ( "attackereinergestorben", true )
addEvent ( "defendereinergestorben", true )
addEvent ( "attackereinerofflineohnezaehlen", true )
addEvent ( "defendereinerofflineohnezaehlen", true )
addEvent ( "stopGWAnzeige", true )
addEvent ( "stopGWAnzeigeSTOP", true )
addEvent ( "rechneKillAn", true )
addEvent ( "moveVehicleInGangwar", true )
 
 
 
-- Zu leerende Variablen --

gangwarDamage = 0 
gangwarKills = 0
gangwarlaeuft = false
local diezeit, startzeit, attackeralive, defenderalive, attacker, defender = 0, 0, 0, 0, 0, 0
local attackerR, attackerG, attackerB, defenderR, defenderG, defenderB = 0, 0, 0, 0, 0, 0
local attackerfracname = ""
local defenderfracname = ""
local thepickup, statistikTabelle = nil
local sortierteStatistikTabelle = nil
local theveh = nil
local lastvehmove = 0
local showing = false
local screenx, screeny = guiGetScreenSize()
local sxA, syA = screenx/1920, screeny/1080



--- EINSTELLBAR ---

local reichweiteZumTK = 15   -- Mindestreichweite zum TK, um drin zu sein - ACHTUNG: Serverseitig auch ändern!
local zeitinsekundenbisstatistikendet = 120   -- In wievielen Minuten die Statistik ausgeblendet werden soll



-- Funktionen --

function dxdrawGangwarAnzeige ()
	local daminute = math.floor ( ( diezeit - ( getRealTime().timestamp - startzeit ) ) / 60 )
	local dasekunde = math.floor ( ( diezeit - ( getRealTime().timestamp - startzeit ) ) % 60 )
	local distance = 0
	if thepickup and isElement ( thepickup ) then
		local xp, yp, zp = getElementPosition ( thepickup )
		local xpl, ypl, zpl = getElementPosition ( getLocalPlayer() )
		distance = math.floor (getDistanceBetweenPoints3D ( xp, yp, zp, xpl, ypl, zpl ) * 10)/10
	end
	if dasekunde < 10 then
		dasekunde = "0"..dasekunde
	end
	
	dxDrawRectangle(20*Gsx,500*Gsy,180*Gsx,60*Gsy,tocolor(attackerR,attackerG,attackerB,160),true)
	dxDrawRectangle(210*Gsx,500*Gsy,180*Gsx,60*Gsy,tocolor(defenderR,defenderG,defenderB,160),true)
	
	dxDrawRectangle(20*Gsx,445*Gsy,120*Gsx,50*Gsy,tocolor(0,0,0,160),true)
	dxDrawRectangle(145*Gsx,445*Gsy,120*Gsx,50*Gsy,tocolor(0,0,0,160),true)
	dxDrawRectangle(270*Gsx,445*Gsy,120*Gsx,50*Gsy,tocolor(0,0,0,160),true)
	
	dxDrawImage(35*Gsx,457*Gsy,25*Gsx,25*Gsy,":"..settings.general.scriptname.."/Files/Images/Gangwar/Kills.png",0,0,0,tocolor(255,255,255,255),true)
	dxDrawImage(160*Gsx,457*Gsy,25*Gsx,25*Gsy,":"..settings.general.scriptname.."/Files/Images/Gangwar/Damage.png",0,0,0,tocolor(255,255,255,255),true)
	dxDrawImage(285*Gsx,457*Gsy,25*Gsx,25*Gsy,":"..settings.general.scriptname.."/Files/Images/Gangwar/Time.png",0,0,0,tocolor(255,255,255,255),true)
	
	dxDrawText(gangwarKills,75*Gsx,457*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,255),1.60*Gsx,"default-bold","left","top",false,false,true,false,false)
	dxDrawText(math.floor(gangwarDamage),200*Gsx,457*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,255),1.60*Gsx,"default-bold","left","top",false,false,true,false,false)
	dxDrawText(daminute..":"..dasekunde,320*Gsx,457*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,255),1.60*Gsx,"default-bold","left","top",false,false,true,false,false)
	
	dxDrawText(attackerfracname,100*Gsx,505*Gsy,120*Gsx,50*Gsy,tocolor(255,255,255,255),1.2*Gsx,"default-bold","center","top",false,false,true,false,false)
	dxDrawText(attackeralive.." / "..attacker,100*Gsx,530*Gsy,120*Gsx,50*Gsy,tocolor(255,255,255,255),1.2*Gsx,"default-bold","center","top",false,false,true,false,false)
	dxDrawText(defenderfracname,475*Gsx,505*Gsy,120*Gsx,50*Gsy,tocolor(255,255,255,255),1.2*Gsx,"default-bold","center","top",false,false,true,false,false)
	dxDrawText(defenderalive.." / "..defender,475*Gsx,530*Gsy,120*Gsx,50*Gsy,tocolor(255,255,255,255),1.2*Gsx,"default-bold","center","top",false,false,true,false,false)
	dxDrawRectangle(20*Gsx,565*Gsy,370*Gsx,30*Gsy,tocolor(0,0,0,160),true)
	
	if(distance>reichweiteZumTK)then
		dxDrawText("Entfernung zum Totenkopf "..distance.."m",30*Gsx,572*Gsy,120*Gsx,50*Gsy,tocolor(255,0,0,255),1.2*Gsx,"default-bold","left","top",false,false,true,false,false)
	else
		dxDrawText("Entfernung zum Totenkopf "..distance.."m",30*Gsx,572*Gsy,120*Gsx,50*Gsy,tocolor(255,255,255,255),1.2*Gsx,"default-bold","left","top",false,false,true,false,false)
	end
	showing=true
end


function startAnzeige ( )
	gangwarlaeuft = true
	gangwarDamage = 0
	gangwarKills = 0
	addEventHandler ( "onClientRender", root, dxdrawGangwarAnzeige )	
	addEventHandler ( "onClientKey", root, deactivateInventar )
	removeEventHandler ( "onClientRender", root, startStatistik )
	addEventHandler ( "onClientPlayerWasted", localPlayer, calculateGangwarKills )
	startzeit = getRealTime().timestamp
end
addEventHandler ( "startGWAnzeige", root, startAnzeige )


function updateAnzeigePrepare_func ( zeitzumende, attackergesamt, attackerfrac, ownerfrac, pickup )
	gangwarlaeuft = true
	diezeit = zeitzumende
	attacker = attackergesamt
	attackeralive = attackergesamt
	attackerfracname = settings.faction.ranknames.levelnames[attackerfrac]
	defenderfracname = settings.faction.ranknames.levelnames[ownerfrac]
	thepickup = pickup
	attackerR = settings.faction.ranknames.color[attackerfrac][1]
	attackerG = settings.faction.ranknames.color[attackerfrac][2]
	attackerB = settings.faction.ranknames.color[attackerfrac][3]
	defenderR = settings.faction.ranknames.color[ownerfrac][1]
	defenderG = settings.faction.ranknames.color[ownerfrac][2]
	defenderB = settings.faction.ranknames.color[ownerfrac][3]
	startzeit = getRealTime().timestamp
end
addEventHandler ( "updateAnzeigePrepare", root, updateAnzeigePrepare_func )


function updateAnzeigeStart_func ( zeitzumende, attackerlebend, attackergesamt )
	gangwarlaeuft = true
	diezeit = zeitzumende
	attackeralive = attackerlebend
	attacker = attackergesamt
	startzeit = getRealTime().timestamp
end
addEventHandler ( "updateAnzeigeStart", root, updateAnzeigeStart_func )


function updateAnzeigeNachJoinen_func ( zeitzumende, attackergesamt, attackerlebend, defendergesamt, defenderlebend, attackerfrac, ownerfrac, pickup )
	gangwarlaeuft = true
	diezeit = zeitzumende
	attacker = attackergesamt
	attackeralive = attackerlebend
	defender = defendergesamt
	defenderalive = defenderlebend
	attackerfracname = settings.faction.ranknames.levelnames[attackerfrac]
	defenderfracname = settings.faction.ranknames.levelnames[ownerfrac]
	thepickup = pickup
	attackerR = settings.faction.ranknames.color[attackerfrac][1]
	attackerG = settings.faction.ranknames.color[attackerfrac][2]
	attackerB = settings.faction.ranknames.color[attackerfrac][3]
	defenderR = settings.faction.ranknames.color[ownerfrac][1]
	defenderG = settings.faction.ranknames.color[ownerfrac][2]
	defenderB = settings.faction.ranknames.color[ownerfrac][3]
	startzeit = getRealTime().timestamp
end
addEventHandler ( "updateAnzeigeNachJoinen", root, updateAnzeigeNachJoinen_func )


function attackerEinerHinzugekommen ( )
	attacker = attacker + 1
	attackeralive = attackeralive + 1
end
addEventHandler ( "attackereinerdazugekommen", root, attackerEinerHinzugekommen )


function defenderEinerHinzugekommen ( )
	defender = defender + 1
	defenderalive = defenderalive + 1
end
addEventHandler ( "defendereinerdazugekommen", root, defenderEinerHinzugekommen )


function attackerEinerTot ( )
	attackeralive = attackeralive - 1
end
addEventHandler ( "attackereinergestorben", root, attackerEinerTot )


function defenderEinerTot ( )
	defenderalive = defenderalive - 1
end
addEventHandler ( "defendereinergestorben", root, defenderEinerTot )


function attackerEinerOffVorStart ( )
	attackeralive = attackeralive - 1
	attacker = attacker - 1
end
addEventHandler ( "attackereinerofflineohnezaehlen", root, attackerEinerOffVorStart )


function defenderEinerOffVorStart ( )
	defenderalive = defenderalive - 1
	defender = defender - 1
end
addEventHandler ( "defendereinerofflineohnezaehlen", root, defenderEinerOffVorStart )


function stopAnzeige ( dmgkilltable )
	gangwarlaeuft = false
	removeEventHandler ( "onClientRender", root, dxdrawGangwarAnzeige )	
	removeEventHandler ( "onClientKey", root, deactivateInventar )
	removeEventHandler ("onClientPlayerWasted", localPlayer, calculateGangwarKills)
	diezeit, startzeit, attackeralive, defenderalive, attacker, defender = 0, 0, 0, 0, 0, 0
	attackerfracname = ""
	defenderfracname = ""
	thepickup = nil
	showing = false
	sortierteStatistikTabelle = dmgkilltable
	removeEventHandler ( "onClientRender", root, startStatistik )
	addEventHandler ( "onClientRender", root, startStatistik )
end
addEventHandler ( "stopGWAnzeige", root, stopAnzeige )


function stopAnzeigeSTOP ( )
	gangwarlaeuft = false
	removeEventHandler ( "onClientRender", root, dxdrawGangwarAnzeige )	
	removeEventHandler ( "onClientKey", root, deactivateInventar )
	diezeit, startzeit, attackeralive, defenderalive, attacker, defender = 0, 0, 0, 0, 0, 0
	attackerfracname = ""
	defenderfracname = ""
	thepickup = nil
	showing = false
end
addEventHandler ( "stopGWAnzeigeSTOP", root, stopAnzeigeSTOP )


function calculateGangwarDamage ( dmg )
	gangwarDamage = gangwarDamage + dmg
	if not showing then
		addEventHandler ( "onClientRender", root, dxdrawGangwarAnzeige )
	end
end
addEventHandler ("rechneDMGAn", root, calculateGangwarDamage)


function calculateGangwarKills ( killer )
	triggerServerEvent ( "rechneKILLAnServer", source, killer )
end


addEventHandler ( "rechneKillAn", root, function ( kills )
	gangwarKills = kills
end )


function deactivateInventar ( button, press ) 
	if ( press ) and button == "i" then
		cancelEvent()
	end
end


function startStatistik()
	local ver, ang = 0, 0
	local hoehe = 0
	for index, tables in pairs ( sortierteStatistikTabelle ) do
		if tables["Attacker"] then
			hoehe = hoehe + 1
		end
	end
	for index, tables in pairs ( sortierteStatistikTabelle ) do
    	if tables["Attacker"] then
    		-- Rechteck --
    		dxDrawRectangle(screenx-400*sxA, screeny-775*syA+46*syA*(index-ang), 180*sxA, 45*syA, tocolor(attackerR, attackerG, attackerB, 200), true)  -- ATTACKER 
   			-- Stats --
    		dxDrawText("Kill: "..tables["Kills"].." | Dmg: "..tables["Damage"], screenx-400*sxA, screeny-754*syA+46*syA*(index-ang), screenx-220, screeny-740*syA+46*syA*(index-ang),tocolor(255, 255, 255, 255), 1.2*syA, "default-bold", "center", "top", false, false, true, false, false) -- Name
			-- Name --
			dxDrawText(tables["Player"], screenx-400*sxA, screeny-770*syA+46*syA*(index-ang), screenx-220, screeny-740*syA+46*syA*(index-ang),tocolor(255, 255, 255, 255), 1.2*syA, "default-bold", "center", "top", false, false, true, false, false) -- Stats
			ver = ver + 1
		else
    		-- Rechteck --
    		dxDrawRectangle(screenx-210*sxA, screeny-775*syA+46*syA*(index-ver), 180*sxA, 45*syA, tocolor(defenderR, defenderG, defenderB, 200), true) -- DEFENDER
    		-- Stats --
			dxDrawText("Kill: "..tables["Kills"].." | Dmg: "..tables["Damage"], screenx-210*sxA, screeny-754*syA+46*syA*(index-ver), screenx-30, screeny-740*syA+46*syA*(index-ver),tocolor(255, 255, 255, 255), 1.2*syA, "default-bold", "center", "top", false, false, true, false, false) -- Name
			-- Name --
			dxDrawText(tables["Player"], screenx-210*sxA, screeny-770*syA+46*syA*(index-ver), screenx-30, screeny-740*syA+46*syA*(index-ver),tocolor(255, 255, 255, 255), 1.2*syA, "default-bold", "center", "top", false, false, true, false, false) -- Stats
			ang = ang + 1
		end
	end
	setTimer ( function () removeEventHandler ( "onClientRender", root, startStatistik ) end, 1000 * zeitinsekundenbisstatistikendet, 1 )
end


addEventHandler ( "moveVehicleInGangwar", root, function ( veh )
	theveh = veh
	lastvehmove = getTickCount()
	addEventHandler ( "onClientRender", root, showVehicleFlying )
	showCursor ( true )
	bindKey ( "mouse1", "up", triggerTheVehiclePosition ) 
	bindKey ( "mouse_wheel_up", "both", setVehicleRotationUpDown, 3 )
	bindKey ( "mouse_wheel_down", "both", setVehicleRotationUpDown, -3 )
end )


function showVehicleFlying ( )
	local _, _, worldx, worldy, worldz = getCursorPosition()
    local px, py, pz = getCameraMatrix()
	local playerx, playery, playerz = getElementPosition ( localPlayer )
	setCameraMatrix ( playerx, playery, playerz+50, playerx, playery, playerz )
    local hit, x, y, z, elementHit = processLineOfSight ( px, py, pz, worldx, worldy, worldz )
	local _, _, rz = getElementRotation ( theveh )
	if x and y and z then
		z = getGroundPosition ( x, y, z )
		setElementPosition ( theveh, x, y, z+0.6 )
	end
	setElementRotation ( theveh, 0, 0, rz )
end


function triggerTheVehiclePosition ( )
	if lastvehmove+500 <= getTickCount() then
		unbindKey ( "mouse1", "both", triggerTheVehiclePosition ) 
		unbindKey ( "mouse_wheel_up", "both", setVehicleRotationUpDown )
		unbindKey ( "mouse_wheel_down", "both", setVehicleRotationUpDown )
		removeEventHandler ( "onClientRender", root, showVehicleFlying )
		local screenx, screeny, worldx, worldy, worldz = getCursorPosition()
		local px, py, pz = getCameraMatrix()
		local hit, x, y, z, elementHit = processLineOfSight ( px, py, pz, worldx, worldy, worldz )
		z = getGroundPosition ( x, y, z )
		local _, _, rz = getElementRotation ( theveh )
		triggerServerEvent ( "triggerActualVehiclePositionForGangwar", player, theveh, x, y, z+0.9, rz )
		setCameraTarget ( localPlayer )
		theveh = nil
	end
end


function setVehicleRotationUpDown ( button, _, value )
	local _, _, rz = getElementRotation ( theveh )
	setElementRotation ( theveh, 0, 0, rz+value )
end




	
		

 