--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("open:companydepot",true)
addEventHandler("open:companydepot",root,function(Money)
	if(isLoggedin())then
		if(not isPedInVehicle(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				setWindowData("add","cursor_clicked",true)
				dgsSetInputMode("no_binds")
				dgsSetInputMode("no_binds_when_editing")
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-250/2,GLOBALscreenY/2-380/2,250,380,settings.general.servername.." - Unternehmendepot",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,settings.general.guibgcolor,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(224,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,250,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=dgsCreateBlurBox()
				dgsSetProperty(Lakeside.Window[1],"functions",[[
					local arguments = {...}
					local blurbox = arguments[1]
					local renderArguments = renderArguments
					local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
					dgsBlurBoxRender(blurbox,x,y,w,h)
				]],Lakeside.Blurbox[1])
				
				Lakeside.Label[1]=dgsCreateLabel(25,20,200,60,"Geld: $"..convertNumber(Money),false,Lakeside.Window[1],_,_,_,_,_,_,"center",_)
				
				Lakeside.Radio[1]=dgsCreateRadioButton(90,110,11,11,"Geld",false,Lakeside.Window[1])
				
				dgsCreateLabel(7,190,100,20,"Anzahl",false,Lakeside.Window[1])
				Lakeside.Edit[1]=dgsCreateEdit(5,205,240,45,"",false,Lakeside.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
				Lakeside.Button[2]=dgsCreateButton(5,255,240,45,"Einzahlen",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[3]=dgsCreateButton(5,305,240,45,"Auszahlen  [R4]",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				
				if(getElementData(lp,"Companyrank")>=4)then
					dgsSetEnabled(Lakeside.Button[3],true)
				else
					dgsSetEnabled(Lakeside.Button[3],false)
				end
				
				
				dgsRadioButtonSetSelected(Lakeside.Radio[1],true)
				
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[3],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local amount=dgsGetText(Lakeside.Edit[1])
							
							if(amount~="" and isOnlyNumbers(amount))then
								if(dgsRadioButtonGetSelected(Lakeside.Radio[1]))then
									triggerServerEvent("payin_payout:companyitems",lp,"payout","Money",amount)
								end
							end
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[2],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local amount=dgsGetText(Lakeside.Edit[1])
							
							if(amount~="" and isOnlyNumbers(amount))then
								if(dgsRadioButtonGetSelected(Lakeside.Radio[1]))then
									triggerServerEvent("payin_payout:companyitems",lp,"payin","Money",amount)
								end
							end
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

addEvent("refresh:companydepot",true)
addEventHandler("refresh:companydepot",root,function(Money)
	if(isElement(Lakeside.Window[1]))then
		dgsSetText(Lakeside.Label[1],"Geld: $"..convertNumber(Money))
	end
end)