--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function teamChat(player,cmd,...)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"Faction"))>=1)then
			if(tonumber(syncGetElementData(player,"Mutedtime"))==0)then
				if(not isPedDead(player))then
					for _,v in ipairs(getElementsByType("player"))do
						if(isLoggedin(v))then
							if(tonumber(syncGetElementData(v,"Faction"))==tonumber(syncGetElementData(player,"Faction")))then
								outputChatBox(""..settings.faction.ranknames.colorToHASH[tonumber(syncGetElementData(player,"Faction"))].."["..settings.faction.ranknames[syncGetElementData(player,"Faction")][syncGetElementData(player,"Factionrank")].."]: "..getPlayerName(player)..": "..stringTextWithAllParameters(...),v,255,255,255,true)
							end
						end
					end
					outputLog("[F-CHAT] "..getPlayerName(player)..": "..stringTextWithAllParameters(...),"Chat")
				end
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Du bist gemuted! ("..tonumber(syncGetElementData(player,"Mutedtime")).." Minuten)")
			end
		end
	end
end
addCommandHandler("Teamchat",teamChat)

function unternehmenChat(player,cmd,...)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"Company"))>=1)then
			if(tonumber(syncGetElementData(player,"Mutedtime"))==0)then
				if(not isPedDead(player))then
					for _,v in ipairs(getElementsByType("player"))do
						if(isLoggedin(v))then
							if(tonumber(syncGetElementData(v,"Company"))==tonumber(syncGetElementData(player,"Company")))then
								outputChatBox("["..settings.company.ranknames[syncGetElementData(player,"Company")][syncGetElementData(player,"Companyrank")].."]: "..getPlayerName(player)..": "..stringTextWithAllParameters(...),v,255,255,255,true)
							end
						end
					end
					outputLog("[U-CHAT] "..getPlayerName(player)..": "..stringTextWithAllParameters(...),"Chat")
				end
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Du bist gemuted! ("..tonumber(syncGetElementData(player,"Mutedtime")).." Minuten)")
			end
		end
	end
end
addCommandHandler("u",unternehmenChat)

function gChat(player,cmd,...)
	if(isLoggedin(player))then
		if(isLSPD(player)or isFBI(player))then
			if(tonumber(syncGetElementData(player,"Mutedtime"))==0)then
				if(not isPedDead(player))then
					for _,v in ipairs(getElementsByType("player"))do
						if(isLoggedin(v))then
							--if(isLSPD(v)==isLSPD(player)or isFBI(v)==isFBI(player)or isLSPD(v)==isFBI(player)or isLSPD(player)==isFBI(v))then
							if(isSTATE(v)==isSTATE(player))then
								outputChatBox("[ "..settings.faction.ranknames[syncGetElementData(player,"Faction")][syncGetElementData(player,"Factionrank")].." "..getPlayerName(player)..": "..stringTextWithAllParameters(...).." ]",v,190,0,0,true)
							end
						end
					end
				end
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Du bist gemuted! ("..tonumber(syncGetElementData(player,"Mutedtime")).." Minuten)")
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Du bist kein Staats-Fraktionist!")
		end
	end
end
addCommandHandler("g",gChat)