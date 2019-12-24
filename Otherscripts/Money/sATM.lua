--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function transferMoney(money,typ,target)
	local target=getPlayerFromName(target)
	local money=tonumber(money)
	if(money)then
		if(tonumber(money)>=1)then
			if(typ=="pay:inATM")then
				if(tonumber(syncGetElementData(client,"Money"))>=tonumber(money))then
					syncSetElementData(client,"Bankmoney",tonumber(syncGetElementData(client,"Bankmoney"))+money)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-money)
					infoShow(client,"minus","Du hast $"..money.." eingezahlt.")
					triggerEvent("set:task",client,client,"PayIn_Out")
					outputLog(getPlayerName(client).." hat $"..money.." eingezahlt!","Moneysystem")
				end
			elseif(typ=="pay:outATM")then
				if(tonumber(syncGetElementData(client,"Bankmoney"))>=tonumber(money))then
					syncSetElementData(client,"Bankmoney",tonumber(syncGetElementData(client,"Bankmoney"))-money)
					syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))+money)
					infoShow(client,"plus","Du hast $"..money.." ausgezahlt.")
					triggerEvent("set:task",client,client,"PayIn_Out")
					outputLog(getPlayerName(client).." hat $"..money.." ausgezahlt!","Moneysystem")
				end
			elseif(typ=="pay:ueberweisung")then
				if(tonumber(syncGetElementData(client,"Bankmoney"))>=tonumber(money))then
					if(isElement(target))then
						syncSetElementData(client,"Bankmoney",tonumber(syncGetElementData(client,"Bankmoney"))-money)
						syncSetElementData(target,"Bankmoney",tonumber(syncGetElementData(target,"Bankmoney"))+money)
						infoShow(client,"minus","Du hast "..getPlayerName(target).." $"..money.." Überwiesen.")
						infoShow(target,"plus",getPlayerName(client).." hat dir $"..money.." Überwiesen.")
						outputLog(getPlayerName(client).." hat "..getPlayerName(target).." $"..money.." überwiesen!","Moneysystem")
					else
						local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","userdata","Username",target),-1)
						if(result and result[1])then
							local bankmoneykplayer=getData("userdata","Username",target,"Bankmoney")+money
							
							handler:exec("UPDATE ?? SET ??=? WHERE ??=?","userdata","Bankmoney",bankmoneykplayer,"Username",target)
							syncSetElementData(client,"Bankmoney",tonumber(syncGetElementData(client,"Bankmoney"))-money)
							infoShow(client,"minus","Du hast "..target.." $"..money.." Überwiesen. (offline)")
							outputLog(getPlayerName(client).." hat "..getPlayerName(target).." $"..money.." überwiesen! (offline)","Moneysystem")
						else
							triggerClientEvent(client,"draw:infobox",root,"warning","Der Spieler existiert nicht!")
						end
					end
				end
			end
			triggerClientEvent(client,"refresh:atm",client)
		end
	end
end
addEvent("transfer:money",true)
addEventHandler("transfer:money",root,transferMoney)


function payMoney_Func(player,cmd,target,money)
	if(source==client)then
		if(target)then
			if(money)then
				if(tonumber(money)>=1)then
					local target=getPlayerFromName(target)
					if(isElement(target)and isLoggedin(target))then
						if(not(isPedDead(target)))then
							local tx,ty,tz=getElementPosition(target)
							local px,py,pz=getElementPosition(player)
							if(getDistanceBetweenPoints3D(tx,ty,tz,px,py,pz)<=5)then
								if(tonumber(syncGetElementData(player,"Money"))>=tonumber(money))then
									syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))-money)
									syncSetElementData(target,"Money",tonumber(syncGetElementData(target,"Money"))+money)
									triggerClientEvent(player,"draw:infobox",root,"success","Du hast "..getPlayerName(target).." $"..money.." gegeben.")
									triggerClientEvent(target,"draw:infobox",root,"info",getPlayerName(player).." hat dir $"..money.." gegeben.")
									outputLog(getPlayerName(player).." hat "..getPlayerName(target).." $"..money.." gegeben! (/pay)","Moneysystem")
								else
									triggerClientEvent(player,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..money..")")
								end
							end
						else
							triggerClientEvent(player,"draw:infobox",root,"error","Der angegebene Spieler ist Tot!")
						end
					else
						triggerClientEvent(player,"draw:infobox",root,"error","Der Spieler ist offline!")
					end
				end
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Geben einen Spieler an!")
		end
	end
end
addCommandHandler("pay",payMoney_Func)
addCommandHandler("geldgeben",payMoney_Func)