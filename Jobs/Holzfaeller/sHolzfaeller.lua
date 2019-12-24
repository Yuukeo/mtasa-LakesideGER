--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo) & Xendom       ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

HolzfaellerSaw=createObject(1962,-2015.6,-2349.5,31.3,0,0,135)
setObjectScale(HolzfaellerSaw,1.5)

local HolzfaellerZones={
	{-1872.8853759766,-2676.7751464844,-1776.2213134766,-2611.2033691406},
	{-2608.1831054688,-2242.7133789063,-2564.7590332031,-2173.4755859375},
	{-701.96078431373,-686.27450980392,-592.1568627451,-631.37254901961},
}
local HolzfaellerTrees={
	{615, -628.79999, -683.5, 39.7},
	{615, -642.09998, -670.90002, 40.9},
	{615, -638.40002, -680.29999, 42.4},
	{615, -629.79999, -663.40002, 35.4},
	{615, -621.59998, -675.40002, 36.3},
	{615, -610.70001, -671.59998, 33},
	{615, -631, -676.29999, 39},
	{615, -640.09998, -658.90002, 37.2},
	{615, -650, -669.59998, 43.2},
	{615, -650.90002, -659.29999, 40.4},
	{615, -663.79999, -661.59998, 45.2},
	{615, -674.40002, -661.29999, 48.6},
	{615, -662.59998, -653, 42.2},
	{615, -673.29999, -652.59998, 45.4},
	{615, -649.20001, -647.40002, 37.3},
	{615, -638.5, -650.90002, 35.5},
	{615, -632.40002, -655.20001, 34.7},
	{615, -619.59998, -660.40002, 32.6},
	{615, -618.5, -671.79999, 34.8},
	{615, -607.29999, -664.20001, 30.2},
	{615, -657.5, -642.29999, 38.4},
	{615, -666.5, -642, 40.8},
	{615, -675.70001, -643.09998, 43.6},
	{615, -682.70001, -638.09998, 44.4},
	{615, -693.5, -641.09998, 47.8},
	{615, -683.5, -648.70001, 47.5},
	{615, -690.90002, -651.09998, 50},
	{615, -684, -656.90002, 49.8},
	--//Wald 2
	{615,-2606.599609375,-2212.3994140625,25.299999237061},
	{615,-2597.1999511719,-2198.3999023438,26.299999237061},
	{615,-2602,-2226,24.299999237061},
	{615,-2592.099609375,-2216.099609375,26.799999237061},
	{615,-2590.8999023438,-2233.1999511719,24.299999237061},
	{615,-2570,-2180.8999023438,28.89999961853},
	{615,-2577,-2190.3994140625,28.200000762939},
	{615,-2584.3994140625,-2205.2998046875,27.39999961853},
	{615,-2581.5,-2219.6999511719,27.60000038147},
	{615,-2578.1000976563,-2233.1000976563,25.89999961853},
	{615,-2569.7001953125,-2228.7998046875,27.700000762939},
	{615,-2565.3999023438,-2214.5,29},
	{615,-2573.8999023438,-2208.3000488281,28.39999961853},
	{615,-2566.8999023438,-2200.8999023438,28.89999961853},
	{615,-2565.1000976563,-2189.5,29},
	--//Wald 3
	{615,-1865.4000244141,-2666.6999511719,53.900001525879},
	{615,-1852.0999755859,-2662.8000488281,53.700000762939},
	{615,-1840,-2659.1999511719,53.200000762939},
	{615,-1873.9000244141,-2658.1999511719,54.400001525879},
	{615,-1863,-2651.8000488281,54.299999237061},
	{615,-1848.5,-2650.099609375,53.799999237061},
	{615,-1835.400390625,-2647.3994140625,53.900001525879},
	{615,-1874.4000244141,-2646.6000976563,54.200000762939},
	{615,-1860.2001953125,-2639.7998046875,54.200000762939},
	{615,-1870.0999755859,-2634.3999023438,54},
	{615,-1860.5,-2628.3999023438,54.799999237061},
	{615,-1846.3000488281,-2636.6000976563,54.599998474121},
	{615,-1850.5999755859,-2625.8999023438,55.400001525879},
	{615,-1839,-2623.7001953125,55.5},
	{615,-1827.900390625,-2623.2001953125,54.900001525879},
	{615,-1831.8000488281,-2635.8999023438,54.700000762939},
	{615,-1820.0999755859,-2644.8000488281,54.099998474121},
	{615,-1826.3000488281,-2657.5,53.700000762939},
	{615,-1816.099609375,-2622.7001953125,54},
	{615,-1814.5999755859,-2634.3999023438,53.799999237061},
	{615,-1806.2001953125,-2643.5,53.099998474121},
	{615,-1814.400390625,-2656.099609375,53.700000762939},
	{615,-1804.5,-2625.3999023438,52.599998474121},
	{615,-1792.0999755859,-2631,51.099998474121},
	{615,-1797.8000488281,-2637.6999511719,52.200000762939},
	{615,-1782,-2638,50.099998474121},
	{615,-1800.900390625,-2654.8994140625,53},
	{615,-1789.599609375,-2649.3994140625,52.200000762939},
	{615,-1778,-2650.3999023438,50.700000762939},
}
local HolzfaellerStaemme={
	[1] = {1.1, -2.3, 0.3, 0, 45, 0},
	[2] = {0.5, -2.3, 0.3, 0, 90, 0},
	[3] = {-0.1, -2.3, 0.3, 0, 135, 0},
	[4] = {-0.7, -2.3, 0.3, 0, 180, 0},
	[5] = {-1.0, -2.3, 0.7, 0, 225, 0},
	[6] = {-0.4, -2.3, 0.7, 0, 270, 0},
	[7] = {0.2, -2.3, 0.7, 0, 315, 0},
	[8] = {0.8, -2.3, 0.7, 0, 0, 0},
}

HolzfaellerTruckDespawn={}
HolzfaellerPlayers={}
HolzfaellerVehicles={}
HolzfaellerTimer={}
HolzfaellerStammeTimer={}
HolzfaellerStamme={}
HolzfaellerStammeSawing={}
HolzfaellerStammeSaw=false


function createTreeZones()
	for _,v in pairs(HolzfaellerZones)do
		local x1,y1=tonumber(v[1]),tonumber(v[2])
		local x2,y2=tonumber(v[3]),tonumber(v[4])
		local xs,ys=math.abs(x1-x2),math.abs(y1-y2)
		HolzfaellerZone=createColRectangle(x1,y1,xs,ys)
		
		addEventHandler("onColShapeHit",HolzfaellerZone,function(player)
			if(HolzfaellerPlayers[player]==true)then
				giveWeapon(player,9,1,true)
			end
		end)
		
		addEventHandler("onColShapeLeave",HolzfaellerZone,function(player)
			if(HolzfaellerPlayers[player]==true)then
				takeWeapon(player,9)
			end
		end)
	end
	for i,v in pairs(HolzfaellerTrees)do
		HolzfaellerTree(i,v[1],v[2],v[3],v[4])
	end
end
addEventHandler("onResourceStart",resourceRoot,createTreeZones)


function HolzfaellerTree(id,model,x,y,z)
	if(id and model and x and y and z)then
		local baum=createObject(model,x,y,z,0,0,math.random(0,360))
		local ped=createPed(0,x,y,z,0)
		setElementFrozen(ped,true)
		setElementAlpha(ped,0)
		attachElements(ped,baum)
		setElementData(baum,"baum",true)
		setElementData(ped,"baum",true)
		setElementData(ped,"attached",baum)
		setElementData(ped,"hits",0)
		setElementData(baum,"baumID",id)
		setElementData(ped,"baumID",id)
	end
end


addEvent("start:holzfaeller",true)
addEventHandler("start:holzfaeller",root,function()
	if(syncGetElementData(client,"Job")=="Holzfaeller")then
		if(not(isElement(HolzfaellerVehicles[client])))then
			HolzfaellerPlayers[client]=true
			HolzfaellerVehicles[client]=createVehicle(455,-1989.4,-2384,31.2,0,0,315)
			setElementData(HolzfaellerVehicles[client],"Fuel",100)
			setElementData(HolzfaellerVehicles[client],"Totalloss",0)
			setElementData(HolzfaellerVehicles[client],"veh:holztruck",true)
			setVehicleVariant(HolzfaellerVehicles[client],3,255)
			warpPedIntoVehicle(client,HolzfaellerVehicles[client])
			setElementData(HolzfaellerVehicles[client],"Owner",getPlayerName(client))
			setElementData(HolzfaellerVehicles[client],"OwnerHolztruck",getPlayerName(client))
			setElementData(HolzfaellerVehicles[client],"Staemme",0)
			triggerClientEvent(client,"createHolzMarker",client,"create")
			outputChatBox("Um den Job zu beenden, drücke Numpad 0",client,0,200,0)
			
			addEventHandler("onVehicleExplode",HolzfaellerVehicles[client],function()
				local OwnerHolztruck=getPlayerFromName(getElementData(source,"OwnerHolztruck"))
				HolzfaellerDestroy(OwnerHolztruck)
			end)
			
			addEventHandler("onVehicleEnter",HolzfaellerVehicles[client],function(player)
				if(isElement(HolzfaellerStamme[player]))then
					removePedFromVehicle(player)
					triggerClientEvent(player,"draw:infobox",root,"error","Du kannst mit einem Baumstamm nicht einsteigen!")
				else
					if(getElementData(source,"OwnerHolztruck")~=getPlayerName(player))then
						if(getPedOccupiedVehicleSeat(player)==0)then
							removePedFromVehicle(player)
							triggerClientEvent(player,"draw:infobox",root,"error","Der Transporter gehört dir nicht!")
						end
					end
				end
			end)
			bindKey(client,"num_0","down",HolzfaellerDestroy)
			addEventHandler("onElementClicked",HolzfaellerVehicles[client],HolzfaellerTakeStammFromTruck)
		end
	end
end)
function HolzfaellerTakeStammFromTruck(button,state,player)
	if(button=="left" and state=="down")then
		if(not(isPedInVehicle(player)))then
			local OwnerHolztruck=getElementData(source,"OwnerHolztruck")
			if(OwnerHolztruck==getPlayerName(player))then
				local Staemme=getElementData(HolzfaellerVehicles[player],"Staemme")
				if(Staemme>=1)then
					if(not(isElement(HolzfaellerStamme[player])))then
						for _,v in pairs(getElementsByType("object"))do
							if(getElementModel(v)==684 and getElementData(v,"id")==getElementData(HolzfaellerVehicles[player],"Staemme")and getElementData(v,"OwnerHolztruck")==getPlayerName(player))then
								destroyElement(v)
							end
						end
						setElementData(HolzfaellerVehicles[player],"Staemme",getElementData(HolzfaellerVehicles[player],"Staemme")-1)
						HolzfaellerStamme[player]=createObject(684,-2013.2,-2351.9,31.1,0,0,0)
						setObjectScale(HolzfaellerStamme[player],0.7)
						attachElements(HolzfaellerStamme[player],player,0.4,0,-0.1)
						setElementData(HolzfaellerStamme[player],"baumstamm",true)
						setElementCollisionsEnabled(HolzfaellerStamme[player],false)
						toggleControl(player,"sprint",false)
						if(isPedInVehicle(player))then
							setElementData(getPedOccupiedVehicle(player),"Staemme",getElementData(getPedOccupiedVehicle(player),"Staemme")-1)
						end
						
						HolzfaellerStammeTimer[player]=setTimer(function(player)
							if(isElement(HolzfaellerStamme[player]))then
								if(getDistanceBetweenPoints3D(-2012.6,-2350.2,30.6-1,getElementPosition(player))>=25)then
									HolzfaellerStamme[player]:destroy()
									triggerClientEvent(player,"draw:infobox",root,"error","Du hast dich zu weit vom Sägewerk entfernt!")
									if(isTimer(HolzfaellerStammeTimer[player]))then
										HolzfaellerStammeTimer[player]:destroy()
									end
								end
							end
						end,1000,0,player)
					else
						triggerClientEvent(player,"draw:infobox",root,"error","Du kannst nicht mehr als einen Baumstamm tragen!")
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","Auf deinem Transporter sind keine Baumstämme mehr!")
				end
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Dieser Transporter gehört dir nicht!")
			end
		end
	end
end

addEvent("abgabe:holzfaeller",true)
addEventHandler("abgabe:holzfaeller",root,function()
	if(isPedInVehicle(client))then
		local veh=getPedOccupiedVehicle(client)
		if(getElementData(veh,"veh:holztruck")==true)then
			local Staemme=getElementData(veh,"Staemme")
			if(Staemme>=1)then
				local money=Staemme*1050
				local Stamm=getAttachedElements(veh)
				
				giveJobMoney("Holzfaeller",money)
				
				for _,v in pairs(Stamm)do
					destroyElement(v)
				end
				setElementData(veh,"Staemme",0)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Auf deinem Transporter befinden sich keine Stämme!")
			end
		end
	end
end)

function damageHolzfaellerBaum(ped,attacker)
	if(isElement(ped))then
		if(getElementData(ped,"baum")==true)then
			setElementData(ped,"hits",getElementData(ped,"hits")+1)
			if(getElementData(ped,"hits")>=50)then
				HolzfaellerFalltree(ped,getPlayerName(attacker))
			end
		end
	end
end
addEvent("damage:holzbaum",true)
addEventHandler("damage:holzbaum",root,damageHolzfaellerBaum)

function HolzfaellerFalltree(ped,faeller)
	local baum=getElementData(ped,"attached")
	local x,y,z=getElementPosition(baum)
	moveObject(baum,3500,x,y,z,0,80,0)
	setElementCollisionsEnabled(baum,false)
	local baumID=getElementData(baum,"baumID")
	
	setTimer(function(baum,baumID)
		if(baum)then
			setElementData(baum,"baumOwner",faeller)
			setElementData(baum,"fallen",true)
			setElementCollisionsEnabled(baum,true)
			
			HolzfaellerTimer[baumID]=setTimer(function(baum)
				if(isElement(baum))then
					local baumID=getElementData(baum,"baumID")
					local x,y,z=getElementPosition(baum)
					
					baum:destroy()
					for _,v in pairs(getElementsByType("ped"))do
						if(getElementData(v,"baumID")and getElementData(v,"baumID")==baumID)then
							v:destroy()
						end
					end
					HolzfaellerTree(baumID,615,x,y,z)
				end
			end,3*60*1000,1,baum)
		end
	end,3*1000,1,baum,baumID)
	destroyElement(ped)
end

function HolzfaellerTurnSaw()
	if(HolzfaellerStammeSawing==true)then
		moveObject(HolzfaellerSaw,250,-2015.6,-2349.5,31.3,0,-360,0)
	end
	setTimer(function()
		HolzfaellerTurnSaw()
	end,250,1)
end
addEvent("cut:holzfaeller",true)
addEventHandler("cut:holzfaeller",root,function()
	if(HolzfaellerStammeSaw==false)then
		if(isElement(HolzfaellerStamme[client]))then
			HolzfaellerStammeSaw=true
			toggleControl(client,"sprint",true)
			local Stamm=getAttachedElements(client)
			for _,v in pairs(Stamm)do
				if(getElementData(v,"baumstamm")==true)then
					destroyElement(v)
				end
			end
			HolzfaellerTurnSaw()
			HolzfaellerStamm=createObject(684,-2013.2,-2351.9,31.1,0,0,45)
			setObjectScale(HolzfaellerStamm,0.7)
			setTimer(function(client)
				moveObject(HolzfaellerStamm,30000,-2017.8,-2347.3,31.1,0,0,0)
                setTimer(function(client)
                    moveObject(HolzfaellerStamm,2500,-2018.4,-2346.5,30.5,-14,0,0)
                    setTimer(function(client)
                        HolzfaellerStammeSawing=false
                        HolzfaellerStammeSaw=false
                        destroyElement(HolzfaellerStamm)
						HolzfaellerAddWood(client)
                    end,2700,1,client)
                end,30100,1,client)
                selfmadeHolzfaellerStammeSawing=true
			end,1000,1,client)
			if(isTimer(HolzfaellerStammeTimer[client]))then
				HolzfaellerStammeTimer[client]:destroy()
			end
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","Es wird bereits ein Baustamm bearbeitet!")
	end
end)
function HolzfaellerAddWood(player)
	local wood=math.random(5,10)
	
	triggerClientEvent(player,"draw:infobox",root,"info","Du hast x"..wood.." Holz bekommen.")
	--setElementData(player,"Holz",getElementData(player,"Holz")+wood)
end

function HolzfaellerTakeTree(player)
	local veh=getPedOccupiedVehicle(player)
	if(veh)then
		local Staemme=getElementData(veh,"Staemme")
		if(Staemme<8)then
			local Stamm=createObject(684,0,0,0)
			setObjectScale(Stamm,0.7)
			setElementCollisionsEnabled(Stamm,false)
			local Position=Staemme+1
			local tbl=HolzfaellerStaemme[Position]
			attachElements(Stamm,veh,tbl[1],tbl[2],tbl[3],tbl[4],tbl[5],tbl[6])
			setElementData(Stamm,"OwnerHolztruck",getPlayerName(player))
			setElementData(veh,"Staemme",getElementData(veh,"Staemme")+1)
			setElementData(Stamm,"id",getElementData(veh,"Staemme"))
		end
	end
end

function HolzfaellerRefreshTrees()
	for _,v in pairs(getElementsByType("player"))do
        if(syncGetElementData(v,"Job")=="Holzfaeller")then
			outputChatBox("[Holzfäller]: Bäume respawnt!",v,0,200,0)
        end
    end
    for _,v in pairs(getElementsByType("object"))do
        if(getElementData(v,"baum")==true)then
            v:destroy()
        end
    end
	for _,v in pairs(getElementsByType("ped"))do
		if(getElementData(v,"baum")==true)then
			v:destroy()
		end
	end
	
	for _,v in pairs(HolzfaellerTrees)do
		HolzfaellerTree(615,v[1],v[2],v[3],v[4])
	end
end
setTimer(function()
	local time=getRealTime()
	local hour=time.hour
	local minute=time.minute
	
	if(hour==01 and minute==30)then
		HolzfaellerRefreshTrees()
	elseif(hour==02 and minute==00)then
		HolzfaellerRefreshTrees()
	elseif(hour==02 and minute==30)then
		HolzfaellerRefreshTrees()
	elseif(hour==03 and minute==00)then
		HolzfaellerRefreshTrees()
	elseif(hour==03 and minute==30)then
		HolzfaellerRefreshTrees()
	elseif(hour==04 and minute==00)then
		HolzfaellerRefreshTrees()
	elseif(hour==04 and minute==30)then
		HolzfaellerRefreshTrees()
	elseif(hour==05 and minute==00)then
		HolzfaellerRefreshTrees()
	elseif(hour==05 and minute==30)then
		HolzfaellerRefreshTrees()
	elseif(hour==06 and minute==00)then
		HolzfaellerRefreshTrees()
	elseif(hour==06 and minute==30)then
		HolzfaellerRefreshTrees()
	elseif(hour==07 and minute==00)then
		HolzfaellerRefreshTrees()
	elseif(hour==07 and minute==30)then
		HolzfaellerRefreshTrees()
	elseif(hour==08 and minute==00)then
		HolzfaellerRefreshTrees()
	elseif(hour==08 and minute==30)then
		HolzfaellerRefreshTrees()
	elseif(hour==09 and minute==00)then
		HolzfaellerRefreshTrees()
	elseif(hour==09 and minute==30)then
		HolzfaellerRefreshTrees()
	elseif(hour==10 and minute==00)then
		HolzfaellerRefreshTrees()
	elseif(hour==10 and minute==30)then
		HolzfaellerRefreshTrees()
	elseif(hour==11 and minute==00)then
		HolzfaellerRefreshTrees()
	elseif(hour==11 and minute==30)then
		HolzfaellerRefreshTrees()
	elseif(hour==12 and minute==00)then
		HolzfaellerRefreshTrees()
	elseif(hour==12 and minute==30)then
		HolzfaellerRefreshTrees()
	elseif(hour==13 and minute==00)then
		HolzfaellerRefreshTrees()
	elseif(hour==13 and minute==30)then
		HolzfaellerRefreshTrees()
	elseif(hour==14 and minute==00)then
		HolzfaellerRefreshTrees()
	elseif(hour==14 and minute==30)then
		HolzfaellerRefreshTrees()
	elseif(hour==15 and minute==00)then
		HolzfaellerRefreshTrees()
	elseif(hour==15 and minute==30)then
		HolzfaellerRefreshTrees()
	elseif(hour==16 and minute==00)then
		HolzfaellerRefreshTrees()
	elseif(hour==16 and minute==30)then
		HolzfaellerRefreshTrees()
	elseif(hour==17 and minute==00)then
		HolzfaellerRefreshTrees()
	elseif(hour==17 and minute==30)then
		HolzfaellerRefreshTrees()
	elseif(hour==18 and minute==00)then
		HolzfaellerRefreshTrees()
	elseif(hour==18 and minute==30)then
		HolzfaellerRefreshTrees()
	elseif(hour==19 and minute==00)then
		HolzfaellerRefreshTrees()
	elseif(hour==19 and minute==30)then
		HolzfaellerRefreshTrees()
	elseif(hour==20 and minute==00)then
		HolzfaellerRefreshTrees()
	elseif(hour==20 and minute==30)then
		HolzfaellerRefreshTrees()
	elseif(hour==21 and minute==00)then
		HolzfaellerRefreshTrees()
	elseif(hour==21 and minute==30)then
		HolzfaellerRefreshTrees()
	elseif(hour==22 and minute==00)then
		HolzfaellerRefreshTrees()
	elseif(hour==22 and minute==30)then
		HolzfaellerRefreshTrees()
	elseif(hour==23 and minute==00)then
		HolzfaellerRefreshTrees()
	elseif(hour==23 and minute==30)then
		HolzfaellerRefreshTrees()
	end
end,60*1000,0)



function HolzfaellerDestroy(player)
	if(isElement(HolzfaellerVehicles[player]))then
		HolzfaellerVehicles[player]:destroy()
	end
	if(isElement(HolzfaellerStamme[player]))then
		HolzfaellerStamme[player]:destroy()
	end
	for _,v in pairs(getElementsByType("object"))do
		if(getElementModel(v)==684 and getElementData(v,"OwnerHolztruck")==getPlayerName(player))then
			v:destroy()
			if(isTimer(HolzfaellerTruckDespawn[v]))then
				HolzfaellerTruckDespawn[v]:destroy()
			end
			triggerClientEvent(player,"draw:infobox",root,"info","Holztruck despawnt!")
		end
	end
	if(isTimer(HolzfaellerStammeTimer[player]))then
		HolzfaellerStammeTimer[player]:destroy()
	end
	HolzfaellerPlayers[player]=false
	takeWeapon(player,9)
	unbindKey(player,"num_0","down",HolzfaellerDestroy)
	triggerClientEvent(player,"createHolzMarker",player)
end

addEventHandler("onPlayerQuit",root,function()
	HolzfaellerDestroy(source)
end)
addEventHandler("onPlayerWasted",root,function()
	HolzfaellerDestroy(source)
end)


