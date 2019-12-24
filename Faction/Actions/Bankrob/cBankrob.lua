--//                                                  \\
--||   Project: MTA - German LSR Reallife Gamemode    ||
--||   Developers: Lorenzo & Bonus                    ||
--||   Version: 3.6                                   ||
--||   URL: Reallife-SA.de                            ||
--\\                                                  //

function cancelPedDamageBank(attacker)
	if(not fac)then
		return
	end
	
	if(not attacker)then
		cancelEvent()
	end
	
	local fac=getElementData(attacker,"Faction")
	
	if(fac==3 or fac==4 or fac==5)then
	else
		cancelEvent()
	end	

end

function makeTheBankPedCool(ped)
	addEventHandler("onClientPedDamage",ped,cancelPedDamageBank)
end
addEvent("onBankPedGetsCool",true)
addEventHandler( "onBankPedGetsCool",root,makeTheBankPedCool)