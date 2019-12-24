--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function getCursor()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			showCursor(not(isCursorShowing()))
		end
	end
end
bindKey("m","down",getCursor)
bindKey("ralt","down",getCursor)

function fixCursorBug()
	if(isLoggedin())then
		if(not isElement(Lakeside.Window[1]))then
			setElementData(lp,"ElementClicked",false)
		end
	end
end
addCommandHandler("cursor",fixCursorBug)





--//Barrikade
local object = nil
local placing = false

function placeObject()
	if placing == false then
		local x,y,z = getElementPosition(lp)
		if(x and y and z)then
			object = createObject(1459, x+3, y+3, z)
			setElementCollisionsEnabled(object,false)
			addEventHandler("onClientRender", root, placeObjectRender)
			bindKey("mouse_wheel_up", "down", rotateObject, 5)
			bindKey("mouse_wheel_down", "down", rotateObject, -5)
			bindKey("mouse1", "down", placeObject)
			placing=true
		end
	end
end
addEvent("place:barricade",true)
addEventHandler("place:barricade",lp,placeObject)

function placeObjectRender()
	if isCursorShowing() then
		if(getElementData(lp,"ElementClicked")==false)then
			local screenx, screeny, worldx, worldy, worldz = getCursorPosition()
			local px, py, pz = getCameraMatrix()
			local hit, x, y, z, elementHit = processLineOfSight(px, py, pz, worldx, worldy, worldz)
			if hit then
				if not elementHit and elementHit ~= object then
					setElementPosition(object, x, y, z+0.5)
				end
			end
		end
	end
end

function rotateObject(key,keyState,amount)
	if(object)then
		local rx,ry,rz=getElementRotation(object)
		setElementRotation(object,rx,ry,rz+amount)
	end
end

function placeObject(key,keyState)
	local id=getElementModel(object)
	local x,y,z=getElementPosition(object)
	local rx,ry,rz=getElementRotation(object)
	destroyElement(object)
	placing=false
	removeBinds()
	triggerServerEvent("createNewsObject",root,id,x,y,z,rx,ry,rz)
	syncClientSetElementData("Barrikade",tonumber(syncClientGetElementData("Barrikade"))-1)
	triggerEvent("draw:infobox",lp,"success","Barrikade erfolgreich gesetzt!")
end

function setNewsUnbreakable(obj)
	if(obj)then
		setObjectBreakable(obj,false)
	end
end
addEvent("set:barricadeunbreakable",true)
addEventHandler("set:barricadeunbreakable",lp,setNewsUnbreakable)

function removeBinds()
	removeEventHandler("onClientRender",root,placeObjectRender)
	unbindKey("mouse_wheel_up","down",rotateObject,5)
	unbindKey("mouse_wheel_down","down",rotateObject,-5)
	unbindKey("mouse1","down",placeObject)
end