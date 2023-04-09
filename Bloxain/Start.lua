local MainDir = 'Bloxain'
_G.BloxainSettings = {Versoin = '0.7', Path = MainDir, Games = MainDir..'/Games', Modules = MainDir..'/Modules', WebAddress = 'https://raw.githubusercontent.com/bloxain/Roblox/Beta/', OldUpdate = MainDir..'/Update.JSON'}
local Modules = _G.BloxainSettings.Modules
local WebAddress = _G.BloxainSettings.WebAddress
pcall(function() loadstring(syn.request({Url = WebAddress..Modules..'/Updater.lua', Method = "GET"}).Body)() end)
loadstring(readfile(Modules..'/Game_Finder.Lua'))()
