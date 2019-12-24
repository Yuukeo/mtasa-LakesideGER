--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

--//Duty system
DutyLSPD=createPickup(257,70.0,1003.6,3,1275,50)
setElementInterior(DutyLSPD,6)
setElementDimension(DutyLSPD,20)

LSPDstellen=createPickup(249.4,67.5,1003.6,3,1239,50)
setElementInterior(LSPDstellen,6)
setElementDimension(LSPDstellen,20)

function openLspdDutyUI(player)
	if(isLoggedin(player))then
		if(isLSPD(player))then
			triggerClientEvent(player,"open:dutyUI",player)
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Du bist kein Polizist!")
		end
	end
end
addEventHandler("onPickupHit",DutyLSPD,openLspdDutyUI)

function openStellenUI(player)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"Wanteds"))>=1)then
			triggerClientEvent(player,"open:stellenUI",player)
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Hier kannst du dich stellen, wenn du Wanteds hast.")
		end
	end
end
addEventHandler("onPickupHit",LSPDstellen,openStellenUI)

addEvent("func:stellen",true)
addEventHandler("func:stellen",root,function()
	if(settings.faction.ranknames[1].stellen==true)then
		if(tonumber(syncGetElementData(client,"Wanteds"))>=1)then
			syncSetElementData(client,"Jailtime",tonumber(syncGetElementData(client,"Wanteds"))*2)
			jailCheck(client)
			syncSetElementData(client,"Wanteds",0)
			triggerClientEvent(client,"draw:infobox",root,"success","Du hast dich erfolgreich gestellt!")
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","Das Stellen ist derzeit nicht möglich!")
	end
end)
function stellenActivateDeaktivate(player)
	if(isSTATE(player)and syncGetElementData(player,"CopDuty")==true)then
		if(settings.faction.ranknames[1].stellen==true)then
			settings.faction.ranknames[1].stellen=false
			
			sendMSGForFaction("#008cff[DEPARTMENT] #c80000Das Stellen wurde von "..getPlayerName(player).." deaktiviert!",1,200,200,0)
			sendMSGForFaction("#008cff[DEPARTMENT] #c80000Das Stellen wurde von "..getPlayerName(player).." deaktiviert!",2,200,200,0)
			
			stellenTimer=setTimer(function()
				settings.faction.ranknames[1].stellen=true
				outputChatBox("INFO: Man kann sich nun wieder stellen!",root,0,200,0)
			end,10*1000*60,1)
		elseif(settings.faction.ranknames[1].stellen==false)then
			settings.faction.ranknames[1].stellen=true
			
			sendMSGForFaction("#008cff[DEPARTMENT] #00c800Das Stellen wurde von "..getPlayerName(player).." aktiviert!",1,200,200,0)
			sendMSGForFaction("#008cff[DEPARTMENT] #00c800Das Stellen wurde von "..getPlayerName(player).." aktiviert!",2,200,200,0)
			
			if(isTimer(stellenTimer))then
				stellenTimer:destroy()
			end
		end
	end
end
addCommandHandler("stellen",stellenActivateDeaktivate)

function goOnOffDuty(typ)
	if(isLoggedin(client))then
		if(typ=="Onduty")then
			if(isLSPD(client))then
				if(syncGetElementData(client,"CopDuty")==false)then
					syncSetElementData(client,"CopDuty",true)
					syncSetElementData(client,"Hunger",100)
					setElementHealth(client,100)
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast den Dienst betreten!")
					if(syncGetElementData(client,"Gender")=="Male")then
						setElementModel(client,280)
					elseif(syncGetElementData(client,"Gender")=="Female")then
						setElementModel(client,263)
					end
					syncSetElementData(client,"Barrikade",0)
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du bist bereits im Dienst!")
				end
			end
		elseif(typ=="Offduty")then
			if(syncGetElementData(client,"CopDuty")==true)then
				setElementModel(client,syncGetElementData(client,"SkinID"))
				takeAllWeapons(client)
				syncSetElementData(client,"Barrikade",0)
				syncSetElementData(client,"CopDuty",false)
				triggerClientEvent(client,"draw:infobox",root,"success","Du hast den Dienst verlassen!")
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du bist nicht im Dienst!")
			end
		end
	end
end
addEvent("go:onoffduty",true)
addEventHandler("go:onoffduty",root,goOnOffDuty)

--//Jail functions
function jailCheck(player)
	if(tonumber(syncGetElementData(player,"Jailtime"))>=1)then
		if(isPedInVehicle(player))then
			removePedFromVehicle(player)
		end
		local rdm=math.random(1,#globalTables["Faction"][1]["Jailspawns"])
		local x,y,z,rot=globalTables["Faction"][1]["Jailspawns"][rdm][1],globalTables["Faction"][1]["Jailspawns"][rdm][2],globalTables["Faction"][1]["Jailspawns"][rdm][3],globalTables["Faction"][1]["Jailspawns"][rdm][4]
		setElementPosition(player,x,y,z)
		setPedRotation(player,rot)
		setElementInterior(player,0)
		setElementDimension(player,0)
		takeAllWeapons(player)
		toggleAllControls(player,true)
		if(syncGetElementData(player,"CopDuty")==true)then
			syncSetElementData(player,"CopDuty",false)
		end
		if(getElementData(player,"tied")==true)then
			setElementData(player,"tied",false)
		end
		setElementModel(player,tonumber(syncGetElementData(player,"SkinID")))
		setElementData(player,"seatbelt",false)
	end
end
function freePlayerJail(player)
	fadeElementInterior(player,globalTables["Faction"][1]["Jailoutspawn"][1],globalTables["Faction"][1]["Jailoutspawn"][2],globalTables["Faction"][1]["Jailoutspawn"][3],globalTables["Faction"][1]["Jailoutspawn"][4],0,0,true)
	syncSetElementData(player,"Jailtime",0)
end

addEvent("tazer:target",true)
addEventHandler("tazer:target",root,function()
	if(isTimer(TazerTimer[client]))then
		killTimer(TazerTimer[client])
	end
	toggleAllControls(client,false,true,false)
	setPedAnimation(source,"CRACK","crckdeth2")
	TazerTimer[client]=setTimer(function(client)
		if(isElement(client))then
			setPedAnimation(client)
			toggleAllControls(client,true,true,false)
		end
	end,25000,1,client)
end)

local saveDeagleAmmoTable={}
function changeTazerToDeagle_changeDeagleToTazer(player)
	if(isSTATE(player)and syncGetElementData(player,"CopDuty")==true)then
		if(getElementData(player,"tazer")==false)then
			if(getPedWeapon(player)==24)then
				saveDeagleAmmoTable[player]=getPedTotalAmmo(player)
				takeWeapon(player,24)
				giveWeapon(player,23,999,true)
				triggerClientEvent(player,"draw:infobox",root,"info","Du hast deinen Tazer rausgeholt.")
				setElementData(player,"tazer",true)
			end
		else
			if(getPedWeapon(player)==23)then
				takeWeapon(player,23)
				giveWeapon(player,24,saveDeagleAmmoTable[player],true)
				triggerClientEvent(player,"draw:infobox",root,"info","Du hast deinen Tazer weggesteckt.")
				setElementData(player,"tazer",false)
			end
		end
	end
end

addCommandHandler("bail",function(player,cmd)
	if(isLoggedin(player))then
		if(isElement(player)and isLoggedin(player))then
			if(tonumber(syncGetElementData(player,"Jailtime"))>=1)then
				if(tonumber(syncGetElementData(player,"Jailtime"))<=10)then
					local bailcosts=tonumber(syncGetElementData(player,"Jailtime"))*250
					if(tonumber(syncGetElementData(player,"Bankmoney"))>=bailcosts)then
						syncSetElementData(player,"Bankmoney",tonumber(syncGetElementData(player,"Bankmoney"))-bailcosts)
						syncSetElementData(player,"Jailtime",0)
						freePlayerJail(player)
					else
						triggerClientEvent(player,"draw:infobox",root,"error","Du hast nicht genug Bankgeld! ($"..bailcosts..")")
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"info","Eine Kaution kann erst unter 10 Minuten\neingelöst werden & kostet $250 pro Minute.")
				end
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"warning","Der Spieler ist offline!")
		end
	end
end)

addEvent("look:illiegalitems",true)
addEventHandler("look:illiegalitems",root,function()
	if(isSTATE(client)and syncGetElementData(client,"CopDuty")==true)then
		local target=getPlayerFromName(getElementData(client,"set:clickedplayer"))
		if(isElement(target)and isLoggedin(target))then
			local x,y,z=getElementPosition(target)
			if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(client))<=5)then
				local Weed=syncGetElementData(target,"Weed")
				local Mats=syncGetElementData(target,"Mats")
				local Kokain=syncGetElementData(target,"Kokain")
				triggerClientEvent(client,"draw:infobox",root,"info","Du hast "..getPlayerName(target).." durchsucht!")
				triggerClientEvent(target,"draw:infobox",root,"info",getPlayerName(client).." hat dich durchsucht!")
				outputChatBox("Illegales von: "..getPlayerName(target).."",client,255,255,255)
				if(Weed>=1 or Mats>=1 or Kokain>=1)then
					outputChatBox("Weed: "..Weed.."",client,255,255,255)
					outputChatBox("Mats: "..Mats.."",client,255,255,255)
					outputChatBox("Kokain: "..Kokain.."",client,255,255,255)
				else
					outputChatBox("Nichts.",client,255,255,255)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Der Spieler ist zu weit entfernt!")
			end
		end
	end
end)

addEvent("take:illiegalitems",true)
addEventHandler("take:illiegalitems",root,function()
	if(isSTATE(client)and syncGetElementData(client,"CopDuty")==true)then
		local target=getPlayerFromName(getElementData(client,"set:clickedplayer"))
		if(isElement(target)and isLoggedin(target))then
			local x,y,z=getElementPosition(target)
			if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(client))<=5)then
				triggerClientEvent(client,"draw:infobox",root,"info","Du hast "..getPlayerName(target).." seine illegalen Gegenstände abgenommen!")
				triggerClientEvent(target,"draw:infobox",root,"info",getPlayerName(client).." hat deine illegalen Gegenstände abgenommen!")
				syncSetElementData(target,"Weed",0)
				syncSetElementData(target,"Mats",0)
				syncSetElementData(target,"Kokain",0)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Der Spieler is zu weit entfernt!")
			end
		end
	end
end)
function takeIllegal(player,cmd,kplayer)
	if(isSTATE(player)and syncGetElementData(player,"CopDuty")==true)then
		local target=getPlayerFromName(kplayer)
		if(isElement(target)and isLoggedin(target))then
			local x,y,z=getElementPosition(target)
			if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(player))<=5)then
				triggerClientEvent(player,"draw:infobox",root,"info","Du hast "..getPlayerName(target).." seine illegalen Gegenstände abgenommen!")
				triggerClientEvent(target,"draw:infobox",root,"info",getPlayerName(player).." hat deine illegalen Gegenstände abgenommen!")
				syncSetElementData(target,"Weed",0)
				syncSetElementData(target,"Mats",0)
				syncSetElementData(target,"Kokain",0)
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Der Spieler is zu weit entfernt!")
			end
		end
	end
end
addCommandHandler("takeillegal",takeIllegal)

addEvent("take:weapons",true)
addEventHandler("take:weapons",root,function()
	if(isSTATE(client)and syncGetElementData(client,"CopDuty")==true)then
		local target=getPlayerFromName(getElementData(client,"set:clickedplayer"))
		if(isElement(target)and isLoggedin(target))then
			local x,y,z=getElementPosition(target)
			if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(client))<=5)then
				triggerClientEvent(client,"draw:infobox",root,"info","Du hast "..getPlayerName(target).." seine Waffen abgenommen!")
				triggerClientEvent(target,"draw:infobox",root,"info",getPlayerName(client).." hat deine Waffen abgenommen!")
				takeAllWeapons(target)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Der Spieler is zu weit entfernt!")
			end
		end
	end
end)
function takeWeapons(player,cmd,kplayer)
	if(isSTATE(player)and syncGetElementData(player,"CopDuty")==true)then
		local target=getPlayerFromName(kplayer)
		if(isElement(target)and isLoggedin(target))then
			local x,y,z=getElementPosition(target)
			if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(player))<=5)then
				triggerClientEvent(player,"draw:infobox",root,"info","Du hast "..getPlayerName(target).." seine Waffen abgenommen!")
				triggerClientEvent(target,"draw:infobox",root,"info",getPlayerName(player).." hat deine Waffen abgenommen!")
				takeAllWeapons(target)
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Der Spieler is zu weit entfernt!")
			end
		end
	end
end
addCommandHandler("takeguns",takeWeapons)
addCommandHandler("takeweapons",takeWeapons)

function unrestPlayer(player,cmd,targetplayer)
	if(isLSPD(player)and tonumber(syncGetElementData(player,"Factionrank"))>=1 or isFBI(player)and syncGetElementData(player,"Factionrank")>=1 or tonumber(syncGetElementData(player,"AdminLvL"))>=2)then
		if(syncGetElementData(player,"CopDuty")==true or tonumber(syncGetElementData(player,"AdminLvL"))>=2)then
			if(targetplayer)then
				local target=getPlayerFromName(targetplayer)
				if(target)then
					if(tonumber(syncGetElementData(target,"Jailtime"))>=1)then
						fadeElementInterior(target,globalTables["Faction"][1]["Jailoutspawn"][1],globalTables["Faction"][1]["Jailoutspawn"][2],globalTables["Faction"][1]["Jailoutspawn"][3],globalTables["Faction"][1]["Jailoutspawn"][4],0,0,true)
						syncSetElementData(target,"Jailtime",0)
						if(syncGetElementData(target,"CopDuty")==true)then
							syncSetElementData(target,"CopDuty",false)
						end
						setElementModel(target,syncGetElementData(target,"SkinID"))
						
						triggerClientEvent(target,"draw:infobox",root,"info","Du wurdest aus dem Knast entlassen!")
						triggerClientEvent(player,"draw:infobox",root,"info","Du hast den Spieler "..getPlayerName(target).."\naus dem Knast entlassen!")
						sendMSGForFaction("#008cff[DEPARTMENT] #ffffff"..getPlayerName(player).." hat "..getPlayerName(target).." aus dem Knast entlassen!",1,200,200,0)
						sendMSGForFaction("#008cff[DEPARTMENT] #ffffff"..getPlayerName(player).." hat "..getPlayerName(target).." aus dem Knast entlassen!",2,200,200,0)
					end
				end
			end
		end
	end
end
addCommandHandler("ausknasten",unrestPlayer)
addCommandHandler("unrest",unrestPlayer)

function putPlayerInJail(player)
	local veh=getPedOccupiedVehicle(player)
	if(veh)then
		if(getPedOccupiedVehicleSeat(player)==0)then
			if(isSTATE(player)and syncGetElementData(player,"CopDuty")==true)then
				if(getElementData(veh,"policecar")==true)then
					for _,v in pairs(getElementsByType("player"))do
						if(isPedInVehicle(v))then
							if(getPedOccupiedVehicle(v)==getPedOccupiedVehicle(player))then
								if(tonumber(syncGetElementData(v,"Wanteds"))>=1)then
									syncSetElementData(v,"Jailtime",tonumber(syncGetElementData(v,"Wanteds"))*3)
									syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+200)
									jailCheck(v)
									syncSetElementData(v,"Wanteds",tonumber(0))
									triggerClientEvent(player,"draw:infobox",root,"info","Du hast "..getPlayerName(v).." eingeknastet!")
									outputChatBox("#ffffffDer Spieler #c80000"..getPlayerName(v).." #ffffffwurde von #00b4ff"..getPlayerName(player).." #ffffffeingesperrt!",root,200,0,0,true)
									outputChatBox("Du hast "..getPlayerName(v).." eingesperrt und erhälst $250!",player,0,200,0)
								end
							end
						end
					end
				end
			end
		end
	end
end

local LSPDjailPICK=createCmarker(1799.7,-1586.2,13.5,0,0,":"..settings.general.scriptname.."/Files/Images/cMarker/Jail.png",nil,2,putPlayerInJail)



addEvent("buy:staatweapons",true)
addEventHandler("buy:staatweapons",root,function(weapon,ammu,amount)
	if(isSTATE(client)and syncGetElementData(client,"CopDuty")==true)then
		if(weapon=="colt45")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=0)then
				if(getPedWeapon(client)~=22)then
					giveWeapon(client,22,1,true)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht den erforderlichen Rang!")
			end
		elseif(weapon=="deagle")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=1)then
				if(getPedWeapon(client)~=24)then
					giveWeapon(client,24,1,true)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht den erforderlichen Rang! (R1+)")
			end
		elseif(weapon=="mp5")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=1)then
				if(getPedWeapon(client)~=29)then
					giveWeapon(client,29,1,true)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht den erforderlichen Rang! (R1+)")
			end
		elseif(weapon=="ak")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=2)then
				if(getPedWeapon(client)~=30)then
					giveWeapon(client,30,1,true)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht den erforderlichen Rang! (R2+)")
			end
		elseif(weapon=="m4")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=3)then
				if(getPedWeapon(client)~=31)then
					giveWeapon(client,31,1,true)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht den erforderlichen Rang! (R3+)")
			end
		elseif(weapon=="sniper")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=4)then
				if(getPedWeapon(client)~=34)then
					giveWeapon(client,34,1,true)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht den erforderlichen Rang! (R4+)")
			end
		end
		
		
		if(ammu=="colt45")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=0)then
				if(getPedWeapon(client)==22)then
					giveWeapon(client,22,17*amount)
				else
					triggerClientEvent(client,"draw:infobox",root,"warning","Du musst zuerst die Waffe auswählen/ausrüsten!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht den erforderlichen Rang! (R0+)")
			end
		elseif(ammu=="deagle")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=1)then
				if(getPedWeapon(client)==24)then
					giveWeapon(client,24,amount*7)
				else
					triggerClientEvent(client,"draw:infobox",root,"warning","Du musst zuerst die Waffe auswählen/ausrüsten!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht den erforderlichen Rang! (R1+)")
			end
		elseif(ammu=="mp5")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=1)then
				if(getPedWeapon(client)==29)then
					giveWeapon(client,29,amount*30)
				else
					triggerClientEvent(client,"draw:infobox",root,"warning","Du musst zuerst die Waffe auswählen/ausrüsten!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht den erforderlichen Rang! (R1+)")
			end
		elseif(ammu=="ak")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=2)then
				if(getPedWeapon(client)==30)then
					giveWeapon(client,30,amount*30)
				else
					triggerClientEvent(client,"draw:infobox",root,"warning","Du musst zuerst die Waffe auswählen/ausrüsten!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht den erforderlichen Rang! (R2+)")
			end
		elseif(ammu=="m4")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=3)then
				if(getPedWeapon(client)==31)then
					giveWeapon(client,31,amount*50)
				else
					triggerClientEvent(client,"draw:infobox",root,"warning","Du musst zuerst die Waffe auswählen/ausrüsten!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht den erforderlichen Rang! (R3+)")
			end
		elseif(ammu=="sniper")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=3)then
				if(getPedWeapon(client)==34)then
					giveWeapon(client,34,amount*1)
				else
					triggerClientEvent(client,"draw:infobox",root,"warning","Du musst zuerst die Waffe auswählen/ausrüsten!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht den erforderlichen Rang! (R4+)")
			end
		elseif(ammu=="armor")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=0)then
				if(tonumber(syncGetElementData(client,"Money"))>=100)then
					syncSetElementData(client,"Weste",tonumber(syncGetElementData(client,"Weste"))+1)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-100)
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir erfolgreich Weste x1 gekauft!")
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($100)")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht den erforderlichen Rang! (R0+)")
			end
		elseif(ammu=="barricade")then
			if(tonumber(syncGetElementData(client,"Factionrank"))>=1)then
				if(tonumber(syncGetElementData(client,"Barrikade"))<10)then
					syncSetElementData(client,"Barrikade",10)
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast dir erfolgreich Barrikaden geholt!")
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht den erforderlichen Rang! (R1+)")
				end
			end
		end
	end
end)

function tiecuff(player,cmd,kplayer)
	local target=getPlayerFromName(kplayer)
	if(target)then
		if(isSTATE(player)or isEVIL(player))then
			if(isElement(target))then
				if(target~=player)then
					local x1,y1,z1=getElementPosition(player)
					local x2,y2,z2=getElementPosition(target)
					if(getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2)<=5)then
						if(getElementData(target,"tied")==false)then
							setElementData(target,"tied",true)
							toggleAllControls(target,false,true,false) 
							outputChatBox("Du hast "..getPlayerName(target).." gefesselt.",player,0,200,0)
							outputChatBox("Du wurdest von "..getPlayerName(player).." gefesselt.",target,200,0,0)
						elseif(getElementData(target,"tied")==true)then
							setElementData(target,"tied",false)
							toggleAllControls(target,true)
							outputChatBox("Du hast "..getPlayerName(target).." entfesselt.",player,0,200,0)
							outputChatBox("Du wurdest von "..getPlayerName(player).." entfesselt.",target,0,200,0)
						end
					end
				end
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Der Spieler ist offline!")
			end
		end
	end
end
addCommandHandler("cuff",tiecuff)
addCommandHandler("tie",tiecuff)

function setNote(player,cmd,kplayer,note)
	if(isLSPD(player)and syncGetElementData(player,"Factionrank")>=4)then
		local target=getPlayerFromName(kplayer)
		local note=tonumber(note)
		if(isElement(target))then
			if(note>=0 and note<=100)then
				syncSetElementData(target,"Note",note)
				triggerClientEvent(player,"draw:infobox",root,"success","Du hast die Note von "..getPlayerName(target).." auf "..note.."% gesetzt!")
				triggerClientEvent(target,"draw:infobox",root,"success","Deine Note wurde von "..getPlayerName(player).." auf "..note.."% gesetzt!")
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Der Spieler ist offline!")
		end
	end
end
addCommandHandler("setpa",setNote)
addCommandHandler("setnote",setNote)





--//Radarfalle
local ticketTax=10
local allowExit=false
local rangeOfRadar=20
local speedoColShapes={}
local playerSpeedoCol={}
local speedoVehicles={}

local function stopFromExit(player,seat)
	if(allowExit==false and seat==0)then
		cancelEvent()
		triggerClientEvent(player,"draw:infobox",root,"error","Du darfst das\nFahrzeug dabei\nnicht verlassen!")
	end
end
local function stopFromEnter(player,seat)
	if(allowExit==false and seat==0)then
		cancelEvent()
	end
end

local function explodeRadar_Func()
	removeEventHandler("onVehicleStartExit",source,stopFromExit)
	removeEventHandler("onVehicleStartEnter",source,stopFromEnter)
	removeEventHandler("onVehicleRespawn",source,explodeRadar_Func)
	removeEventHandler("onVehicleExplode",source,explodeRadar_Func)
	for i,v in pairs(speedoVehicles)do
		if(v==source)then
			speedoVehicles[i]=nil
		end
	end
end

local function playerDisconnectRadar_Func()
	local vehicle=speedoVehicles[source]
	setElementFrozen(vehicle,false)
	removeEventHandler("onVehicleStartExit",vehicle,stopFromExit) 
	removeEventHandler("onVehicleStartEnter",vehicle,stopFromEnter)
	removeEventHandler("onVehicleRespawn",vehicle,explodeRadar_Func)
	removeEventHandler("onVehicleExplode",vehicle,explodeRadar_Func)
	playerSpeedoCol[speedoColShapes[source]]=nil
	destroyElement(speedoColShapes[source])
	speedoColShapes[source]=nil
	speedoVehicles[source]=nil
end

local function playerDeadRadar_Func()
	local vehicle=speedoVehicles[source]
	setElementFrozen(vehicle, false)
	removeEventHandler("onVehicleStartExit",vehicle,stopFromExit)
	removeEventHandler("onVehicleStartEnter",vehicle,stopFromEnter)
	removeEventHandler("onVehicleRespawn",vehicle,explodeRadar_Func)
	removeEventHandler("onVehicleExplode",vehicle,explodeRadar_Func)
	playerSpeedoCol[speedoColShapes[source]]=nil
	destroyElement(speedoColShapes[source])
	speedoColShapes[source]=nil
	speedoVehicles[source]=nil
	removeEventHandler("onPlayerQuit",source,playerDisconnectRadar_Func)
	removeEventHandler("onPlayerWasted",source,playerDeadRadar_Func)
	triggerClientEvent(source,"draw:infobox",root,"info","Radarfalle deaktiviert!")
end

local function deactivateSpeedCamera(player)
	if(isPedInVehicle(player))then
		local theVehicle=getPedOccupiedVehicle(player)
		setElementFrozen(theVehicle,false)
		playerSpeedoCol[speedoColShapes[player]]=nil
		destroyElement(speedoColShapes[player])
		speedoColShapes[player]=nil
		speedoVehicles[player]=nil
		playSoundFrontEnd(player,101)
		triggerClientEvent(player,"draw:infobox",root,"info","Radarfalle deaktiviert!")
		removeEventHandler("onPlayerQuit", player,playerDisconnectRadar_Func)
		removeEventHandler("onPlayerWasted", player,playerDeadRadar_Func)
		removeEventHandler("onVehicleStartExit",theVehicle,stopFromExit) 
		removeEventHandler("onVehicleStartEnter",theVehicle,stopFromEnter)
		removeEventHandler("onVehicleRespawn",theVehicle,explodeRadar_Func)
		removeEventHandler("onVehicleExplode",theVehicle,explodeRadar_Func)
	end
end

local function ticketTheSpeedoman(theVehicle)
	if(getElementType(theVehicle)=="vehicle")then
		local id=getElementModel(theVehicle)
		if id~=523 and id~=598 and id~=596 and id~=597 and id~=599 and id~=416 and id~=490 and id~=427 and id~=407 and id~=544 and id~=470 and id~=433 and id~=601 and id~=428 and id~=432 then
			local speedx,speedy,speedz=getElementVelocity(theVehicle)
			local actualspeed=(speedx^2+speedy^2+speedz^2)^(0.5) 
			local kmh=math.ceil(actualspeed*180)
			if(120<kmh)then
				local driver=getVehicleOccupant(theVehicle)
				if(driver and getElementType(driver)=="player" and not syncGetElementData(driver,"CopDuty")==true)then
					local moneydriver=tonumber(syncGetElementData(driver,"Money"))
					local bankmoneydriver=tonumber(syncGetElementData(driver,"Bankmoney"))
					local price=(ticketTax*(kmh-120))
					if(moneydriver>=price)then
						syncSetElementData(driver,"Money",moneydriver-price)
						outputChatBox("Du bist "..(kmh-120).." km/h zu schnell gefahren und musst "..price.."$ bezahlen.", driver,200,0,0)	
						fadeCamera(driver,false,0.2,255,255,255)
						setTimer(fadeCamera,500,1,driver,true,2)
					elseif(moneydriver+bankmoneydriver>=price)then
						syncSetElementData(driver,"Money",0)
						syncSetElementData(driver,"Bankmoney",bankmoneydriver-(price-moneydriver))
						outputChatBox("Du bist "..(kmh-120).." km/h zu schnell gefahren und musst "..price.."$ bezahlen.", driver, 200, 0, 0 )	
						fadeCamera(driver,false,0.2,255,255,255)
						setTimer(fadeCamera,500,1,driver,true,2)
					else
						syncSetElementData(driver,"Money",0)
						syncSetElementData(driver,"Bankmoney",0)
						outputChatBox("Du bist "..(kmh-120).." km/h zu schnell gefahren und bist nun pleite.", driver, 200, 0, 0 )
						fadeCamera(driver,false,0.1,255,255,255)
						setTimer(fadeCamera,500,1,driver,true,2)
						price=bankmoney+moneydriver
					end
					
					local ticketer=playerSpeedoCol[source]
					syncSetElementData(ticketer,"Money",syncGetElementData(ticketer,"Money")+price)
					outputChatBox("Du hast "..getPlayerName(driver).." mit "..kmh.." km/h erwischt und kriegst "..price.."$ dafür.",ticketer,0,200,0)
					playSoundFrontEnd(ticketer,101)
				end
			end
		end
	end
end


local function activateSpeedCamera(player)	
	if(isLSPD(player))then
		if(syncGetElementData(player,"CopDuty")==true)then
			if(not speedoColShapes[player])then
				local seat=getPedOccupiedVehicleSeat(player)
				if(seat==0)then
					local veh=getPedOccupiedVehicle(player)
					if(veh)then 
						setElementFrozen(veh,true)
						local x,y,z=getElementPosition(veh)
						speedoColShapes[player]=createColSphere(x,y,z,rangeOfRadar)
						playerSpeedoCol[speedoColShapes[player]]=player
						addEventHandler("onColShapeHit",speedoColShapes[player],ticketTheSpeedoman)
						addEventHandler("onPlayerQuit",player,playerDisconnectRadar_Func)
						addEventHandler("onPlayerWasted",player,playerDeadRadar_Func)
						addEventHandler("onVehicleStartExit",veh,stopFromExit) 
						addEventHandler("onVehicleStartEnter",veh,stopFromEnter)
						addEventHandler("onVehicleRespawn", veh,explodeRadar_Func)
						addEventHandler("onVehicleExplode",veh,explodeRadar_Func)
						speedoVehicles[player]=veh
						triggerClientEvent(player,"draw:infobox",root,"error","Radarfalle aktiviert!")
						playSoundFrontEnd(player,101)
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","Radarfalle ist nur als Fahrer möglich!")
				end
			else
				deactivateSpeedCamera ( player )
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Du bist nicht im Dienst!")
		end
	end
end
addCommandHandler("radarfalle",activateSpeedCamera)









setWeaponProperty(23,"pro", "damage", 1)
setWeaponProperty(23,"std", "damage", 1)
setWeaponProperty(23,"poor", "damage", 1)
setWeaponProperty(23,"pro", "maximum_clip_ammo", 1)
setWeaponProperty(23,"std", "maximum_clip_ammo", 1)
setWeaponProperty(23,"poor", "maximum_clip_ammo", 1)
setWeaponProperty(23,"pro", "weapon_range", 35/3)
setWeaponProperty(23,"std", "weapon_range", 35/3)
setWeaponProperty(23,"poor", "weapon_range", 35/3)
setWeaponProperty(23,"pro", "move_speed", 2)
setWeaponProperty(23,"std", "move_speed", 2)
setWeaponProperty(23,"poor", "move_speed", 2)