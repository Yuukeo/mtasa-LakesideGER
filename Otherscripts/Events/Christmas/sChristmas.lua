--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local xmasObjectList={
	{3861,1487.7,-1709.2,14.2,0,0,270},
	{2513,1487,-1708.2,13.95,0,0,300},
	{2474,1486.8,-1709.6,13.84,0,0,20},
}
local XMASpedTable={
	{256,1488.1,-1709.2,14.1,90,"Christmas1_PED","Madeleine Elliott [NPC]","Christmas"},
}

if(settings.general.christmas==true)then
	local christmasQuest=createPickup(1487.1,-1712.2,14.1,3,1239,50)

	addEventHandler("onPickupHit",christmasQuest,function(player)
		if(isLoggedin(player))then
			triggerClientEvent(player,"open:christmasQuestUI",player)
		end
	end)
end

addEventHandler("onResourceStart",resourceRoot,function()
	if(settings.general.christmas==true)then
		local XMASobject={}
		for i,v in pairs(xmasObjectList)do
			XMASobject[i]=createObject(v[1],v[2],v[3],v[4],v[5],v[6],v[7])
			setElementDoubleSided(XMASobject[i],true)
		end
	end
end)

addEventHandler("onResourceStart",resourceRoot,function()
	if(settings.general.christmas==true)then
		local XmasPeds={}
		for i,v in pairs(XMASpedTable)do
			if(#XMASpedTable>=1)then
				XmasPeds[i]=createPed(v[1],v[2],v[3],v[4],v[5])
				setElementData(XmasPeds[i],"dontdamagePED",true)
				
				if(v[6]=="Christmas1_PED")then
					setElementData(XmasPeds[i],"Christmas1PED",true)
				end
				
				
				if(v[7])then
					setElementData(XmasPeds[i],"set:pedtext",v[7])
				end
				if(v[8])then
					setElementData(XmasPeds[i],"set:peddescription",v[8])
				end
			end
		end
	end
end)

function getChristmasPresent(typ)
	if(settings.general.christmas==true)then
		if(typ=="1")then
			if(tonumber(syncGetElementData(client,"Adventstate"..typ..""))==0)then
				local rdm=math.random(1,2)
				syncSetElementData(client,"Adventstate"..typ.."",1)
				syncSetElementData(client,"Geschenk",tonumber(syncGetElementData(client,"Geschenk"))+rdm)
				triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..rdm.." Geschenk(e)!")
			end
		elseif(typ=="2")then
			if(tonumber(syncGetElementData(client,"Adventstate"..typ..""))==0)then
				local rdm=math.random(1,3)
				syncSetElementData(client,"Adventstate"..typ.."",1)
				syncSetElementData(client,"Zuckerstange",tonumber(syncGetElementData(client,"Zuckerstange"))+rdm)
				triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..rdm.." Zuckerstange(n)!")
			end
		elseif(typ=="3")then
			if(tonumber(syncGetElementData(client,"Adventstate"..typ..""))==0)then
				local rdm=math.random(1000,6000)
				syncSetElementData(client,"Adventstate"..typ.."",1)
				syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))+rdm)
				triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst $"..rdm.."!")
			end
		elseif(typ=="4")then
			if(tonumber(syncGetElementData(client,"Adventstate"..typ..""))==0)then
				local rdm=math.random(1,2)
				syncSetElementData(client,"Adventstate"..typ.."",1)
				syncSetElementData(client,"TicketBronze",tonumber(syncGetElementData(client,"TicketBronze"))+rdm)
				triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..rdm.." Bronzeticket(s)!")
			end
		elseif(typ=="5")then
			if(tonumber(syncGetElementData(client,"Adventstate"..typ..""))==0)then
				local rdm=math.random(1,5)
				syncSetElementData(client,"Adventstate"..typ.."",1)
				syncSetElementData(client,"Zuckerstange",tonumber(syncGetElementData(client,"Zuckerstange"))+rdm)
				triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..rdm.." Zuckerstange(n)!")
			end
		elseif(typ=="6")then
			if(tonumber(syncGetElementData(client,"Adventstate"..typ..""))==0)then
				local rdm=math.random(1,3)
				syncSetElementData(client,"Adventstate"..typ.."",1)
				syncSetElementData(client,"TicketBronze",tonumber(syncGetElementData(client,"TicketBronze"))+rdm)
				triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..rdm.." Bronzeticket(s)!")
			end
		elseif(typ=="7")then
			if(tonumber(syncGetElementData(client,"Adventstate"..typ..""))==0)then
				local rdm=math.random(1,3)
				syncSetElementData(client,"Adventstate"..typ.."",1)
				syncSetElementData(client,"TicketSilver",tonumber(syncGetElementData(client,"TicketSilver"))+rdm)
				triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..rdm.." Silberticket(s)!")
			end
		elseif(typ=="8")then
			if(tonumber(syncGetElementData(client,"Adventstate"..typ..""))==0)then
				local rdm=math.random(8000,16000)
				syncSetElementData(client,"Adventstate"..typ.."",1)
				syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))+rdm)
				triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst $"..rdm.."!")
			end
		elseif(typ=="9")then
			if(tonumber(syncGetElementData(client,"Adventstate"..typ..""))==0)then
				local rdm=math.random(1,3)
				syncSetElementData(client,"Adventstate"..typ.."",1)
				syncSetElementData(client,"Benzinkanister",tonumber(syncGetElementData(client,"Benzinkanister"))+rdm)
				triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..rdm.." Benzinkanister!")
			end
		elseif(typ=="10")then
			if(tonumber(syncGetElementData(client,"Adventstate"..typ..""))==0)then
				local rdm=math.random(1,6)
				syncSetElementData(client,"Adventstate"..typ.."",1)
				syncSetElementData(client,"Weste",tonumber(syncGetElementData(client,"Weste"))+rdm)
				triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..rdm.." Weste!")
			end
		elseif(typ=="11")then
			if(tonumber(syncGetElementData(client,"Adventstate"..typ..""))==0)then
				local rdm=math.random(10,60)
				syncSetElementData(client,"Adventstate"..typ.."",1)
				syncSetElementData(client,"Hanfsamen",tonumber(syncGetElementData(client,"Hanfsamen"))+rdm)
				triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..rdm.." Hanfsame(n)!")
			end
		elseif(typ=="12")then
			if(tonumber(syncGetElementData(client,"Adventstate"..typ..""))==0)then
				local rdm=math.random(1,3)
				syncSetElementData(client,"Adventstate"..typ.."",1)
				syncSetElementData(client,"Geschenk",tonumber(syncGetElementData(client,"Geschenk"))+rdm)
				triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..rdm.." Geschenk(e)!")
			end
		elseif(typ=="13")then
			if(tonumber(syncGetElementData(client,"Adventstate"..typ..""))==0)then
				local rdm=math.random(1,2)
				syncSetElementData(client,"Adventstate"..typ.."",1)
				syncSetElementData(client,"TicketBronze",tonumber(syncGetElementData(client,"TicketBronze"))+rdm)
				triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..rdm.." Bronzeticket(s)!")
			end
		elseif(typ=="14")then
			if(tonumber(syncGetElementData(client,"Adventstate"..typ..""))==0)then
				local rdm=math.random(5000,20000)
				syncSetElementData(client,"Adventstate"..typ.."",1)
				syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))+rdm)
				triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst $"..rdm.."!")
			end
		elseif(typ=="15")then
			if(tonumber(syncGetElementData(client,"Adventstate"..typ..""))==0)then
				local rdm=math.random(5000,15000)
				syncSetElementData(client,"Adventstate"..typ.."",1)
				syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))+rdm)
				triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst $"..rdm.."!")
			end
		elseif(typ=="16")then
			if(tonumber(syncGetElementData(client,"Adventstate"..typ..""))==0)then
				local rdm=math.random(10,40)
				syncSetElementData(client,"Adventstate"..typ.."",1)
				syncSetElementData(client,"Kokain",tonumber(syncGetElementData(client,"Kokain"))+rdm)
				triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..rdm.." Kokain!")
			end
		elseif(typ=="17")then
			if(tonumber(syncGetElementData(client,"Adventstate"..typ..""))==0)then
				local rdm=math.random(10,50)
				syncSetElementData(client,"Adventstate"..typ.."",1)
				syncSetElementData(client,"Hanfsamen",tonumber(syncGetElementData(client,"Hanfsamen"))+rdm)
				triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..rdm.." Hanfsame(n)!")
			end
		elseif(typ=="18")then
			if(tonumber(syncGetElementData(client,"Adventstate"..typ..""))==0)then
				local rdm=math.random(1,4)
				syncSetElementData(client,"Adventstate"..typ.."",1)
				syncSetElementData(client,"Repairkit",tonumber(syncGetElementData(client,"Repairkit"))+rdm)
				triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..rdm.." Repairkit(s)!")
			end
		elseif(typ=="19")then
			if(tonumber(syncGetElementData(client,"Adventstate"..typ..""))==0)then
				local rdm=math.random(4,12)
				syncSetElementData(client,"Adventstate"..typ.."",1)
				syncSetElementData(client,"Burger",tonumber(syncGetElementData(client,"Burger"))+rdm)
				triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..rdm.." Burger!")
			end
		elseif(typ=="20")then
			if(tonumber(syncGetElementData(client,"Adventstate"..typ..""))==0)then
				local rdm=math.random(1,2)
				syncSetElementData(client,"Adventstate"..typ.."",1)
				syncSetElementData(client,"Geschenk",tonumber(syncGetElementData(client,"Geschenk"))+rdm)
				triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..rdm.." Geschenk(e)!")
			end
		elseif(typ=="21")then
			if(tonumber(syncGetElementData(client,"Adventstate"..typ..""))==0)then
				local rdm=math.random(100,9000)
				syncSetElementData(client,"Adventstate"..typ.."",1)
				syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))+rdm)
				triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst $"..rdm.."!")
			end
		elseif(typ=="22")then
			if(tonumber(syncGetElementData(client,"Adventstate"..typ..""))==0)then
				local rdm=math.random(1,2)
				syncSetElementData(client,"Adventstate"..typ.."",1)
				syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))+rdm)
				triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst $"..rdm.."!")
			end
		elseif(typ=="23")then
			if(tonumber(syncGetElementData(client,"Adventstate"..typ..""))==0)then
				local rdm=math.random(1,7)
				syncSetElementData(client,"Adventstate"..typ.."",1)
				syncSetElementData(client,"Zuckerstange",tonumber(syncGetElementData(client,"Zuckerstange"))+rdm)
				triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..rdm.." Zuckerstange(n)!")
			end
		elseif(typ=="24")then
			if(tonumber(syncGetElementData(client,"Adventstate"..typ..""))==0)then
				local rdm=math.random(1,3)
				syncSetElementData(client,"Adventstate"..typ.."",1)
				syncSetElementData(client,"Zuckerstange",tonumber(syncGetElementData(client,"Zuckerstange"))+rdm)
				triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..rdm.." Zuckerstange(n)!")
			end
		end
	end
end
addEvent("get:christmasPresent",true)
addEventHandler("get:christmasPresent",root,getChristmasPresent)