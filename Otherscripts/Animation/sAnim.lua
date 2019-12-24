--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local animationListTable={
	["Händehoch"]={"shop","SHP_HandsUp_Scr",-1,false,true,true,nil,nil},
	["Winken"]={"ON_LOOKERS","wave_loop",-1,true,false,true,nil,nil},
	["Fuck you"]={"ped","fucku",-1,true,true,true,nil,nil},
	["Lachen"]={"rapping","Laugh_01",-1,true,false,true,nil,nil},
	["Etwas zeigen"]={"on_lookers","point_loop",-1,true,false,true,nil,nil},
	["Arme verschränken"]={"cop_ambient","Coplook_loop",-1,true,false,true,nil,nil},
	["Masturbieren"]={"PAULNMAC","wank_loop",-1,true,false,true,nil,nil},
	["Tanzen orientalisch"]={"DANCING","dnce_M_a",-1,true,false,true,nil,nil},
	["Tanzen chillig"]={"DANCING","dnce_M_b",-1,true,false,true,nil,nil},
	["Tanzen rhythmisch"]={"DANCING","dnce_M_d",-1,true,false,false,nil,nil},
	["Tanzen wild"]={"DANCING","dnce_M_e",-1,true,false,false,nil,nil},
	["Tanzen HipHop"]={"DANCING","dance_loop",-1,true,false,false,nil,nil},
	["Tanzen sexy"]={"STRIP","STR_Loop_A",-1,true,false,false,nil,nil},
	["Tanzen nuttig"]={"STRIP","STR_Loop_B",-1,true,false,false,nil,nil},
	["Tanzen strip 1"]={"STRIP","STR_Loop_C",-1,true,false,false,nil,nil},
	["Tanzen strip 2"]={"STRIP","strip_d",-1,true,false,false,nil,nil},
}
local playerAnimTimer={}

addEvent("start:animation",true)
addEventHandler("start:animation",root,function(anim)
	if(not isTimer(ATMrobTimer[client])and not isTimer(GangtagPlayerTimer[client])and not isTimer(TazerTimer[client])and not isTimer(FallingOutofVehicleTimer[client]))then
		if(pizzaLoaded[client]==false or pizzaLoaded[client]==nil)then
			if(animationListTable[anim])then
				if(not(isPedInVehicle(client)))then
					playerAnimTimer[client]=true
					setPedAnimation(client,animationListTable[anim][1],animationListTable[anim][2],animationListTable[anim][3],animationListTable[anim][4],animationListTable[anim][5],animationListTable[anim][6],animationListTable[anim][7],animationListTable[anim][8])
					bindKey(client,"space","down",stopPlayerAnimation)
				end
			end
		else
			triggerClientEvent(client,"draw:infobox",root,"error","Du kannst keine Animation ausführen\nda du eine Pizza hast!")
		end
	end
end)

function stopPlayerAnimation(player)
	if(playerAnimTimer[player]==true)then
		playerAnimTimer[player]=nil
		setPedAnimation(player)
		unbindKey(player,"space","down",stopPlayerAnimation)
	end
end