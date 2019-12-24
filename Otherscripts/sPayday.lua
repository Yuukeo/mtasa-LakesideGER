--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local paydayPlayerTimerTable={}
local hungerPlayerTimerTable={}
local pissPlayerTimerTable={}

function startPaydayPlayerTimer(player)
	if(not(isTimer(paydayPlayerTimerTable[player])))then
		paydayPlayerTimerTable[player]=setTimer(function()
			triggerPlayerPayday(player)
		end,1*60*1000,0)
	end
end
function startHungerPlayerTimer(player)
	if(not(isTimer(hungerPlayerTimerTable[player])))then
		local rdm=math.random(1,2)
		hungerPlayerTimerTable[player]=setTimer(function()
			hungerLoss(player)
		end,rdm*60*1000,0)
	end
end

addEventHandler("onPlayerQuit",root,function()
	if(isTimer(paydayPlayerTimerTable[source]))then
		paydayPlayerTimerTable[source]:destroy()
	end
	if(isTimer(hungerPlayerTimerTable[source]))then
		hungerPlayerTimerTable[source]:destroy()
	end
	if(isTimer(pissPlayerTimerTable[source]))then
		pissPlayerTimerTable[source]:destroy()
	end
end)

function triggerPlayerPayday(player)
	if(isElement(player))then
		if(isLoggedin(player))then
			if(getElementData(player,"AFK")==false)then
				syncSetElementData(player,"Playtime",tonumber(syncGetElementData(player,"Playtime"))+1)
				syncSetElementData(player,"Weeklytime",tonumber(syncGetElementData(player,"Weeklytime"))+1)
				
				if(tonumber(syncGetElementData(player,"Mutedtime"))>=1)then
					syncSetElementData(player,"Mutedtime",tonumber(syncGetElementData(player,"Mutedtime"))-1)
					if(tonumber(syncGetElementData(player,"Mutedtime"))==0)then
						outputChatBox("Du bist nun wieder entmuted!",player,200,0,0)
					end
				end
				
				if(tonumber(syncGetElementData(player,"Jailtime"))>=1)then
					syncSetElementData(player,"Jailtime",tonumber(syncGetElementData(player,"Jailtime"))-1)
					if(tonumber(syncGetElementData(player,"Jailtime"))==0)then
						freePlayerJail(player)
					end
				end
				
				
				if(math.floor(syncGetElementData(player,"Playtime")/60)==(syncGetElementData(player,"Playtime")/60))then
					rent=0
					if(syncGetElementData(player,"Housekey")<0)then
						local Cash=tonumber(dbPoll(dbQuery(handler,"SELECT ?? FROM ?? WHERE ??=?","Cash","houses","ID",ID),-1)[1]["Cash"])
						local ID=syncGetElementData(player,"Housekey")
						local house=houses["pickup"][ID]
						rent=getElementData(house,"miete")
						handler:exec("UPDATE ?? SET ??=? WHERE ID=?","houses","Cash",Cash+rent,ID)
					end
					miete=rent
					
					local factionmoney=0
					if(tonumber(syncGetElementData(player,"Faction"))>=1)then
						local FacMoney=getData("factiondepots","Faction",tonumber(syncGetElementData(player,"Faction")),"Money")
						local Salary=getData("factiondepots","Faction",tonumber(syncGetElementData(player,"Faction")),"Rang"..tonumber(syncGetElementData(player,"Factionrank")).."")
						if(FacMoney>=Salary)then
							factionmoney=factionmoney+Salary
							handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Money",FacMoney-Salary,"Faction",tonumber(syncGetElementData(player,"Faction")))
						end
					end
					local companymoney=0
					if(tonumber(syncGetElementData(player,"Company"))>=1)then
						local FacMoney=getData("companydepots","Company",tonumber(syncGetElementData(player,"Company")),"Money")
						local Salary=getData("companydepots","Company",tonumber(syncGetElementData(player,"Company")),"Rang"..tonumber(syncGetElementData(player,"Companyrank")).."")
						if(FacMoney>=Salary)then
							companymoney=companymoney+Salary
							handler:exec("UPDATE ?? SET ??=? WHERE ??=?","companydepots","Money",FacMoney-Salary,"Company",tonumber(syncGetElementData(player,"Company")))
						end
					end
					
					local tagCount=0
					local costsTag=50
					local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiontags","Owner",tonumber(syncGetElementData(player,"Faction"))),-1)
					if(#result>=1)then
						for _,v in pairs(result)do
							tagCount=tagCount+1
						end
					end
					tagPrice=tagCount*costsTag
					
					local vehCount=0
					local costsVeh=125
					local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","uservehicles","Owner",getPlayerName(player)),-1)
					if(#result>=1)then
						for _,v in pairs(result)do
							vehCount=vehCount+1
						end
					end
					vehPrice=vehCount*costsVeh
					
					jobmoney=tonumber(syncGetElementData(player,"Jobmoney"))
				
					outputChatBox("___________| PAYDAY |___________",player,255,255,255)
					outputChatBox("Einnahmen: ",player,0,200,0)
					outputChatBox("Jobgehalt: $"..jobmoney,player,255,255,255)
					if(tonumber(syncGetElementData(player,"Faction"))>=1)then
						outputChatBox("Fraktionsgehalt: $"..factionmoney,player,255,255,255)
					end
					if(tonumber(syncGetElementData(player,"Faction"))>=3)then
						outputChatBox("Gangtag Bonus: $"..tagPrice,player,255,255,255)
					end
					if(tonumber(syncGetElementData(player,"Company"))>=1)then
						outputChatBox("Unternehmensgehalt: $"..companymoney,player,255,255,255)
					end
					outputChatBox("Ausgaben: ",player,200,0,0)
					outputChatBox("Fahrzeugsteuern: $"..vehPrice.." Miete: $"..miete,player,255,255,255)
					outputChatBox("_______________________________",player,255,255,255)
					paydayCash=jobmoney+factionmoney+companymoney+tagPrice-vehPrice-miete
					outputChatBox("Gehalt: $"..paydayCash,player,255,255,255)
					triggerClientEvent(player,"show:desktopnotify",player,"info","Payday: $"..paydayCash)
					
					syncSetElementData(player,"Bankmoney",tonumber(syncGetElementData(player,"Bankmoney"))+paydayCash)
					syncSetElementData(player,"Jobmoney",0)
					
					if(settings.general.christmas==true)then
						outputChatBox("__________| Christmas |__________",player,255,255,255)
						outputChatBox("Zuckerstange: +1",player,220,0,0)
						outputChatBox("______________________________",player,255,255,255)
						syncSetElementData(player,"Zuckerstange",tonumber(syncGetElementData(player,"Zuckerstange"))+1)
					end
					
					if(tonumber(syncGetElementData(player,"Wanteds"))>=1)then
						syncSetElementData(player,"Wanteds",tonumber(syncGetElementData(player,"Wanteds"))-1)
						outputChatBox("Dir wurden soeben x1 Wanted entlassen.",player,200,0,0)
					end
					if(tonumber(syncGetElementData(player,"CarLicensePoints"))>=2)then
						syncSetElementData(player,"CarLicensePoints",tonumber(syncGetElementData(player,"CarLicensePoints"))-2)
						outputChatBox("Dir wurden soeben x2 StVO Punkt von deinem Auto-Führerschein entlassen.",player,200,0,0)
					end
					if(tonumber(syncGetElementData(player,"BikeLicensePoints"))>=2)then
						syncSetElementData(player,"BikeLicensePoints",tonumber(syncGetElementData(player,"BikeLicensePoints"))-2)
						outputChatBox("Dir wurden soeben x2 StVO Punkt von deinem Motorrad-Führerschein entlassen.",player,200,0,0)
					end
					
					RegisterLogin_saveDatas(player)
				end
			end
		end
	end
end

function hungerLoss(player)
	if(isElement(player))then
		if(isLoggedin(player))then
			if(getElementData(player,"AFK")==false)then
				local hunger=tonumber(syncGetElementData(player,"Hunger"))
				syncSetElementData(player,"Hunger",hunger-1)
				if(hunger<25)then
					setElementHealth(player,getElementHealth(player)-math.floor((25-hunger)/2*20)/10)
				end
				if(hunger<1)then
					killPed(player)
					setElementHealth(player,50)
					syncSetElementData(player,"Hunger",25)
					outputChatBox("Du bist auf grund Mangel an Essen gestorben!",player,200,0,0)
				end
				if(hunger==20)then
					outputChatBox("Du wirst hungrig!",player,200,0,0)
				elseif(hunger==15)then
					outputChatBox("Du wirst hungrig!",player,200,0,0)
				elseif(hunger==10)then
					outputChatBox("Du wirst hungrig!",player,200,0,0)
				end
			end
		end
	end
end