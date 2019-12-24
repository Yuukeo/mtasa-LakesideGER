--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo) & Xendom       ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("createHolzMarker",true)
addEventHandler("createHolzMarker",root,function(typ)
	if(isElement(WaldBlip1))then
		WaldBlip1:destroy()
	end
	if(isElement(WaldBlip2))then
		WaldBlip2:destroy()
	end
	if(isElement(WaldBlip3))then
		WaldBlip3:destroy()
	end
	if(isElement(HolzMarker))then
		HolzMarker:destroy()
	end
	--if(isElement(HolzSawMarker))then
	--	HolzSawMarker:destroy()
	--end
	if(isElement(HolzAbgabeBlip))then
		HolzAbgabeBlip:destroy()
	end
	
	if(typ=="create")then
		WaldBlip1=createBlip(-654.7,-662.5,43.5,0,2,200,200,0)
		WaldBlip2=createBlip(-2590.9,-2233.2,24.3,0,2,200,200,0)
		WaldBlip3=createBlip(-1860.5,-2628.4,54.8,0,2,200,200,0)
		HolzAbgabeBlip=createBlip(-2027.8,-2335.2,30.6,0,2,255,255,255)
		HolzMarker=createMarker(-2027.8,-2335.2,30.625-1,"cylinder",4,255,255,255)
		--HolzSawMarker=createMarker(-2012.6,-2350.1,30.625-1,"cylinder",1,0,120,200)
		
		addEventHandler("onClientMarkerHit",HolzMarker,function(player)
			if(player==lp)then
				if(isPedInVehicle(player))then
					triggerServerEvent("abgabe:holzfaeller",lp)
				end
			end
		end)
		
		--[[addEventHandler("onClientMarkerHit",HolzSawMarker,function(player)
			if(player==lp)then
				triggerServerEvent("cut:holzfaeller",lp)
			end
		end)]]
	end
end)



addEvent("open:holzjob",true)
addEventHandler("open:holzjob",root,function()
	if(isLoggedin())then
		if(not isPedInVehicle(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				setWindowData("add","cursor_clicked",true)
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-340/2,GLOBALscreenY/2-260/2,340,260,settings.general.servername.." - Job",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,settings.general.guibgcolor,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(314,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,340,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=dgsCreateBlurBox()
				dgsSetProperty(Lakeside.Window[1],"functions",[[
					local arguments = {...}
					local blurbox = arguments[1]
					local renderArguments = renderArguments
					local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
					dgsBlurBoxRender(blurbox,x,y,w,h)
				]],Lakeside.Blurbox[1])
				
				
				Lakeside.Image[1]=dgsCreateImage(5,5,330,140,":"..settings.general.scriptname.."/Files/Images/UI/Jobs/Busdriver.png",false,Lakeside.Window[1])
				dgsCreateLabel(5,145,100,20,"INFO: Du bekommst dein gehalt erst beim Payday.",false,Lakeside.Window[1])
				dgsCreateLabel(5,160,100,20,"Gehalt: $1050 pro Stamm.",false,Lakeside.Window[1])
				
				Lakeside.Button[2]=dgsCreateButton(5,190,330,40,"Job annehmen & starten",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[2],
					function(btn,state)
						if(btn=="left" and state=="down")then
							dgsCloseWindow(Lakeside.Window[1])
							setWindowData("remove","cursor_clicked",true)
							triggerServerEvent("set:job",lp,lp,"Holzfaeller")
							triggerServerEvent("start:holzfaeller",lp)
						end
					end,
				false)
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[1],
					function(btn,state)
						if(btn=="left" and state=="up")then
							dgsCloseWindow(Lakeside.Window[1])
							setWindowData("remove","cursor_clicked",true)
						end
					end,
				false)
			end
		end
	end
end)

addEventHandler("onClientPedDamage",root,function(attacker,weapon)
	if(getElementData(source,"baum")==true)then
		cancelEvent()
		if(weapon==9)then
			triggerServerEvent("damage:holzbaum",lp,source,attacker)
		end
	end
end)