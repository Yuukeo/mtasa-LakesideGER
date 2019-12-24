--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo) & Xendom       ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local ADaktiv=true
local adWaitTimer={}
local saveAdTyp={}
local saveADText={}
local allowAD={}
local badWords={
"reallife",
"german",
"roleplay",
"xtream",
"xtream rl",
"ekonomie",
"ekonomie rl",
"coa",
"coa rl",
"vio",
"vio rl",
"exo",
"exo rl",
"venox",
"venox rl",
"sunrise",
"sunrise rl",
"syn",
"syn rl",
"astro",
"astro rl",
"deltroyz",
"deltroyz rl",
"server",
"bester server",
"scheiss server",
"sieg heil",
"adolf",
"hitler",
"ultimate",
}

addEvent("write:ad",true)
addEventHandler("write:ad",root,function(text,typ,costs)
	player=client

	if(typ=="special")then
		costs=costs+settings.general.adspecialprice
	else
		costs=costs+settings.general.adnormalprice
	end
	if(tonumber(syncGetElementData(player,"Playtime"))>=180)then
		if(tonumber(syncGetElementData(player,"Jailtime"))==0)then
			if(adWaitTimer[player] == nil)then
				if(tonumber(syncGetElementData(player,"Money"))>=costs)then
					if(allowAD[player]~=false)then
						for word in text:gmatch("%S+")do
							for i,v in ipairs(badWords)do
								local src=word:lower():gsub("%s","")
								local src=src:gsub("#%x%x%x%x%x%x","")
								local src=src:gsub("%c","")
								local src=src:gsub("%p","")
								local pat=v:lower():gsub("%s","")
								
								if(src:find(pat))then
									saveAdTyp[player]=typ
									saveADText[player]=text
									outputChatBox("Bei deiner Werbung besteht der Verdacht auf Serverwerbung. Sie wird von einem Teammitglied kontrolliert.",player,255,0,0)
									sendControlMessageToAdmins(getPlayerName(player),text)
									allowAD[player]=false
									return false
								end
							end
						end
						
						
						syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))-costs)
						adWaitTimer[player]=true
						setTimer(function()
							adWaitTimer[player]=nil
						end,3*60*1000,1)
						
						if(tonumber(getElementData(player,"Telenr"))~=0)then
							handynummer=getElementData(player,"Telenr")
						else
							handynummer="-"
						end
								
						if(typ=="special")then
							outputChatBox("═════ ↓↓ Werbung von "..getPlayerName(player).." - Nummer: "..handynummer.." ↓↓ ═════",root,255,255,0)
							outputChatBox(text,root,200,200,0)
							outputChatBox("═════ ↑↑ Werbung von "..getPlayerName(player).." - Nummer: "..handynummer.." ↑↑ ═════",root,255,255,0)
						else
							outputChatBox("Werbung von "..getPlayerName(player)..": "..text.." (Nummer: "..handynummer..")",root,0,160,0)
						end
						
						
						outputLog("Werbung von "..getPlayerName(player)..": "..text,"Werbungen")
					else
						triggerClientEvent(player,"draw:infobox",root,"error","Du kannst zurzeit keine Werbungen schalten!")
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","Du hat nicht genug Bargeld! ($"..costs..")")
				end
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Du kannst nur alle 3 Minuten eine Werbung schalten!")
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Du kannst im Knast keine Werbnung schalten!")
		end
	else
		triggerClientEvent(player,"draw:infobox",root,"error","Du hast keine 3 Spielstunden!")
	end
end)

function sendControlMessageToAdmins(pname,text)
	sendAdminMessage("Bei folgender Werbung könnte es sich um Serverwerbung handeln:")
	sendAdminMessage(text)
	sendAdminMessage("Von: "..pname.." - Tipe /allowad "..pname.." oder /adbann "..pname.."")
end

addCommandHandler("allowad",function(player,cmd,tplayer)
	if(tonumber(syncGetElementData(player,"AdminLvL"))>=2)then
		if(tplayer)then
			pname = getPlayerFromName(tplayer)
			
			if(isElement(pname))then
				if(saveADText[pname] ~= nil)then
					if(tonumber(getElementData(pname,"Handy"))==1)then
						handynummer=getElementData(pname,"Telenr")
					else
						handynummer="-"
					end
						
					if(saveAdTyp[pname]=="special")then
						outputChatBox("═════ ↓↓ Werbung von "..getPlayerName(pname).." - Nummer: "..handynummer.." ↓↓ ═════",root,255,255,0)
						outputChatBox(saveADText[pname],root,200,200,0)
						outputChatBox("═════ ↑↑ Werbung von "..getPlayerName(pname).." - Nummer: "..handynummer.." ↑↑ ═════",root,255,255,0)
					else
						outputChatBox("Werbung von "..getPlayerName(pname)..": "..saveADText[pname].." (Nummer: "..handynummer..")",root,0,160,0)
					end
					
					saveAdTyp[pname]=nil
					saveADText[pname]=nil
					allowAD[pname]=true
					
					triggerClientEvent(player,"draw:infobox",root,"info","Du hast die Werbung von "..getPlayerName(pname).." zugelassen.")
					triggerClientEvent(pname,"draw:infobox",root,"info","Deine Werbung wurde von einem Teammitglied akzeptiert.")
				end
			end
		end
	end
end)

addCommandHandler("adbann",function(player,cmd,target)
	if(tonumber(syncGetElementData(player,"AdminLvL"))>=2)then
		if(target)then
			target=getPlayerFromName(target)
			
			if(isElement(target))then
				if(saveADText[target] ~= nil)then
					dbExec(db_connection,"INSERT INTO BANS (Username,Admin,Grund,Serial) VALUES ('"..getPlayerName(target).."','"..getPlayerName(player).."','Serverwerbung','"..getPlayerSerial(target).."')")
					kickPlayer(target,player,"Du wurdest permanent gebannt! Grund: Serverwerbung")
					outputChatBox(""..getPlayerName(target).." wurde von "..getPlayerName(player).." permanent gebannt! Grund: Serverwerbung",root,200,0,0)
				end
			end
		end
	end
end)