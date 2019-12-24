--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local updateTimer
local scroll=0
local ziviCounter=0
local lspdCounter=0
local fbiCounter=0
local groveCounter=0
local ballasCounter=0
local mechtowCounter=0
local fahrschuleCounter=0
local rescueCounter=0
plp={}

function refreshScoreboard()
	ziviCounter=0
	lspdCounter=0
	fbiCounter=0
	groveCounter=0
	ballasCounter=0
	yakuzaCounter=0
	mechtowCounter=0
	fahrschuleCounter=0
	rescueCounter=0
	if(isLoggedin(lp))then
		plp={}
		local i=0
		for i,v in ipairs(getElementsByType("player"))do
			local ping=getPlayerPing(v)
			local name=getPlayerName(v)
			
			if(isLoggedin(v))then
				telenr=tonumber(getElementData(v,"Telenr"))
				unternehmen=tonumber(getElementData(v,"Company"))
				companyrang=settings.company.ranknames.levelnames[unternehmen]
				fraktion=tonumber(getElementData(v,"Faction"))
				factionrang=settings.faction.ranknames.levelnames[fraktion]
				alevel=tonumber(getElementData(v,"AdminLvL"))or 0
				adminrang=settings.admin.levelnames[alevel]
				playingtime=tonumber(getElementData(v,"Playtime"))
				spielzeit=math.floor(playingtime/60)..":"..(playingtime-math.floor(playingtime/60)*60)
			else
				adminrang="-"
				spielzeit="-"
				playingtime="-"
				telenr=0
				alevel=0
				fraktion=0
				unternehmen=0
				factionrang="-"
				companyrang="-"
			end
			
			plp[i]={}
			plp[i].name=name
			plp[i].adminrang=adminrang
			plp[i].telenr=telenr
			plp[i].alevel=alevel
			plp[i].spielzeit=spielzeit
			plp[i].playingtime=playingtime
			plp[i].fraktion=fraktion
			plp[i].factionrang=factionrang
			plp[i].unternehmen=unternehmen
			plp[i].companyrang=companyrang
			plp[i].ping=ping
			
			if(getElementData(v,"Faction"))then
				if(tonumber(getElementData(v,"Faction"))==0)then
					ziviCounter=ziviCounter+1
				end
				if(tonumber(getElementData(v,"Faction"))==1)then
					lspdCounter=lspdCounter+1
				end
				if(tonumber(getElementData(v,"Faction"))==2)then
					fbiCounter=fbiCounter+1
				end
				if(tonumber(getElementData(v,"Faction"))==3)then
					groveCounter=groveCounter+1
				end
				if(tonumber(getElementData(v,"Faction"))==4)then
					ballasCounter=ballasCounter+1
				end
				if(tonumber(getElementData(v,"Faction"))==5)then
					yakuzaCounter=yakuzaCounter+1
				end
				if(tonumber(getElementData(v,"Company"))==1)then
					mechtowCounter=mechtowCounter+1
				end
				if(tonumber(getElementData(v,"Company"))==2)then
					fahrschuleCounter=fahrschuleCounter+1
				end
				if(tonumber(getElementData(v,"Company"))==3)then
					rescueCounter=rescueCounter+1
				end
			end
			
			i=i+1
			
		end
		table.sort(plp,function(a,b)
			return a.fraktion<b.fraktion
		end)
	end
end

function getPingColor(ping)
	if ping<=50 then
		return 0,200,0
	elseif ping<=150 then
		return 200,200,0
	else
		return 200,0,0
	end
end

function drawScoreboard()
	local rr,gg,bb,aa=10,10,10,160
	if(isLoggedin())then
		if(isPlayerMapVisible(lp)==false)then
			if(getElementData(lp,"ElementClicked")==false)then
				if(getElementData(lp,"intchange")==false)then
					di=0
					--dxDrawImage(GLOBALscreenX/2-680/2+280,GLOBALscreenY/2-400/2-100,140,100,"files/IMAGES/LogoBlack.png")
					
					dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2,680,30,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+32,680,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+59,680,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+86,680,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+113,680,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+140,680,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+167,680,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+194,680,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+221,680,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+248,680,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+275,680,25,tocolor(rr,gg,bb,aa),_)
					
					dxDrawText("Name",GLOBALscreenX/2-680/2+20,GLOBALscreenY/2-400/2+5,680,400,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					dxDrawText("Spielzeit",GLOBALscreenX/2-680/2+215,GLOBALscreenY/2-400/2+4,680,400,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					dxDrawText("Fraktion",GLOBALscreenX/2-680/2+320,GLOBALscreenY/2-400/2+5,680,400,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					dxDrawText("Unternehmen",GLOBALscreenX/2-680/2+445,GLOBALscreenY/2-400/2+5,680,400,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					dxDrawText("Ping",GLOBALscreenX/2-680/2+625,GLOBALscreenY/2-400/2+4,680,400,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					
					for i=0+scroll,10+scroll do
						if(plp[i])then
							pingR,pingG,pingB=getPingColor(plp[i].ping)
							fraktion=plp[i].fraktion
							teamR,teamG,teamB=settings.faction.ranknames.color[fraktion][1],settings.faction.ranknames.color[fraktion][2],settings.faction.ranknames.color[fraktion][3]
							if(isMouseInPosition(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+(di*27)+32,680,25))then
								dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+(di*27)+32,680,25,tocolor(50,50,50,140),false)
								
								dxDrawRectangle(GLOBALscreenX/2-680/2-230,GLOBALscreenY/2-400/2,220,260,tocolor(rr,gg,bb,aa),false)
								dxDrawRectangle(GLOBALscreenX/2-680/2-230,GLOBALscreenY/2-400/2+25,220,2,settings.general.guimaincolor,false)
								dxDrawText("Name: "..plp[i].name,GLOBALscreenX/2-680/2-220,GLOBALscreenY/2-400/2+5,680,200,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,true,_,_)
								dxDrawText("Adminstatus: "..settings.admin.colorToHASH[plp[i].alevel]..""..plp[i].adminrang,GLOBALscreenX/2-680/2-220,GLOBALscreenY/2-400/2+35,680,200,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,true,true,_)
								dxDrawText("Handy Nr.: "..plp[i].telenr,GLOBALscreenX/2-680/2-220,GLOBALscreenY/2-400/2+65,680,200,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,true,_,_)
							end
							
							dxDrawText(plp[i].name,GLOBALscreenX/2-680/2+20,GLOBALscreenY/2-400/2+35+(di*27),680,400,tocolor(255,255,255,255),1.00,dxFONT2,"left","top",_,_,false,_,_)
							dxDrawText(plp[i].spielzeit,GLOBALscreenX/2-680/2+215,GLOBALscreenY/2-400/2+35+(di*27),680,400,tocolor(255,255,255,255),1.00,dxFONT2,"left","top",_,_,false,_,_)
							dxDrawText(plp[i].factionrang,GLOBALscreenX/2-680/2+320,GLOBALscreenY/2-400/2+35+(di*27),680,400,tocolor(teamR,teamG,teamB,255),1.00,dxFONT2,"left","top",_,_,false,_,_)
							dxDrawText(plp[i].companyrang,GLOBALscreenX/2-680/2+445,GLOBALscreenY/2-400/2+35+(di*27),680,400,tocolor(255,255,255,255),1.00,dxFONT2,"left","top",_,_,false,_,_)
							dxDrawText(plp[i].ping,GLOBALscreenX/2-680/2+625,GLOBALscreenY/2-400/2+35+(di*27),680,400,tocolor(pingR,pingG,pingB,255),1.00,dxFONT2,"left","top",_,_,false,_,_)
							
							di=di+1
						end
					end
					
					dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+302,680,90,tocolor(rr,gg,bb,aa),false)
					
					dxDrawText("Zivilisten: "..ziviCounter.."", GLOBALscreenX/2-680/2+5,GLOBALscreenY/2-400/2+305,680,400,tocolor(settings.faction.ranknames.color[0][1],settings.faction.ranknames.color[0][2],settings.faction.ranknames.color[0][3],255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					dxDrawText("L.S.P.D: "..lspdCounter.."", GLOBALscreenX/2-680/2+5,GLOBALscreenY/2-400/2+335,680,400,tocolor(settings.faction.ranknames.color[1][1],settings.faction.ranknames.color[1][2],settings.faction.ranknames.color[1][3],255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					dxDrawText("F.B.I: "..fbiCounter.."", GLOBALscreenX/2-680/2+5,GLOBALscreenY/2-400/2+365,680,400,tocolor(settings.faction.ranknames.color[2][1],settings.faction.ranknames.color[2][2],settings.faction.ranknames.color[2][3],255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					dxDrawText("Grove Street: "..groveCounter.."", GLOBALscreenX/2-680/2+140,GLOBALscreenY/2-400/2+305,680,400,tocolor(settings.faction.ranknames.color[3][1],settings.faction.ranknames.color[3][2],settings.faction.ranknames.color[3][3],255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					dxDrawText("Ballas: "..ballasCounter.."", GLOBALscreenX/2-680/2+140,GLOBALscreenY/2-400/2+335,680,400,tocolor(settings.faction.ranknames.color[4][1],settings.faction.ranknames.color[4][2],settings.faction.ranknames.color[4][3],255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					dxDrawText("Vagos: "..yakuzaCounter.."", GLOBALscreenX/2-680/2+140,GLOBALscreenY/2-400/2+365,680,400,tocolor(settings.faction.ranknames.color[5][1],settings.faction.ranknames.color[5][2],settings.faction.ranknames.color[5][3],255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					dxDrawText("Mech&Tow: "..mechtowCounter.."", GLOBALscreenX/2-680/2+420,GLOBALscreenY/2-400/2+305,680,400,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					dxDrawText("Fahrschule: "..fahrschuleCounter.."", GLOBALscreenX/2-680/2+420,GLOBALscreenY/2-400/2+335,680,400,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					dxDrawText("Rescue Team: "..rescueCounter.."", GLOBALscreenX/2-680/2+420,GLOBALscreenY/2-400/2+365,680,400,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,false,_,_)
				end
			end
		end
	end
end

function scrollDown()
	if(#getElementsByType("player")-scroll<2)then
		scroll=#getElementsByType("player")
	else
		scroll=scroll+2
	end
end

function scrollUp()
	if(scroll<=2)then
		scroll=0
	else
		scroll=scroll-2
	end
end

bindKey("tab","down",function()
	addEventHandler("onClientRender",root,drawScoreboard)
	refreshScoreboard()
	if(isTimer(updateTimer))then
		killTimer(updateTimer)
	end
	updateTimer=setTimer(refreshScoreboard,1500,0)
	bindKey("mouse_wheel_down","down",scrollDown)
	bindKey("mouse_wheel_up","down",scrollUp)
	toggleControl("next_weapon",false)
	toggleControl("previous_weapon",false)
	toggleControl("fire",false)
end)

bindKey("tab","up",function()
	removeEventHandler("onClientRender",root,drawScoreboard)
	unbindKey("mouse_wheel_down","down",scrollDown)
	unbindKey("mouse_wheel_up","down",scrollUp)
	toggleControl("next_weapon",true)
	toggleControl("previous_weapon",true)
	toggleControl("fire",true)
	di=0
	i=0
end)