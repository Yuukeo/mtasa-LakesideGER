--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("show:timerui",true)
addEventHandler("show:timerui",root,function(htext,time)
	if(isTimer(cATMrobTimer))then
		killTimer(cATMrobTimer)
	end
	timer=time
	headertext=htext
	
	addEventHandler("onClientRender",root,drawTimerDisplay)
	cATMrobTimer=setTimer(function()
		timer=timer-1
		if(timer==0)then
			removeEventHandler("onClientRender",root,drawTimerDisplay)
			if(isTimer(cATMrobTimer))then killTimer(cATMrobTimer)end
		end
	end,1000,timer)
end)

function drawTimerDisplay()
	if(isLoggedin())then
		if(not(isPedDead(lp)))then
			if(getElementData(lp,"ElementClicked")==false and isPlayerMapVisible(lp)==false)then
				dxDrawRectangle(820*Gsx,60*Gsy,280*Gsx,80*Gsy,settings.general.guibgcolor,false)
				dxDrawRectangle(820*Gsx,60*Gsy,280*Gsx,21*Gsy,settings.general.guimaincolor,false)
				dxDrawText(headertext,1725*Gsx,61.5*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,255),1.00*Gsx,dxFONT3,"center",_,_,_,false,_,_)
				--dxDrawImage(820*Gsx,80*Gsy,280*Gsx,2*Gsy,":"..settings.general.scriptname.."/Files/Images/White.png",0,0,0,settings.general.guilinecolor,false)
				dxDrawRectangle(820*Gsx,80*Gsy,280*Gsx,2*Gsy,settings.general.guilinecolor,false)
				dxDrawText(timer.." Sekunden",1725*Gsx,100*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,255),1.30*Gsx,dxFONT3,"center",_,_,_,false,_,_)
			end
		end
	end
end


addEvent("show:desktopnotify",true)
addEventHandler("show:desktopnotify",root,function(typ,text)
	createTrayNotification("Lakeside Reallife:\n"..text.."",typ,true)
end)