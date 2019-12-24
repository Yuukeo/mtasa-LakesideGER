--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("open:weaponbox",true)
addEventHandler("open:weaponbox",root,function(Weapon1,Ammu1,Weapon2,Ammu2,Weapon3,Ammu3,Weapon4,Ammu4,Weapon5,Ammu5,Weapon6,Ammu6,Weapon7,Ammu7,Weapon8,Ammu8)
	if(isLoggedin())then
		if(not isPedInVehicle(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				if(Ammu1=="none")then Ammu1="- LEER -" else Ammu1=Ammu1.." Patrone(n)" end
				if(Ammu2=="none")then Ammu2="- LEER -" else Ammu2=Ammu2.." Patrone(n)" end
				if(Ammu3=="none")then Ammu3="- LEER -" else Ammu3=Ammu3.." Patrone(n)" end
				if(Ammu4=="none")then Ammu4="- LEER -" else Ammu4=Ammu4.." Patrone(n)" end
				if(Ammu5=="none")then Ammu5="- LEER -" else Ammu5=Ammu5.." Patrone(n)" end
				if(Ammu6=="none")then Ammu6="- LEER -" else Ammu6=Ammu6.." Patrone(n)" end
				if(Ammu7=="none")then Ammu7="- LEER -" else Ammu7=Ammu7.." Patrone(n)" end
				if(Ammu8=="none")then Ammu8="- LEER -" else Ammu8=Ammu8.." Patrone(n)" end
								
				if(Weapon1=="none")then Weapon1="Empty" text1="Einlagen" else text1="Auslagern" end
				if(Weapon2=="none")then Weapon2="Empty" text2="Einlagen" else text2="Auslagern" end
				if(Weapon3=="none")then Weapon3="Empty" text3="Einlagen" else text3="Auslagern" end
				if(Weapon4=="none")then Weapon4="Empty" text4="Einlagen" else text4="Auslagern" end
				if(Weapon5=="none")then Weapon5="Empty" text5="Einlagen" else text5="Auslagern" end
				if(Weapon6=="none")then Weapon6="Empty" text6="Einlagen" else text6="Auslagern" end
				if(Weapon7=="none")then Weapon7="Empty" text7="Einlagen" else text7="Auslagern" end
				if(Weapon8=="none")then Weapon8="Empty" text8="Einlagen" else text8="Auslagern" end
				
				setWindowData("add","cursor_clicked",true)
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-410/2,GLOBALscreenY/2-380/2,410,380,settings.general.servername.." - Waffenbox",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,settings.general.guibgcolor,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(384,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,410,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=dgsCreateBlurBox()
				dgsSetProperty(Lakeside.Window[1],"functions",[[
					local arguments = {...}
					local blurbox = arguments[1]
					local renderArguments = renderArguments
					local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
					dgsBlurBoxRender(blurbox,x,y,w,h)
				]],Lakeside.Blurbox[1])
				
				Lakeside.Label[1]=dgsCreateLabel(-10,110,100,20,text1,false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
				Lakeside.Label[2]=dgsCreateLabel(100,110,100,20,text2,false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
				Lakeside.Label[3]=dgsCreateLabel(205,110,100,20,text3,false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
				Lakeside.Label[4]=dgsCreateLabel(320,110,100,20,text4,false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
				Lakeside.Label[5]=dgsCreateLabel(-10,300,100,20,text5,false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
				Lakeside.Label[6]=dgsCreateLabel(100,300,100,20,text6,false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
				Lakeside.Label[7]=dgsCreateLabel(205,300,100,20,text7,false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
				Lakeside.Label[8]=dgsCreateLabel(320,300,100,20,text8,false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
				Lakeside.Label[9]=dgsCreateLabel(-10,140,100,20,Ammu1,false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
				Lakeside.Label[10]=dgsCreateLabel(100,140,100,20,Ammu2,false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
				Lakeside.Label[11]=dgsCreateLabel(205,140,100,20,Ammu3,false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
				Lakeside.Label[12]=dgsCreateLabel(320,140,100,20,Ammu4,false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
				Lakeside.Label[13]=dgsCreateLabel(-10,330,100,20,Ammu5,false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
				Lakeside.Label[14]=dgsCreateLabel(100,330,100,20,Ammu6,false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
				Lakeside.Label[15]=dgsCreateLabel(205,330,100,20,Ammu7,false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
				Lakeside.Label[16]=dgsCreateLabel(320,330,100,20,Ammu8,false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
				
				if(isElement(Lakeside.Image[1]))then
					Lakeside.Image[1]:destroy()
				end
				if(isElement(Lakeside.Image[2]))then
					Lakeside.Image[2]:destroy()
				end
				if(isElement(Lakeside.Image[3]))then
					Lakeside.Image[3]:destroy()
				end
				if(isElement(Lakeside.Image[4]))then
					Lakeside.Image[4]:destroy()
				end
				if(isElement(Lakeside.Image[5]))then
					Lakeside.Image[5]:destroy()
				end
				if(isElement(Lakeside.Image[6]))then
					Lakeside.Image[6]:destroy()
				end
				if(isElement(Lakeside.Image[7]))then
					Lakeside.Image[7]:destroy()
				end
				if(isElement(Lakeside.Image[8]))then
					Lakeside.Image[8]:destroy()
				end
				
				Lakeside.Image[1]=dgsCreateImage(5,20,70,70,":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/"..Weapon1..".png",false,Lakeside.Window[1],tocolor(255,255,255,255))
				Lakeside.Image[2]=dgsCreateImage(115,20,70,70,":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/"..Weapon2..".png",false,Lakeside.Window[1],tocolor(255,255,255,255))
				Lakeside.Image[3]=dgsCreateImage(225,20,70,70,":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/"..Weapon3..".png",false,Lakeside.Window[1],tocolor(255,255,255,255))
				Lakeside.Image[4]=dgsCreateImage(335,20,70,70,":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/"..Weapon4..".png",false,Lakeside.Window[1],tocolor(255,255,255,255))
				Lakeside.Image[5]=dgsCreateImage(5,220,70,70,":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/"..Weapon5..".png",false,Lakeside.Window[1],tocolor(255,255,255,255))
				Lakeside.Image[6]=dgsCreateImage(115,220,70,70,":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/"..Weapon6..".png",false,Lakeside.Window[1],tocolor(255,255,255,255))
				Lakeside.Image[7]=dgsCreateImage(225,220,70,70,":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/"..Weapon7..".png",false,Lakeside.Window[1],tocolor(255,255,255,255))
				Lakeside.Image[8]=dgsCreateImage(335,220,70,70,":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/"..Weapon8..".png",false,Lakeside.Window[1],tocolor(255,255,255,255))
				
				
				addEventHandler("onDgsMouseClick",Lakeside.Label[1],
					function(btn,state)
						if(btn=="left" and state=="down")then
							weaponboxPutin_Putout(1)
							dgsImageSetImage(Lakeside.Image[1],":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/"..Weapon1..".png")
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Label[2],
					function(btn,state)
						if(btn=="left" and state=="down")then
							weaponboxPutin_Putout(2)
							dgsImageSetImage(Lakeside.Image[2],":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/"..Weapon2..".png")
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Label[3],
					function(btn,state)
						if(btn=="left" and state=="down")then
							weaponboxPutin_Putout(3)
							dgsImageSetImage(Lakeside.Image[3],":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/"..Weapon3..".png")
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Label[4],
					function(btn,state)
						if(btn=="left" and state=="down")then
							weaponboxPutin_Putout(4)
							dgsImageSetImage(Lakeside.Image[4],":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/"..Weapon4..".png")
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Label[5],
					function(btn,state)
						if(btn=="left" and state=="down")then
							weaponboxPutin_Putout(5)
							dgsImageSetImage(Lakeside.Image[5],":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/"..Weapon5..".png")
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Label[6],
					function(btn,state)
						if(btn=="left" and state=="down")then
							weaponboxPutin_Putout(6)
							dgsImageSetImage(Lakeside.Image[6],":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/"..Weapon6..".png")
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Label[7],
					function(btn,state)
						if(btn=="left" and state=="down")then
							weaponboxPutin_Putout(7)
							dgsImageSetImage(Lakeside.Image[7],":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/"..Weapon7..".png")
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Label[8],
					function(btn,state)
						if(btn=="left" and state=="down")then
							weaponboxPutin_Putout(8)
							dgsImageSetImage(Lakeside.Image[8],":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/"..Weapon8..".png")
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

function weaponboxPutin_Putout(id)
	if(dgsGetText(Lakeside.Label[id])=="Einlagen")then
		triggerServerEvent("putin:weaponinweaponbox",lp,id)
	elseif(dgsGetText(Lakeside.Label[id])=="Auslagern")then
		triggerServerEvent("putout:weaponinweaponbox",lp,id)
	end
end