--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function adminChat(player,cmd,...)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=1)then
			if(...)then
				if(not isPedDead(player))then
					for _,v in ipairs(getElementsByType("player"))do
						if(isLoggedin(v))then
							if(tonumber(syncGetElementData(v,"AdminLvL"))>=1)then
								if(tonumber(syncGetElementData(player,"AdminLvL"))>=1)then
									outputChatBox("#ffffff[#c80000Admin#ffffff] "..settings.admin.colorToHASH[syncGetElementData(player,"AdminLvL")].." "..getPlayerName(player).."#ffffff: "..stringTextWithAllParameters(...).."",v,255,255,255,true)
								end
							end
						end
					end
					outputLog("[A-CHAT] "..getPlayerName(player)..": "..stringTextWithAllParameters(...),"Chat")
				end
			end
		end
	end
end
addCommandHandler("adminchat",adminChat)
addCommandHandler("a",adminChat)

function oChat(player,cmd,...)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=2)then
			if(...)then
				for _,v in ipairs(getElementsByType("player"))do
					if(isLoggedin(v))then
						outputChatBox(""..settings.admin.colorToHASH[syncGetElementData(player,"AdminLvL")].." "..getPlayerName(player).."#ffffff: "..stringTextWithAllParameters(...).."",v,255,255,255,true)
					end
				end
			end
		end
	end
end
addCommandHandler("o",oChat)
addCommandHandler("ochat",oChat)