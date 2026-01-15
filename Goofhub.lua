--====================================================
-- GOOFHUB PRO
-- Key: goofy321123
-- Toggle UI: G
--====================================================

-- SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local PlayerGui = player:FindFirstChildOfClass("PlayerGui")

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
    Hip = 0,
    Fly = false,
    Noclip = false,
    ESP = false,
    FullBright = false,
    Theme = "Purple"
}

--====================================================
-- KEY SYSTEM
--====================================================
local function KeySystem()
    local g = Instance.new("ScreenGui", PlayerGui)
    g.ResetOnSpawn = false

    local f = Instance.new("Frame", g)
    f.Size = UDim2.fromScale(0.4,0.25)
    f.Position = UDim2.fromScale(0.3,0.35)
    f.BackgroundColor3 = Color3.fromRGB(20,20,30)
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,20)

    local t = Instance.new("TextLabel", f)
    t.Size = UDim2.fromScale(1,0.3)
    t.BackgroundTransparency = 1
    t.Text = "GoofHub Pro"
    t.TextScaled = true
    t.TextColor3 = Color3.fromRGB(220,180,255)

    local box = Instance.new("TextBox", f)
    box.Size = UDim2.fromScale(0.8,0.25)
    box.Position = UDim2.fromScale(0.1,0.4)
    box.PlaceholderText = "Enter Key"
    box.TextScaled = true
    box.BackgroundColor3 = Color3.fromRGB(30,30,45)
    box.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,12)

    local b = Instance.new("TextButton", f)
    b.Size = UDim2.fromScale(0.4,0.2)
    b.Position = UDim2.fromScale(0.3,0.72)
    b.Text = "UNLOCK"
    b.TextScaled = true
    b.BackgroundColor3 = Color3.fromRGB(140,80,255)
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,12)

    local ok = false
    b.MouseButton1Click:Connect(function()
        if box.Text == "goofy321123" then
            ok = true
            g:Destroy()
        else
            box.Text = ""
        end
    end)

    repeat task.wait() until ok
end
KeySystem()

--====================================================
-- MAIN UI
--====================================================
local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "GoofHub Pro"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.65,0.75)
main.Position = UDim2.fromScale(0.175,0.12)
main.BackgroundColor3 = Color3.fromRGB(18,18,26)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,24)

local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(170,90,255)

-- TITLE
local title = Instance.new("TextLabel", main)
title.Size = UDim2.fromScale(1,0.08)
title.BackgroundTransparency = 1
title.Text = "🔥 GoofHub Pro"
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.TextColor3 = Color3.fromRGB(230,200,255)

--====================================================
-- SIDEBAR
--====================================================
local side = Instance.new("Frame", main)
side.Size = UDim2.fromScale(0.22,0.9)
side.Position = UDim2.fromScale(0,0.1)
side.BackgroundColor3 = Color3.fromRGB(25,25,40)
Instance.new("UICorner", side).CornerRadius = UDim.new(0,18)

local sideLayout = Instance.new("UIListLayout", side)
sideLayout.Padding = UDim.new(0,10)

--====================================================
-- PAGES
--====================================================
local pages = {}

local function newPage()
    local p = Instance.new("Frame", main)
    p.Size = UDim2.fromScale(0.75,0.9)
    p.Position = UDim2.fromScale(0.23,0.1)
    p.BackgroundTransparency = 1
    p.Visible = false
    Instance.new("UIListLayout", p).Padding = UDim.new(0,10)
    table.insert(pages,p)
    return p
end

local PlayerPage = newPage()
local VisualPage = newPage()
local ScriptsPage = newPage()
local SettingsPage = newPage()
PlayerPage.Visible = true

local function Tab(name,page)
    local b = Instance.new("TextButton", side)
    b.Size = UDim2.fromScale(1,0.1)
    b.Text = name
    b.TextScaled = true
    b.BackgroundColor3 = Color3.fromRGB(40,40,65)
    b.TextColor3 = Color3.fromRGB(230,230,255)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,14)

    b.MouseButton1Click:Connect(function()
        for _,p in ipairs(pages) do p.Visible = false end
        page.Visible = true
    end)
end

Tab("Player",PlayerPage)
Tab("Visual",VisualPage)
Tab("Scripts",ScriptsPage)
Tab("Settings",SettingsPage)

--====================================================
-- UI ELEMENTS
--====================================================
local function toggle(parent,text,cb)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.fromScale(0.9,0.1)
    b.Text = text..": OFF"
    b.TextScaled = true
    b.BackgroundColor3 = Color3.fromRGB(45,45,70)
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,14)
    local on=false
    b.MouseButton1Click:Connect(function()
        on = not on
        b.Text = text..": "..(on and "ON" or "OFF")
        cb(on)
    end)
end

local function slider(parent,text,min,max,cb)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.fromScale(0.9,0.1)
    f.BackgroundColor3 = Color3.fromRGB(40,40,60)
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,14)

    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.fromScale(0.4,1)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextScaled = true
    l.TextColor3 = Color3.new(1,1,1)

    local bar = Instance.new("TextButton", f)
    bar.Size = UDim2.fromScale(0.5,0.3)
    bar.Position = UDim2.fromScale(0.45,0.35)
    bar.Text = ""

    bar.MouseButton1Down:Connect(function()
        local mv
        mv = UIS.InputChanged:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseMovement then
                local p = math.clamp((i.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
                cb(math.floor(min+(max-min)*p))
            end
        end)
        UIS.InputEnded:Once(function() mv:Disconnect() end)
    end)
end

--====================================================
-- PLAYER
--====================================================
slider(PlayerPage,"Speed",16,300,function(v) hum.WalkSpeed=v end)
slider(PlayerPage,"Jump Power",50,300,function(v) hum.JumpPower=v end)
slider(PlayerPage,"Hip Height",0,50,function(v) hum.HipHeight=v end)
toggle(PlayerPage,"Fly",function(v) cfg.Fly=v end)
toggle(PlayerPage,"Noclip",function(v) cfg.Noclip=v end)

--====================================================
-- VISUAL
--====================================================
toggle(VisualPage,"ESP",function(v) cfg.ESP=v end)
toggle(VisualPage,"FullBright",function(v)
    Lighting.Brightness = v and 3 or 1
    Lighting.ClockTime = v and 14 or 12
end)

--====================================================
-- SCRIPTS
--====================================================
local function ScriptButton(name,url)
    local b = Instance.new("TextButton", ScriptsPage)
    b.Size = UDim2.fromScale(0.9,0.1)
    b.Text = name
    b.TextScaled = true
    b.BackgroundColor3 = Color3.fromRGB(60,60,90)
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,14)
    b.MouseButton1Click:Connect(function()
        pcall(function()
            loadstring(game:HttpGet(url,true))()
        end)
    end)
end

ScriptButton("Infinite Yield","https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")
ScriptButton("DarkMoon","https://rawscripts.net/raw/Universal-Script-DarkMoon-Client-46431")

--====================================================
-- SETTINGS (THEMES)
--====================================================
local function SetTheme(c)
    main.BackgroundColor3 = c
end

local function ThemeBtn(name,color)
    local b = Instance.new("TextButton", SettingsPage)
    b.Size = UDim2.fromScale(0.9,0.1)
    b.Text = name
    b.TextScaled = true
    b.BackgroundColor3 = color
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,14)
    b.MouseButton1Click:Connect(function()
        stroke.Color = color
    end)
end

ThemeBtn("Purple",Color3.fromRGB(170,90,255))
ThemeBtn("Red",Color3.fromRGB(255,80,80))
ThemeBtn("Blue",Color3.fromRGB(80,160,255))

--====================================================
-- CHAT COMMAND SCRIPT LOADER
-- Prefix: ?
-- Command: ?load <name>
--====================================================

local SCRIPT_URLS = {
    iy = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source",
    bn2 = "https://raw.githubusercontent.com/EnesXVC/Breakin2/main/script",
    dmc = "https://rawscripts.net/raw/Universal-Script-DarkMoon-Client-46431",
    uniadm = "https://rawscripts.net/raw/Universal-Script-un*led-admin-82103",
    antiknock = "https://rawscripts.net/raw/Universal-Script-Anti-Knockback-script-81139",
    ug2 = "https://rawscripts.net/raw/Universal-Script-unexpected-g2-80546"
}

local function loadScript(name)
    local url = SCRIPT_URLS[name]
    if not url then
        warn("[GoofHub] Unknown script:", name)
        return
    end

    local ok, err = pcall(function()
        loadstring(game:HttpGet(url, true))()
    end)

    if ok then
        print("[GoofHub] Loaded:", name)
    else
        warn("[GoofHub] Failed to load:", name, err)
    end
end

player.Chatted:Connect(function(msg)
    msg = msg:lower()

    if msg:sub(1,5) == "?load" then
        local args = msg:split(" ")
        local scriptName = args[2]

        if scriptName then
            loadScript(scriptName)
        else
            warn("[GoofHub] Usage: ?load <script>")
        end
    end
end)


--====================================================
-- LOOPS
--====================================================
RS.Stepped:Connect(function()
    if cfg.Noclip and char then
        for _,p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide=false end
        end
    end
end)

RS.RenderStepped:Connect(function()
    if cfg.Fly and hrp then
        local d = Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then d+=camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then d-=camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then d-=camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then d+=camera.CFrame.RightVector end
        hrp.Velocity = d * hum.WalkSpeed
    end
end)

UIS.InputBegan:Connect(function(i,g)
    if not g and i.KeyCode==Enum.KeyCode.G then
        main.Visible = not main.Visible
    end
end)


--// Services
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

--// URLs
local SCRIPTS = {
    ["FE Satan"] = "https://raw.githubusercontent.com/goofer213/Goof-hub-for-roblox/main/Fe_Satan.lua",
    ["Goof Hub"] = "https://raw.githubusercontent.com/goofer213/Goof-hub-for-roblox/main/Goofhub.lua"
}

--// GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GoofHubLoader"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.fromScale(0.3, 0.35)
Frame.Position = UDim2.fromScale(0.35, 0.3)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 12)

local UIListLayout = Instance.new("UIListLayout", Frame)
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

--// Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "Goof Hub Loader"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.Parent = Frame

--// Button creator
local function createButton(text, url)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0.85, 0, 0, 45)
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 18
    Button.Text = text
    Button.Parent = Frame

    Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 8)

    Button.MouseButton1Click:Connect(function()
        Button.Text = "Loading..."
        local success, err = pcall(function()
            loadstring(game:HttpGet(url))()
        end)

        if success then
            Button.Text = "Loaded!"
        else
            Button.Text = "Error (check console)"
            warn("Goof Hub Loader Error:", err)
        end
    end)
end

--// Create buttons
for name, url in pairs(SCRIPTS) do
    createButton(name, url)
end

--// Close button
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0.85, 0, 0, 35)
Close.BackgroundColor3 = Color3.fromRGB(120, 30, 30)
Close.Text = "Close"
Close.TextColor3 = Color3.new(1,1,1)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 16
Close.Parent = Frame

Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 8)

Close.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

print("✅ GoofHub Pro LOADED")
