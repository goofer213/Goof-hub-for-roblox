--====================================================
-- GOOFHUB PRO (FULL VERSION)
-- KEY: 7622134
-- PREFIX: ?
-- TOGGLE UI: G
--====================================================

-- SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local camera = workspace.CurrentCamera
local player = Players.LocalPlayer
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

-- KEY SYSTEM
local VALID_KEY = "7622134"
local unlocked = false
local KeyGui = Instance.new("ScreenGui", PlayerGui)
KeyGui.Name = "GoofHub_Key"
local KF = Instance.new("Frame", KeyGui)
KF.Size = UDim2.fromScale(0.45,0.3)
KF.Position = UDim2.fromScale(0.275,0.35)
KF.BackgroundColor3 = Color3.fromRGB(20,20,30)
Instance.new("UICorner", KF).CornerRadius = UDim.new(0,20)

local KT = Instance.new("TextLabel", KF)
KT.Size = UDim2.fromScale(1,0.3)
KT.BackgroundTransparency = 1
KT.Text = "GoofHub Pro"
KT.TextScaled = true
KT.TextColor3 = Color3.fromRGB(220,220,255)

local KB = Instance.new("TextBox", KF)
KB.Size = UDim2.fromScale(0.8,0.25)
KB.Position = UDim2.fromScale(0.1,0.45)
KB.PlaceholderText = "Enter Key"
KB.TextScaled = true
Instance.new("UICorner", KB)

local KBtn = Instance.new("TextButton", KF)
KBtn.Size = UDim2.fromScale(0.4,0.18)
KBtn.Position = UDim2.fromScale(0.3,0.75)
KBtn.Text = "UNLOCK"
KBtn.TextScaled = true
Instance.new("UICorner", KBtn)

KBtn.MouseButton1Click:Connect(function()
    if KB.Text == VALID_KEY then
        unlocked = true
        KeyGui:Destroy()
    else
        KT.Text = "Wrong Key"
        KB.Text = ""
    end
end)

repeat task.wait() until unlocked

-- MAIN GUI
local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "GoofHub"
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.72,0.75)
main.Position = UDim2.fromScale(0.14,0.12)
main.BackgroundColor3 = Color3.fromRGB(18,18,26)
Instance.new("UICorner",main).CornerRadius = UDim.new(0,26)

-- DRAG
do
    local drag, sp, sf
    main.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then
            drag=true; sp=i.Position; sf=main.Position
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if drag and i.UserInputType==Enum.UserInputType.MouseMovement then
            local d=i.Position-sp
            main.Position=UDim2.fromScale(
                sf.X.Scale+d.X/camera.ViewportSize.X,
                sf.Y.Scale+d.Y/camera.ViewportSize.Y
            )
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end
    end)
end

-- SIDEBAR
local side = Instance.new("Frame",main)
side.Size = UDim2.fromScale(0.22,0.86)
side.Position = UDim2.fromScale(0.02,0.12)
side.BackgroundColor3 = Color3.fromRGB(28,30,40)
Instance.new("UICorner",side)

-- PAGES SYSTEM
local pages = {}
local function newPage(name)
    local p = Instance.new("Frame", main)
    p.Size = UDim2.fromScale(0.72,0.86)
    p.Position = UDim2.fromScale(0.26,0.12)
    p.BackgroundTransparency = 1
    p.Visible = false
    Instance.new("UIListLayout",p).Padding = UDim.new(0,10)
    pages[name] = p
    return p
end
local function tabButton(name,page)
    local b = Instance.new("TextButton", side)
    b.Size = UDim2.fromScale(1,0.12)
    b.Text = name
    b.TextScaled = true
    b.BackgroundColor3 = Color3.fromRGB(40,42,55)
    b.TextColor3 = Color3.fromRGB(220,220,255)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        for _,v in pairs(pages) do v.Visible = false end
        page.Visible = true
    end)
end

-- PAGES
local pPlayer = newPage("Player")
local pESP = newPage("ESP")
local pScripts = newPage("Scripts")
local pUsers = newPage("Users")
local pSettings = newPage("Settings")
pPlayer.Visible = true

tabButton("Player", pPlayer)
tabButton("ESP", pESP)
tabButton("Scripts", pScripts)
tabButton("Users", pUsers)
tabButton("Settings", pSettings)

-- UI HELPERS
local function toggle(parent,text,cb)
    local b=Instance.new("TextButton",parent)
    b.Size=UDim2.fromScale(1,0.14)
    b.Text=text..": OFF"
    b.TextScaled=true
    Instance.new("UICorner",b)
    local on=false
    b.MouseButton1Click:Connect(function()
        on=not on
        b.Text=text..": "..(on and "ON" or "OFF")
        cb(on)
    end)
end
local function slider(parent,text,min,max,cb)
    local f=Instance.new("Frame",parent)
    f.Size=UDim2.fromScale(1,0.14)
    Instance.new("UICorner",f)
    local t=Instance.new("TextLabel",f)
    t.Size=UDim2.fromScale(0.4,1)
    t.BackgroundTransparency = 1
    t.Text = text
    t.TextScaled = true
    local bar = Instance.new("Frame",f)
    bar.Size = UDim2.fromScale(0.5,0.25)
    bar.Position = UDim2.fromScale(0.45,0.38)
    local fill = Instance.new("Frame",bar)
    fill.Size = UDim2.fromScale(0,1)
    bar.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then
            local mv
            mv = UIS.InputChanged:Connect(function(m)
                if m.UserInputType==Enum.UserInputType.MouseMovement then
                    local p = math.clamp((m.Position.X - bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
                    fill.Size=UDim2.fromScale(p,1)
                    cb(math.floor(min+(max-min)*p))
                end
            end)
            UIS.InputEnded:Once(function() mv:Disconnect() end)
        end
    end)
end

-- PLAYER PAGE
slider(pPlayer,"Speed",16,300,function(v) if hum then hum.WalkSpeed=v end end)
slider(pPlayer,"Jump Power",50,300,function(v) if hum then hum.JumpPower=v end end)
slider(pPlayer,"Hip Height",0,10,function(v) if hum then hum.HipHeight=v end end)

local flying=false
toggle(pPlayer,"Fly",function(v) flying=v end)
toggle(pPlayer,"Noclip",function(v)
    RS.Stepped:Connect(function()
        if v and char then
            for _,p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide=false end
            end
        end
    end)
end)

-- FULLBRIGHT
toggle(pSettings,"FullBright",function(v)
    Lighting.Brightness = v and 5 or 1
    Lighting.ClockTime = v and 14 or 12
end)

-- ESP
toggle(pESP,"Player ESP",function(on)
    for _,plr in ipairs(Players:GetPlayers()) do
        if plr.Character and plr~=player then
            if on then
                if not plr.Character:FindFirstChild("ESP") then
                    Instance.new("Highlight",plr.Character).Name="ESP"
                end
            else
                local h=plr.Character:FindFirstChild("ESP")
                if h then h:Destroy() end
            end
        end
    end
end)

-- SCRIPTS
local SCRIPTS={
    iy="https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source",
    bn2="https://raw.githubusercontent.com/EnesXVC/Breakin2/main/script",
    dmc="https://rawscripts.net/raw/Universal-Script-DarkMoon-Client-46431",
    uniadm="https://rawscripts.net/raw/Universal-Script-un*led-admin-82103",
    antiknock="https://rawscripts.net/raw/Universal-Script-Anti-Knockback-script-81139",
    ug2="https://rawscripts.net/raw/Universal-Script-unexpected-g2-80546"
}

local function loadScript(id)
    local url=SCRIPTS[id]
    if url then pcall(function() loadstring(game:HttpGet(url,true))() end) end
end

for k,_ in pairs(SCRIPTS) do
    local b=Instance.new("TextButton",pScripts)
    b.Size=UDim2.fromScale(1,0.12)
    b.Text="Load "..k
    b.TextScaled=true
    Instance.new("UICorner",b)
    b.MouseButton1Click:Connect(function() loadScript(k) end)
end

-- USERS TAB
for _,plr in ipairs(Players:GetPlayers()) do
    local b=Instance.new("TextButton",pUsers)
    b.Size=UDim2.fromScale(1,0.12)
    b.Text=plr.Name.." | "..plr.UserId
    b.TextScaled=true
    Instance.new("UICorner",b)
    b.MouseButton1Click:Connect(function()
        if setclipboard then setclipboard(plr.Name.." "..plr.UserId) end
    end)
end

-- CHAT COMMANDS
player.Chatted:Connect(function(msg)
    msg=msg:lower()
    if msg=="?fly" then flying=true end
    if msg=="?unfly" then flying=false end
    if msg:sub(1,5)=="?load" then loadScript(msg:sub(7)) end
end)

-- FLY LOOP
RS.RenderStepped:Connect(function()
    if flying and hrp then
        local vel = Vector3.new(0,0,0)
        if UIS:IsKeyDown(Enum.KeyCode.W) then vel=vel+camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then vel=vel-camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then vel=vel-camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then vel=vel+camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then vel=vel+Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then vel=vel+Vector3.new(0,-1,0) end
        hrp.Velocity = vel * (hum and hum.WalkSpeed or 16)
    end
end)

-- UI TOGGLE
UIS.InputBegan:Connect(function(i,g)
    if not g and i.KeyCode==Enum.KeyCode.G then
        main.Visible=not main.Visible
    end
end)

print("✅ GoofHub Pro Loaded Successfully")
