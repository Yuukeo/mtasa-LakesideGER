--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local gunsPickup={}
local moneyPickup={}
local weedPickup={}
local matsPickup={}
gotLastHit={}

local weaponPickupIDS={
[24]=348,
[25]=349,
[28]=352,
[29]=353,
[30]=355,
[31]=356,
[33]=357,
}

local bodybarts={
[3]="Bauch",
[4]="Arsch",
[5]="Linker Arm",
[6]="Rechter Arm",
[7]="Linkes Bein",
[8]="Rechtes Bein",
[9]="Kopf",
}

function player_Wasted(ammo,attacker,weapon,bodypart)
	local x,y,z=getElementPosition(source)
	local money=syncGetElementData(source,"Money")
	local weed=tonumber(syncGetElementData(source,"Weed"))
	local mats=tonumber(syncGetElementData(source,"Mats"))
	local weapon=getPedWeapon(source)
	local ammo=getPedTotalAmmo(source)
	
	if(weaponPickupIDS[weapon])then
		if(isElement(gunsPickup[source]))then gunsPickup[source]:destroy()end
		gunsPickup[source]=createPickup(x,y,z,3,weaponPickupIDS[weapon],50)
		setElementData(gunsPickup[source],"weapon",weapon)
		setElementData(gunsPickup[source],"ammo",ammo)
		
		addEventHandler("onPickupHit",gunsPickup[source],function(player)
			if(syncGetElementData(player,"GunLicense")==1)then
				if(not player:isDead())then
					local waffe=getElementData(source,"weapon")
					local munition=getElementData(source,"ammo")
					giveWeapon(player,waffe,munition,true)
					source:destroy()
					triggerClientEvent(player,"draw:infobox",root,"info","Du hast eine Waffe aufgehoben!")
				end
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Du besitzt keinen Waffenschein!")
			end
		end)
	end
	
	if(isElement(moneyPickup[source]))then
		moneyPickup[source]:destroy()
	end
	if(isElement(weedPickup[source]))then
		weedPickup[source]:destroy()
	end
	if(isElement(matsPickup[source]))then
		matsPickup[source]:destroy()
	end
	
	if(money)then
		if(tonumber(money)>=1)then
			moneyPickup[source]=createPickup(x,y,z,3,1212,50)
			syncSetElementData(moneyPickup[source],"Money",math.abs(math.floor(money/50)))
			syncSetElementData(source,"Money",tonumber(syncGetElementData(source,"Money"))-math.abs(math.floor(money/50)))
			
			addEventHandler("onPickupHit",moneyPickup[source],function(player)
				if(not isPedDead(player))then
					local pickupMoney=tonumber(syncGetElementData(source,"Money"))
					syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+pickupMoney)
					source:destroy()
					triggerClientEvent(player,"draw:infobox",root,"money","Du hast Geld aufgehoben! ($"..pickupMoney..")")
				end
			end)
		end
	end
	
	if(weed)then
		if(tonumber(weed)>=1)then
			weedPickup[source]=createPickup(x,y,z,3,1279,50)
			syncSetElementData(weedPickup[source],"Weed",weed/4)
			syncSetElementData(source,"Weed",math.floor(syncGetElementData(source,"Weed"))-math.abs(math.floor(weed/6)))
			
			addEventHandler("onPickupHit",weedPickup[source],function(player)
				if(not isPedDead(player))then
					local pickupDrugs=tonumber(syncGetElementData(source,"Weed"))
					syncSetElementData(player,"Weed",math.floor(syncGetElementData(player,"Weed"))+pickupDrugs)
					source:destroy()
					triggerClientEvent(player,"draw:infobox",root,"money","Du hast Weed aufgehoben! (x"..pickupDrugs..")")
				end
			end)
		end
	end
	if(mats)then
		if(tonumber(mats)>=1)then
			matsPickup[source]=createPickup(x,y,z,3,1210,50)
			syncSetElementData(matsPickup[source],"Mats",mats/4)
			syncSetElementData(source,"Mats",math.floor(syncGetElementData(source,"Mats"))-math.abs(math.floor(mats/6)))
			
			addEventHandler("onPickupHit",matsPickup[source],function(player)
				if(not isPedDead(player))then
					local pickupMats=tonumber(syncGetElementData(source,"Mats"))
					syncSetElementData(player,"Mats",math.floor(syncGetElementData(player,"Mats"))+pickupMats)
					source:destroy()
					triggerClientEvent(player,"draw:infobox",root,"money","Du hast Mats aufgehoben! (x"..pickupMats..")")
				end
			end)
		end
	end
	
	
	if(attacker and attacker~=source and getElementType(attacker)=="player")then
		syncSetElementData(attacker,"Kills",tonumber(syncGetElementData(attacker,"Kills"))+1)
		if(isSTATE(attacker)and syncGetElementData(attacker,"CopDuty")==true)then
			if(tonumber(syncGetElementData(source,"Wanteds"))>=1)then
				syncSetElementData(source,"Jailtime",tonumber(syncGetElementData(source,"Wanteds"))*5)
				syncSetElementData(attacker,"Money",tonumber(syncGetElementData(attacker,"Money"))+250)
				jailCheck(source)
				syncSetElementData(source,"Wanteds",0)
				outputChatBox("#ffffffDer Spieler #c80000"..getPlayerName(source).." #ffffffwurde von #00b4ff"..getPlayerName(attacker).." #ffffffeingesperrt!",root,200,0,0,true)
				outputChatBox("Du hast "..getPlayerName(source).." eingesperrt und erhälst $250!",attacker,0,200,0)
			end
		end
	end
	
	
	if(isPedInVehicle(source))then
		removePedFromVehicle(source)
	end
	setElementDimension(source,0)
	setElementInterior(source,0)
	checkIfMedicRespawn(source)
	syncSetElementData(source,"Deaths",tonumber(syncGetElementData(source,"Deaths"))+1)
	if(tonumber(syncGetElementData(source,"AdminLvL"))>=1)then
		triggerClientEvent(source,"render.hospital",source,30)
		--syncSetElementData(source,"Hospitaltime",20)
	else
		if(getCompanyMembersOnline(3)>=1)then
			triggerClientEvent(source,"render.hospital",source,180)
		else
			triggerClientEvent(source,"render.hospital",source,80)
		end
	end
	if(syncGetElementData(source,"CopDuty")==true)then
		syncSetElementData(source,"CopDuty",false)
	end
	if(syncGetElementData(source,"RescueDuty")==true)then
		syncSetElementData(source,"RescueDuty",false)
	end
	if(syncGetElementData(source,"DrivingschoolDuty")==true)then
		syncSetElementData(source,"DrivingschoolDuty",false)
	end
	if(syncGetElementData(source,"MechTowDuty")==true)then
		syncSetElementData(source,"MechTowDuty",false)
	end
	
	if(getElementData(player,"callswith"))then
		if(getElementData(player,"callswith")~="none")then
			local caller=isElement(getElementData(player,"callswith"))and getElementData(player,"callswith")or getPlayerFromName(getElementData(player,"callswith"))
			if(caller)then
				setElementData(caller,"callswith","none")
				setElementData(caller,"call",false)
				setElementData(caller,"calls","none")
				setElementData(caller,"callswith","none")
				setElementData(caller,"calledby","none")
				outputChatBox("*Knack* - Die Leitung ist tod!",caller,200,0,0)
			else
				setElementData(player,"callswith","none")
				setElementData(player,"call",false)
				setElementData(player,"calls","none")
				setElementData(player,"callswith","none")
				setElementData(player,"calledby","none")
			end
		end
	end
	
	setElementData(source,"adminduty",false)
	setElementData(source,"tied",false)
	setElementData(source,"seatbelt",false)
	triggerClientEvent(source,"stop:seatbeltsound",source)
end
addEventHandler("onPlayerWasted",root,player_Wasted)


addEvent("damageCalcServer",true)
addEventHandler("damageCalcServer",root,function(attacker,weapon,bodypart,loss,player)
	if(attacker and weapon and bodypart and loss)then
		local x1,y1,z1=getElementPosition(attacker)
		local x2,y2,z2=getElementPosition(player)
		local dist=getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2)
		gotLastHit[player]=getTickCount()
		gotLastHit[attacker]=getTickCount()
		if(weapon==34 and bodypart==9 and dist>=20)then
			if(getElementData(player,"adminduty")==true)then
				return false
			end
			if(tonumber(syncGetElementData(player,"Jailtime"))>=1)then
				return false
			end
			outputChatBox("Du wurdest gesnipet!",player,200,0,0)
			setPedHeadless(player,true)
			killPed(player,attacker,weapon,bodypart)
			outputLog(getPlayerName(attacker).." hat "..getPlayerName(player).." mit der Sniper ein Headshot gegeben!","Damage")
			
			if(getElementData(attacker,"ImGangwar")==true and getElementData(player,"ImGangwar")==true and getElementData(player,"ImGangwarGestorben")~=true and tonumber(syncGetElementData(attacker,"Faction"))~=tonumber(syncGetElementData(player,"Faction")))then
				setElementData(attacker,"TemporaerGWDamage",getElementData(attacker,"TemporaerGWDamage")+basicDMG*multiply)
				setElementData(attacker,"GangwarDamage",getElementData(attacker,"GangwarDamage")+basicDMG*multiply)
			end
		elseif(weapon==34 and bodypart==9)then
			return
		else
			if(getElementData(player,"adminduty")==true)then
				return false
			end
			if(tonumber(syncGetElementData(player,"Jailtime"))>=1)then
				return false
			end
			
			--local basicDMG=weaponDamages[weapon][bodypart]
			local basicDMG=(weaponDamages[weapon] and weaponDamages[weapon][bodypart]or 1)	
			if(bodypart==9)then
				multiply=1.3
			else
				multiply=1
			end
			outputLog(getPlayerName(attacker).." hat "..getPlayerName(player).." mit Waffe "..weapon.." an Part "..bodybarts[bodypart].." getroffen, Schaden: "..basicDMG*multiply,"Damage")
			
			if(weaponDamages[weapon][bodypart])then
				damagePlayer(player,basicDMG*multiply,attacker,weapon)
			else
				damagePlayer(player,loss,attacker,weapon)
			end
			
			local pname=getPlayerName(attacker)
			if(gangAreaUnderAttack)then
				if(playerData[pname] and playerData[pname]["imGW"] and isElement(player)and getElementType(player)=="player" and syncGetElementData(player,"Faction")~=syncGetElementData(attacker,"Faction"))then
					playerData[pname]["damage"]=playerData[pname]["damage"]+basicDMG
					if(playerData[getPlayerName(player)])then
						playerData[getPlayerName(player)]["hatDMGbekommen"]=attacker
					end
					syncSetElementData(attacker,"GangwarDamageGemacht",(syncGetElementData(attacker,"GangwarDamageGemacht")or 0)+basicDMG)
					syncSetElementData(player,"GangwarDamageBekommen",(syncGetElementData(player,"GangwarDamageBekommen")or 0)+basicDMG)
					triggerClientEvent(attacker,"rechneDMGAn",attacker,basicDMG)
				end
			end
			
		end
		
	end
end)

addEvent("spawn:hospital",true)
addEventHandler("spawn:hospital",root,function()
	setCameraTarget(client,client)
	local pname=getPlayerName(client)
	
	--if(syncGetElementData(client,"Faction")~=3 and syncGetElementData(client,"Faction")~=4)then
		spawnPlayer(client,1179.1,-1327.4,14.2,270,syncGetElementData(client,"SkinID"),0,0)
	--end
	
	gotLastHit[client]=0
	
	setPedHeadless(client,false)
	setElementHealth(client,50)
	syncSetElementData(client,"Hunger",25)
	
	if(isElement(m_mark[pname]))then
		m_mark[pname]:destroy()
	end
	if(isElement(m_pick[pname]))then
		m_pick[pname]:destroy()
	end
	if(isElement(m_blip[pname]))then
		m_blip[pname]:destroy()
	end
end)