local lib = loadstring(game:HttpGet "https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()
local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()

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

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

task.spawn(function()
    _G.wl_key = _G.LH_Keys[1] or "e473c4176b80b197d8ba696b62905b6e12064242"
    _G.FastLoad = true
    
    loadstring(game:HttpGet('https://raw.githubusercontent.com/diepedyt/bui/main/mainLoader.lua'))()
end)

task.spawn(function()
    getgenv().key = _G.LH_Keys[2] or "YoMamaLovesSomeNiggaPorn"
    loadstring(game:HttpGet("https://versus-airlines.cf/scripts/loader.lua"))()
end)

task.spawn(function()
    local function disableUI(name)
        game.Players.LocalPlayer.PlayerGui:FindFirstChild(name).Enabled = false
    end
    
    local uiToDisable = {
        "RewardItem",
        "Transition",
        "Darken"
    }
    
    for _, uiName in pairs(uiToDisable) do
        disableUI(uiName)
    end
end)