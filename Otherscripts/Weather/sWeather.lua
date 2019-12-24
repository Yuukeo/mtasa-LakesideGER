--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo) & Xendom       ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

oilspill=false
local heatwave=nil
local earthquake=nil

local Weather={
	["Disasters"]={
		[1]={"Die Ölplattform hat einen Defekt, es kam zu einer Ölpest!",oilspill},
		[2]={"San Andreas wurde von einer Hitzewelle überrascht!",heatwave},
		[3]={"Die Bauarbeiten am Mount Chiliad haben zu einem Erdbeben geführt!",earthquake},
	},
	["Names"]={
		[0]="Extra Sunny",
		[1]="Sunny",
		[2]="Extra sun and cloudy",
		[3]="Sunny and cloudy",
		[4]="Cloudy",
		[5]="Sunny",
		[6]="Extra Sunny",
		[7]="Cloudy",
		[8]="Rainy",
		[9]="Foggy",
		[10]="Sunny",
		[11]="Extra Sunny",
		[12]="Cloudy",
		[13]="Extra Sunny",
		[14]="Sunny",
		[15]="Cloudy",
		[16]="Rainy",
		[17]="Extra Sunny",
		[18]="Sunny",
	},
}

function setWeatherAfterStart()
	local rdm=math.random(1,18)
	WetterID=rdm
	setWeather(WetterID)
	setWaveHeight(0)
end
addEventHandler("onResourceStart",resourceRoot,setWeatherAfterStart)

function generateWeather()
	local rdm=math.random(1,18)
	WetterID=rdm
	
	local Disasters=math.random(1,#Weather["Disasters"])
	
	local rdm2=math.random(1,5)
	if(rdm2==3)then
		oilspill=false
		heatwave=false
		earthquake=false
		resetWaterColor()
		setWaveHeight(0)
		
		
		outputChatBox(Weather["Disasters"][Disasters][1],root,255,255,0)
		if(Disasters==1)then
			oilspill=true
			setWaveHeight(1)
		end
		if(Disasters==2)then
			heatwave=true
			setWeather(11)
			setWaveHeight(2)
		end
		if(Disasters==3)then
			earthquake=true
			setWaveHeight(1)
			for _,v in pairs(getElementsByType("player"))do
				if(isLoggedin(v))then
					triggerClientEvent(v,"trigger:earthquake",v)
				end
			end
		end
		if(oilspill==true)then
			setWaterColor(0,0,0)
		end
	else
		setWeather(WetterID)
		setWaveHeight(0)
	end
end
setTimer(generateWeather,30*60*1000,0)

function refreshWeather(player)
	triggerClientEvent(player,"refresh:weather",player,WetterID)
end