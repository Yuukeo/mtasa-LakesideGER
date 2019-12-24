--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("open:christmas1_UI",true)
addEventHandler("open:christmas1_UI",root,function()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			setWindowData("add","cursor_clicked",true)
			Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-400/2,GLOBALscreenY/2-260/2,400,260,settings.general.servername.." - Christmas",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,settings.general.guibgcolor,nil,true)
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
			
			dgsCreateImage(35,15,150,150,":"..settings.general.scriptname.."/Files/Images/Inventory/Present.png",false,Lakeside.Window[1])
			
			Lakeside.Button[2]=dgsCreateButton(35,180,150,40,"Geschenk kaufen\n(x5 Zuckerstangen)",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			
			addEventHandler("onDgsMouseClick",Lakeside.Button[2],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("buy:shopitem",lp,"Present",1)
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
end)

addEvent("open:christmasQuestUI",true)
addEventHandler("open:christmasQuestUI",root,function()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			setWindowData("add","cursor_clicked",true)
			Lakeside.Window[1]=dgsCreateWindow(GLOBALscreenX/2-525/2,GLOBALscreenY/2-370/2,525,370,settings.general.servername.." - Adventskalender",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,settings.general.guibgcolor,nil,true)
			dgsWindowSetSizable(Lakeside.Window[1],false)
			dgsWindowSetMovable(Lakeside.Window[1],false)
			Lakeside.Button[1]=dgsCreateButton(499,-25,26,25,"×",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			dgsSetProperty(Lakeside.Button[1],"textSize",{1.6,1.6})
			dgsCreateImage(0,0,525,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[1],settings.general.guilinecolor)
			Lakeside.Blurbox[1]=dgsCreateBlurBox()
			dgsSetProperty(Lakeside.Window[1],"functions",[[
				local arguments = {...}
				local blurbox = arguments[1]
				local renderArguments = renderArguments
				local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
				dgsBlurBoxRender(blurbox,x,y,w,h)
			]],Lakeside.Blurbox[1])
			
			local time=getRealTime()
			local monthday=time.monthday
			
			dgsCreateLabel(5,7,100,20,"Merry Christmas wünscht dir das "..settings.general.servername.." Team.",false,Lakeside.Window[1])
			
			Lakeside.Button[2]=dgsCreateButton(5,45,125,45,"Türchen 1\n01.12.2019",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[3]=dgsCreateButton(135,45,125,45,"Türchen 2\n02.12.2019",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[4]=dgsCreateButton(265,45,125,45,"Türchen 3\n03.12.2019",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[5]=dgsCreateButton(395,45,125,45,"Türchen 4\n04.12.2019",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[6]=dgsCreateButton(5,95,125,45,"Türchen 5\n05.12.2019",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[7]=dgsCreateButton(135,95,125,45,"Türchen 6\n06.12.2019",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[8]=dgsCreateButton(265,95,125,45,"Türchen 7\n07.12.2019",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[9]=dgsCreateButton(395,95,125,45,"Türchen 8\n08.12.2019",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[10]=dgsCreateButton(5,145,125,45,"Türchen 9\n09.12.2019",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[11]=dgsCreateButton(135,145,125,45,"Türchen 10\n10.12.2019",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[12]=dgsCreateButton(265,145,125,45,"Türchen 11\n11.12.2019",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[13]=dgsCreateButton(395,145,125,45,"Türchen 12\n12.12.2019",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[14]=dgsCreateButton(5,195,125,45,"Türchen 13\n13.12.2019",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[15]=dgsCreateButton(135,195,125,45,"Türchen 14\n14.12.2019",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[16]=dgsCreateButton(265,195,125,45,"Türchen 15\n15.12.2019",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[17]=dgsCreateButton(395,195,125,45,"Türchen 16\n16.12.2019",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[18]=dgsCreateButton(5,245,125,45,"Türchen 17\n17.12.2019",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[19]=dgsCreateButton(135,245,125,45,"Türchen 18\n18.12.2019",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[20]=dgsCreateButton(265,245,125,45,"Türchen 19\n19.12.2019",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[21]=dgsCreateButton(395,245,125,45,"Türchen 20\n20.12.2019",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[22]=dgsCreateButton(5,295,125,45,"Türchen 21\n21.12.2019",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[23]=dgsCreateButton(135,295,125,45,"Türchen 22\n22.12.2019",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[24]=dgsCreateButton(265,295,125,45,"Türchen 23\n23.12.2019",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			Lakeside.Button[25]=dgsCreateButton(395,295,125,45,"Türchen 24\n24.12.2019",false,Lakeside.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			if(settings.general.christmas==true)then
				if(monthday==1)then
					dgsSetEnabled(Lakeside.Button[2],true)
				else
					dgsSetEnabled(Lakeside.Button[2],false)
				end
				if(monthday==2)then
					dgsSetEnabled(Lakeside.Button[3],true)
				else
					dgsSetEnabled(Lakeside.Button[3],false)
				end
				if(monthday==3)then
					dgsSetEnabled(Lakeside.Button[4],true)
				else
					dgsSetEnabled(Lakeside.Button[4],false)
				end
				if(monthday==4)then
					dgsSetEnabled(Lakeside.Button[5],true)
				else
					dgsSetEnabled(Lakeside.Button[5],false)
				end
				if(monthday==5)then
					dgsSetEnabled(Lakeside.Button[6],true)
				else
					dgsSetEnabled(Lakeside.Button[6],false)
				end
				if(monthday==6)then
					dgsSetEnabled(Lakeside.Button[7],true)
				else
					dgsSetEnabled(Lakeside.Button[7],false)
				end
				if(monthday==7)then
					dgsSetEnabled(Lakeside.Button[8],true)
				else
					dgsSetEnabled(Lakeside.Button[8],false)
				end
				if(monthday==8)then
					dgsSetEnabled(Lakeside.Button[9],true)
				else
					dgsSetEnabled(Lakeside.Button[9],false)
				end
				if(monthday==9)then
					dgsSetEnabled(Lakeside.Button[10],true)
				else
					dgsSetEnabled(Lakeside.Button[10],false)
				end
				if(monthday==10)then
					dgsSetEnabled(Lakeside.Button[11],true)
				else
					dgsSetEnabled(Lakeside.Button[11],false)
				end
				if(monthday==11)then
					dgsSetEnabled(Lakeside.Button[12],true)
				else
					dgsSetEnabled(Lakeside.Button[12],false)
				end
				if(monthday==12)then
					dgsSetEnabled(Lakeside.Button[13],true)
				else
					dgsSetEnabled(Lakeside.Button[13],false)
				end
				if(monthday==13)then
					dgsSetEnabled(Lakeside.Button[14],true)
				else
					dgsSetEnabled(Lakeside.Button[14],false)
				end
				if(monthday==14)then
					dgsSetEnabled(Lakeside.Button[15],true)
				else
					dgsSetEnabled(Lakeside.Button[15],false)
				end
				if(monthday==15)then
					dgsSetEnabled(Lakeside.Button[16],true)
				else
					dgsSetEnabled(Lakeside.Button[16],false)
				end
				if(monthday==16)then
					dgsSetEnabled(Lakeside.Button[17],true)
				else
					dgsSetEnabled(Lakeside.Button[17],false)
				end
				if(monthday==17)then
					dgsSetEnabled(Lakeside.Button[18],true)
				else
					dgsSetEnabled(Lakeside.Button[18],false)
				end
				if(monthday==18)then
					dgsSetEnabled(Lakeside.Button[19],true)
				else
					dgsSetEnabled(Lakeside.Button[19],false)
				end
				if(monthday==19)then
					dgsSetEnabled(Lakeside.Button[20],true)
				else
					dgsSetEnabled(Lakeside.Button[20],false)
				end
				if(monthday==20)then
					dgsSetEnabled(Lakeside.Button[21],true)
				else
					dgsSetEnabled(Lakeside.Button[21],false)
				end
				if(monthday==21)then
					dgsSetEnabled(Lakeside.Button[22],true)
				else
					dgsSetEnabled(Lakeside.Button[22],false)
				end
				if(monthday==22)then
					dgsSetEnabled(Lakeside.Button[23],true)
				else
					dgsSetEnabled(Lakeside.Button[23],false)
				end
				if(monthday==23)then
					dgsSetEnabled(Lakeside.Button[24],true)
				else
					dgsSetEnabled(Lakeside.Button[24],false)
				end
				if(monthday==14)then
					dgsSetEnabled(Lakeside.Button[25],true)
				else
					dgsSetEnabled(Lakeside.Button[25],false)
				end
			end
			
			
			addEventHandler("onDgsMouseClick",Lakeside.Button[25],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("get:christmasPresent",lp,"24")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[24],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("get:christmasPresent",lp,"23")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[23],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("get:christmasPresent",lp,"22")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[22],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("get:christmasPresent",lp,"21")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[21],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("get:christmasPresent",lp,"20")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[20],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("get:christmasPresent",lp,"19")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[19],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("get:christmasPresent",lp,"18")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[18],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("get:christmasPresent",lp,"17")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[17],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("get:christmasPresent",lp,"16")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[16],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("get:christmasPresent",lp,"15")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[15],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("get:christmasPresent",lp,"14")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[14],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("get:christmasPresent",lp,"13")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[13],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("get:christmasPresent",lp,"12")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[12],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("get:christmasPresent",lp,"11")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[11],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("get:christmasPresent",lp,"10")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[10],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("get:christmasPresent",lp,"9")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[9],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("get:christmasPresent",lp,"8")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[8],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("get:christmasPresent",lp,"7")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[7],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("get:christmasPresent",lp,"6")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[6],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("get:christmasPresent",lp,"5")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[5],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("get:christmasPresent",lp,"4")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[4],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("get:christmasPresent",lp,"3")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[3],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("get:christmasPresent",lp,"2")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",Lakeside.Button[2],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("get:christmasPresent",lp,"1")
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
end)








--//Snow Ground shader
local maxEffectDistance=400
local snowApplyList={
	"*"
}
local snowRemoveList={
	"",
	"vehicle*","?emap*","?hite*",
	"*92*","*wheel*","*interior*",
	"*handle*","*body*","*decal*",
	"*8bit*","*logos*","*badge*",
	"*plate*","*sign*",
	"headlight","headlight1",
	"shad*",
	"coronastar",
	"tx*",
	"lod*",
	"cj_w_grad",
	"*cloud*",
	"*smoke*",
	"sphere_cj",
	"particle*",
	"*water*","sw_sand","coral",
}
local treeApplyList={
	"sm_des_bush*","*tree*","*ivy*","*pine*",
	"veg_*","*largefur*","hazelbr*","weeelm",
	"*branch*","cypress*",
	"*bark*","gen_log","trunk5",
	"bchamae","vegaspalm01_128",
}

local naughtyTreeApplyList={
	"planta256","sm_josh_leaf","kbtree4_test","trunk3",
	"newtreeleaves128","ashbrnch","pinelo128","tree19mi",
	"lod_largefurs07","veg_largefurs05","veg_largefurs06",
	"fuzzyplant256","foliage256","cypress1","cypress2",
}



--[[addEventHandler("onClientResourceStart",resourceRoot,
function()
	if(settings.general.christmas==true)then
		triggerEvent("switchGoundSnow",resourceRoot,true)
	end
end)]]

function toggleGoundSnow()
	triggerEvent("switchGoundSnow",resourceRoot,not bEffectEnabled)
end

function switchGoundSnow(typ)
	if(typ)then
		enableGoundSnow()
	else
		disableGoundSnow()
	end
end
addEvent("switchGoundSnow",true)
addEventHandler("switchGoundSnow",lp,switchGoundSnow)



function enableGoundSnow()
	if(bEffectEnabled)then
		return
	end
	snowShader=dxCreateShader(":"..settings.general.scriptname.."/Files/Shaders/Snow/Ground.fx",0,maxEffectDistance)
	treeShader=dxCreateShader(":"..settings.general.scriptname.."/Files/Shaders/Snow/Trees.fx")
	naughtyTreeShader=dxCreateShader(":"..settings.general.scriptname.."/Files/Shaders/Snow/NaughtyTrees.fx")
	sNoiseTexture=dxCreateTexture(":"..settings.general.scriptname.."/Files/Textures/Snow.dds")
	
	if(not snowShader or not treeShader or not naughtyTreeShader or not sNoiseTexture)then
		return nil
	end
	
	dxSetShaderValue(treeShader,"sNoiseTexture",sNoiseTexture)
	dxSetShaderValue(naughtyTreeShader,"sNoiseTexture",sNoiseTexture)
	dxSetShaderValue(snowShader,"sNoiseTexture",sNoiseTexture)
	dxSetShaderValue(snowShader,"sFadeEnd",maxEffectDistance)
	dxSetShaderValue(snowShader,"sFadeStart",maxEffectDistance/2)
	
	for _,v in ipairs(snowApplyList) do
		engineApplyShaderToWorldTexture(snowShader,v)
	end

	for _,v in ipairs(snowRemoveList) do
		engineRemoveShaderFromWorldTexture(snowShader,v)
	end

	for _,v in ipairs(treeApplyList) do
		engineApplyShaderToWorldTexture(treeShader,v)
	end

	for _,v in ipairs(naughtyTreeApplyList) do
		engineApplyShaderToWorldTexture(naughtyTreeShader,v)
	end
	
	
	doneVehTexRemove={}
	vehTimer=setTimer(checkCurrentVehicle,100,0)
	removeVehTextures()
	bEffectEnabled=true
end


function disableGoundSnow()
	if(not bEffectEnabled)then
		return
	end
	sNoiseTexture:destroy()
	treeShader:destroy()
	naughtyTreeShader:destroy()
	snowShader:destroy()
	vehTimer:destroy()
	bEffectEnabled=false
end




function checkCurrentVehicle()
	local veh=getPedOccupiedVehicle(localPlayer)
	local id=veh and getElementModel(veh)
	if(lastveh~=veh or lastid~=id)then
		lastveh=veh
		lastid=id
		removeVehTexturesSoon()
	end
	if(nextCheckTime<getTickCount())then
		nextCheckTime=getTickCount()+5000
		removeVehTextures()
	end
end

function removeVehTexturesSoon()
    nextCheckTime=getTickCount()+200
end

function removeVehTextures ()
	if(not bHasFastRemove)then
		return
	end

	local veh=getPedOccupiedVehicle(localPlayer)
	if(veh)then
		local id=getElementModel(veh)
		local vis=engineGetVisibleTextureNames("*",id)
		if(vis)then	
			for _,removeMatch in pairs(vis)do
				if(not doneVehTexRemove[removeMatch])then
					doneVehTexRemove[removeMatch]=true
					engineRemoveShaderFromWorldTexture(snowShader,removeMatch)
				end
			end
		end
	end
end



_dxCreateShader=dxCreateShader
function dxCreateShader(filepath,priority,maxDistance,bDebug)
	priority=priority or 0
	maxDistance=maxDistance or 0
	bDebug=bDebug or false
	local build=getVersion().sortable:sub(9)
	local fullscreen=not dxGetStatus().SettingWindowed
	if(build<"03236" and fullscreen)then
		maxDistance=0
	end
	return _dxCreateShader(filepath,priority,maxDistance,bDebug)
end


--//Snowfall shader
