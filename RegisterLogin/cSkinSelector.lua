--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo) & Hade         ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local skinSped=nil
local curskin=0
local rdmDIM=math.random(20000,30000)

function showSkinSelector()
	if(isElement(Lakeside.Window[1]))then
		dgsCloseWindow(Lakeside.Window[1])
	end
	if(isElement(Lakeside.Image[22]))then
		Lakeside.Image[22]:destroy()
	end
	setWindowData("add","cursor_clicked",false)
	if(syncClientGetElementData("Gender")=="Male")then
		startSkinID=1
	else
		startSkinID=11
	end
	
	setCameraInterior(14)
	setCameraMatrix(254.7190,-41.1370,1002,256.7190,-41.1370,1002)
	skinSped=createPed(startSkinID,258,-42,1002)
	setElementDimension(skinSped,rdmDIM)
	setElementInterior(skinSped,14)
	setElementInterior(lp,14)
	setElementDimension(lp,rdmDIM)
	setPedRotation(skinSped,87)
	setElementDimension(skinSped,getElementDimension(lp))
	fadeCamera(true,1,0,0,0)
	
	
	Lakeside.Window[22]=dgsCreateWindow(100,100,420,300,"Wähle deinen Skin",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,settings.general.guibgcolor,nil,true)
	dgsWindowSetSizable(Lakeside.Window[22],false)
	dgsWindowSetMovable(Lakeside.Window[22],false)
	setWindowData("add","cursor_clicked",false)
	dgsCreateImage(0,0,420,2,":"..settings.general.scriptname.."/Files/Images/White.png",false,Lakeside.Window[22],settings.general.guilinecolor)
	Lakeside.Blurbox[1]=dgsCreateBlurBox()
	dgsSetProperty(Lakeside.Window[22],"functions",[[
		local arguments = {...}
		local blurbox = arguments[1]
		local renderArguments = renderArguments
		local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
		dgsBlurBoxRender(blurbox,x,y,w,h)
	]],Lakeside.Blurbox[1])
	
	Lakeside.Button[1]=dgsCreateButton(20,120,180,55,"<- Vorheriger Skin",false,Lakeside.Window[22],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
	Lakeside.Button[2]=dgsCreateButton(220,120,180,55,"Nächster Skin ->",false,Lakeside.Window[22],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
	Lakeside.Button[3]=dgsCreateButton(20,200,380,55,"Diesen Skin auswählen!",false,Lakeside.Window[22],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
	
	
	addEventHandler("onDgsMouseClick",Lakeside.Button[1],
		function(btn,state)
			if(btn=="left" and state=="up")then
				changeSkinClick()
			end
		end,
	false)
	
	addEventHandler("onDgsMouseClick",Lakeside.Button[2],
		function(btn,state)
			if(btn=="left" and state=="up")then
				changeSkinClick()
			end
		end,
	false)
	
	addEventHandler("onDgsMouseClick",Lakeside.Button[3],
		function(btn,state)
			if(btn=="left" and state=="up")then
				if(isElement(Lakeside.Window[22]))then
					dgsCloseWindow(Lakeside.Window[22])
				end
				setWindowData("remove","cursor_clicked",false)
				showCursor(false)
				triggerServerEvent("select:skin",lp,getElementModel(skinSped))
			end
		end,
	false)
	
end
addEvent("open:skinselector",true)
addEventHandler("open:skinselector",root,showSkinSelector)

function changeSkinClick()
	local diff=0
	if(source==Lakeside.Button[2])then
		diff=1
	elseif (source==Lakeside.Button[1])then
		diff=-1
	else
		curskin=1
	end
	changeSkin(diff)
end

function changeSkin(diff)
	local array=getSkinGender()
	local skin=0
	if(diff~=nil)then
		curskin=curskin+diff
	end
	if(curskin>#array or curskin<1)then
		curskin=1
		skin=array[1]
	else
		curskin=curskin
		skin=array[curskin]
	end
	if(skin~=nil)then
		setElementModel(skinSped,tonumber(skin))
	end
end

function getSkinGender()
	local array={}
	if(syncClientGetElementData("Gender")=="Male")then 
		array=maleSkins
	elseif(syncClientGetElementData("Gender")=="Female")then 
        array=femaleSkins
	end
	return array
end