--=====================================
--        GOOFHUB PRO
--=====================================

-- SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local PlayerGui = player:WaitForChild("PlayerGui")

-- CHARACTER
local char, hum, hrp
local function bindChar(c)
    char = c
    hum = c:WaitForChild("Humanoid")
    hrp = c:WaitForChild("HumanoidRootPart")
end
bindChar(player.Character or player.CharacterAdded:Wait())
player.CharacterAdded:Connect(bindChar)

-- CONFIG
local cfg = {
    Speed = 16,
    Jump = 50,
    HipHeight = 0,
    Fly = false,
    Noclip = false,
    ESP = false,
    FullBright = false
}

-- SCRIPT URLS
local SCRIPTS = {
    IY = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source",
    BN2 = "https://raw.githubusercontent.com/EnesXVC/Breakin2/main/script",
    DMC = "https://rawscripts.net/raw/Universal-Script-DarkMoon-Client-46431",
    ASH = "https://rawscripts.net/raw/99-Nights-in-the-Forest-asura-hub-79348",
    UNIADM = "https://rawscripts.net/raw/Universal-Script-un*led-admin-82103",
    ANTIKNOCK = "https://rawscripts.net/raw/Universal-Script-Anti-Knockback-script-81139",
    UG2 = "https://rawscripts.net/raw/Universal-Script-unexpected-g2-80546"
}

-- LOAD SCRIPT
local function LoadScript(key)
    local url = SCRIPTS[key]
    if url then
        pcall(function()
            loadstring(game:HttpGet(url,true))()
        end)
    end
end

-- APPLY STATS
RS.RenderStepped:Connect(function()
    if hum then
        hum.WalkSpeed = cfg.Speed
        hum.JumpPower = cfg.Jump
        hum.HipHeight = cfg.HipHeight
    end
end)

-- FULLBRIGHT
local function ApplyFullBright(on)
    if on then
        Lighting.Brightness = 3
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
    else
        Lighting.Brightness = 1
        Lighting.ClockTime = 12
        Lighting.FogEnd = 1000
        Lighting.GlobalShadows = true
    end
end

-- ESP
local ESPFolder = Instance.new("Folder", workspace)
ESPFolder.Name = "GoofHubESP"

local function ClearESP()
    ESPFolder:ClearAllChildren()
end

local function CreateESP(plr)
    if plr == player or not plr.Character then return end
    local h = plr.Character:FindFirstChild("HumanoidRootPart")
    if not h then return end

    local box = Instance.new("BoxHandleAdornment")
    box.Adornee = h
    box.Size = Vector3.new(4,6,4)
    box.Color3 = Color3.fromRGB(255,0,0)
    box.AlwaysOnTop = true
    box.Transparency = 0.5
    box.ZIndex = 10
    box.Parent = ESPFolder
end

RS.RenderStepped:Connect(function()
    ClearESP()
    if cfg.ESP then
        for _,plr in pairs(Players:GetPlayers()) do
            pcall(CreateESP, plr)
        end
    end
    ApplyFullBright(cfg.FullBright)
end)

-- FLY / NOCLIP
RS.Stepped:Connect(function()
    if char then
        if cfg.Noclip then
            for _,p in pairs(char:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = false end
            end
        end
        if cfg.Fly and hrp then
            local vel = Vector3.zero
            if UIS:IsKeyDown(Enum.KeyCode.W) then vel += camera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then vel -= camera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then vel -= camera.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then vel += camera.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then vel += Vector3.new(0,1,0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then vel -= Vector3.new(0,1,0) end
            hrp.Velocity = vel * cfg.Speed
        end
    end
end)

-- GUI
local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "GoofHubPro"

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.55,0.65)
main.Position = UDim2.fromScale(0.22,0.18)
main.BackgroundColor3 = Color3.fromRGB(20,22,30)
Instance.new("UICorner", main).CornerRadius = UDim.new(0,20)

-- TITLE
local title = Instance.new("TextLabel", main)
title.Size = UDim2.fromScale(1,0.1)
title.BackgroundTransparency = 1
title.Text = "GoofHub Pro"
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(220,220,255)

-- CONTENT
local function button(parent,text,cb)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.fromScale(0.9,0.08)
    b.Position = UDim2.fromScale(0.05,0,0)
    b.Text = text
    b.TextScaled = true
    b.BackgroundColor3 = Color3.fromRGB(40,45,65)
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(cb)
    return b
end

local y = 0.12
local function add(btn)
    btn.Position = UDim2.fromScale(0.05,y)
    y += 0.09
end

add(button(main,"Speed +5",function() cfg.Speed += 5 end))
add(button(main,"Jump +10",function() cfg.Jump += 10 end))
add(button(main,"HipHeight +1",function() cfg.HipHeight += 1 end))
add(button(main,"Toggle Fly",function() cfg.Fly = not cfg.Fly end))
add(button(main,"Toggle Noclip",function() cfg.Noclip = not cfg.Noclip end))
add(button(main,"Toggle ESP",function() cfg.ESP = not cfg.ESP end))
add(button(main,"Toggle FullBright",function() cfg.FullBright = not cfg.FullBright end))
add(button(main,"Load Infinite Yield",function() LoadScript("IY") end))
add(button(main,"Load BreakIn2",function() LoadScript("BN2") end))
add(button(main,"Load DarkMoon",function() LoadScript("DMC") end))
add(button(main,"Load Asura Hub",function() LoadScript("ASH") end))
add(button(main,"Load UniAdmin",function() LoadScript("UNIADM") end))
add(button(main,"Load AntiKnock",function() LoadScript("ANTIKNOCK") end))
add(button(main,"Load UG2",function() LoadScript("UG2") end))

-- UI TOGGLE
UIS.InputBegan:Connect(function(i,g)
    if g then return end
    if i.KeyCode == Enum.KeyCode.G then
        main.Visible = not main.Visible
    end
end)

-- CHAT COMMANDS
player.Chatted:Connect(function(msg)
    msg = msg:lower()
    if msg == "?fly" then cfg.Fly = true end
    if msg == "?unfly" then cfg.Fly = false end
    if msg == "?esp" then cfg.ESP = not cfg.ESP end
    if msg == "?fullbright" then cfg.FullBright = not cfg.FullBright end
    if msg:sub(1,5) == "?load" then
        LoadScript(msg:sub(7):upper())
    end
end)

print("✅ GoofHub Pro Loaded")
