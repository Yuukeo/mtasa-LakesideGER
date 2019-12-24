--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo) & Xendom       ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function offlineMSG(Username,text)
	if(Username and text)then
		handler:exec("INSERT INTO offlinemessages (Username,Text) VALUES (?,?)",Username,text)
	end
end

function checkOfflineMSG(player)
	local messages=dbPoll(dbQuery(handler,"SELECT * FROM ??","offlinemessages"),-1)
	for _,v in pairs(messages)do
		if(v["Username"]==getPlayerName(player))then
			outputChatBox("[Offline-MSG] "..v["text"],player,150,150,150)
			handler:exec("DELETE FROM ?? WHERE ??=?","offlinemessages","ID",v["id"])
		end
	end
end