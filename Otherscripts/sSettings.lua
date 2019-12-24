--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("set:settings",true)
addEventHandler("set:settings",root,function(typ,amount)
	if(typ)then
		if(typ=="Radar")then
			if(amount>=1 and amount<=2)then
				if(tonumber(syncGetElementData(client,"Radar"))~=amount)then
					syncSetElementData(client,"Radar",tonumber(amount))
					triggerClientEvent(client,"refresh:settingsmenu",client,"Radar")
					triggerClientEvent(client,"draw:infobox",root,"success","Radar erfolgreich geändert!")
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du hast bereits dieses Radar ausgewählt!")
				end
			end
		elseif(typ=="Hitglocke")then
			if(amount>=1 and amount<=3)then
				if(tonumber(syncGetElementData(client,"Hitglocke"))~=amount)then
					syncSetElementData(client,"Hitglocke",tonumber(amount))
					triggerClientEvent(client,"refresh:settingsmenu",client,"Hitglocke")
					triggerClientEvent(client,"draw:infobox",root,"success","Hitglocke erfolgreich geändert!")
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du hast bereits diese Hitglocke ausgewählt!")
				end
			end
		elseif(typ=="Snowshader")then
			if(tonumber(syncGetElementData(client,"Snowshader"))==1)then
				syncSetElementData(client,"Snowshader",tonumber(2))
				triggerClientEvent("switchGoundSnow",client,true)
				triggerClientEvent(client,"refresh:settingsmenu",client,"Snowshader")
			elseif(tonumber(syncGetElementData(client,"Snowshader"))==2)then
				syncSetElementData(client,"Snowshader",tonumber(1))
				triggerClientEvent("switchGoundSnow",client,false)
				triggerClientEvent(client,"refresh:settingsmenu",client,"Snowshader")
			end
		elseif(typ=="Blurshader")then
			if(tonumber(syncGetElementData(client,"Blurshader"))==1)then
				syncSetElementData(client,"Blurshader",tonumber(2))
				setPlayerBlurLevel(client,36)
				triggerClientEvent(client,"refresh:settingsmenu",client,"Blurshader")
			elseif(tonumber(syncGetElementData(client,"Blurshader"))==2)then
				syncSetElementData(client,"Blurshader",tonumber(1))
				setPlayerBlurLevel(client,0)
				triggerClientEvent(client,"refresh:settingsmenu",client,"Blurshader")
			end
		elseif(typ=="Autologin")then
			if(tonumber(syncGetElementData(client,"Autologin"))==1)then
				syncSetElementData(client,"Autologin",tonumber(2))
				triggerClientEvent(client,"refresh:settingsmenu",client,"Autologin")
			elseif(tonumber(syncGetElementData(client,"Autologin"))==2)then
				syncSetElementData(client,"Autologin",tonumber(1))
				triggerClientEvent(client,"refresh:settingsmenu",client,"Autologin")
			end
		end
	end
end)

local oldName={}
addEvent("change:accountsettings",true)
addEventHandler("change:accountsettings",root,function(typ,variable)
	local pname=getPlayerName(client)
	if(typ=="Password")then
		if(variable)then
			local variable=md5(hash("sha512",variable))
			
			handler:exec("UPDATE ?? SET ??=? WHERE ??=?","userdata","Password",variable,"UID",playerUID[pname])
			triggerClientEvent(client,"draw:infobox",root,"success","Dein Passwort wurde erfolgreich geändert!")
		end
	elseif(typ=="Nickchange")then
		if(variable)then
			if(tonumber(syncGetElementData(client,"Playtime"))<=180)then
				nickcosts=0
			else
				nickcosts=100000
			end
			if(tonumber(syncGetElementData(client,"Money"))>=nickcosts)then
				oldName[client]=getPlayerName(client)
				local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","userdata","Username",variable),-1)
				if(not result or not result[1])then
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-nickcosts)

					local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=? AND ??=?","houses","Owner",pname),-1)
					if(result and result[1])then
						handler:exec("UPDATE ?? SET ??=? WHERE ??=?","houses","Owner",variable,"Owner",pname)
					end
					local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=? AND ??=?","uservehicles","Owner",pname),-1)
					if(result and result[1])then
						handler:exec("UPDATE ?? SET ??=? WHERE ??=?","uservehicles","Owner",variable,"Owner",pname)
					end
					handler:exec("UPDATE ?? SET ??=? WHERE ??=?","inventory","Username",variable,"Username",pname)
					handler:exec("UPDATE ?? SET ??=? WHERE ??=?","userdata","Username",variable,"Username",pname)
					handler:exec("UPDATE ?? SET ??=? WHERE ??=?","userlevel","Username",variable,"Username",pname)
					handler:exec("UPDATE ?? SET ??=? WHERE ??=?","usersettings","Username",variable,"Username",pname)
					handler:exec("UPDATE ?? SET ??=? WHERE ??=?","userstats","Username",variable,"Username",pname)
					
					playerUID[variable]=playerUID[oldName[client]]
                    playerUID[oldName[client]]=nil
					
					setPlayerName(client,variable)
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Dieser Benutzername ist bereits vergeben!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..nickcosts..")")
			end
		end
	end
end)