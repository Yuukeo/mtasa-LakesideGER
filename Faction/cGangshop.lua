--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("shop:gangUI",true)
addEventHandler("shop:gangUI",root,function()
	if(isLoggedin())then
		if(not isPedDead(lp))then
			if(not isPedInVehicle(lp))then
				if(getElementData(lp,"ElementClicked")==false)then
					setWindowData("add","cursor_clicked",true)
					dgsSetInputMode("no_binds")
					dgsSetInputMode("no_binds_when_editing")
					Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-405/2,GLOBALscreenY/2-460/2,405,460,settings.general.servername.." - Gangshop",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,settings.general.guibgcolor,nil,true)
					dgsWindowSetSizable(Lakeside.Window[1],false)
					dgsWindowSetMovable(Lakeside.Window[1],false)
					Lakeside.Button[1]=dgsCreateButton(379,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
					dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
					dgsCreateImage(0,0,405,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
					Lakeside.Blurbox[1]=dgsCreateBlurBox()
					dgsSetProperty(Lakeside.Window[1],"functions",[[
						local arguments = {...}
						local blurbox = arguments[1]
						local renderArguments = renderArguments
						local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
						dgsBlurBoxRender(blurbox,x,y,w,h)
					]],Lakeside.Blurbox[1])
					
					Lakeside.Tabpanel[1]=dgsCreateTabPanel(10,10,385,415,false,Lakeside.Window[1])
					Lakeside.Tab[1]=dgsCreateTab("Waffen",Lakeside.Tabpanel[1])
					
					Lakeside.Image[1]=dgsCreateImage(5,5,90,90,":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/22.png",false,Lakeside.Tab[1],tocolor(255,255,255,255))
					Lakeside.Image[2]=dgsCreateImage(100,5,90,90,":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/24.png",false,Lakeside.Tab[1],tocolor(255,255,255,255))
					Lakeside.Image[3]=dgsCreateImage(195,5,90,90,":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/29.png",false,Lakeside.Tab[1],tocolor(255,255,255,255))
					Lakeside.Image[4]=dgsCreateImage(290,5,90,90,":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/30.png",false,Lakeside.Tab[1],tocolor(255,255,255,255))
					Lakeside.Image[5]=dgsCreateImage(5,175,90,90,":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/31.png",false,Lakeside.Tab[1],tocolor(255,255,255,255))
					Lakeside.Image[6]=dgsCreateImage(100,175,90,90,":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/34.png",false,Lakeside.Tab[1],tocolor(255,255,255,255))
					Lakeside.Image[7]=dgsCreateImage(290,175,90,90,":"..settings.general.scriptname.."/Files/Images/Hud/Weapons/41.png",false,Lakeside.Tab[1],tocolor(255,255,255,255))
					
					
					Lakeside.Button[2]=dgsCreateButton(5,100,90,30,"Colt45 kaufen\nMats:"..settings.faction.weaponprices.mats.colt45.."",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[3]=dgsCreateButton(5,135,90,30,"Magazin kaufen\nMats:"..settings.faction.weaponprices.ammomats.colt45.."",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					Lakeside.Button[4]=dgsCreateButton(100,100,90,30,"Deagle kaufen\nMats:"..settings.faction.weaponprices.mats.deagle.."",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[5]=dgsCreateButton(100,135,90,30,"Magazin kaufen\nMats:"..settings.faction.weaponprices.ammomats.deagle.."",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					Lakeside.Button[6]=dgsCreateButton(195,100,90,30,"MP5 kaufen\nMats:"..settings.faction.weaponprices.mats.mp5.."",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[7]=dgsCreateButton(195,135,90,30,"Magazin kaufen\nMats:"..settings.faction.weaponprices.ammomats.mp5.."",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					Lakeside.Button[8]=dgsCreateButton(290,100,90,30,"AK kaufen\nMats:"..settings.faction.weaponprices.mats.ak.."",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[9]=dgsCreateButton(290,135,90,30,"Magazin kaufen\nMats:"..settings.faction.weaponprices.ammomats.ak.."",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					
					Lakeside.Button[10]=dgsCreateButton(5,275,90,30,"M4 kaufen\nMats:"..settings.faction.weaponprices.mats.m4.."",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[11]=dgsCreateButton(5,310,90,30,"Magazin kaufen\nMats:"..settings.faction.weaponprices.ammomats.m4.."",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					Lakeside.Button[12]=dgsCreateButton(100,275,90,30,"Sniper kaufen\nMats:"..settings.faction.weaponprices.mats.sniper.."",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					Lakeside.Button[13]=dgsCreateButton(100,310,90,30,"Magazin kaufen\nMats:"..settings.faction.weaponprices.ammomats.sniper.."",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					Lakeside.Button[16]=dgsCreateButton(290,275,90,30,"Spray kaufen\nMats:"..settings.faction.weaponprices.mats.spraycan.."",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					Lakeside.Button[20]=dgsCreateButton(290,310,90,30,"Weste kaufen\n$100",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					
					dgsCreateLabel(7,345,100,10,"Gebe eine Zahl ein, um das Magazin mehrmals zu kaufen.",false,Lakeside.Tab[1])
					Lakeside.Edit[1]=dgsCreateEdit(5,360,375,30,"1",false,Lakeside.Tab[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
					
					
					Lakeside.Tab[2]=dgsCreateTab("Skins",Lakeside.Tabpanel[1])
					
					if(getElementData(lp,"Faction")==5)then--
						if(syncClientGetElementData("Gender")=="Female")then
							dgsCreateImage(5,5,120,300,":"..settings.general.scriptname.."/Files/Images/Skin/215.png",false,Lakeside.Tab[2],tocolor(255,255,255,255))
							--dgsCreateImage(200,5,180,320,":"..settings.general.scriptname.."/Files/Images/Skin/101.png",false,Lakeside.Tab[2],tocolor(255,255,255,255))
							
							Lakeside.Button[22]=dgsCreateButton(5,310,120,80,"Skin auswählen",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
							
							
							addEventHandler("onDgsMouseClick",Lakeside.Button[22],
								function(btn,state)
									if(btn=="left" and state=="down")then
										triggerServerEvent("select:factionskin",lp,215)
									end
								end,
							false)
						elseif(syncClientGetElementData("Gender")=="Male")then
							dgsCreateImage(5,5,120,300,":"..settings.general.scriptname.."/Files/Images/Skin/108.png",false,Lakeside.Tab[2],tocolor(255,255,255,255))
							Lakeside.Button[22]=dgsCreateButton(5,310,120,80,"Skin auswählen",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
							
							dgsCreateImage(130,5,120,300,":"..settings.general.scriptname.."/Files/Images/Skin/110.png",false,Lakeside.Tab[2],tocolor(255,255,255,255))
							Lakeside.Button[23]=dgsCreateButton(130,310,120,80,"Skin auswählen",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
							
							dgsCreateImage(255,5,120,300,":"..settings.general.scriptname.."/Files/Images/Skin/109.png",false,Lakeside.Tab[2],tocolor(255,255,255,255))
							Lakeside.Button[24]=dgsCreateButton(255,310,120,80,"Skin auswählen",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
							
							
							addEventHandler("onDgsMouseClick",Lakeside.Button[22],
								function(btn,state)
									if(btn=="left" and state=="down")then
										triggerServerEvent("select:factionskin",lp,108)
									end
								end,
							false)
							addEventHandler("onDgsMouseClick",Lakeside.Button[23],
								function(btn,state)
									if(btn=="left" and state=="down")then
										triggerServerEvent("select:factionskin",lp,110)
									end
								end,
							false)
							addEventHandler("onDgsMouseClick",Lakeside.Button[24],
								function(btn,state)
									if(btn=="left" and state=="down")then
										triggerServerEvent("select:factionskin",lp,109)
									end
								end,
							false)
						end
					end--
					if(getElementData(lp,"Faction")==4)then
						if(syncClientGetElementData("Gender")=="Female")then
							dgsCreateImage(5,5,120,300,":"..settings.general.scriptname.."/Files/Images/Skin/13.png",false,Lakeside.Tab[2],tocolor(255,255,255,255))
							Lakeside.Button[22]=dgsCreateButton(5,310,120,80,"Skin auswählen",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
							
							dgsCreateImage(130,5,120,300,":"..settings.general.scriptname.."/Files/Images/Skin/195.png",false,Lakeside.Tab[2],tocolor(255,255,255,255))
							Lakeside.Button[23]=dgsCreateButton(130,310,120,80,"Skin auswählen",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
							
							--Lakeside.Button[23]=dgsCreateButton(255,310,120,80,"Skin auswählen",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
							
							
							addEventHandler("onDgsMouseClick",Lakeside.Button[22],
								function(btn,state)
									if(btn=="left" and state=="down")then
										triggerServerEvent("select:factionskin",lp,13)
									end
								end,
							false)
							addEventHandler("onDgsMouseClick",Lakeside.Button[23],
								function(btn,state)
									if(btn=="left" and state=="down")then
										triggerServerEvent("select:factionskin",lp,195)
									end
								end,
							false)
						elseif(syncClientGetElementData("Gender")=="Male")then
							dgsCreateImage(5,5,120,300,":"..settings.general.scriptname.."/Files/Images/Skin/102.png",false,Lakeside.Tab[2],tocolor(255,255,255,255))
							Lakeside.Button[22]=dgsCreateButton(5,310,120,80,"Skin auswählen",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
							
							dgsCreateImage(130,5,120,300,":"..settings.general.scriptname.."/Files/Images/Skin/103.png",false,Lakeside.Tab[2],tocolor(255,255,255,255))
							Lakeside.Button[23]=dgsCreateButton(130,310,120,80,"Skin auswählen",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
							
							dgsCreateImage(255,5,120,300,":"..settings.general.scriptname.."/Files/Images/Skin/104.png",false,Lakeside.Tab[2],tocolor(255,255,255,255))
							Lakeside.Button[24]=dgsCreateButton(255,310,120,80,"Skin auswählen",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
							
							
							addEventHandler("onDgsMouseClick",Lakeside.Button[22],
								function(btn,state)
									if(btn=="left" and state=="down")then
										triggerServerEvent("select:factionskin",lp,102)
									end
								end,
							false)
							addEventHandler("onDgsMouseClick",Lakeside.Button[23],
								function(btn,state)
									if(btn=="left" and state=="down")then
										triggerServerEvent("select:factionskin",lp,103)
									end
								end,
							false)
							addEventHandler("onDgsMouseClick",Lakeside.Button[24],
								function(btn,state)
									if(btn=="left" and state=="down")then
										triggerServerEvent("select:factionskin",lp,104)
									end
								end,
							false)
						end
					end
					if(getElementData(lp,"Faction")==3)then
						if(syncClientGetElementData("Gender")=="Female")then
							dgsCreateImage(5,5,120,300,":"..settings.general.scriptname.."/Files/Images/Skin/207.png",false,Lakeside.Tab[2],tocolor(255,255,255,255))
							Lakeside.Button[22]=dgsCreateButton(5,310,120,80,"Skin Auswählen",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
							
							
							addEventHandler("onDgsMouseClick",Lakeside.Button[22],
								function(btn,state)
									if(btn=="left" and state=="down")then
										triggerServerEvent("select:factionskin",lp,207)
									end
								end,
							false)
						elseif(syncClientGetElementData("Gender")=="Male")then
							dgsCreateImage(5,5,120,300,":"..settings.general.scriptname.."/Files/Images/Skin/106.png",false,Lakeside.Tab[2],tocolor(255,255,255,255))
							Lakeside.Button[22]=dgsCreateButton(5,310,120,80,"Skin Auswählen",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
							
							dgsCreateImage(130,5,120,300,":"..settings.general.scriptname.."/Files/Images/Skin/300.png",false,Lakeside.Tab[2],tocolor(255,255,255,255))
							Lakeside.Button[23]=dgsCreateButton(130,310,120,80,"Skin Auswählen",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
							
							dgsCreateImage(255,5,120,300,":"..settings.general.scriptname.."/Files/Images/Skin/107.png",false,Lakeside.Tab[2],tocolor(255,255,255,255))
							Lakeside.Button[24]=dgsCreateButton(255,310,120,80,"Skin Auswählen",false,Lakeside.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
							
							
							addEventHandler("onDgsMouseClick",Lakeside.Button[22],
								function(btn,state)
									if(btn=="left" and state=="down")then
										triggerServerEvent("select:factionskin",lp,106)
									end
								end,
							false)
							addEventHandler("onDgsMouseClick",Lakeside.Button[23],
								function(btn,state)
									if(btn=="left" and state=="down")then
										triggerServerEvent("select:factionskin",lp,300)
									end
								end,
							false)
							addEventHandler("onDgsMouseClick",Lakeside.Button[24],
								function(btn,state)
									if(btn=="left" and state=="down")then
										triggerServerEvent("select:factionskin",lp,107)
									end
								end,
							false)
						end
					end
					
					
					addEventHandler("onDgsMouseClick",Lakeside.Button[20],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:gangweapons",lp,_,"armor")
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[16],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local amount=dgsGetText(Lakeside.Edit[1])
								if(amount~="" and isOnlyNumbers(amount))then
									triggerServerEvent("buy:gangweapons",lp,"spraycan",_,_)
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[13],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local amount=dgsGetText(Lakeside.Edit[1])
								if(amount~="" and isOnlyNumbers(amount))then
									triggerServerEvent("buy:gangweapons",lp,_,"sniper",amount)
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[12],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:gangweapons",lp,"sniper",_,_)
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[11],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local amount=dgsGetText(Lakeside.Edit[1])
								if(amount~="" and isOnlyNumbers(amount))then
									triggerServerEvent("buy:gangweapons",lp,_,"m4",amount)
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[10],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:gangweapons",lp,"m4",_,_)
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[9],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local amount=dgsGetText(Lakeside.Edit[1])
								if(amount~="" and isOnlyNumbers(amount))then
									triggerServerEvent("buy:gangweapons",lp,_,"ak",amount)
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[8],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:gangweapons",lp,"ak",_,_)
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[7],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local amount=dgsGetText(Lakeside.Edit[1])
								if(amount~="" and isOnlyNumbers(amount))then
									triggerServerEvent("buy:gangweapons",lp,_,"mp5",amount)
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[6],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:gangweapons",lp,"mp5",_,_)
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[5],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local amount=dgsGetText(Lakeside.Edit[1])
								if(amount~="" and isOnlyNumbers(amount))then
									triggerServerEvent("buy:gangweapons",lp,_,"deagle",amount)
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[4],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:gangweapons",lp,"deagle",_,_)
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[3],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local amount=dgsGetText(Lakeside.Edit[1])
								if(amount~="" and isOnlyNumbers(amount))then
									triggerServerEvent("buy:gangweapons",lp,_,"colt45",amount)
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",Lakeside.Button[2],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("buy:gangweapons",lp,"colt45",_,_)
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
	end
end)