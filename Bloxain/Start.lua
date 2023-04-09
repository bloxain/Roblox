local MainDir = 'Bloxain'
_G.BloxainSettings = {Path = MainDir, Games = MainDir..'/Games', Modules = MainDir..'/Modules', WebAddress = 'https://raw.githubusercontent.com/bloxain/Roblox/Beta/', OldUpdate = MainDir..'/Update.JSON'}
local Modules = _G.BloxainSettings.Modules
local WebAddress = _G.BloxainSettings.WebAddress
print(WebAddress..Modules..'/Updater.lua')
print(syn.request({Url = WebAddress..Modules..'/Updater.lua', Method = "GET"}).Body)
loadstring(syn.request({Url = WebAddress..Modules..'/Updater.lua', Method = "GET"}).Body)()
loadstring(readfile(Modules..'/Game_Finder.Lua'))()
