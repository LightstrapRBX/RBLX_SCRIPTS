loadstring(game:HttpGet("https://versus-airlines.cf/V3/Loader.lua"))()
-- KEY: YesNiggerThisIsAkeY

getgenv().autoEquipBestWeapons = false
getgenv().autoEquipBestPets = false

task.spawn(function()
    while true do
        if getgenv().autoEquipBestWeapons then
            game:GetService("ReplicatedStorage").Packages.Knit.Services.WeaponInvService.RF.EquipBest:InvokeServer()
        end
        task.wait(5)
    end
end)

task.spawn(function()
    while true do
        if getgenv().autoEquipBestPets then
            game:GetService("ReplicatedStorage").Packages.Knit.Services.PetInvService.RF.EquipBest:InvokeServer()
        end
        task.wait(5)
    end
end)

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()

local window = library.new("SFS Hub", 5013109572)

local page1 = window:addPage("Auto", 5012544693)
local page2 = window:addPage("UI", 5012544693)

local section1 = page1:addSection("Auto Tools")
local section2 = page2:addSection("Window")

section1:addToggle("Auto Equip Best Weapons", nil, function(value)
	getgenv().autoEquipBestWeapons = value
end)

section1:addToggle("Auto Equip Best Pets", nil, function(value)
	getgenv().autoEquipBestPets = value
end)

section2:addKeybind("Toggle Keybind", Enum.KeyCode.RightShift, function()
	window:toggle()
end)

window:SelectPage(window.pages[1], true)