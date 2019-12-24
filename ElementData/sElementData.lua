--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo) & Bonus        ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

elementData={}
local syncDataToClient={
--//Christmas
["Adventstate1"]=true,
["Adventstate2"]=true,
["Adventstate3"]=true,
["Adventstate4"]=true,
["Adventstate5"]=true,
["Adventstate6"]=true,
["Adventstate7"]=true,
["Adventstate8"]=true,
["Adventstate9"]=true,
["Adventstate10"]=true,
["Adventstate11"]=true,
["Adventstate12"]=true,
["Adventstate13"]=true,
["Adventstate14"]=true,
["Adventstate15"]=true,
["Adventstate16"]=true,
["Adventstate17"]=true,
["Adventstate18"]=true,
["Adventstate19"]=true,
["Adventstate20"]=true,
["Adventstate21"]=true,
["Adventstate22"]=true,
["Adventstate23"]=true,
["Adventstate24"]=true,

--//Inventory
["Apfel"]=true,
["Apfelsamen"]=true,
["Burger"]=true,
["Pizza"]=true,
["Zuckerstange"]=true,
["Cola"]=true,
["ChestWood"]=true,
["ChestIron"]=true,
["Zigarette"]=true,
["TicketBronze"]=true,
["TicketSilver"]=true,
["TicketGold"]=true,
["Repairkit"]=true,
["Mobilephone"]=true,
["Fahrzeugschlüssel"]=true,
["Kokain"]=true,
["Weed"]=true,
["Mats"]=true,
["Hanfsamen"]=true,
["Weste"]=true,
["Spitzhacke"]=true,
["Mondstein"]=true,
["Geschenk"]=true,
["Fishingrod"]=true,
["Fishinghook"]=true,
["Köder"]=true,
["Ausweis"]=true,
["Forelle"]=true,
["Benzinkanister"]=true,
["Barrikade"]=true,
["Brechstange"]=true,
["Tablet"]=true,

--//Userdata
["Bankmoney"]=true,
["Gender"]=true,
["Bankpin"]=true,
["Mutedtime"]=true,
["CarLicense"]=true,
["BikeLicense"]=true,
["CarLicensePoints"]=true,
["BikeLicensePoints"]=true,
["GunLicense"]=true,
["Vehicleslots"]=true,
["Jobmoney"]=true,
["Housekey"]=true,
["Task"]=true,
["IntroCompleted"]=true,
["Job"]=true,
["BirthDate"]=true,
["Jailtime"]=true,
["Note"]=true,
["Weeklytime"]=true,

--//Userlevel
["Joblevel"]=true,
["Jobexp"]=true,

--//Userstats
["Kills"]=true,
["Deaths"]=true,
["GangwarRounds"]=true,
["GangwarWins"]=true,
["GangwarLoses"]=true,
["GangwarKills"]=true,
["GangwarDeaths"]=true,
["GangwarDamageGemacht"]=true,
["GangwarDamageBekommen"]=true,

--//Usersettings
["PhoneModel"]=true,
["PhoneBackground"]=true,
["PhoneState"]=true,
["Radar"]=true,
["Snowshader"]=true,
["Blurshader"]=true,
["Autologin"]=true,
["Hitglocke"]=true,
["PhoneRightone"]=true,

--//Other
--["CopDuty"]=true,
--["MechTowDuty"]=true,
--["DrivingschoolDuty"]=true,
--["RescueDuty"]=true,
}

local syncDataNotToClient={

--//Userdata
["SpawnX"]=true,
["SpawnY"]=true,
["SpawnZ"]=true,
["SpawnROT"]=true,
["SpawnINT"]=true,
["SpawnDIM"]=true,
["UID"]=true,
["curIntIn"]=true,




["lasthp"]=true,
}


function syncSetElementData(player,dataString,value)
	if(player and dataString and value~=nil)then	
		if(not elementData[player])then
			elementData[player]={}
		end
		elementData[player][dataString]=value
		if(dataString=="Money")then
			local value=math.floor(value)
			triggerClientEvent(player,"sync:money",player,value)
			setElementData(player,dataString,value,true)
			elementData[player][dataString]=value
		elseif(syncDataToClient[dataString])then
			triggerClientEvent(player,"trigger:clientData",player,dataString,value)
		elseif(not syncDataNotToClient[dataString] and isElement(player))then
			setElementData(player,dataString,value)
		end
	else
		return nil
	end
end

function syncGetElementData(player,dataString)
	if(player and dataString)then
		if(not elementData[player])then
			elementData[player]={}
		end
		if(elementData[player][dataString])then
			return elementData[player][dataString]
		elseif(not elementData[player][dataString] and dataString~="AdminLvL" and dataString~="Loggedin" and not syncDataNotToClient[dataString])then
			elementData[player][dataString]=getElementData(player,dataString)
			return elementData[player][dataString]
		else
			return nil
		end
	else
		return nil
	end
end

function freeElementData()
	if(elementData)then
		if(getElementType(source)~="player")then
			if(elementData[source])then
				elementData[source]=nil
			end
		end
	end
end
addEventHandler("onElementDestroy",root,freeElementData)

addEvent("change:clientData",true)
addEventHandler("change:clientData",root,function(dataString,value)
	elementData[client][dataString]=value
end)