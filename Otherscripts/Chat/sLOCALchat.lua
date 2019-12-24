--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEventHandler("onPlayerPrivateMessage",root,
function()
    cancelEvent()
end)

function localChat(message,messageTyp)
	if(isLoggedin(source))then
		if(not isPedDead(source))then
			if(tonumber(syncGetElementData(source,"Mutedtime"))==0)then
				if(messageTyp==0)then
					local x,y,z=getElementPosition(source)
					local interior=getElementInterior(source)
					local dimension=getElementDimension(source)
					local pname=getPlayerName(source)
					
					local nearbyPlayers=getElementsByType("player")
					for _,v in ipairs(nearbyPlayers)do
						if(isLoggedin(v))then
							local vx,vy,vz=getElementPosition(v)
							local vinterior=getElementInterior(v)
							local vdimension=getElementDimension(v)
							
							if(interior==vinterior and dimension==vdimension)then
								if(getDistanceBetweenPoints3D(x,y,z,vx,vy,vz)<=10)then
									if(isElement(getElementData(source,"callswith")))then
										outputChatBox(pname.." am Handy: "..message,v,255,255,255)
									else
										outputChatBox(pname.." sagt: "..message,v,255,255,255)
									end
								end
							end
						end
					end
					if(isElement(getElementData(source,"callswith")))then
						local target=getElementData(source,"callswith")
						outputChatBox("[Handy] "..pname.." sagt: "..message,target,255,255,255)
						outputLog("[Handy] "..pname.." sagt: "..message,"Chat")
					else
						outputLog(pname.." sagt: "..message,"Chat")
					end
				elseif(messageTyp==1)then
					local x,y,z=getElementPosition(source)
					local interior=getElementInterior(source)
					local dimension=getElementDimension(source)
					local pname=getPlayerName(source)
					
					local nearbyPlayers=getElementsByType("player")
					for _,v in ipairs(nearbyPlayers)do
						if(isLoggedin(v))then
							local vx,vy,vz=getElementPosition(v)
							local vinterior=getElementInterior(v)
							local vdimension=getElementDimension(v)
							
							if(getDistanceBetweenPoints3D(x,y,z,vx,vy,vz)<=16)then
								if(interior==vinterior and dimension==vdimension)then
									outputChatBox("✪ "..pname..": "..message,v,230,25,140)
								end
							end
						end
					end
					outputLog("✪ "..pname..": "..message,"Chat")
				elseif(messageTyp==2)then
					executeCommandHandler("t",source,message)
				end
			else
				triggerClientEvent(source,"draw:infobox",root,"error","Du bist gemuted! ("..tonumber(syncGetElementData(source,"Mutedtime")).." Minuten)")
			end
		end
	end
	cancelEvent()
end
addEventHandler("onPlayerChat",root,localChat)

function schreiChat(player,cmd,...)
    if(isLoggedin(player))then
        if(...)then
            if(tonumber(syncGetElementData(player,"Mutedtime"))==0)then
				if(not isPedDead(player))then
					local x,y,z=getElementPosition(player)
					local int=getElementInterior(player)
					local dim=getElementDimension(player)
					
					local nearbyPlayers=getElementsByType("player")
					
					for _,v in ipairs(nearbyPlayers)do
						if(isLoggedin(v))then
							local vx,vy,vz=getElementPosition(v)
							local vint=getElementInterior(v)
							local vdim=getElementDimension(v)
							
							if(getDistanceBetweenPoints3D(x,y,z,vx,vy,vz)<=18)then
								if(int==vint and dim==vdim)then
									outputChatBox(getPlayerName(player).." schreit: "..stringTextWithAllParameters(...),v,200,200,200)
								end
							end
						end
					end
					outputLog(getPlayerName(player).." schreit: "..stringTextWithAllParameters(...),"Chat")
                end
            else
                triggerClientEvent(player,"draw:infobox",root,"error","Du bist gemuted! ("..tonumber(syncGetElementData(player,"Mutedtime")).." Minuten)")
            end
        end
    end
end
addCommandHandler("s",schreiChat)


function mChat(player,cmd,...)
    if(isLoggedin(player))then
        if(...)then
			local veh=getPedOccupiedVehicle(player)
			if(veh)then
				local id=getElementModel(veh)
				if(syncGetElementData(player,"CopDuty")==true)then
					if(id==433 or id==427 or id==490 or id==528 or id==470 or id==596 or id==597 or id==598 or id==599 or id==601)then
						if(tonumber(syncGetElementData(player,"Mutedtime"))==0)then
							local x,y,z=getElementPosition(player)
							local int=getElementInterior(player)
							local dim=getElementDimension(player)
									
							for _,v in ipairs(getElementsByType("player"))do
								if(isLoggedin(v))then
									local vx,vy,vz=getElementPosition(v)
									local vint=getElementInterior(v)
									local vdim=getElementDimension(v)
									
									if(getDistanceBetweenPoints3D(x,y,z,vx,vy,vz)<=30)then
										if(int==vint and dim==vdim)then
											outputChatBox("["..settings.faction.ranknames[tonumber(syncGetElementData(player,"Faction"))][tonumber(syncGetElementData(player,"Factionrank"))].."] "..getPlayerName(player):gsub("_"," ")..": "..stringTextWithAllParameters(...),v,255,255,0)
										end
									end
								end
							end
						else
							triggerClientEvent(player,"draw:infobox",root,"error","Du bist gemuted! ("..tonumber(syncGetElementData(player,"Mutedtime")).." Minuten)")
						end
					end
				end
			end
        end
    end
end
addCommandHandler("m",mChat)
addCommandHandler("megaphone",mChat)

function meCMD_func(player,cmd,...)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"Mutedtime"))==0)then
			local x,y,z=getElementPosition(player)
			local int=getElementInterior(player)
			local dim=getElementDimension(player)
			
			if(not isPedDead(player))then
				for _,v in ipairs(getElementsByType("player"))do
					if(isLoggedin(v))then
						local vx,vy,vz=getElementPosition(v)
						local vint=getElementInterior(v)
						local vdim=getElementDimension(v)
						if(getDistanceBetweenPoints3D(x,y,z,vx,vy,vz)<=18)then
							if(int==vint and dim==vdim)then
								outputChatBox("✪ "..getPlayerName(player)..": "..stringTextWithAllParameters(...),v,230,25,140)
							end
						end
					end
				end
				outputLog("[ME-CHAT] "..getPlayerName(player)..": "..stringTextWithAllParameters(...),"Chat")
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Du bist gemuted! ("..tonumber(syncGetElementData(player,"Mutedtime")).." Minuten)")
		end
	end
end
addCommandHandler("meCMD",meCMD_func)