--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local state=false

function openTablet()
	if(isLoggedin())then
		if(not isElement(Lakeside.Window[1]))then
			if(syncClientGetElementData("Tablet")==1)then
				if(isElement(Lakeside.Window[10]))then
					Lakeside.Window[10]:destroy()
				end
				if(state==false)then
					state=true
					setWindowData("add","cursor_clicked",false)
					Lakeside.Window[10]=guiCreateStaticImage(10,GLOBALscreenY/2-700/2,700,500,":"..settings.general.scriptname.."/Files/Images/Tablet/Background.png",false)
				elseif(state==true)then
					state=false
					setWindowData("remove","cursor_clicked",false)
					if(isElement(Lakeside.Window[10]))then
						Lakeside.Window[10]:destroy()
					end
				end
			end
		end
	end
end
bindKey("o","down",openTablet)