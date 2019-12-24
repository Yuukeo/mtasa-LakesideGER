--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("open:pizzastackUI",true)
addEventHandler("open:pizzastackUI",root,function()
	if(isLoggedin())then
		if(not isPedInVehicle(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				local PizzaCount=0
				setWindowData("add","cursor_clicked",true)
				Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-400/2,GLOBALscreenY/2-260/2,400,260,settings.general.servername.." - Pizza Stack",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,settings.general.guibgcolor,nil,true)
				dgsWindowSetSizable(Lakeside.Window[1],false)
				dgsWindowSetMovable(Lakeside.Window[1],false)
				Lakeside.Button[1]=dgsCreateButton(374,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
				dgsCreateImage(0,0,400,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
				Lakeside.Blurbox[1]=dgsCreateBlurBox()
				dgsSetProperty(Lakeside.Window[1],"functions",[[
					local arguments = {...}
					local blurbox = arguments[1]
					local renderArguments = renderArguments
					local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
					dgsBlurBoxRender(blurbox,x,y,w,h)
				]],Lakeside.Blurbox[1])
				
				Lakeside.Tabpanel[1]=dgsCreateTabPanel(10,10,380,215,false,Lakeside.Window[1])
				Lakeside.Tab[1]=dgsCreateTab("Pizza",Lakeside.Tabpanel[1])
				
				Lakeside.Button[2]=dgsCreateButton(5,5,40,140,"<",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[3]=dgsCreateButton(335,5,40,140,">",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[4]=dgsCreateButton(50,5,40,140,"<<",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				Lakeside.Button[5]=dgsCreateButton(290,5,40,140,">>",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				dgsCreateImage(140,40,100,100,":"..settings.general.scriptname.."/Files/Images/Inventory/Pizza.png",false,Lakeside.Tab[1])
				Lakeside.Label[1]=dgsCreateLabel(180,25,20,20,"0",false,Lakeside.Tab[1],_,_,_,_,_,_,"center",_)
				
				Lakeside.Button[6]=dgsCreateButton(5,150,370,40,"Kaufen x0 $0",false,Lakeside.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				Lakeside.Tab[1]=dgsCreateTab("more soon...",Lakeside.Tabpanel[1])
				
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[6],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local amount=dgsGetText(Lakeside.Label[1])
							triggerServerEvent("buy:shopitem",lp,"Pizza",amount)
						end
					end,
				false)
				
				addEventHandler("onDgsMouseClick",Lakeside.Button[5],
					function(btn,state)
						if(btn=="left" and state=="down")then
							PizzaCount=PizzaCount+2
							if(PizzaCount>=20)then
								PizzaCount=20
							end
							dgsSetText(Lakeside.Label[1],PizzaCount)
							dgsSetText(Lakeside.Button[6],"Kaufen x"..PizzaCount.." $"..PizzaCount*settings.shop.pizzaPrice)
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[4],
					function(btn,state)
						if(btn=="left" and state=="down")then
							PizzaCount=PizzaCount-2
							if(PizzaCount<=0)then
								PizzaCount=0
							end
							dgsSetText(Lakeside.Label[1],PizzaCount)
							dgsSetText(Lakeside.Button[6],"Kaufen x"..PizzaCount.." $"..PizzaCount*settings.shop.pizzaPrice)
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[3],
					function(btn,state)
						if(btn=="left" and state=="down")then
							PizzaCount=PizzaCount+1
							if(PizzaCount>=20)then
								PizzaCount=20
							end
							dgsSetText(Lakeside.Label[1],PizzaCount)
							dgsSetText(Lakeside.Button[6],"Kaufen x"..PizzaCount.." $"..PizzaCount*settings.shop.pizzaPrice)
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",Lakeside.Button[2],
					function(btn,state)
						if(btn=="left" and state=="down")then
							PizzaCount=PizzaCount-1
							if(PizzaCount<=0)then
								PizzaCount=0
							end
							dgsSetText(Lakeside.Label[1],PizzaCount)
							dgsSetText(Lakeside.Button[6],"Kaufen x"..PizzaCount.." $"..PizzaCount*settings.shop.pizzaPrice)
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