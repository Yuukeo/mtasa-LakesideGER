--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo) & Xendom       ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local LottoLS=createPickup(1499.5,-1748.8,15.3,3,1239,50)

function openWeaponlicenseUI(player)
	if(isLoggedin(player))then
		triggerClientEvent(player,"open:lottoUI",player)
	end
end
addEventHandler("onPickupHit",LottoLS,openWeaponlicenseUI)

addEvent("buy:lottoticket",true)
addEventHandler("buy:lottoticket",root,function(number1,number2,number3)
	local pname=getPlayerName(client)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","lotto","Username",pname),-1)
	if(not result or not result[1])then
		if(tonumber(syncGetElementData(client,"Money"))>=2500)then
			outputChatBox("Lotto-ticket erfolgreich gekauft! Deine nummern: "..number1.." "..number2.." "..number3,client,0,200,0)
			handler:exec("INSERT INTO lotto (Username,Number1,Number2,Number3) VALUES (?,?,?,?)",pname,number1,number2,number3)
			syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-2500)
		else
			triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($2500)")
		end
	end
end)


LottoTimer=setTimer(function()
	local time=getRealTime()
	local minute=time.minute
	if(hour==20)then
		if(isTimer(LottoTimer))then
			local number1,number2,number3=math.random(0,99),math.random(0,99),math.random(0,99)
			LottoTimer:destroy()
			
			local WinnerTable={}
			local consolationprizeTable={}
			
			outputChatBox("-----------------| Lottery |-----------------",root,250,150,0)
			outputChatBox("Heute Lotto zahlen:",root,250,125,0)
			outputChatBox(number1.." "..number2.." "..number3.." !",root,250,125,0)
			
			local result=dbPoll(dbQuery(handler,"SELECT * FROM ??","lotto"),-1)
			for _,v in pairs(result)do
				if(v["Number1"]==number1 and v["Number2"]==number2 and v["Number3"]==number3)then
					table.insert(WinnerTable,v["Username"])
				else
					local Count=0
					if(v["Number1"]==number1)then
						Count=Count+1
					end
					if(v["Number2"]==number2)then
						Count=Count+1
					end
					if(v["Number3"]==number3)then
						Count=Count+1
					end
					if(Count>=2)then
						table.insert(consolationprizeTable,v["Username"])
					end
				end
			end
			if(#WinnerTable>=1)then
				outputChatBox("Der Jackpot in höre $"..Jackpot.." wurde geknackt!",root,250,125,0)
				outputChatBox("Winner:",root,250,125,0)
				for _,v in pairs(WinnerTable)do
					local playername=getPlayerFromName(v)
					local jackpotwin=math.floor(Jackpot/#WinnerTable)
					outputChatBox(v,root,250,125,0)
					if(isElement(playername)and isLoggedin(playername))then
						syncSetElementData(playername,"Bankmoney",tonumber(syncGetElementData(playername,"Bankmoney"))+jackpotwin)
						outputChatBox("[LOTTO]: Du hast $"..jackpotwin.." gewonnen.",playername,0,200,0)
					else
						handler:exec("UPDATE ?? SET ??=? WHERE ??=?","userdata","Bankmoney",getData("userdata","Username",v,"Bankmoney")+jackpotwin,"Username",v)
					end
				end
			else
				outputChatBox("Niemand hat den Jackpot heute geknackt!",root,250,125,0)
			end
			if(#consolationprizeTable>=1)then
				for _,v in pairs(consolationprizeTable)do
					local playername=getPlayerFromName(v)
					local jackpotwin=math.random(500,1000)
					if(isElement(playername)and isLoggedin(playername))then
						syncSetElementData(playername,"Bankmoney",tonumber(syncGetElementData(playername,"Bankmoney"))+jackpotwin)
						outputChatBox("[LOTTO]: Du hast $"..jackpotwin.." gewonnen.",playername,0,200,0)
					else
						handler:exec("UPDATE ?? SET ??=? WHERE ??=?","userdata","Bankmoney",getData("userdata","Username",v,"Bankmoney")+jackpotwin,"Username",v)
					end
				end
			end
			
			handler:exec("TRUNCATE TABLE ??","lotto")
		end
	end
end,55*1000,0)