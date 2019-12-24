--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local interactionTable={
	["Items"]={
		["Pizza"]="Pizza",
		["Burger"]="Burger",
		["Apfel"]="Apfel",
		["Cola"]="Cola",
		["Weed"]="Weed",
		["Kokain"]="Kokain",
		["Mats"]="Mats",
		["Apfelsamen"]="Apfelsamen",
		["Hanfsamen"]="Hanfsamen",
		["Weste"]="Weste",
		["Benzinkanister"]="Benzinkanister",
	},
	["License"]={
		[1]={"Ausweis","Ausweis"},
		[1]={"GunLicense","Waffenschein"},
		[2]={"CarLicense","Auto-Führerschein"},
		[3]={"BikeLicense","Motorrad-Führerschein"},
	},
}

addEvent("show:license",true)
addEventHandler("show:license",root,function()
	local target=getPlayerFromName(getElementData(client,"set:clickedplayer"))
	if(isElement(target)and isLoggedin(target))then
		outputChatBox("Du hast "..getPlayerName(target).." deine Lizenzen gezeigt.",client,0,255,0)
		outputChatBox("Lizenzen von "..getPlayerName(client)..":",target,255,255,255)
		for i=1,#interactionTable["License"] do
			if(tonumber(syncGetElementData(client,interactionTable["License"][i][1]))==1)then
				outputChatBox(interactionTable["License"][i][2]..": Vorhanden",target,0,150,0)
			else
				outputChatBox(interactionTable["License"][i][2]..": Nicht-Vorhanden",target,150,0,0)
			end
		end
	end
end)
addEvent("show:note",true)
addEventHandler("show:note",root,function()
	local target=getPlayerFromName(getElementData(client,"set:clickedplayer"))
	if(isElement(target)and isLoggedin(target))then
		outputChatBox("Du hast "..getPlayerName(target).." deine Note gezeigt.",client,0,255,0)
		outputChatBox("Note von "..getPlayerName(client)..": "..syncGetElementData(target,"Note").."%",target,255,255,255)
	end
end)

addEvent("give:itemstouser",true)
addEventHandler("give:itemstouser",root,function(item,amount)
	local target=getPlayerFromName(getElementData(client,"set:clickedplayer"))
	local x,y,z=getElementPosition(client)
	local x1,y1,z1=getElementPosition(target)
	
	if(getDistanceBetweenPoints3D(x,y,z,x1,y1,z1)<=5)then
		if(syncGetElementData(client,"CopDuty")==false)then
			if(tonumber(syncGetElementData(client,interactionTable["Items"][item]))>=tonumber(amount))then
				syncSetElementData(client,interactionTable["Items"][item],syncGetElementData(client,interactionTable["Items"][item])-amount)
				syncSetElementData(target,interactionTable["Items"][item],syncGetElementData(target,interactionTable["Items"][item])+amount)
				outputChatBox("Du gibst "..getPlayerName(target).." "..item .." x"..amount..".",client,0,200,0)
				outputChatBox(getPlayerName(client).." gibt dir "..item.." x"..amount..".",target,0,200,0)
			end
		end
	end
end)