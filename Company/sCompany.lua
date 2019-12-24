--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function isMECHTOW(player)
	if(tonumber(syncGetElementData(player,"Company"))==1)then
		return true
	else
		return false
	end
end
function isDRIVINGSCHOOL(player)
	if(tonumber(syncGetElementData(player,"Company"))==2)then
		return true
	else
		return false
	end
end
function isRESCUETEAM(player)
	if(tonumber(syncGetElementData(player,"Company"))==3)then
		return true
	else
		return false
	end
end

function sendMSGForCompany(text,id,r,g,b)
	if(not r)then r,g,b=255,255,255 end
	for _,v in ipairs(getElementsByType("player"))do
		if(tonumber(syncGetElementData(v,"Company"))==id)then
			outputChatBox(text,v,r,g,b,true)
		end
	end
end


function getCompanyMembersOnline(id)
	local counter=0
	for _,v in pairs(getElementsByType("player"))do
		if(tonumber(syncGetElementData(v,"Company"))==id)then
			counter=counter+1
		end
	end
	return counter
end



function respawnCompanyVehicles()
	local company=tonumber(syncGetElementData(client,"Company"))
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","companydepots","Company",company),-1)
	if(result or result[1])then
		if(tonumber(result[1]["Money"])>=tonumber(2500))then
			if(company~=0)then
				for i,v in ipairs(getElementsByType("vehicle"))do
					if(not getVehicleOccupant(v))then
						if(getElementData(v,"Owner")==company)then
							destroyElement(v)
							loadCompanyVehicles(company)
						end
					end
				end
				triggerClientEvent(client,"draw:infobox",root,"success","Unternehmensfahrzeuge erfolgreich respawnt!")
				handler:exec("UPDATE ?? SET ??=? WHERE ??=?","companydepots","Money",tonumber(result[1]["Money"])-2500,"Company",company)
			end
		else
			triggerClientEvent(client,"draw:infobox",root,"error","Es ist nicht genug Geld in der Kasse! ($2500)")
		end
	end
end
addEvent("respawn:companyvehicles",true)
addEventHandler("respawn:companyvehicles",root,respawnCompanyVehicles)






