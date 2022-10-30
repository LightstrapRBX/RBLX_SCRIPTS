for _, obj in pairs(game:GetService("CoreGui"):GetChildren()) do
    if obj:FindFirstChild("Window") and obj.Window:FindFirstChild("MainUI") then
        obj:Destroy()
    end
end

getgenv().autoUpgrades = {
    ["SpawnLevel"] = {
        toggled = false,
        stopAt = 29,
        max = 29,
    },
    ["SpawnRate"] = {
        toggled = false,
        stopAt = 20,
        max = 20,
    },
    ["Capacity"] = {
        toggled = false,
        stopAt = 15,
        max = 15
    }
}

getgenv().autoRebirthUpgrades = {
    ["Coins"] = false,
    ["Gems"] = false,
    ["Speed"] = false
}

getgenv().autoClick = false
getgenv().autoRebirth = false

getgenv().walkSpeed = 16
getgenv().jumpPower = 50

task.spawn(function()
    local myPlot
    for _, plot in pairs(workspace.Plots:GetChildren()) do
        if plot.Board.UIHolder:FindFirstChildWhichIsA("SurfaceGui") then
            myPlot = plot
            break
        end
    end
    local Content = myPlot.Board.UIHolder.BoardTemplate.Frame.Content

    task.spawn(function()
        local VirtualUser = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end)

    task.spawn(function()
        game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().walkSpeed
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = getgenv().jumpPower
        while task.wait(0.1) do
            if game.Players.LocalPlayer.Character then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().walkSpeed
                game.Players.LocalPlayer.Character.Humanoid.JumpPower = getgenv().jumpPower
            end
        end
        game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
            character.Humanoid.WalkSpeed = getgenv().walkSpeed
            character.Humanoid.JumpPower = getgenv().jumpPower
        end)
    end)

    task.spawn(function()
        while task.wait(0.1) do
            if getgenv().autoClick then
                for _, spawned in pairs(myPlot.Spawned:GetChildren()) do
                    task.spawn(function()
                        fireclickdetector(spawned.Hitbox.ClickDetector, 100)
                    end)
                end
                task.wait()
            end
            task.wait()
        end
    end)

    local upgradeModule = require(game:GetService("ReplicatedStorage").Modules.Network)
    local function fireUpgrade(...)
        upgradeModule:FireServer(...)
    end

    task.spawn(function()
        while task.wait(0.1) do
            for rebirthUpgrade, toggled in pairs(getgenv().autoRebirthUpgrades) do
                task.spawn(function()
                    if toggled then
                        fireUpgrade("Upgrade", rebirthUpgrade)
                    end
                end)
            end
        end
    end)

    task.spawn(function()
        while task.wait(0.25) do
            for upgrade, data in pairs(getgenv().autoUpgrades) do
                task.spawn(function()
                    if data.toggled then
                        local level = Content:FindFirstChild(upgrade, true).Content.Level.Text
                        local shortenedLevel = tonumber(level:match("^(.-)/"))
                        if shortenedLevel < data.stopAt then
                            fireUpgrade("Upgrade", upgrade) 
                        end
                    end
                end)
            end
        end
    end)

    task.spawn(function()
        while task.wait(0.1) do
            if getgenv().autoRebirth then
            fireUpgrade("Upgrade", "Rebirth") 
            end
        end
    end)
end)

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

local UILib = loadstring(game:HttpGet('https://raw.githubusercontent.com/StepBroFurious/Script/main/HydraHubUi.lua'))()
local Window = UILib.new("Halloween Merge Simulator", game.Players.LocalPlayer.Name, "Lightstrap#0658 was here...")

local Category1 = Window:Category("Main", "http://www.roblox.com/asset/?id=8395621517")
local C1_SubButton1 = Category1:Button("Player", "http://www.roblox.com/asset/?id=8395747586")

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

local SB1_Section1 = C1_SubButton1:Section("Walk Speed", "Left")

SB1_Section1:Slider(
    {
        Title = "Walk Speed",
        Description = "",
        Default = 16,
        Min = 0,
        Max = 500
    },
    function(value)
        getgenv().walkSpeed = value
    end
)

SB1_Section1:Slider(
    {
        Title = "Jump Power",
        Description = "",
        Default = 50,
        Min = 0,
        Max = 500
    },
    function(value)
        getgenv().jumpPower = value
    end
)

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

local Category2 = Window:Category("Auto", "http://www.roblox.com/asset/?id=8395621517")
local C2_SubButton1 = Category2:Button("Auto Farms", "http://www.roblox.com/asset/?id=8395747586")

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

local SB2_Section1 = C2_SubButton1:Section("General Autos", "Right")

SB2_Section1:Toggle(
    {
        Title = "Auto Click",
        Description = "Auto clicks pets - fast money",
        Default = getgenv().autoClick
    },
    function(value)
        getgenv().autoClick = value
    end
)

SB2_Section1:Toggle(
    {
        Title = "Auto Rebirth",
        Description = "You know the drill",
        Default = getgenv().autoRebirth
    },
    function(value)
        getgenv().autoRebirth = value
    end
)

-------------------------------------------------------------------------------------------------

local SB2_Section5 = C2_SubButton1:Section("Auto Rebirth Upgrades", "Right")

SB2_Section5:Toggle(
    {
        Title = "Auto Coins",
        Description = "",
        Default = getgenv().autoRebirthUpgrades.Coins
    },
    function(value)
        getgenv().autoRebirthUpgrades.Coins = value
    end
)

SB2_Section5:Toggle(
    {
        Title = "Auto Gems",
        Description = "",
        Default = getgenv().autoRebirthUpgrades.Gems
    },
    function(value)
        getgenv().autoRebirthUpgrades.Gems = value
    end
)

SB2_Section5:Toggle(
    {
        Title = "Auto Speed",
        Description = "",
        Default = getgenv().autoRebirthUpgrades.Speed
    },
    function(value)
        getgenv().autoRebirthUpgrades.Speed = value
    end
)

-------------------------------------------------------------------------------------------------

local SB2_Section2 = C2_SubButton1:Section("Spawn Level", "Left")

SB2_Section2:Toggle(
    {
        Title = "Auto Upgrade",
        Description = "",
        Default = getgenv().autoUpgrades["SpawnLevel"].toggled
    },
    function(value)
        getgenv().autoUpgrades["SpawnLevel"].toggled = value
    end
)

SB2_Section2:Slider(
    {
        Title = "Stop-At Lvl",
        Description = "Lvl to stop auto upgrading.",
        Default = getgenv().autoUpgrades["SpawnLevel"].max,
        Min = 1,
        Max = getgenv().autoUpgrades["SpawnLevel"].max
    },
    function(value)
        getgenv().autoUpgrades["SpawnLevel"].stopAt = value
    end
)

-------------------------------------------------------------------------------------------------

local SB2_Section3 = C2_SubButton1:Section("Spawn Rate", "Left")

SB2_Section3:Toggle(
    {
        Title = "Auto Upgrade",
        Description = "",
        Default = getgenv().autoUpgrades["SpawnRate"].toggled
    },
    function(value)
        getgenv().autoUpgrades["SpawnRate"].toggled = value
    end
)

SB2_Section3:Slider(
    {
        Title = "Stop-At Lvl",
        Description = "Lvl to stop auto upgrading.",
        Default = getgenv().autoUpgrades["SpawnRate"].max,
        Min = 1,
        Max = getgenv().autoUpgrades["SpawnRate"].max
    },
    function(value)
        getgenv().autoUpgrades["SpawnRate"].stopAt = value
    end
)

-------------------------------------------------------------------------------------------------

local SB2_Section4 = C2_SubButton1:Section("Capacity", "Left")

SB2_Section4:Toggle(
    {
        Title = "Auto Upgrade",
        Description = "",
        Default = getgenv().autoUpgrades["Capacity"].toggled
    },
    function(value)
        getgenv().autoUpgrades["Capacity"].toggled = value
    end
)

SB2_Section4:Slider(
    {
        Title = "Stop-At Lvl",
        Description = "Lvl to stop auto upgrading.",
        Default = getgenv().autoUpgrades["Capacity"].max,
        Min = 1,
        Max = getgenv().autoUpgrades["Capacity"].max
    },
    function(value)
        getgenv().autoUpgrades["Capacity"].stopAt = value
    end
)

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------