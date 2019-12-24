--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo) & Xendom       ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function callPlayer(player,number)
	if(player==client or not client)then
		if(syncGetElementData(player,"PhoneState")==1)then
			local number=tonumber(number)
			local players=getElementsByType("player")
			for i=1, #players do
				local playeritem = players[i]
				if(syncGetElementData(playeritem,"Telenr"))then
					if(syncGetElementData(playeritem,"Telenr")==number)then
						if(syncGetElementData(playeritem,"PhoneState")==1)then
							if(not getElementData(player,"call"))then
								if(not getElementData(playeritem,"call"))then
									outputChatBox("Tippe /hangup, um aufzulegen!",player,255,255,255)
									outputChatBox(getPlayerName(player).." (Nummer: "..syncGetElementData(player,"Telenr")..") ruft an, tippe /takeoff um abzunehmen!",playeritem,0,200,0)
									setElementData(player,"calls",playeritem)
									setElementData(player,"call",true)
									setElementData(playeritem,"calledby",player)
									triggerClientEvent(player,"play:phonesound",player,"rightone")
									triggerClientEvent(playeritem,"play:phonesound",player,"rightone")
									return
								else
									triggerClientEvent(player,"draw:infobox",root,"error","Besetzt...")
									triggerClientEvent(player,"play:phonesound",player,"rightone")
								end
							else
								triggerClientEvent(player,"draw:infobox",root,"error","Du telefonierst bereits!")
							end
						else
							triggerClientEvent(player,"draw:infobox",root,"error","Dein Handy des Spielers ist aus!")
							triggerClientEvent(player,"play:phonesound",player,"noconnection")
						end
						return
					end
				end
			end
			triggerClientEvent(player,"draw:infobox",root,"error","Der Spieler ist nicht erreichbar!")
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Dein Handy ist aus!")
		end
	end
end
addEvent("call:player",true)
addEventHandler("call:player",root,callPlayer)

function acceptCall(player)
	local caller=getElementData(player,"calledby")
	setElementData(player,"calledby","none")
	if(isElement(caller))then
		setElementData(player,"call",true)
		setElementData(caller,"call",true)
		setElementData(player,"callswith",caller)
		setElementData(caller,"callswith",player)
		setElementData(player,"calledby","none")
		setElementData(caller,"calledby","none")
		setElementData(player,"calls","none")
		setElementData(caller,"calls","none")
		outputChatBox("Abgehoben.",player,0,200,0)
		outputChatBox("Abgehoben.",caller,0,200,0)
		triggerClientEvent(player,"stop:phonesound",player)
		triggerClientEvent(caller,"stop:phonesound",caller)
	else
		outputChatBox("Du kannst keinen Anruf annehmen!",player,200,0,0)
	end
end
addCommandHandler("takeoff",acceptCall)
addCommandHandler("hup",acceptCall)
addEvent("call:accept",true)
addEventHandler("call:accept",root,acceptCall)

function hangupCall(player)
	if(isElement(getElementData(player,"callswith")))then
		local caller=getElementData(player,"callswith")
		setElementData(caller,"call",false)
		setElementData(caller,"callswith","none")
		setElementData(caller,"calledby","none")
		setElementData(caller,"calls","none")
		outputChatBox("Aufgelegt.",caller,255,255,255)
		triggerClientEvent(caller,"stop:phonesound",caller)
	elseif(isElement(getElementData(player,"calledby")))then
		local caller=getElementData(player,"calledby")
		setElementData(caller,"call",false)
		setElementData(caller,"callswith","none")
		setElementData(caller,"calledby","none")
		setElementData(caller,"calls","none")
		outputChatBox("Aufgelegt.", caller,255,255,255)
		triggerClientEvent(caller,"stop:phonesound",caller)
	end
	setElementData(player,"call",false)
	setElementData(player,"callswith","none")
	setElementData(player,"calledby","none")
	setElementData(player,"calls","none")
	outputChatBox("Aufgelegt.",player,255,255,255)
	triggerClientEvent(player,"stop:phonesound",player)
end
addCommandHandler("hangup",hangupCall)
addEvent("call:denied",true)
addEventHandler("call:denied",root,hangupCall)


local HandyWaffenBesteller={}
local HandyWaffenBestellerTimer={}
local HandyWaffenBestellerID=0
local HandyWaffenBestellTimer={}
local HandyWaffenBestellCooldown={}

addEvent("deliver:weapon",true)
addEventHandler("deliver:weapon",root,function(weapon,price)
	local price=tonumber(price)
	if(tonumber(syncGetElementData(client,"Bankmoney"))>=price)then
		if(tonumber(syncGetElementData(client,"GunLicense"))==1)then
			if(getElementDimension(client)==0 and getElementInterior(client)==0)then
				if(isPedOnGround(client)and not(isElementInWater(client)))then
					if(not HandyWaffenBestellCooldown[client]or HandyWaffenBestellCooldown[client]+lastDeliverTimer<=getTickCount())then
						syncSetElementData(client,"Bankmoney",tonumber(syncGetElementData(client,"Bankmoney"))-price)
						local x,y,z=getElementPosition(client)
						local parachute=createObject(2903,x,y,z+50)
						local box=createObject(2358,x,y,z+50)
						setObjectScale(box,3.0)
						attachElements(box,parachute,0,0,-7.68)
						moveObject(parachute,10000,x,y,z+7)
						setElementCollisionsEnabled(parachute,false)
						setElementCollisionsEnabled(box,false)
						
						triggerClientEvent(client,"draw:infobox",root,"info","Deine Bestellung ist unterwegs.")
						
						HandyWaffenBestellCooldown[client]=getTickCount()
						
						HandyWaffenBestellTimer[client]=setTimer(function(parachute,box,x,y,z,weapon)
							HandyWaffenBestellerID=HandyWaffenBestellerID+1
							parachute:destroy()
							box:destroy()
							HandyWaffenBesteller[HandyWaffenBestellerID]=createPickup(x,y,z,3,2358,50)
							setElementData(HandyWaffenBesteller[HandyWaffenBestellerID],"HandyWaffenTable",weapon)
							setElementData(HandyWaffenBesteller[HandyWaffenBestellerID],"HandyID",HandyWaffenBestellerID)
							
							HandyWaffenBestellerTimer[HandyWaffenBestellerID]=setTimer(function(id)
								if(isElement(HandyWaffenBesteller[id]))then
									HandyWaffenBesteller[id]:destroy()
								end
							end,300000,1,HandyWaffenBestellerID)
							
							addEventHandler("onPickupHit",HandyWaffenBesteller[HandyWaffenBestellerID],function(player)
								if(not(isPedInVehicle(player)))then
									if(getElementDimension(player)==0 and getElementInterior(player)==0)then
										local ID=getElementData(source,"HandyID")
										local Weapons=getElementData(source,"HandyWaffenTable")
										if(isTimer(HandyWaffenBestellerTimer[ID]))then
											HandyWaffenBestellerTimer[ID]:destroy()
										end
										for _,v in pairs(Weapons)do
											if(v[1]=="Weste")then
												syncSetElementData(player,"Weste",tonumber(syncGetElementData(player,"Weste"))+1)
											else
												giveWeapon(player,HandyWeaponsIDS[v[1]][1],HandyWeaponsIDS[v[1]][2],true)
											end
										end
										source:destroy()
										triggerClientEvent(player,"draw:infobox",root,"info","Bestellung eingesammelt.")
									end
								end
							end)
						end,10000,1,parachute,box,x,y,z,weapon)
					else
						triggerClientEvent(client,"draw:infobox",root,"error","Du kannst erst in 20 Sekunden wieder bestellen!")
					end
				end
			end
		else
			triggerClientEvent(client,"draw:infobox",root,"error","Du besitzt keinen Waffenschein!")
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bankgeld! ($"..price..")")
	end
end)


local HandyEssenBesteller={}
local HandyEssenBestellerTimer={}
local HandyEssenBestellerID=0
local HandyEssenBestellTimer={}
local HandyEssenBestellCooldown={}

addEvent("deliver:eat",true)
addEventHandler("deliver:eat",root,function(eat,price)
	local price=tonumber(price)
	if(tonumber(syncGetElementData(client,"Bankmoney"))>=price)then
		if(getElementDimension(client)==0 and getElementInterior(client)==0)then
			if(isPedOnGround(client)and not(isElementInWater(client)))then
				if(not HandyEssenBestellCooldown[client]or HandyEssenBestellCooldown[client]+lastDeliverTimer<=getTickCount())then
					syncSetElementData(client,"Bankmoney",tonumber(syncGetElementData(client,"Bankmoney"))-price)
					local x,y,z=getElementPosition(client)
					local lieferparachute=createObject(2903,x,y,z+50)
					local box=createObject(1582,x,y,z+50)
					setObjectScale(box,3.0)
					attachElements(box,lieferparachute,0,0,-7.68)
					moveObject(lieferparachute,10000,x,y,z+7)
					setElementCollisionsEnabled(lieferparachute,false)
					setElementCollisionsEnabled(box,false)
					
					triggerClientEvent(client,"draw:infobox",root,"info","Deine Bestellung ist unterwegs.")
					
					HandyEssenBestellCooldown[client]=getTickCount()
					
					HandyEssenBestellTimer[client]=setTimer(function(lieferparachute,box,x,y,z,eat)
						HandyEssenBestellerID=HandyEssenBestellerID+1
						lieferparachute:destroy()
						box:destroy()
						HandyEssenBesteller[HandyEssenBestellerID]=createPickup(x,y,z,3,1582,50)
						setElementData(HandyEssenBesteller[HandyEssenBestellerID],"HandyEssenTable",eat)
						setElementData(HandyEssenBesteller[HandyEssenBestellerID],"HandyID",HandyEssenBestellerID)
						
						HandyEssenBestellerTimer[HandyEssenBestellerID]=setTimer(function(id)
							if(isElement(HandyEssenBesteller[id]))then
								HandyEssenBesteller[id]:destroy()
							end
						end,300000,1,HandyEssenBestellerID)
						
						addEventHandler("onPickupHit",HandyEssenBesteller[HandyEssenBestellerID],function(player)
							if(not(isPedInVehicle(player)))then
								if(getElementDimension(player)==0 and getElementInterior(player)==0)then
									local ID=getElementData(source,"HandyID")
									local Eats=getElementData(source,"HandyEssenTable")
									if(isTimer(HandyEssenBestellerTimer[ID]))then
										HandyEssenBestellerTimer[ID]:destroy()
									end
									for _,v in pairs(Eats)do
										syncSetElementData(player,v[1],tonumber(syncGetElementData(player,v[1]))+1)
									end
									source:destroy()
									triggerClientEvent(player,"draw:infobox",root,"info","Bestellung eingesammelt.")
								end
							end
						end)
					end,10000,1,lieferparachute,box,x,y,z,eat)
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du kannst erst in 20 Sekunden wieder bestellen!")
				end
			end
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bankgeld! ($"..price..")")
	end
end)


function addFriendToYourContacts(player,target)
	if(player==client)then
		if(player==getPlayerFromName(target))then
			triggerClientEvent(player,"draw:infobox",root,"error","Du kannst dich nicht selber zur Friendlist hinzufügen!")
		elseif(getPlayerFromName(target))then
			triggerClientEvent(player,"addFriend",root,getPlayerName(getPlayerFromName(target)))
		elseif(playerUID[target])then
			triggerClientEvent(player,"addFriend",root,target)
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Der Spieler existiert nicht!")
		end
	end
end
addEvent("addFriend",true)
addEventHandler("addFriend",root,addFriendToYourContacts)