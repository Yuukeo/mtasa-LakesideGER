--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

--//Bloodscreen
local bloodAlpha=0

function showBloodFlash()
	bloodAlpha=255
end
addEvent("showBloodFlash",true)
addEventHandler("showBloodFlash",root,showBloodFlash)

addEventHandler("onClientRender",root,function()
	if(bloodAlpha>0)then
		dxDrawImage(0,0,GLOBALscreenX,GLOBALscreenY,"Files/Images/Bloodscreen.png",0,0,0,tocolor(255,255,255,bloodAlpha))
		bloodAlpha=math.max(0,bloodAlpha-3)
	end
end)


function cancelAllDamage(attacker,weapon,bodypart,loss)
	if(source==lp)then
		showBloodFlash()
	end
	if(attacker==lp)then
		if(syncClientGetElementData("Hitglocke")==1)then
			if(source~=lp)then
				local sound=playSound(":"..settings.general.scriptname.."/Files/Sounds/Hitglocke/"..syncClientGetElementData("Hitglocke")..".mp3")
				setSoundVolume(sound,0.5)
			end
		end
		if(attacker and weapon and bodypart and loss)then
			if(globalTables["weaponDMG"][weapon])then
				triggerServerEvent("damageCalcServer",lp,attacker,weapon,bodypart,loss,source)
			end
		end
	elseif(lp==source)then
		if(not(isPedDead(lp)))then
			showBloodFlash()
		end
		if(attacker and weapon and bodypart and loss)then
			if(globalTables["weaponDMG"][weapon])then
				cancelEvent()
			end
		end
	end
end
addEventHandler("onClientPlayerDamage",root,cancelAllDamage)

addEvent("render.hospital",true)
addEventHandler("render.hospital",root,function(time)
	local deathsound=playSound(":"..settings.general.scriptname.."/Files/Sounds/Wasted.mp3",false)
	setSoundVolume(deathsound,1)
	if(isTimer(HospitalStartTimer))then
		killTimer(HospitalStartTimer)
	end
	if(isElement(Lakeside.Window[1]))then
		dgsCloseWindow(Lakeside.Window[1])
	end
	HospitalStartTimer=setTimer(function()
		showChat(false)
		setElementData(lp,"ElementClicked",true)
		setElementInterior(lp,0)
		setElementDimension(lp,0)
		if(isPedInVehicle(lp))then
			removePedFromVehicle(lp)
		end
		setCameraMatrix(1216,-1323.6,21.5,1183.5,-1323.6,17.2)
		Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-380/2,GLOBALscreenY/2-355/2,380,355,settings.general.servername.." - Krankenhaus",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,settings.general.guibgcolor,nil,true)
		dgsWindowSetSizable(Lakeside.Window[1],false)
		dgsWindowSetMovable(Lakeside.Window[1],false)
		dgsCreateImage(0,0,380,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
		Lakeside.Blurbox[1]=dgsCreateBlurBox()
		dgsSetProperty(Lakeside.Window[1],"functions",[[
			local arguments = {...}
			local blurbox = arguments[1]
			local renderArguments = renderArguments
			local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
			dgsBlurBoxRender(blurbox,x,y,w,h)
		]],Lakeside.Blurbox[1])
		
		Lakeside.Label[1]=dgsCreateLabel(140,40,100,20,"Du bist noch "..time.." sekunden im Krankenhaus.",false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
		dgsSetProperty(Lakeside.Label[1],"textSize",{1.5,1.5})
		
		dgsCreateImage(5,185,375,140,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],tocolor(0,0,0,255))
		Lakeside.Label[2]=dgsCreateLabel(140,150,100,20,"Wusstest du schon?",false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
		dgsSetProperty(Lakeside.Label[2],"textSize",{1.3,1.3})
		Lakeside.Label[3]=dgsCreateLabel(140,220,100,20,globalTables["facts"][math.random(1,#globalTables["facts"])],false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
		dgsSetProperty(Lakeside.Label[3],"textSize",{1.2,1.2})
		
		changeTextTimer=setTimer(function()
			dgsSetText(Lakeside.Label[3],globalTables["facts"][math.random(1,#globalTables["facts"])])
		end,8000,0)
		
		HospitalTimer=setTimer(function()
			time=time-1
			dgsSetText(Lakeside.Label[1],"Du bist noch "..time.." sekunden im Krankenhaus.")
			if(time==1)then
				dgsCloseWindow(Lakeside.Window[1])
				setWindowData("remove","cursor_clicked",false)
				showChat(true)
				triggerServerEvent("spawn:hospital",lp)
				if(isTimer(HospitalTimer))then
					killTimer(HospitalTimer)
				end
				if(isTimer(HospitalStartTimer))then
					killTimer(HospitalStartTimer)
				end
				if(isTimer(changeTextTimer))then
					killTimer(changeTextTimer)
				end
			end
		end,1000,time)
		if(isTimer(HospitalStartTimer))then
			killTimer(HospitalStartTimer)
		end
		
	end,6700,1)
end)

function endHospitalByRevive()
	if(isTimer(HospitalTimer))then
		killTimer(HospitalTimer)
	end
	if(isTimer(HospitalStartTimer))then
		killTimer(HospitalStartTimer)
	end
	if(isElement(Lakeside.Window[1]))then
		dgsCloseWindow(Lakeside.Window[1])
		setWindowData("remove","cursor_clicked",false)
	end
	showChat(true)
end
addEvent("stop:hospitaltime",true)
addEventHandler("stop:hospitaltime",root,endHospitalByRevive)