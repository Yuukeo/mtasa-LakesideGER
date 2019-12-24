--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local state=false

function openHandy()
	if(isLoggedin())then
		if(not isElement(Lakeside.Window[1]))then
			if(syncClientGetElementData("Mobilephone")==1)then
				HandyPlayerEatBestellung={}
				HandyPlayerBestellung={}
				HandyEatPrices=0
				HandyWeaponPrices=0
				if(not isTimer(TimerOnOFF))then
					HandyPlayerEatBestellung={}
					HandyPlayerBestellung={}
					HandyEatPrices=0
					HandyWeaponPrices=0
					
					if(isElement(Lakeside.Window[10]))then
						Lakeside.Window[10]:destroy()
					end
					if(isElement(Lakeside.Window[11]))then
						Lakeside.Window[11]:destroy()
					end
					if(isElement(Lakeside.Window[12]))then
						Lakeside.Window[12]:destroy()
					end
					if(isElement(Lakeside.Window[13]))then
						Lakeside.Window[13]:destroy()
					end
					if(isElement(Lakeside.Window[14]))then
						Lakeside.Window[14]:destroy()
					end
					if(isElement(Lakeside.Window[15]))then
						Lakeside.Window[15]:destroy()
					end
					if(isElement(Lakeside.Window[16]))then
						Lakeside.Window[16]:destroy()
					end
					if(isElement(Lakeside.Window[17]))then
						Lakeside.Window[17]:destroy()
					end
					if(state==false)then
						state=true
						setWindowData("add","cursor_clicked",false)
						if(isElement(Lakeside.Window[10]))then
							Lakeside.Window[10]:destroy()
						end
						HandyPlayerEatBestellung={}
						HandyPlayerBestellung={}
						HandyEatPrices=0
						HandyWeaponPrices=0
						if(syncClientGetElementData("PhoneState")==1)then
							setPedAnimation(lp,"ped","PHONE_IN",0,false)
							Lakeside.Window[10]=guiCreateStaticImage(10,GLOBALscreenY/2-500/2,250,460,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel")..".png",false)
							Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/Backgrounds/"..syncClientGetElementData("PhoneBackground")..".png",false,Lakeside.Window[10])
							guiMoveToBack(Lakeside.Image[1])
							Lakeside.Button[1]=guiCreateStaticImage(25,65,55,55,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel").."Apps/Call.png",false,Lakeside.Window[10])
							Lakeside.Label[1]=guiCreateLabel(30,120,100,15,"Anrufen",false,Lakeside.Window[10])
							Lakeside.Button[2]=guiCreateStaticImage(95,65,55,55,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel").."Apps/Settings.png",false,Lakeside.Window[10])
							Lakeside.Label[2]=guiCreateLabel(88,120,100,15,"Einstellungen",false,Lakeside.Window[10])
							Lakeside.Button[3]=guiCreateStaticImage(170,65,55,55,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel").."Apps/Youtube.png",false,Lakeside.Window[10])
							Lakeside.Label[3]=guiCreateLabel(172,120,100,15,"Youtube",false,Lakeside.Window[10])
							Lakeside.Button[4]=guiCreateStaticImage(25,145,55,55,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel").."Apps/Notes.png",false,Lakeside.Window[10])
							Lakeside.Label[4]=guiCreateLabel(33,200,100,15,"Notizen",false,Lakeside.Window[10])
							Lakeside.Button[5]=guiCreateStaticImage(95,145,55,55,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel").."Apps/Ammunation.png",false,Lakeside.Window[10])
							Lakeside.Label[5]=guiCreateLabel(90,200,100,15,"Ammunation",false,Lakeside.Window[10])
							Lakeside.Button[7]=guiCreateStaticImage(170,145,55,55,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel").."Apps/Lieferheld.png",false,Lakeside.Window[10])
							Lakeside.Label[7]=guiCreateLabel(172,200,100,15,"Lieferheld",false,Lakeside.Window[10])
							Lakeside.Button[8]=guiCreateStaticImage(25,220,55,55,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel").."Apps/Contacts.png",false,Lakeside.Window[10])
							Lakeside.Label[8]=guiCreateLabel(30,275,100,15,"Kontakte",false,Lakeside.Window[10])
							
							Timer1=setTimer(function()
								if(getElementData(lp,"call")==true)then
									if(isElement(Lakeside.Window[10]))then
										Lakeside.Button[6]=guiCreateStaticImage(175,345,55,55,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel").."Apps/CallDenied.png",false,Lakeside.Window[10])
										
										addEventHandler("onClientGUIClick",Lakeside.Button[6],
											function()
												triggerServerEvent("call:denied",lp,lp)
											end,
										false)
									end
								else
									if(isElement(Lakeside.Window[10]))then
										if(isElement(Lakeside.Button[6]))then
											Lakeside.Button[6]:destroy()
										end
										if(isElement(Lakeside.Button[66]))then
											Lakeside.Button[66]:destroy()
										end
									end
								end
								if(getElementData(lp,"call")==true and getElementData(lp,"callswith")~=getPlayerName(lp))then
									if(isElement(Lakeside.Window[10]))then
										Lakeside.Button[66]=guiCreateStaticImage(25,345,55,55,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel").."Apps/CallAccept.png",false,Lakeside.Window[10])
										
										addEventHandler("onClientGUIClick",Lakeside.Button[66],
											function()
												triggerServerEvent("call:accept",lp,lp)
											end,
										false)
									end
								else
									if(isElement(Lakeside.Window[10]))then
										if(isElement(Lakeside.Button[6]))then
											Lakeside.Button[6]:destroy()
										end
										if(isElement(Lakeside.Button[66]))then
											Lakeside.Button[66]:destroy()
										end
									end
								end
							end,100,1)
							
							
							addEventHandler("onClientGUIMouseDown",Lakeside.Image[1],
								function()
									guiMoveToBack(Lakeside.Image[1])
								end,
							false)
							
							addEventHandler("onClientGUIClick",Lakeside.Button[8],
								function()
									openContactsFunction()
								end,
							false)
							addEventHandler("onClientGUIClick",Lakeside.Button[7],
								function()
									openLieferheldFunction()
								end,
							false)
							addEventHandler("onClientGUIClick",Lakeside.Button[5],
								function()
									openAmmunationFunction()
								end,
							false)
							addEventHandler("onClientGUIClick",Lakeside.Button[4],
								function()
									openNotesFunction()
								end,
							false)
							addEventHandler("onClientGUIClick",Lakeside.Button[3],
								function()
									openYoutubeFunction()
								end,
							false)
							addEventHandler("onClientGUIClick",Lakeside.Button[2],
								function()
									openSettingsFunction()
								end,
							false)
							addEventHandler("onClientGUIClick",Lakeside.Button[1],
								function()
									openCallFunction()
								end,
							false)
						elseif(syncClientGetElementData("PhoneState")==0)then
							Lakeside.Window[10]=guiCreateStaticImage(10,GLOBALscreenY/2-500/2,250,460,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel")..".png",false)
							Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/PhoneOFF.png",false,Lakeside.Window[10])
						end
						
						
						
						Lakeside.Button[20]=guiCreateButton(105,412,38,35,"",false,Lakeside.Window[10])
						guiSetAlpha(Lakeside.Button[20],0)
						
						
						addEventHandler("onClientGUIClick",Lakeside.Button[20],
							function()
								if(Lakeside.Button[20])then
									if(getElementData(lp,"call")==false)then
										if(syncClientGetElementData("PhoneState")==1)then
											syncClientSetElementData("PhoneState",0)
											if(isElement(Lakeside.Button[1]))then
												Lakeside.Button[1]:destroy()
											end
											if(isElement(Lakeside.Button[2]))then
												Lakeside.Button[2]:destroy()
											end
											if(isElement(Lakeside.Button[3]))then
												Lakeside.Button[3]:destroy()
											end
											if(isElement(Lakeside.Button[4]))then
												Lakeside.Button[4]:destroy()
											end
											if(isElement(Lakeside.Button[5]))then
												Lakeside.Button[5]:destroy()
											end
											if(isElement(Lakeside.Button[7]))then
												Lakeside.Button[7]:destroy()
											end
											if(isElement(Lakeside.Button[8]))then
												Lakeside.Button[8]:destroy()
											end
											if(isElement(Lakeside.Label[1]))then
												Lakeside.Label[1]:destroy()
											end
											if(isElement(Lakeside.Label[2]))then
												Lakeside.Label[2]:destroy()
											end
											if(isElement(Lakeside.Label[3]))then
												Lakeside.Label[3]:destroy()
											end
											if(isElement(Lakeside.Label[4]))then
												Lakeside.Label[4]:destroy()
											end
											if(isElement(Lakeside.Label[5]))then
												Lakeside.Label[5]:destroy()
											end
											if(isElement(Lakeside.Label[7]))then
												Lakeside.Label[7]:destroy()
											end
											if(isElement(Lakeside.Label[8]))then
												Lakeside.Label[8]:destroy()
											end
											if(isElement(Lakeside.Image[1]))then
												Lakeside.Image[1]:destroy()
											end
											Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/PhoneOFF.png",false,Lakeside.Window[10])
											guiMoveToBack(Lakeside.Image[1])
											if(isTimer(Timer1))then
												Timer1:destroy()
											end
										else
											if(isElement(Lakeside.Image[1]))then
												Lakeside.Image[1]:destroy()
											end
											Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/Backgrounds/"..syncClientGetElementData("PhoneBackground")..".png",false,Lakeside.Window[10])
											guiMoveToBack(Lakeside.Image[1])
											Lakeside.Label[20]=guiCreateLabel(90,120,100,15,"Booting...",false,Lakeside.Image[1])
											Lakeside.Image[2]=guiCreateStaticImage(75,180,80,80,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel").."Boot.png",false,Lakeside.Image[1])
											if(isTimer(TimerOnOFF))then
												TimerOnOFF:destroy()
											end
											local rdmStartTimer=math.random(4,8)
											TimerOnOFF=setTimer(function()
												if(isElement(Lakeside.Label[20]))then
													Lakeside.Label[20]:destroy()
												end
												if(isElement(Lakeside.Image[2]))then
													Lakeside.Image[2]:destroy()
												end
												if(isTimer(TimerOnOFF))then
													TimerOnOFF:destroy()
												end
												syncClientSetElementData("PhoneState",1)
												state=false
												openHandy()
											end,rdmStartTimer*1000,1)
										end
									end
								end
							end,
						false)
					elseif(state==true)then
						state=false
						if(isElement(Lakeside.Window[10]))then
							Lakeside.Window[10]:destroy()
						end
						if(isTimer(TimerOnOFF))then
							TimerOnOFF:destroy()
						end
						setWindowData("remove","cursor_clicked",false)
						if(isTimer(Timer1))then
							Timer1:destroy()
						end
						setPedAnimation(lp,"ped","PHONE_OUT",1200,false)
					end
				end
			end
		end
	end
end
bindKey("u","down",openHandy)

function openCallFunction()
	if(isElement(Lakeside.Window[10]))then
		Lakeside.Window[10]:destroy()
	end
	if(isElement(Lakeside.Window[11]))then
		Lakeside.Window[11]:destroy()
	end
	if(isElement(Lakeside.Window[12]))then
		Lakeside.Window[12]:destroy()
	end
	if(isElement(Lakeside.Window[13]))then
		Lakeside.Window[13]:destroy()
	end
	if(isElement(Lakeside.Window[14]))then
		Lakeside.Window[14]:destroy()
	end
	if(isElement(Lakeside.Window[15]))then
		Lakeside.Window[15]:destroy()
	end
	if(isElement(Lakeside.Window[16]))then
		Lakeside.Window[16]:destroy()
	end
	if(isElement(Lakeside.Window[17]))then
		Lakeside.Window[17]:destroy()
	end
	Lakeside.Window[11]=guiCreateStaticImage(10,GLOBALscreenY/2-500/2,250,460,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel")..".png",false)
	Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/Backgrounds/"..syncClientGetElementData("PhoneBackground")..".png",false,Lakeside.Window[11])
	
	Lakeside.Edit[1]=guiCreateEdit(30,60,185,40,"",false,Lakeside.Window[11])
	guiEditSetReadOnly(Lakeside.Edit[1],true)
	
	Lakeside.Button[1]=guiCreateButton(30,105,45,45,"1",false,Lakeside.Window[11])
	Lakeside.Button[2]=guiCreateButton(100,105,45,45,"2",false,Lakeside.Window[11])
	Lakeside.Button[3]=guiCreateButton(170,105,45,45,"3",false,Lakeside.Window[11])
	Lakeside.Button[4]=guiCreateButton(30,165,45,45,"4",false,Lakeside.Window[11])
	Lakeside.Button[5]=guiCreateButton(100,165,45,45,"5",false,Lakeside.Window[11])
	Lakeside.Button[6]=guiCreateButton(170,165,45,45,"6",false,Lakeside.Window[11])
	Lakeside.Button[7]=guiCreateButton(30,225,45,45,"7",false,Lakeside.Window[11])
	Lakeside.Button[8]=guiCreateButton(100,225,45,45,"8",false,Lakeside.Window[11])
	Lakeside.Button[9]=guiCreateButton(170,225,45,45,"9",false,Lakeside.Window[11])
	Lakeside.Button[10]=guiCreateButton(30,285,45,45,"0",false,Lakeside.Window[11])
	Lakeside.Button[11]=guiCreateButton(100,285,115,45,"Nummerfeld\nleeren",false,Lakeside.Window[11])
	Lakeside.Button[12]=guiCreateButton(30,345,185,25,"Spieler anrufen",false,Lakeside.Window[11])
	Lakeside.Button[13]=guiCreateButton(30,375,185,25,"Handynummer kopieren",false,Lakeside.Window[11])
	
	
	
	
	Lakeside.Button[20]=guiCreateButton(105,412,38,35,"",false,Lakeside.Window[11])
	guiSetAlpha(Lakeside.Button[20],0)
	
	
	addEventHandler("onClientGUIClick",Lakeside.Button[13],
		function()
			if(Lakeside.Button[13])then
				if(tonumber(syncClientGetElementData("Telenr"))~=0)then
					setClipboard(syncClientGetElementData("Telenr"))
				end
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[12],
		function()
			if(guiGetText(Lakeside.Edit[1])~="" and isOnlyNumbers(guiGetText(Lakeside.Edit[1])))then
				triggerServerEvent("call:player",lp,lp,guiGetText(Lakeside.Edit[1]))
			end
		end,
	false)
	
	addEventHandler("onClientGUIClick",Lakeside.Button[11],
		function()
			if(Lakeside.Button[11])then
				guiSetText(Lakeside.Edit[1],"")
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[10],
		function()
			if(Lakeside.Button[10])then
				guiSetText(Lakeside.Edit[1],guiGetText(Lakeside.Edit[1]).."0")
				Numbsounds=playSound("Files/Sounds/Phone/Numberfield/0.mp3")
				setSoundVolume(Numbsounds,1)
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[9],
		function()
			if(Lakeside.Button[9])then
				guiSetText(Lakeside.Edit[1],guiGetText(Lakeside.Edit[1]).."9")
				Numbsounds=playSound("Files/Sounds/Phone/Numberfield/9.mp3")
				setSoundVolume(Numbsounds,1)
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[8],
		function()
			if(Lakeside.Button[8])then
				guiSetText(Lakeside.Edit[1],guiGetText(Lakeside.Edit[1]).."8")
				Numbsounds=playSound("Files/Sounds/Phone/Numberfield/8.mp3")
				setSoundVolume(Numbsounds,1)
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[7],
		function()
			if(Lakeside.Button[7])then
				guiSetText(Lakeside.Edit[1],guiGetText(Lakeside.Edit[1]).."7")
				Numbsounds=playSound("Files/Sounds/Phone/Numberfield/7.mp3")
				setSoundVolume(Numbsounds,1)
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[6],
		function()
			if(Lakeside.Button[6])then
				guiSetText(Lakeside.Edit[1],guiGetText(Lakeside.Edit[1]).."6")
				Numbsounds=playSound("Files/Sounds/Phone/Numberfield/6.mp3")
				setSoundVolume(Numbsounds,1)
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[5],
		function()
			if(Lakeside.Button[5])then
				guiSetText(Lakeside.Edit[1],guiGetText(Lakeside.Edit[1]).."5")
				Numbsounds=playSound("Files/Sounds/Phone/Numberfield/5.mp3")
				setSoundVolume(Numbsounds,1)
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[4],
		function()
			if(Lakeside.Button[4])then
				guiSetText(Lakeside.Edit[1],guiGetText(Lakeside.Edit[1]).."4")
				Numbsounds=playSound("Files/Sounds/Phone/Numberfield/4.mp3")
				setSoundVolume(Numbsounds,1)
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[3],
		function()
			if(Lakeside.Button[3])then
				guiSetText(Lakeside.Edit[1],guiGetText(Lakeside.Edit[1]).."3")
				Numbsounds=playSound("Files/Sounds/Phone/Numberfield/3.mp3")
				setSoundVolume(Numbsounds,1)
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[2],
		function()
			if(Lakeside.Button[2])then
				guiSetText(Lakeside.Edit[1],guiGetText(Lakeside.Edit[1]).."2")
				Numbsounds=playSound("Files/Sounds/Phone/Numberfield/2.mp3")
				setSoundVolume(Numbsounds,1)
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[1],
		function()
			if(Lakeside.Button[1])then
				guiSetText(Lakeside.Edit[1],guiGetText(Lakeside.Edit[1]).."1")
				Numbsounds=playSound("Files/Sounds/Phone/Numberfield/1.mp3")
				setSoundVolume(Numbsounds,1)
			end
		end,
	false)
	
	addEventHandler("onClientGUIMouseDown",Lakeside.Image[1],
		function()
			guiMoveToBack(Lakeside.Image[1])
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[20],
		function()
			if(Lakeside.Button[20])then
				setWindowData("remove","cursor_clicked",false)
				state=false
				openHandy()
			end
		end,
	false)
end

local HandyBackgrounds={
	{1,"Xperia Z3"},
	{2,"Nexus 1"},
	{3,"OnePlus 3T"},
	{4,"Xperia X"},
	{5,"iOS 10"},
	{6,"iOS 7"},
	{7,"Google Pixle"},
	{8,"Girl 1"},
	{9,"Arsch 1"},
	{10,"Girl 2"},
	{11,"Samsung Galaxy"},
	{12,"Nexus 2"},
	{13,"Samsung Galaxy S11"},
}
local HandyModelle={
	{1,"Iphone Black"},
	{2,"Iphone White"},
	{3,"Nexus 5"},
	{4,"Samsung Galaxy"},
}
local HandyRightones={
	{1},
	{2},
	{3},
	{4},
}
function openSettingsFunction()
	if(isElement(Lakeside.Window[10]))then
		Lakeside.Window[10]:destroy()
	end
	if(isElement(Lakeside.Window[11]))then
		Lakeside.Window[11]:destroy()
	end
	if(isElement(Lakeside.Window[12]))then
		Lakeside.Window[12]:destroy()
	end
	if(isElement(Lakeside.Window[13]))then
		Lakeside.Window[13]:destroy()
	end
	if(isElement(Lakeside.Window[14]))then
		Lakeside.Window[14]:destroy()
	end
	if(isElement(Lakeside.Window[15]))then
		Lakeside.Window[15]:destroy()
	end
	if(isElement(Lakeside.Window[16]))then
		Lakeside.Window[16]:destroy()
	end
	if(isElement(Lakeside.Window[17]))then
		Lakeside.Window[17]:destroy()
	end
	Lakeside.Window[12]=guiCreateStaticImage(10,GLOBALscreenY/2-500/2,250,460,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel")..".png",false)
	Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/Backgrounds/"..syncClientGetElementData("PhoneBackground")..".png",false,Lakeside.Window[12])
	
	Lakeside.Tabpanel[1]=guiCreateTabPanel(20,65,210,330,false,Lakeside.Window[12])
	Lakeside.Tab[1]=guiCreateTab("Hintergründe",Lakeside.Tabpanel[1])
	
	Lakeside.Gridlist[1]=guiCreateGridList(5,5,200,250,false,Lakeside.Tab[1])
	bgid=guiGridListAddColumn(Lakeside.Gridlist[1],"ID",0.2)
	bg=guiGridListAddColumn(Lakeside.Gridlist[1],"Hintergrund",0.7)
	
	Lakeside.Button[1]=guiCreateButton(5,260,200,40,"Hintergrund auswählen",false,Lakeside.Tab[1])
	
	
	Lakeside.Tab[2]=guiCreateTab("Modelle",Lakeside.Tabpanel[1])
	
	Lakeside.Gridlist[2]=guiCreateGridList(5,5,200,250,false,Lakeside.Tab[2])
	modellid=guiGridListAddColumn(Lakeside.Gridlist[2],"ID",0.2)
	modell=guiGridListAddColumn(Lakeside.Gridlist[2],"Modell",0.7)
	
	Lakeside.Button[2]=guiCreateButton(5,260,200,40,"Modell auswählen",false,Lakeside.Tab[2])
	
	
	Lakeside.Tab[3]=guiCreateTab("Ton",Lakeside.Tabpanel[1])
	
	Lakeside.Gridlist[3]=guiCreateGridList(5,5,200,250,false,Lakeside.Tab[3])
	modellrightone=guiGridListAddColumn(Lakeside.Gridlist[3],"Klingelton",0.7)
	
	Lakeside.Button[3]=guiCreateButton(5,260,200,40,"Klingelton auswählen",false,Lakeside.Tab[3])
	
	
	Lakeside.Button[20]=guiCreateButton(105,412,38,35,"",false,Lakeside.Window[12])
	guiSetAlpha(Lakeside.Button[20],0)
	
	for _,v in pairs(HandyBackgrounds)do
		local row=guiGridListAddRow(Lakeside.Gridlist[1])
		guiGridListSetItemText(Lakeside.Gridlist[1],row,bgid,v[1],false,false)
		guiGridListSetItemText(Lakeside.Gridlist[1],row,bg,v[2],false,false)
	end
	for _,v in pairs(HandyModelle)do
		local row=guiGridListAddRow(Lakeside.Gridlist[2])
		guiGridListSetItemText(Lakeside.Gridlist[2],row,modellid,v[1],false,false)
		guiGridListSetItemText(Lakeside.Gridlist[2],row,modell,v[2],false,false)
	end
	for _,v in pairs(HandyRightones)do
		local row=guiGridListAddRow(Lakeside.Gridlist[3])
		guiGridListSetItemText(Lakeside.Gridlist[3],row,modellrightone,v[1],false,false)
	end
	
	
	addEventHandler("onClientGUIMouseDown",Lakeside.Image[1],
		function()
			guiMoveToBack(Lakeside.Image[1])
		end,
	false)
	
	addEventHandler("onClientGUIClick",Lakeside.Button[3],
		function(btn,state)
			if(btn=="left" and state=="up")then
				if(Lakeside.Button[3])then
					local clicked=guiGridListGetItemText(Lakeside.Gridlist[3],guiGridListGetSelectedItem(Lakeside.Gridlist[3]),1)
					if(clicked~="")then
						syncClientSetElementData("PhoneRightone",tonumber(clicked))
						triggerEvent("draw:infobox",lp,"info","Klingelton geändert!")
					end
				end
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Gridlist[3],
		function(btn,state)
			if(btn=="left" and state=="up")then
				if(Lakeside.Gridlist[3])then
					local clicked=guiGridListGetItemText(Lakeside.Gridlist[3],guiGridListGetSelectedItem(Lakeside.Gridlist[3]),1)
					if(clicked~="")then
						if(isElement(testSound))then
							testSound:destroy()
						end
						testSound=playSound(":"..settings.general.scriptname.."/Files/Sounds/Phone/Rightones/"..clicked..".mp3",false)
						setSoundVolume(testSound,0.5)
					end
				end
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[2],
		function(btn,state)
			if(btn=="left" and state=="up")then
				if(Lakeside.Button[2])then
					local clicked=guiGridListGetItemText(Lakeside.Gridlist[2],guiGridListGetSelectedItem(Lakeside.Gridlist[2]),1)
					if(clicked~="")then
						syncClientSetElementData("PhoneModel",clicked)
						if(isElement(Lakeside.Window[12]))then
							Lakeside.Window[12]:destroy()
						end
						state=false
						openHandy()
					end
				end
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[1],
		function(btn,state)
			if(btn=="left" and state=="up")then
				if(Lakeside.Button[1])then
					local clicked=guiGridListGetItemText(Lakeside.Gridlist[1],guiGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
					if(clicked~="")then
						syncClientSetElementData("PhoneBackground",clicked)
						if(isElement(Lakeside.Image[1]))then
							Lakeside.Image[1]:destroy()
						end
						Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/Backgrounds/"..syncClientGetElementData("PhoneBackground")..".png",false,Lakeside.Window[12])
						guiMoveToBack(Lakeside.Image[1])
					end
				end
			end
		end,
	false)
	
	addEventHandler("onClientGUIClick",Lakeside.Button[20],
		function()
			if(Lakeside.Button[20])then
				setWindowData("remove","cursor_clicked",false)
				state=false
				openHandy()
			end
		end,
	false)
end

function openYoutubeFunction()
	if(isElement(Lakeside.Window[10]))then
		Lakeside.Window[10]:destroy()
	end
	if(isElement(Lakeside.Window[11]))then
		Lakeside.Window[11]:destroy()
	end
	if(isElement(Lakeside.Window[12]))then
		Lakeside.Window[12]:destroy()
	end
	if(isElement(Lakeside.Window[13]))then
		Lakeside.Window[13]:destroy()
	end
	if(isElement(Lakeside.Window[14]))then
		Lakeside.Window[14]:destroy()
	end
	if(isElement(Lakeside.Window[15]))then
		Lakeside.Window[15]:destroy()
	end
	if(isElement(Lakeside.Window[16]))then
		Lakeside.Window[16]:destroy()
	end
	if(isElement(Lakeside.Window[17]))then
		Lakeside.Window[17]:destroy()
	end
	Lakeside.Window[13]=guiCreateStaticImage(10,GLOBALscreenY/2-500/2,620,320,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel").."Right.png",false)
	Lakeside.Image[1]=guiCreateStaticImage(63,15,490,289,":"..settings.general.scriptname.."/Files/Images/Phone/Backgrounds/"..syncClientGetElementData("PhoneBackground")..".png",false,Lakeside.Window[13])
	
	Lakeside.Browser[1]=guiCreateBrowser(63,15,490,289,false,false,false,Lakeside.Window[13])
	theBrowserHandy=guiGetBrowser(Lakeside.Browser[1])
	
	Lakeside.Button[15]=guiCreateStaticImage(562,60,38,40,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel").."Apps/VolumeUp.png",false,Lakeside.Window[13])
	Lakeside.Button[16]=guiCreateStaticImage(562,225,38,40,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel").."Apps/VolumeDown.png",false,Lakeside.Window[13])
	
	Lakeside.Button[20]=guiCreateButton(562,130,38,40,"",false,Lakeside.Window[13])
	guiSetAlpha(Lakeside.Button[20],0)
	
	
	requestBrowserDomains({"youtube.com/tv"})
	addEventHandler("onClientBrowserCreated",theBrowserHandy, 
		function()
			loadBrowserURL(source,"https://youtube.com/")
			focusBrowser(source)
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[15],
		function()
			if(Lakeside.Button[15])then
				setBrowserVolume(theBrowserHandy,getBrowserVolume(theBrowserHandy)+2/100)
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[16],
		function()
			if(Lakeside.Button[16])then
				setBrowserVolume(theBrowserHandy,getBrowserVolume(theBrowserHandy)-2/100)
			end
		end,
	false)
	
	addEventHandler("onClientGUIClick",Lakeside.Button[20],
		function()
			if(Lakeside.Button[20])then
				setWindowData("remove","cursor_clicked",false)
				state=false
				openHandy()
			end
		end,
	false)
end

function openNotesFunction()
	if(isElement(Lakeside.Window[10]))then
		Lakeside.Window[10]:destroy()
	end
	if(isElement(Lakeside.Window[11]))then
		Lakeside.Window[11]:destroy()
	end
	if(isElement(Lakeside.Window[12]))then
		Lakeside.Window[12]:destroy()
	end
	if(isElement(Lakeside.Window[13]))then
		Lakeside.Window[13]:destroy()
	end
	if(isElement(Lakeside.Window[14]))then
		Lakeside.Window[14]:destroy()
	end
	if(isElement(Lakeside.Window[15]))then
		Lakeside.Window[15]:destroy()
	end
	if(isElement(Lakeside.Window[16]))then
		Lakeside.Window[16]:destroy()
	end
	if(isElement(Lakeside.Window[17]))then
		Lakeside.Window[17]:destroy()
	end
	Lakeside.Window[14]=guiCreateStaticImage(10,GLOBALscreenY/2-500/2,250,460,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel")..".png",false)
	Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/Backgrounds/"..syncClientGetElementData("PhoneBackground")..".png",false,Lakeside.Window[14])
	
	Lakeside.Memo[1]=guiCreateMemo(25,60,200,280,"",false,Lakeside.Window[14])
	loadHandyNotes()
	
	Lakeside.Button[1]=guiCreateButton(25,350,200,45,"Notiz speichern",false,Lakeside.Window[14])
	
	
	Lakeside.Button[20]=guiCreateButton(105,412,38,35,"",false,Lakeside.Window[14])
	guiSetAlpha(Lakeside.Button[20],0)
	
	
	addEventHandler("onClientGUIMouseDown",Lakeside.Image[1],
		function()
			guiMoveToBack(Lakeside.Image[1])
		end,
	false)
	
	addEventHandler("onClientGUIClick",Lakeside.Button[1],
		function()
			if(Lakeside.Button[20])then
				saveHandyNotes()
			end
		end,
	false)
	
	addEventHandler("onClientGUIClick",Lakeside.Button[20],
		function()
			if(Lakeside.Button[20])then
				setWindowData("remove","cursor_clicked",false)
				state=false
				openHandy()
			end
		end,
	false)
end

function openAmmunationFunction()
	if(isElement(Lakeside.Window[10]))then
		Lakeside.Window[10]:destroy()
	end
	if(isElement(Lakeside.Window[11]))then
		Lakeside.Window[11]:destroy()
	end
	if(isElement(Lakeside.Window[12]))then
		Lakeside.Window[12]:destroy()
	end
	if(isElement(Lakeside.Window[13]))then
		Lakeside.Window[13]:destroy()
	end
	if(isElement(Lakeside.Window[14]))then
		Lakeside.Window[14]:destroy()
	end
	if(isElement(Lakeside.Window[15]))then
		Lakeside.Window[15]:destroy()
	end
	if(isElement(Lakeside.Window[16]))then
		Lakeside.Window[16]:destroy()
	end
	if(isElement(Lakeside.Window[17]))then
		Lakeside.Window[17]:destroy()
	end
	Lakeside.Window[15]=guiCreateStaticImage(10,GLOBALscreenY/2-500/2,250,460,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel")..".png",false)
	Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/Backgrounds/"..syncClientGetElementData("PhoneBackground")..".png",false,Lakeside.Window[15])
	
	Lakeside.Gridlist[1]=guiCreateGridList(15,55,220,305,false,Lakeside.Window[15])
	local waffe=guiGridListAddColumn(Lakeside.Gridlist[1],"Waffe",0.36)
	local munition=guiGridListAddColumn(Lakeside.Gridlist[1],"Munition",0.3)
	local preis=guiGridListAddColumn(Lakeside.Gridlist[1],"Preis",0.3)
	
	
	Lakeside.Button[20]=guiCreateButton(105,412,38,35,"",false,Lakeside.Window[15])
	guiSetAlpha(Lakeside.Button[20],0)
	
	for _,v in pairs(HandyWeapons)do
		local row = guiGridListAddRow(Lakeside.Gridlist[1])
		guiGridListSetItemText(Lakeside.Gridlist[1],row,waffe,v[1],false,false)
		guiGridListSetItemText(Lakeside.Gridlist[1],row,munition,v[2],false,false)
		guiGridListSetItemText(Lakeside.Gridlist[1],row,preis,v[3],false,false)
	end
	
	Lakeside.Button[1]=guiCreateButton(15,365,220,40,"Waffen bestellen",false,Lakeside.Window[15])
	
	
	addEventHandler("onClientGUIMouseDown",Lakeside.Image[1],
		function()
			guiMoveToBack(Lakeside.Image[1])
		end,
	false)
	
	addEventHandler("onClientGUIClick",Lakeside.Button[1],
		function()
			if(Lakeside.Button[1])then
				local waffe=guiGridListGetItemText(Lakeside.Gridlist[1],guiGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
				local preis=guiGridListGetItemText(Lakeside.Gridlist[1],guiGridListGetSelectedItem(Lakeside.Gridlist[1]),3)
				if(waffe~="")then
					if(preis~="")then
						table.insert(HandyPlayerBestellung,{waffe})
						HandyWeaponPrices=HandyWeaponPrices+preis
						triggerServerEvent("deliver:weapon",lp,HandyPlayerBestellung,HandyWeaponPrices)
						HandyPlayerEatBestellung={}
						HandyPlayerBestellung={}
						HandyEatPrices=0
						HandyWeaponPrices=0
					end
				end
			end
		end,
	false)
	
	addEventHandler("onClientGUIClick",Lakeside.Button[20],
		function()
			if(Lakeside.Button[20])then
				setWindowData("remove","cursor_clicked",false)
				state=false
				openHandy()
			end
		end,
	false)
end

function openLieferheldFunction()
	if(isElement(Lakeside.Window[10]))then
		Lakeside.Window[10]:destroy()
	end
	if(isElement(Lakeside.Window[11]))then
		Lakeside.Window[11]:destroy()
	end
	if(isElement(Lakeside.Window[12]))then
		Lakeside.Window[12]:destroy()
	end
	if(isElement(Lakeside.Window[13]))then
		Lakeside.Window[13]:destroy()
	end
	if(isElement(Lakeside.Window[14]))then
		Lakeside.Window[14]:destroy()
	end
	if(isElement(Lakeside.Window[15]))then
		Lakeside.Window[15]:destroy()
	end
	if(isElement(Lakeside.Window[16]))then
		Lakeside.Window[16]:destroy()
	end
	if(isElement(Lakeside.Window[17]))then
		Lakeside.Window[17]:destroy()
	end
	Lakeside.Window[16]=guiCreateStaticImage(10,GLOBALscreenY/2-500/2,250,460,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel")..".png",false)
	Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/Backgrounds/"..syncClientGetElementData("PhoneBackground")..".png",false,Lakeside.Window[16])
	
	Lakeside.Gridlist[1]=guiCreateGridList(15,55,220,305,false,Lakeside.Window[16])
	local eat=guiGridListAddColumn(Lakeside.Gridlist[1],"Essen",0.42)
	local price=guiGridListAddColumn(Lakeside.Gridlist[1],"Preis",0.4)
	
	
	Lakeside.Button[20]=guiCreateButton(105,412,38,35,"",false,Lakeside.Window[16])
	guiSetAlpha(Lakeside.Button[20],0)
	
	for _,v in pairs(HandyEat)do
		local row=guiGridListAddRow(Lakeside.Gridlist[1])
		guiGridListSetItemText(Lakeside.Gridlist[1],row,eat,v[1],false,false)
		guiGridListSetItemText(Lakeside.Gridlist[1],row,price,v[2],false,false)
	end
	
	Lakeside.Button[1]=guiCreateButton(15,365,220,40,"Essen bestellen",false,Lakeside.Window[16])
	
	
	addEventHandler("onClientGUIMouseDown",Lakeside.Image[1],
		function()
			guiMoveToBack(Lakeside.Image[1])
		end,
	false)
	
	addEventHandler("onClientGUIClick",Lakeside.Button[1],
		function()
			if(Lakeside.Button[1])then
				local eat=guiGridListGetItemText(Lakeside.Gridlist[1],guiGridListGetSelectedItem(Lakeside.Gridlist[1]),1)
				local eatprice=guiGridListGetItemText(Lakeside.Gridlist[1],guiGridListGetSelectedItem(Lakeside.Gridlist[1]),2)
				if(eat~="")then
					if(eatprice~="")then
						table.insert(HandyPlayerEatBestellung,{eat})
						HandyEatPrices=HandyEatPrices+eatprice
						triggerServerEvent("deliver:eat",lp,HandyPlayerEatBestellung,HandyEatPrices)
						HandyPlayerEatBestellung={}
						HandyPlayerBestellung={}
						HandyEatPrices=0
						HandyWeaponPrices=0
					end
				end
			end
		end,
	false)
	
	addEventHandler("onClientGUIClick",Lakeside.Button[20],
		function()
			if(Lakeside.Button[20])then
				setWindowData("remove","cursor_clicked",false)
				state=false
				openHandy()
			end
		end,
	false)
end

function openContactsFunction()
	if(isElement(Lakeside.Window[10]))then
		Lakeside.Window[10]:destroy()
	end
	if(isElement(Lakeside.Window[11]))then
		Lakeside.Window[11]:destroy()
	end
	if(isElement(Lakeside.Window[12]))then
		Lakeside.Window[12]:destroy()
	end
	if(isElement(Lakeside.Window[13]))then
		Lakeside.Window[13]:destroy()
	end
	if(isElement(Lakeside.Window[14]))then
		Lakeside.Window[14]:destroy()
	end
	if(isElement(Lakeside.Window[15]))then
		Lakeside.Window[15]:destroy()
	end
	if(isElement(Lakeside.Window[16]))then
		Lakeside.Window[16]:destroy()
	end
	if(isElement(Lakeside.Window[17]))then
		Lakeside.Window[17]:destroy()
	end
	Lakeside.Window[17]=guiCreateStaticImage(10,GLOBALscreenY/2-500/2,250,460,":"..settings.general.scriptname.."/Files/Images/Phone/Phone"..syncClientGetElementData("PhoneModel")..".png",false)
	Lakeside.Image[1]=guiCreateStaticImage(13,53,224,356,":"..settings.general.scriptname.."/Files/Images/Phone/Backgrounds/"..syncClientGetElementData("PhoneBackground")..".png",false,Lakeside.Window[17])
	
	Lakeside.Gridlist[122]=guiCreateGridList(15,55,220,220,false,Lakeside.Window[17])
	frienlistmembers=guiGridListAddColumn(Lakeside.Gridlist[122],"Name",0.45)
	--frienlistmembernumber=guiGridListAddColumn(Lakeside.Gridlist[122],"Nummer",0.4)
	fillFriendlist()
	
	Lakeside.Edit[122]=guiCreateEdit(15,280,220,35,"",false,Lakeside.Window[17])
	Lakeside.Button[1]=guiCreateButton(15,320,220,40,"Hinzufügen",false,Lakeside.Window[17])
	Lakeside.Button[2]=guiCreateButton(15,365,220,40,"Kontakt entfernen",false,Lakeside.Window[17])
	
	
	Lakeside.Button[20]=guiCreateButton(105,412,38,35,"",false,Lakeside.Window[17])
	guiSetAlpha(Lakeside.Button[20],0)
	
	
	addEventHandler("onClientGUIMouseDown",Lakeside.Image[1],
		function()
			guiMoveToBack(Lakeside.Image[1])
		end,
	false)
	
	addEventHandler("onClientGUIClick",Lakeside.Button[2],
		function()
			if(Lakeside.Button[2])then
				local row=guiGridListGetItemText(Lakeside.Gridlist[122],guiGridListGetSelectedItem(Lakeside.Gridlist[122]),1)
				deleteFriend(row)
			end
		end,
	false)
	addEventHandler("onClientGUIClick",Lakeside.Button[1],
		function()
			if(Lakeside.Button[1])then
				triggerServerEvent("addFriend",root,lp,guiGetText(Lakeside.Edit[122]))
			end
		end,
	false)
	
	addEventHandler("onClientGUIClick",Lakeside.Button[20],
		function()
			if(Lakeside.Button[20])then
				setWindowData("remove","cursor_clicked",false)
				state=false
				openHandy()
			end
		end,
	false)
end




function loadHandyNotes()
	local noteHandyList=xmlLoadFile(":"..settings.general.scriptname.."/handynotes.xml")
	if(not noteHandyList)then
		local noteHandyList=xmlCreateFile(":"..settings.general.scriptname.."/handynotes.xml","handynotes")
		local notesHandy=xmlCreateChild(noteHandyList,"noteHandyText")
		xmlNodeSetValue(notesHandy,"")
		xmlSaveFile(noteHandyList)
		guiSetText(Lakeside.Memo[1],notesHandy)
	else
		local notesHandy=xmlNodeGetChildren(noteHandyList,0)
		local notesHandy=xmlNodeGetValue(notesHandy)
		guiSetText(Lakeside.Memo[1],notesHandy)
	end
end
function saveHandyNotes()
	if(Lakeside.Memo[1])then
		local noteHandyText=guiGetText(Lakeside.Memo[1])
		local fileHandyNotes=xmlLoadFile(":"..settings.general.scriptname.."/handynotes.xml" )
		local node=xmlNodeGetChildren(fileHandyNotes,0)
		xmlNodeSetValue(node,noteHandyText)
		xmlSaveFile(fileHandyNotes)
	end
end




function addFriend_func(target)
	local friendlist=xmlLoadFile(":"..settings.general.scriptname.."/friendlist.xml")
	local friends = xmlNodeGetChildren(friendlist,0)
	local curfriends=xmlNodeGetValue(friends)
	local lastfriend="console"
	for i=1,100 do
		local newfriend=gettok(curfriends,i,string.byte('|'))
		if not newfriend then
			triggerEvent("draw:infobox",lp,"info","Freund wurde zur Liste hinzugefügt!")
			_G["friend"..target]=true
			xmlNodeSetValue(friends,curfriends..target.."|")
			xmlSaveFile(friendlist)
			deleteFriendLabels()
			fillFriendlist()
			break
		end
		if(tostring(newfriend)==tostring(target))then
			triggerEvent("draw:infobox",lp,"error","Der Spieler ist bereits in der Liste!")
			break
		end	
		local lastfriend=newfriend
	end
end
addEvent("addFriend",true)
addEventHandler("addFriend",root,addFriend_func)

function getFriends()
	local friendlist=xmlLoadFile(":"..settings.general.scriptname.."/friendlist.xml")
	local friends=xmlNodeGetChildren(friendlist,0)
	xmlSaveFile(friendlist)
	local friends=xmlNodeGetValue(friends)
	if(friends)then
		return friends
	else
		return false
	end
end
function deleteFriend(friendname)
	local newfriends=""
	for i=0, guiGridListGetRowCount(Lakeside.Gridlist[122])do
		local text=guiGridListGetItemText(Lakeside.Gridlist[122],i,frienlistmembers)
		if(text~=friendname)then
			newfriends=newfriends..text.."|"
		else
			triggerEvent("draw:infobox",lp,"info","Freund gelöscht!")
			_G["friend"..friendname]=false
		end
	end
	local friendlist=xmlLoadFile(":"..settings.general.scriptname.."/friendlist.xml" )
	local friends=xmlNodeGetChildren(friendlist,0)
	xmlNodeSetValue(friends,newfriends)
	xmlSaveFile(friendlist)
	deleteFriendLabels()
	fillFriendlist()
end

function fillFriendlist()
	if(Lakeside.Gridlist[122])then
		guiGridListClear(Lakeside.Gridlist[122])
		local friendlist=xmlLoadFile(":"..settings.general.scriptname.."/friendlist.xml")
		if not friendlist then
			local friendlist=xmlCreateFile(":"..settings.general.scriptname.."/friendlist.xml","friendlist")
			local friends=xmlCreateChild(friendlist,"friends")
			xmlNodeSetValue(friends,"")
			xmlSaveFile(friendlist)
		end
		local friendlist=xmlLoadFile(":"..settings.general.scriptname.."/friendlist.xml")
		local friends=getFriends()
		local lastfriend="console"
		local newfriend=""
		for i=1,100 do
			local newfriend=gettok(friends,i,string.byte('|'))
			if(tostring(newfriend)==tostring(lastfriend))then
				break
			elseif(newfriend)then
				local row=guiGridListAddRow(Lakeside.Gridlist[122])
				guiGridListSetItemText(Lakeside.Gridlist[122],row,frienlistmembers,newfriend,false,false)
				_G["friend"..newfriend]=true
			end
			local lastfriend=gettok(friends,i,string.byte('|'))
		end
	end
end

function deleteFriendLabels()
	if(isElement(Lakeside.Edit[122]))then
		guiSetText(Lakeside.Edit[122],"")
	end
end


















function playPhoneSounds(typ)
	if(isElement(sound))then
		sound:destroy()
	end
	if(typ=="noconnection")then
		sound=playSound("Files/Sounds/phone/NoConnection.mp3",false)
		setSoundVolume(sound,0.5)
	elseif(typ=="rightone")then
		if(syncClientGetElementData("PhoneRightone")>=1)then
			sound=playSound("Files/Sounds/phone/Rightones/"..syncClientGetElementData("PhoneRightone")..".mp3",true)
			setSoundVolume(sound,0.5)
		end
	end
end
addEvent("play:phonesound",true)
addEventHandler("play:phonesound",root,playPhoneSounds)

function stopPhoneSounds()
	if(isElement(sound))then
		sound:destroy()
	end
end
addEvent("stop:phonesound",true)
addEventHandler("stop:phonesound",root,playPhoneSounds)