getgenv().destroyHub = function()
    local done = false
    repeat
        if game.CoreGui:FindFirstChild("STX_Nofitication") then
            for _, obj in pairs(game.CoreGui.STX_Nofitication:GetChildren()) do
                if obj:IsA("ImageLabel") then
                    obj.Visible = false
                    obj.Position = UDim2.fromScale(0, -.7)
                end
            end
            done = true
        else
            done = true
        end
    until done
    repeat
        if game.CoreGui:FindFirstChild("ui") then
            game.CoreGui.ui:Destroy()
        else
            return
        end
    until not game.CoreGui:FindFirstChild("ui")
    getgenv().UI_TOGGLE_CONNECTION:Disconnect()
end
getgenv().destroyHub()

local lib = loadstring(game:HttpGet "https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()
local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()

getgenv().UI_KeyBind = Enum.KeyCode.RightControl

task.spawn(function()
    local UIS = game:GetService("UserInputService")
    getgenv().UI_TOGGLED = false
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
------------------------------------------------------------------------------

-- [ Hub Setup ] --

local loadingColor = Color3.fromRGB(80, 80, 80)
local doneLoadingColor = Color3.fromRGB(44, 120, 224)
local succesColor = Color3.fromRGB(73, 255, 112)

getgenv().hubDescription = "Loading window..."
getgenv().hubIsLoaded = false

Notification:Notify(
    {
        Title = "LOADING HUB",
        Description = getgenv().hubDescription
    },
    {
        OutlineColor = loadingColor,
        Time = 13.75,
        Type = "default"
    }
)

warn("\n\n\n\n------------------------")
warn("-- [ LOADING LIGHTHUB ] --")

local function initDot(text, time, bypassBase)
    local count = 0
    local base = "Loading "
    local decr = game.CoreGui:WaitForChild("STX_Nofitication"):WaitForChild("ambientShadow").Window.WindowDescription
   
    if not getgenv().initialisingDot then
        getgenv().initialisingDot = true
    end

    getgenv().overrideDotInit = false

    local count = 1
    for i = 1, time, 1 do
        if not decr then break end
        if getgenv().overrideDotInit then getgenv().overrideDotInit = false; break end
        count = i
        if count == 1 then
            if bypassBase then
                decr.Text = text .. "."
            else
                decr.Text = base .. text .. "."
            end
        elseif count == 2 then
            if bypassBase then
                decr.Text = text .. ".."
            else
                decr.Text = base .. text .. ".."
            end
        elseif count == 3 then
            if bypassBase then
                decr.Text = text .. "..."
            else
                decr.Text = base .. text .. "..."
            end
        else
            i = 0
            count = i
            if bypassBase then
                decr.Text = text
            else
                decr.Text = base .. text
            end
        end
        
        task.wait(time/60)
    end
end

------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- [ Initialising ] --

local win = lib:Window("LIGHT HUB | Lightstrap // LDevs#0658", loadingColor, getgenv().UI_KeyBind)

task.spawn(function()
    task.wait(0.5) -- 0.5 passed
    initDot("TBs", 3)
    warn("-- [ LOADING TBs ] --")
    task.wait(3) -- 4 passed
    getgenv().overrideDotInit = true
    initDot("BTNs", 2)
    warn("-- [ LOADING BTNs ] --")
    task.wait(2) -- 5.5 passed
    getgenv().overrideDotInit = true
    initDot("SLDRs", 2.5)
    warn("-- [ LOADING SLDRs ] --")
    task.wait(2.5) -- 8 passed
    getgenv().overrideDotInit = true
    initDot("Finalizing Hub", 3.5, true)
    warn("-- [ FINALIZING HUB ] --")
    task.wait(3.5) -- 11.5 passed
    getgenv().overrideDotInit = true
    initDot("Successfully loaded LightHub", 1.5, true)
    warn("-- [ SUCCESSFULLY LOADED LIGHTHUB ] --")
    warn("------------------------\n\n\n\n")
    task.wait(1.25) -- 13 passed
    getgenv().overrideDotInit = true
    getgenv().hubIsLoaded = true
end)

repeat task.wait() until getgenv().hubIsLoaded

------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- [ Main Tab Setup ] --

local mainTab = win:Tab("Main")

-- do stuff here

-------------------------
-------------------------

-- [ Extra ] --
mainTab:Button("Destroy Hub", function()
    getgenv().destroyHub()
    Notification:Notify(
        {
            Title = "DESTROYED GUI",
            Description = "Goodbye!"
        },
        {
            OutlineColor = succesColor,
            Time = 3.5,
            Type = "default"
        }
    )
end)

------------------------------------------------------------------------------
------------------------------------------------------------------------------

local playersTab = win:Tab("Players")

playersTab:Slider("Change Walk Speed", 0, 500, game.Players.LocalPlayer.Character.Humanoid.WalkSpeed, function(val)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = val
end)

game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = false

playersTab:Slider("Change Jump Power", 0, 250, (game.Players.LocalPlayer.Character.Humanoid.JumpHeight or game.Players.LocalPlayer.Character.Humanoid.JumpPower), function(val)
    if game.Players.LocalPlayer.Character.Humanoid.JumpHeight ~= nil then
        game.Players.LocalPlayer.Character.Humanoid.JumpHeight = val
    else
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = val
    end
end)

task.spawn(function ()
    getgenv().playerTable = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        getgenv().playerTable[player] = player.Name
    end
    game.Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(char)
            getgenv().playerTable[player] = player.Name
        end)
    end)
    game.Players.PlayerRemoving:Connect(function(player)
        getgenv().playerTable[player] = nil
    end)
end)

playersTab:Dropdown("Select Player to TP To", getgenv().playerTable, function(selected)
    getgenv().selectedPlayerToTPTo = selected
end)

playersTab:Button("Teleport to Player", function()
    if getgenv().selectedPlayerToTPTo and getgenv().selectedPlayerToTPTo ~= game.Players.LocalPlayer.Name then
        local playerChar = game.Players.LocalPlayer.Character
        local targetChar = game.Players[getgenv().selectedPlayerToTPTo].Character
        playerChar.HumanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame
    end
end)

----------------------------------------------------------------------------

-- [ Extra ] --

getgenv().infJumpFirstTime = false
getgenv().infJumpEnabled = false

task.spawn(function ()
    local plr = game:GetService('Players').LocalPlayer
	local m = plr:GetMouse()
	m.KeyDown:connect(function(k)
		if getgenv().infJumpEnabled then
			if k:byte() == 32 then
                humanoid = game:GetService'Players'.LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
                humanoid:ChangeState('Jumping')
                task.wait()
                humanoid:ChangeState('Seated')
			end
		end
	end)
end)

playersTab:Toggle("Infinite Jump", false, function(val)
    if not getgenv().infJumpFirstTime then
        getgenv().infJumpFirstTime = true
        getgenv().infJumpEnabled = val
    else
        getgenv().infJumpEnabled = val
    end
end)

------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- [ Executables Tab Setup ] --

local executablesTab = win:Tab("Universal Executables")

getgenv().Executables = {
    SimpleSpy = false;
    DarkDexv3 = false;
}

executablesTab:Button("SimpleSpy", function()
    if not getgenv().Executables.SimpleSpy then
        getgenv().Executables.SimpleSpy = not getgenv().Executables.SimpleSpy
        loadstring(game:HttpGet("https://github.com/exxtremestuffs/SimpleSpySource/raw/master/SimpleSpy.lua"))()
    end
end)

executablesTab:Button("Dark Dex v3", function ()
    if not getgenv().Executables.DarkDexv3 then
        getgenv().Executables.DarkDexv3 = not getgenv().Executables.DarkDexv3
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
    end
end)

------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- [ Executables Tab Setup ] --

if game.PlaceId == 292439477 then
    getgenv().gameExecutables = {
        Strawhook = false;
    }
    local gameExecutables = win:Tab(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. " - Executables")
    gameExecutables:Button("Strawhook Hub", function()
        if not getgenv().gameExecutables.Strawhook then
            getgenv().gameExecutables.Strawhook = not getgenv().gameExecutables.Strawhook
            loadstring(game:HttpGet("https://raw.githubusercontent.com/VoidMasterX/strawhook/main/script.lua", true))()
        end
    end)
elseif game.PlaceId == 6299805723 then
    getgenv().gameExecutables = {
        Zer0Hub = false;
    }
    local gameExecutables = win:Tab("Anime Fighters - Executables")
    gameExecutables:Button("Zer0Hub", function()
        if not getgenv().gameExecutables.Zer0Hub then
            getgenv().gameExecutables.Zer0Hub = not getgenv().gameExecutables.Zer0Hub
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Discord0000/Zer0Hub/main/MainScript.lua"))()
        end
    end)
end

------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- [ Help Tab Setup ] --

local helpTab = win:Tab("Hub Help")

getgenv().keybind = tostring(getgenv().UI_KeyBind)
getgenv().keybind = keybind:gsub("Enum.KeyCode.", "")
helpTab:Label("Toggle hub visibility: ".. getgenv().keybind)

------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- [ Hub Settings Tab Setup ] --

local hub_settingsTab = win:Tab("Hub Settings")

hub_settingsTab:Colorpicker("Change UI Color", Color3.fromRGB(44, 120, 224), function(t)
    lib:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G * 255, t.B * 255))
end)

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

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

task.spawn(function ()
    for _, obj in pairs(game.CoreGui:FindFirstChild("ui").Main.TabHold:GetChildren()) do
        if obj.Name ~= "TabHoldLayout" and string.len(obj.TabTitle.Text) >= 17 then
            obj.TabTitle.TextScaled = true 
        end
    end
end)

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------