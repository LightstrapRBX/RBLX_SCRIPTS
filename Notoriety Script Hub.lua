local function fireproximityprompt(Obj, Amount, Skip)
    if Obj.ClassName == "ProximityPrompt" then 
        Amount = Amount or 1
        local PromptTime = Obj.HoldDuration
        if Skip then 
            Obj.HoldDuration = 0
        end
        for i = 1, Amount do 
            Obj:InputHoldBegin()
            if not Skip then 
                wait(Obj.HoldDuration)
            end
            Obj:InputHoldEnd()
        end
        Obj.HoldDuration = PromptTime
    else 
        error("userdata<ProximityPrompt> expected")
    end
end

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Notoriety", HidePremium = true, SaveConfig = false, ConfigFolder = "OrionTest"})

local v = workspace.Criminals:WaitForChild(game:GetService("Players").LocalPlayer.Name)

local Tab = Window:MakeTab({
	Name = "Player",
	Icon = "rbxassetid://6802936804",
	PremiumOnly = false
})

local Section = Tab:AddSection({
	Name = "Interaction"
})

local Interact = Tab:AddBind({
	Name = "Interact",
	Default = Enum.KeyCode.T,
	Hold = false,
	Callback = function()
        for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v.Name=="ProximityPrompt" then 
                fireproximityprompt(v,1,true)
            end        
        end    
    end
})

local PickLock = Tab:AddBind({
	Name = "PickLock",
	Default = Enum.KeyCode.Y,
	Hold = false,
	Callback = function()
        for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v.Name=="ProximityPromptPickLock" then 
                fireproximityprompt(v,1,true)
            end        
        end    
    end
})

-------------------------------------------------------------------------
-------------------------------------------------------------------------
-------------------------------------------------------------------------

local Section2 = Tab:AddSection({
	Name = "Player Speed Values"
})

local BaseSpeed = Tab:AddSlider({
	Name = "BaseSpeed",
	Min = v.BaseSpeed.Value,
	Max = 30,
	Default = v.BaseSpeed.Value,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Base Speed (SENSITIVE)",
	Callback = function(Value)
        v.BaseSpeed.Value = (Value)
    end
})

-------------------------------------------------------------------------

local Section3 = Tab:AddSection({
	Name = "Armor Values"
})

local totalArmor = v.Armor.Total.Value
v.Armor.Total.Changed:Connect(function()
    totalArmor = v.Armor.Total.Value
end)

local CurrentArmor = Tab:AddSlider({
	Name = "CurrentArmor",
	Min = v.Armor.Value,
	Max = totalArmor,
	Default = v.Armor.Value,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Current Armor",
	Callback = function(Value)
        v.Armor.Value = (Value)
    end
})

local TotalArmor = Tab:AddSlider({
	Name = "TotalArmor",
	Min = v.Armor.Total.Value,
	Max = 1000000,
	Default = v.Armor.Total.Value,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Total Armor",
	Callback = function(Value)
        v.Armor.Total.Value = (Value)
    end
})

-------------------------------------------------------------------------

local Section4 = Tab:AddSection({
	Name = "Other Values"
})

local Detection = Tab:AddSlider({
	Name = "Detection",
	Min = 0,
	Max = 100,
	Default = v.Detection.Value,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Detection Rate (i would set to 0)",
	Callback = function(Value)
        v.Detection.Value = (Value)
    end
})

local BagSpeed = Tab:AddSlider({
	Name = "BagSpeed",
	Min = v.BagSpeed.Value,
	Max = 50,
	Default = v.BagSpeed.Value,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Movement while carrying Bags (SENSITIVE)",
	Callback = function(Value)
        v.Detection.Value = (Value)
    end
})

local Crit = Tab:AddSlider({
	Name = "Crit",
	Min = v.Crit.Value,
	Max = 500,
	Default = v.Crit.Value,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Crit %+",
	Callback = function(Value)
        v.Crit.Value = (Value)
    end
})

local Dodge = Tab:AddSlider({
	Name = "Dodge",
	Min = v.Dodge.Value,
	Max = 100,
	Default = v.Dodge.Value,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Dodge % (higher = better)",
	Callback = function(Value)
        v.Dodge.Value = (Value)
    end
})

-------------------------------------------------------------------------
-------------------------------------------------------------------------
-------------------------------------------------------------------------

local Tab2 = Window:MakeTab({
    Name = "Teleports",
	Icon = "rbxassetid://6802936804",
	PremiumOnly = false
})

local bind2 = Tab2:AddBind({
	Name = "Teleport Player to Evacuation",
	Default = Enum.KeyCode.P,
	Hold = false,
	Callback = function()
        v.HumanoidRootPart.CFrame = game:GetService("Workspace").BagSecuredArea.FloorPart.CFrame
    end
})

local bind3 = Tab2:AddBind({
	Name = "Move Player 10+ Studs Ahead (noclip thru walls, etc)",
	Default = Enum.KeyCode.V,
	Hold = false,
	Callback = function()
        v.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, -10)
    end
})

local bind1 = Tab2:AddButton({
	Name = "Teleport bags to Evacuation [1]",
	Callback = function()
        for i,v in pairs(game:GetService("Workspace").Bags:GetDescendants()) do
            if v.Name == 'MoneyBag' then
                v.CFrame = game:GetService("Workspace").BagSecuredArea.FloorPart.CFrame * CFrame.new(0,0,0)
            end
        end
    end
})

local bind1_2 = Tab2:AddButton({
	Name = "Teleport bags to Evacuation [2]",
	Callback = function()
        for i,v in pairs(game:GetService("Workspace").Bags:GetDescendants()) do
            if v.Name == 'MoneyBag' then
                v.CFrame = game:GetService("Workspace").BagSecuredArea.FloorPart.CFrame * CFrame.new(0,0,3)
            end
        end
    end
})

local bind1_3 = Tab2:AddButton({
	Name = "Teleport bags to Evacuation [3]",
	Callback = function()
        for i,v in pairs(game:GetService("Workspace").Bags:GetDescendants()) do
            if v.Name == 'MoneyBag' then
                v.CFrame = game:GetService("Workspace").BagSecuredArea.FloorPart.CFrame * CFrame.new(0,0,5)
            end
        end
    end
})

local bind1_4 = Tab2:AddButton({
	Name = "Teleport bags to Evacuation [4]",
	Callback = function()
        for i,v in pairs(game:GetService("Workspace").Bags:GetDescendants()) do
            if v.Name == 'MoneyBag' then
                v.CFrame = game:GetService("Workspace").BagSecuredArea.FloorPart.CFrame * CFrame.new(0,0,7)
            end
        end
    end
})

local bind1_5 = Tab2:AddButton({
	Name = "Teleport bags to Evacuation [5]",
	Callback = function()
        for i,v in pairs(game:GetService("Workspace").Bags:GetDescendants()) do
            if v.Name == 'MoneyBag' then
                v.CFrame = game:GetService("Workspace").BagSecuredArea.FloorPart.CFrame * CFrame.new(0,0,10)
            end
        end
    end
})

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

local Tab3 = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://6802936804",
	PremiumOnly = false
})

Tab3:AddBind({
	Name = "Yeet NPCs",
    Default = Enum.KeyCode.C,
    Hold = false,
	Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/2567-rblx/scripts/main/Notoriety/RemoveNPCs.lua",true))()
  	end    
})
Tab3:AddBind({
	Name = "Delete Glass",
    Default = Enum.KeyCode.B,
    Hold = false,
	Callback = function()
        for i,v in pairs(game:GetService("Workspace").Glass:GetChildren()) do
            if v.Name == 'Glass' then
                v:Destroy()
            end
        end
  	end    
})

OrionLib:Init()
