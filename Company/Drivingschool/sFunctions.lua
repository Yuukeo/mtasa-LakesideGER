--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

DrivingschoolDuty=createPickup(-2033.6,-117.6,1034.9,3,1275,50)
setElementInterior(DrivingschoolDuty,3)
setElementDimension(DrivingschoolDuty,110)

DrivingschoolCall=createPickup(1364.5,-1664.8,13.7,3,1239,50)

function openDrivingschoolDutyUI(player)
	if(isLoggedin(player))then
		if(isDRIVINGSCHOOL(player))then
			triggerClientEvent(player,"open:drivingschoolUI",player)
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Du bist kein Fahrschullehrer!")
		end
	end
end
addEventHandler("onPickupHit",DrivingschoolDuty,openDrivingschoolDutyUI)

function openDrivingCallMembersUI(player)
	if(isLoggedin(player))then
		triggerClientEvent(player,"open:drivingschoolCallMembersUI",player)
	end
end
addEventHandler("onPickupHit",DrivingschoolCall,openDrivingCallMembersUI)

function goMechTowOnOffDuty(typ)
	if(isLoggedin(client))then
		if(typ=="Onduty")then
			if(isDRIVINGSCHOOL(client))then
				if(syncGetElementData(client,"DrivingschoolDuty")==false)then
					syncSetElementData(client,"DrivingschoolDuty",true)
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast den Dienst betreten!")
					if(syncGetElementData(client,"Gender")=="Male")then
						setElementModel(client,59)
					elseif(syncGetElementData(client,"Gender")=="Female")then
						setElementModel(client,150)
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du bist bereits im Dienst!")
				end
			end
		elseif(typ=="Offduty")then
			if(syncGetElementData(client,"DrivingschoolDuty")==true)then
				setElementModel(client,syncGetElementData(client,"SkinID"))
				takeAllWeapons(client)
				syncSetElementData(client,"DrivingschoolDuty",false)
				triggerClientEvent(client,"draw:infobox",root,"success","Du hast den Dienst verlassen!")
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du bist nicht im Dienst!")
			end
		end
	end
end
addEvent("go:driveonoffduty",true)
addEventHandler("go:driveonoffduty",root,goMechTowOnOffDuty)

addCommandHandler("exam",function(player,cmd,target)
	if(target)then
		local target=getPlayerFromName(target)
		local x,y,z=getElementPosition(player)
		local x1,y1,z1=getElementPosition(target)
		if(getDistanceBetweenPoints3D(x,y,z,x1,y1,z1)<=5)then
			if(isDRIVINGSCHOOL(player)and syncGetElementData(player,"DrivingschoolDuty")==true)then
				outputChatBox("Du hast "..getPlayerName(target).." eine Fahrprüfung angeboten.",player,255,255,255)
				outputChatBox(getPlayerName(player).." bietet dir an, die Fahrprüfung bei ihm zu belegen.",target,255,255,255)
				outputChatBox("Tippe: '/examaccept "..getPlayerName(player).."' - um die Prüfung zu starten!",target,255,255,255)
				setElementData(target,"infahrpruefung",true)
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Du bist nicht im Dienst!")
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Der Spieler ist zu weit entfernt!")
		end
	end
end)

addCommandHandler("examaccept",function(player,cmd,target)
	if(target)then
		local target=getPlayerFromName(target)
		local x,y,z=getElementPosition(player)
		local x1,y1,z1=getElementPosition(target)
		if(getDistanceBetweenPoints3D(x,y,z,x1,y1,z1)<=5)then
			if(getElementData(player,"infahrpruefung")==true)then
				setElementData(player,"inpruefung",true)
				outputChatBox("Du bist nun in der Fahrprüfung!",player,255,255,255)
				outputChatBox(getPlayerName(player).." hat die Fahrprüfungsanfrage angenommen.",target,255,255,255)
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Du hast keine Fahrprüfungsanfrage erhalten!")
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Der Fahrlehrer ist zu weit entfernt!")
		end
	else
		triggerClientEvent(player,"draw:infobox",root,"error","Gebe den Fahrlehrer an! (/examaccept NAME)")
	end
end)


addCommandHandler("examend",function(player,cmd,target,license)
	if(target)then
	local target=getPlayerFromName(target)
		if(isDRIVINGSCHOOL(player)and syncGetElementData(player,"DrivingschoolDuty")==true)then
			if(getElementData(target,"inpruefung")==true)then
				if(license)then
					if(license=="Car")then
						if(tonumber(syncGetElementData(target,"Money"))>=settings.company.ranknames[2].carlicensePrice)then
							syncSetElementData(target,"CarLicense",1)
							syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+settings.company.ranknames[2].carlicensePrice)
							syncSetElementData(target,"Money",tonumber(syncGetElementData(target,"Money"))-settings.company.ranknames[2].carlicensePrice)
							outputChatBox("Sie haben den Führerschein erhalten! (Kosten: "..settings.company.ranknames[2].carlicensePrice..")",target,0,200,0)
							triggerClientEvent(player,"draw:infobox",root,"success","Auto-Führerschein an "..getPlayerName(target).." gegeben!")
							
							if(getElementData(target,"infahrpruefung")==true)then
								setElementData(target,"infahrpruefung",false)
							end
							if (getElementData(target,"inpruefung")==true)then
								setElementData(target,"inpruefung",false)
							end
						else
							outputChatBox("Du hast nicht genug Bargeld! ($"..settings.company.ranknames[2].carlicensePrice..")",target,200,0,0)
							outputChatBox("Der Prüfling hat nicht genug Geld! ($"..settings.company.ranknames[2].carlicensePrice..")",player,200,0,0)
						end
					elseif(license=="Bike")then
						if(tonumber(syncGetElementData(target,"Money"))>=settings.company.ranknames[2].bikelicensePrice)then
							syncSetElementData(target,"BikeLicense",1)
							syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+settings.company.ranknames[2].bikelicensePrice)
							syncSetElementData(target,"Money",tonumber(syncGetElementData(target,"Money"))-settings.company.ranknames[2].bikelicensePrice)
							outputChatBox("Sie haben den Führerschein erhalten! (Kosten: "..settings.company.ranknames[2].bikelicensePrice..")",target,0,200,0)
							triggerClientEvent(player,"draw:infobox",root,"success","Motorrad-Führerschein an "..getPlayerName(target).." gegeben!")
							
							if(getElementData(target,"infahrpruefung")==true)then
								setElementData(target,"infahrpruefung",false)
							end
							if (getElementData(target,"inpruefung")==true)then
								setElementData(target,"inpruefung",false)
							end
						else
							outputChatBox("Du hast nicht genug Bargeld! ($"..settings.company.ranknames[2].bikelicensePrice..")",target,200,0,0)
							outputChatBox("Der Prüfling hat nicht genug Geld! ($"..settings.company.ranknames[2].bikelicensePrice..")",player,200,0,0)
						end
					end
				end
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Du bist nicht im Dienst!")
		end
	end
end)


function contactDrivingschoolMember(player)
	if(getCompanyMembersOnline(2)>=1)then
		sendMSGForCompany(""..getPlayerName(player).." benötigt einen Fahrlehrer.",2,0,200,0)
		triggerClientEvent(player,"draw:infobox",root,"success","Du hast alle Fahrlehrer benachrichtigt!")
	else
		triggerClientEvent(player,"draw:infobox",root,"error","Derzeit ist kein Fahrlehrer online!")
	end
end
addEvent("call:drivingschoolmembers",true)
addEventHandler("call:drivingschoolmembers",root,contactDrivingschoolMember)