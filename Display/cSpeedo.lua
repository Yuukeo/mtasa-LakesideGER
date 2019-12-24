--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

speedo_blinker_r=false
speedo_blinker_l=false

function drawSpeedo()
	if(isPedInVehicle(lp))then
		if(isPlayerMapVisible(lp)~=true)then
			if(getElementData(lp,"InTuninggarage")==false)then
				if(getElementData(lp,"InPTuninggarage")==false)then
					local veh=getPedOccupiedVehicle(lp)
					local vehfuel=getElementData(veh,"Fuel")
					local vehfuell=vehfuel
					local vehfuel=180/100*vehfuel
					local vehspeed=getElementSpeed(veh)
					local lights=getVehicleOverrideLights(veh)
					local engine=getVehicleEngineState(veh)
					local id=getElementModel(veh)
					
					if not CDN:getReady()then
						return
					end
					dxDrawImage(1550*Gsx,700*Gsy,400*Gsx,400*Gsy,"Files/Images/Speedo/Background.png",0,0,0,tocolor(255,255,255,255),false)
					
					dxDrawImage(1620*Gsx,780*Gsy,280*Gsx,280*Gsy,"Files/Images/Speedo/Needle.png",vehspeed,0,0,tocolor(255,255,255,255),true)
					dxDrawImage(1535*Gsx,720*Gsy,240*Gsx,240*Gsy,"Files/Images/Speedo/TankNeedle.png",vehfuel,0,0,tocolor(255,255,255,255),true)
					
					if(vehfuell<=15)then
						dxDrawImage(1620*Gsx,805*Gsy,25*Gsx,25*Gsy,"Files/Images/Speedo/TankWarning.png",0,0,0,tocolor(255,255,255,255),false)
					end
					
					if(getPedOccupiedVehicleSeat(lp)==0)then
						if(cars[id]or lkws[id]or bus[id])then
							if(speedo_blinker_l==true)then
								dxDrawImage(1700*Gsx,875*Gsy,50*Gsx,35*Gsy,"Files/Images/Speedo/BlinkerLeft.png",0,0,0,tocolor(0,200,0,255),false)
							else
								dxDrawImage(1700*Gsx,875*Gsy,50*Gsx,35*Gsy,"Files/Images/Speedo/BlinkerLeft.png",0,0,0,tocolor(255,255,255,255),false)
							end
							if(speedo_blinker_r==true)then
								dxDrawImage(1770*Gsx,875*Gsy,50*Gsx,35*Gsy,"Files/Images/Speedo/BlinkerRight.png",0,0,0,tocolor(0,200,0,255),false)
							else
								dxDrawImage(1770*Gsx,875*Gsy,50*Gsx,35*Gsy,"Files/Images/Speedo/BlinkerRight.png",0,0,0,tocolor(255,255,255,255),false)
							end
						end
					end
					
					if(cars[id]or lkws[id]or bus[id])then
						if(getElementData(lp,"seatbelt")==false)then
							dxDrawImage(1743*Gsx,855*Gsy,35*Gsx,35*Gsy,"Files/Images/Speedo/Seatbelt.png",0,0,0,tocolor(150,0,0,255),false)
						elseif(getElementData(lp,"seatbelt")==true)then
							dxDrawImage(1743*Gsx,855*Gsy,35*Gsx,35*Gsy,"Files/Images/Speedo/Seatbelt.png",0,0,0,tocolor(0,150,0,255),false)
						end
					end
					
					if(isVehicleLocked(veh)==true)then
						dxDrawImage(1750*Gsx,970*Gsy,35*Gsx,35*Gsy,"Files/Images/Speedo/State.png",0,0,0,tocolor(0,150,0,255),false)
					elseif(isVehicleLocked(veh)==false)then
						dxDrawImage(1750*Gsx,970*Gsy,35*Gsx,35*Gsy,"Files/Images/Speedo/State.png",0,0,0,tocolor(150,0,0,255),false)
					end
					
					if(lights)then
						if(lights==2)then
							dxDrawImage(1705*Gsx,922*Gsy,35*Gsx,35*Gsy,"Files/Images/Speedo/Light.png",0,0,0,tocolor(0,85,200,255),false)
						else
							dxDrawImage(1705*Gsx,922*Gsy,35*Gsx,35*Gsy,"Files/Images/Speedo/Light.png",0,0,0,tocolor(255,255,255,255),false)
						end
					end
					
					if(getElementData(veh,"Totalloss")==1)then
						dxDrawImage(1785*Gsx,922*Gsy,35*Gsx,35*Gsy,"Files/Images/Speedo/Engine.png",0,0,0,tocolor(200,0,0,255),false)
					elseif(engine==true)then
						dxDrawImage(1785*Gsx,922*Gsy,35*Gsx,35*Gsy,"Files/Images/Speedo/Engine.png",0,0,0,tocolor(200,85,0,255),false)
					elseif(engine==false)then
						dxDrawImage(1785*Gsx,922*Gsy,35*Gsx,35*Gsy,"Files/Images/Speedo/Engine.png",0,0,0,tocolor(255,255,255,255),false)
					end
					
				end
			end
		end
	else
		removeEventHandler("onClientRender",root,drawSpeedo)
	end
end

addEventHandler("onClientVehicleEnter",root,function(player)
	if(player==lp)then
		removeEventHandler("onClientRender",root,drawSpeedo)
		addEventHandler("onClientRender",root,drawSpeedo)
	end
end)
addEventHandler("onClientVehicleExit",root,function(playere)
	if(playere==lp)then
		removeEventHandler("onClientRender",root,drawSpeedo)
	end
end)

function blinkerall(state)
    speedo_blinker_r=state
	speedo_blinker_l=state
	if(state==true)then
		playSoundFrontEnd(38)
	else
		playSoundFrontEnd(37)
	end
end
addEvent("blinker:all", true )
addEventHandler("blinker:all",root,blinkerall) 
function blinkerleft(state)
    speedo_blinker_l=state
	if(state==true)then
		playSoundFrontEnd(38)
	else
		playSoundFrontEnd(37)
	end
end
addEvent("blinker:left",true)
addEventHandler("blinker:left",root,blinkerleft)
function blinkerright(state)
    speedo_blinker_r=state
	if(state==true)then
		playSoundFrontEnd(38)
	else
		playSoundFrontEnd(37)
	end
end
addEvent("blinker:right",true)
addEventHandler("blinker:right",root,blinkerright)


--//Limit
local maxspeed=500

function setVehicleLimit(player,speed)
	local speed=tonumber(speed)
	if(speed)then
		if(speed>=35 and speed<=500)then
			maxspeed=speed
			if(not isTimer(limitTimer))then
				limitTimer=setTimer(function()
					local veh=getPedOccupiedVehicle(lp)
					if(veh)then
						if(isVehicleOnGround(veh)and getVehicleOccupant(veh)==lp)then
							local vehspeed=getElementSpeed(veh)
							if(vehspeed>maxspeed)then
								setElementSpeed(veh,_,speed)
							end
						end
					end
				end,50,0)
				triggerEvent("draw:infobox",lp,"info","Limit gesetzt auf: "..speed.." - Tippe /limit, um es wieder zu entfernen.")
			else
				triggerEvent("draw:infobox",lp,"error","Das hast bereits ein Limit gesetzt! Tippe /limit, um es wieder zu entfernen.")
			end
		else
			triggerEvent("draw:infobox",lp,"error","Das hast kein Limit angegeben!")
		end
	else
		if(isTimer(limitTimer))then
			killTimer(limitTimer)
			maxspeed=500
			triggerEvent("draw:infobox",lp,"info","Das Limit wurde entfernt!")
		end
	end
end
addCommandHandler("limit",setVehicleLimit)