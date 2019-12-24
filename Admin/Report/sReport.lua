--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local ReportPickup=createPickup(125.1,-187.5,2001,3,1239,1)

function openReportUI(player)
	if(isLoggedin(player))then
		if(getElementData(player,"inReport")==true)then
			triggerClientEvent(player,"open:reportUI",player)
		end
	end
end
addEventHandler("onPickupHit",ReportPickup,openReportUI)


function teleportToReporthall(player)
	if(isLoggedin(player))then
		if(getElementDimension(player)==0 and getElementInterior(player)==0)then
			if(not isPedInVehicle(player))then
				if(not isPedDead(player))then
					if(getElementData(player,"inReport")==false)then
						local x,y,z=getElementPosition(player)
						setElementData(player,"old_position_x",x)
						setElementData(player,"old_position_y",y)
						setElementData(player,"old_position_z",z)
						if(getAdminLevel(player)>=1)then
							setElementData(player,"inReport",true)
							setElementPosition(player,129,-187.3,2001.4)
							sendMSGForAdmins("[ADMIN]: "..getPlayerName(player).." hat die Reporthalle betreten!",0,120,255)
							addEventHandler("onPlayerWeaponSwitch",player,dontHoldWeapon)
						else
							setElementData(player,"inReport",true)
							setElementPosition(player,121,-187.3,2001.4)
							sendMSGForAdmins("[ADMIN]: "..getPlayerName(player).." hat die Reporthalle betreten!",0,120,255)
							addEventHandler("onPlayerWeaponSwitch",player,dontHoldWeapon)
						end
					else
						triggerClientEvent(player,"draw:infobox",root,"error","Du bist bereits in der Reporthalle!")
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","Du kannst die Reporthalle nicht\nbetreten, da du Tot bist!")
				end
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Du kannst die Reporthalle nicht\nbetreten, da du in einem Fahrzeug bist!")
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Du kannst die Reporthalle nicht\nbetreten, da du in einem Interior bist!")
		end
	end
end
addCommandHandler("report",teleportToReporthall)
addCommandHandler("support",teleportToReporthall)


function ReporthallNeedhelp(player)
	if(isLoggedin(player))then
		if(not isPedDead(player))then
			for _,v in pairs(getElementsByType("player"))do
				if(isLoggedin(v))then
					if(getAdminLevel(v)>=1)then
						if(getElementData(v,"inReport")==false)then
							triggerClientEvent(v,"playSound_mp3",root,"Support","mp3",false)
						end
					end
				end
			end
			triggerClientEvent(player,"draw:infobox",root,"info","Alle Teammitglieder, welche\nonline sind wurden benachrichtig!")
			sendMSGForAdmins("[ADMIN]: "..getPlayerName(player).." benötigt Hilfe! Tippe /report, um zu ihm zu gelangen!",0,120,255)
		end
	end
end
addEvent("reporthalle:hilfe",true)
addEventHandler("reporthalle:hilfe",root,ReporthallNeedhelp)

function ReporthallLeave(player)
	if(isLoggedin(player))then
		if(not isPedDead(player))then
			if(getElementData(player,"inReport")==true)then
				local x,y,z=getElementData(player,"old_position_x"),getElementData(player,"old_position_y"),getElementData(player,"old_position_z")
				if(x and y and z)then
					setElementData(player,"inReport",false)
					setElementPosition(player,x,y,z)
					sendMSGForAdmins("[ADMIN]: "..getPlayerName(player).." hat die Reporthalle verlassen!",0,120,255)
					removeEventHandler("onPlayerWeaponSwitch",player,dontHoldWeapon)
				end
			end
		end
	end
end
addEvent("reporthalle:leave",true)
addEventHandler("reporthalle:leave",root,ReporthallLeave)
addCommandHandler("leavereport",ReporthallLeave)