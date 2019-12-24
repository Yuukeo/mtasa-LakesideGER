--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

RescueDuty=createPickup(412.6,257.3,996.8,3,1275,50)
setElementInterior(RescueDuty,3)

function openRescueDutyUI(player)
	if(isLoggedin(player))then
		if(isRESCUETEAM(player))then
			triggerClientEvent(player,"open:rescueUI",player)
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Du bist kein Mitarbeiter vom Rescue Team!")
		end
	end
end
addEventHandler("onPickupHit",RescueDuty,openRescueDutyUI)


function goRescueTeamOnOffDuty(typ)
	if(isLoggedin(client))then
		if(typ=="Onduty")then
			if(isRESCUETEAM(client))then
				if(syncGetElementData(client,"RescueDuty")==false)then
					syncSetElementData(client,"RescueDuty",true)
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast den Dienst betreten!")
					if(syncGetElementData(client,"Gender")=="Male")then
						setElementModel(client,274)
					elseif(syncGetElementData(client,"Gender")=="Female")then
						setElementModel(client,276)
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du bist bereits im Dienst!")
				end
			end
		elseif(typ=="Offduty")then
			if(syncGetElementData(client,"RescueDuty")==true)then
				setElementModel(client,syncGetElementData(client,"SkinID"))
				takeAllWeapons(client)
				syncSetElementData(client,"RescueDuty",false)
				triggerClientEvent(client,"draw:infobox",root,"success","Du hast den Dienst verlassen!")
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du bist nicht im Dienst!")
			end
		end
	end
end
addEvent("go:rescueonoffduty",true)
addEventHandler("go:rescueonoffduty",root,goRescueTeamOnOffDuty)




m_pick={}
m_mark={}
m_blip={}

function checkIfMedicRespawn(client)
	local pname=getPlayerName(client)
	if(isElement(m_pick[pname]))then
		m_pick[pname]:destroy()
	end
	if(isElement(m_mark[pname]))then
		m_mark[pname]:destroy()
	end
	if(isElement(m_blip[pname]))then
		m_blip[pname]:destroy()
	end
	
	if(getElementInterior(client)==0)then
		if(tonumber(syncGetElementData(client,"Jailtime"))==0)then
			local x,y,z=getElementPosition(client)
			local r,g,b=math.random(0,255),math.random(0,255),math.random(0,255)
			
			m_pick[pname]=createPickup(x,y,z,3,1240,1000)
			m_mark[pname]=createMarker(x,y,z,"corona",1.0,0,0,0,0)
			m_blip[pname]=createBlip(x,y,z,0,2,r,g,b,255,0,99999,root)
			
			local zonename1=getZoneName(x,y,z,false)
			local zonename2=getZoneName(x,y,z,true)
			
			setElementVisibleTo(m_blip[pname],root,false)
			
			for i,v in pairs(getElementsByType("player"))do
				if(isLoggedin(v))then
					if(getCompanyMembersOnline(3)>=1)then
						if(isRESCUETEAM(v)and syncGetElementData(v,"RescueDuty")==true)then
							setElementVisibleTo(m_blip[pname],v,true)
							outputChatBox("[INFO]: Toter in "..zonename1..", "..zonename2.." gemeldet.",v,0,200,0)
						end
					end
				end
			end
			addEventHandler("onMarkerHit",m_mark[pname],medicOnMarkerHitRevive)
		end
	end
end

local reviveTimer={}
local function revivePlayer(player,target)
	if(isPedDead(target))then
		local x,y,z=getElementPosition(player)
		reviveTimer[player]=setTimer(function(player,target)
			triggerClientEvent("stop:hospitaltime",target)
			setCameraTarget(target)
			spawnPlayer(target,x,y,z,0,syncGetElementData(target,"SkinID"),0,0)
			gotLastHit[target]=0
			setPedHeadless(target,false)
			setElementHealth(target,50)
			syncSetElementData(target,"Hunger",25)
			
			syncSetElementData(player,"Jobmoney",tonumber(syncGetElementData(player,"Jobmoney"))+200)
			
			local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","companydepots","Company",tonumber(syncGetElementData(player,"Company"))),-1)
			if(result and result[1])then
				handler:exec("UPDATE ?? SET ??=? WHERE ??=?","companydepots","Money",tonumber(result[1]["Money"])+100,"Company",tonumber(syncGetElementData(player,"Company")))
			end
			
			outputChatBox("Du wurdest von Sanitäter "..getPlayerName(player).." wieder ins Leben gerufen!",target,0,200,0)
			outputChatBox("Du hast "..getPlayerName(target).." wiederbelebt und erhälst $200 beim Payday!",player,0,200,0)
		end,2000,1,player,target)
	end
end
function medicOnMarkerHitRevive(elem)
	if(getElementType(elem)=="player")then
		if(isRESCUETEAM(elem)and syncGetElementData(elem,"RescueDuty")==true)then
			if(getElementHealth(elem)>0)then
				local pname=nil
				for i,v in pairs(m_mark)do
					if(v==source)then
						pname=i
						local target=getPlayerFromName(i)
						if(isElement(target))then
							toggleAllControls(elem,false)
							setPedAnimation(elem,"MEDIC","CPR",-1,true,false,false)
							setTimer(function(player,target)
								if(isElement(player))then
									setPedAnimation(player)
									toggleAllControls(player,true)
								end
								revivePlayer(player,target)
							end,5000,1,elem,target)
						end
						break
					end
				end
				m_mark[pname]:destroy()
				m_pick[pname]:destroy()
				m_blip[pname]:destroy()
			end
		end
	end
end


addEventHandler("onPlayerQuit",root,function()
	local pname=getPlayerName(source)
	if(isElement(m_mark[pname]))then
		m_mark[pname]:destroy()
	end
	if(isElement(m_pick[pname]))then
		m_pick[pname]:destroy()
	end
	if(isElement(m_blip[pname]))then
		m_blip[pname]:destroy()
	end
end)