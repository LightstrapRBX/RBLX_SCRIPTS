local lib = loadstring(game:HttpGet "https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()
local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()

getgenv().UI_KeyBind = Enum.KeyCode.RightControl
getgenv().UI_TOGGLED = false

task.spawn(function()
    local UIS = game:GetService("UserInputService")
    getgenv().UI_TOGGLE_CONNECTION = UIS.InputBegan:Connect(function(input, GPE)
        if GPE then return end
        if input.KeyCode == getgenv().UI_KeyBind then
            local Main = game.CoreGui.ui:FindFirstChild("Main")
            if not getgenv().UI_TOGGLED then
                Main:TweenSize(
                    UDim2.new(0, 0, 0, 0),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    .2,
                    true
                )
                getgenv().UI_TOGGLED = not getgenv().UI_TOGGLED
            else
                Main:TweenSize(
                    UDim2.new(0, 560, 0, 319),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    .2,
                    true
                )
                getgenv().UI_TOGGLED = not getgenv().UI_TOGGLED
            end
        end
    end)
end)

------------------------------------------------------------------------------

-- [ Hub Setup ] --

local loadingColor = Color3.fromRGB(80, 80, 80)
local doneLoadingColor = Color3.fromRGB(44, 120, 224)
local succesColor = Color3.fromRGB(73, 255, 112)

Notification:Notify(
    {
        Title = "LOADING HUB",
        Description = "..."
    },
    {
        OutlineColor = loadingColor,
        Time = 3,
        Type = "default"
    }
)

local win = lib:Window("LIGHT HUB | Lightstrap // LDevs#0658", loadingColor, getgenv().UI_KeyBind)

getgenv().destroyHub = function()
    repeat
        game.CoreGui.ui:Destroy()
    until not game.CoreGui:FindFirstChild("ui")
    getgenv().UI_TOGGLE_CONNECTION:Disconnect()
end

------------------------------------------------------------------------------

-- [ Main Tab Setup ] --

local Main = win:Tab("Main")

Main:Button("Destroy GUI", function()
    destroyHub()
    Notification:Notify(
        {
            Title = "DESTROYED GUI",
            Description = "Goodbye!"
        },
        {
            OutlineColor = doneLoadingColor,
            Time = 3.5,
            Type = "default"
        }
    )
    return
end)

------------------------------------------------------------------------------

-- [ Executables Tab Setup ] --

local tab2 = win:Tab("Executables")

getgenv().Executables = {
    SimpleSpy = false;
    DarkDexv3 = false;
}

tab2:Button("SimpleSpy", function()
    if not getgenv().Executables.SimpleSpy then
        getgenv().Executables.SimpleSpy = not getgenv().Executables.SimpleSpy
        loadstring(game:HttpGet("https://github.com/exxtremestuffs/SimpleSpySource/raw/master/SimpleSpy.lua"))()
    end
end)

tab2:Button("Dark Dex v3", function ()
    if not getgenv().Executables.DarkDexv3 then
        getgenv().Executables.DarkDexv3 = not getgenv().Executables.DarkDexv3
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
    end
end)

------------------------------------------------------------------------------

-- [ Extra Tab Setup ] --

local changeclr = win:Tab("Change UI Color")

changeclr:Colorpicker("Change UI Color", Color3.fromRGB(44, 120, 224), function(t)
    lib:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G * 255, t.B * 255))
end)

Notification:Notify(
    {
        Title = "SUCCESSFULLY LOADED",
        Description = "Thanks for using!"
    },
    {
        OutlineColor = succesColor,
        Time = 3.5,
        Type = "default"
    }
)

------------------------------------------------------------------------------
