_G.BloxainSettings = {Path = 'Bloxain', Games = 'Bloxain/Games', Modules = 'Bloxain/Modules', WebAddress = 'https://github.com/bloxain/Roblox/raw/Beta/Bloxain/'}
local Modules = _G.BloxainSettings.Modules
local WebAddress = _G.BloxainSettings.WebAddress
syn.request({Url = WebAddress, Body = 'Started', Method = "POST"})
loadstring(syn.request({Url = WebAddress..Modules..'/Updater.lua', Method = "GET"}).Body)()
loadstring(readfile(Modules..'/Game_Finder.Lua'))()
