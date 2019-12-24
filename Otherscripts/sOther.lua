--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("set:task",true)
addEventHandler("set:task",root,function(player,typ)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"Task"))==1)then
			if(typ=="Scooter")then
				syncSetElementData(player,"Task",2)
				syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+750)
				outputChatBox("Gratulation, du hast eine Aufgabe erledigt! Du bekommst $750",player,255,255,255)
			end
		elseif(tonumber(syncGetElementData(player,"Task"))==2)then
			if(typ=="Ausweis")then
				syncSetElementData(player,"Task",3)
				syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+500)
				outputChatBox("Gratulation, du hast eine Aufgabe erledigt! Du bekommst $500",player,255,255,255)
			end
		elseif(tonumber(syncGetElementData(player,"Task"))==3)then
			if(typ=="CreateBankaccount")then
				syncSetElementData(player,"Task",4)
				syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+890)
				outputChatBox("Gratulation, du hast eine Aufgabe erledigt! Du bekommst $890",player,255,255,255)
			end
		elseif(tonumber(syncGetElementData(player,"Task"))==4)then
			if(typ=="PayIn_Out")then
				syncSetElementData(player,"Task",5)
				syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+920)
				outputChatBox("Gratulation, du hast eine Aufgabe erledigt! Du bekommst $920",player,255,255,255)
			end
		elseif(tonumber(syncGetElementData(player,"Task"))==5)then
			if(typ=="OpenHelpmenue")then
				syncSetElementData(player,"Task",6)
				syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+650)
				outputChatBox("Gratulation, du hast eine Aufgabe erledigt! Du bekommst $650",player,255,255,255)
			end
		elseif(tonumber(syncGetElementData(player,"Task"))==6)then
			if(typ=="BuyMobilephone")then
				syncSetElementData(player,"Task",7)
				syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+1400)
				outputChatBox("Gratulation, du hast eine Aufgabe erledigt! Du bekommst $1400",player,255,255,255)
			end
		end
	end
end)

--[[local PissTimerTable={}
function pissFunction(player)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"Urin"))>=1)then
			if(not isPedInVehicle(player)and not isElementInWater(player)and isPedOnGround(player))then
				if(not(isTimer(PissTimerTable[player])))then
					setElementFrozen(player,true)
					setPedAnimation(player,"paulnmac","piss_loop")
					PissTimerTable[player]=setTimer(function(player)
						if(isElement(player))then
							setElementFrozen(player,false)
							setPedAnimation(player)
							syncSetElementData(player,"Urin",0)
						end
					end,9000,1,player)
					local x,y,z=getElementPosition(player)
					local rx,ry,rz=getElementRotation(player)
					for _,v in pairs(getElementsByType("player"))do
						if(isLoggedin(v))then
							triggerClientEvent(v,"create:pisseffect",v,x,y,z,rz)
						end
					end
				end
			end
		end
	end
end
addCommandHandler("urine",pissFunction)
addCommandHandler("urin",pissFunction)
addCommandHandler("piss",pissFunction)]]




function reloadWeapon_Func()
	reloadPedWeapon(client)
end
addEvent("reload:weapon", true)
addEventHandler("reload:weapon",resourceRoot,reloadWeapon_Func)