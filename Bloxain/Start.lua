local MainDir = 'Bloxain'
_G.BloxainSettings = {Path = MainDir, Games = MainDir..'/Games', Modules = MainDir..'/Modules', WebAddress = 'https://github.com/bloxain/Roblox/raw/Beta/Bloxain/', OldUpdate = MainDir..'/Update.JSON'}
local Modules = _G.BloxainSettings.Modules
local WebAddress = _G.BloxainSettings.WebAddress
pcall(function() loadstring(syn.request({Url = WebAddress..Modules..'/Updater.lua', Method = "GET"}).Body)() end)
loadstring(readfile(Modules..'/Game_Finder.Lua'))()
