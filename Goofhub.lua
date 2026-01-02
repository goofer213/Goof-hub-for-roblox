-- SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local remote = ReplicatedStorage:WaitForChild("GoofHubSettings")

-- CHARACTER
local char, hum, hrp
local function bindChar(c)
    char = c
    hum = c:WaitForChild("Humanoid")
    hrp = c:WaitForChild("HumanoidRootPart")
end
bindChar(player.Character or player.CharacterAdded:Wait())
player.CharacterAdded:Connect(bindChar)

-- OWNER MODE DETECTION
local ownerMode = false
if player.Name:lower() == "hakerfilipcriminal" then
    ownerMode = true
end

-- SETTINGS
local cfg = {
    Speed = 16,
    Jump = 50,
    Hip = 0,
    FOV = 70,
    Fly = false,
    FlySpeed = 100,
    FullBright = false,
    Noclip = false,
    ESP = false
}

-- LOAD SETTINGS
remote.OnClientEvent:Connect(function(data)
    local decoded = HttpService:JSONDecode(data)
    for k,v in pairs(decoded) do
        cfg[k] = v
    end
end)

-- SAVE SETTINGS
local function save()
    remote:FireServer(cfg)
end

-- UI ROOT
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "GoofHub"
gui.ResetOnSpawn = false

-- BLUR
local blur = Instance.new("BlurEffect", Lighting)
blur.Size = 18

-- MAIN FRAME
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.7,0.75)
main.Position = UDim2.fromScale(0.15,0.12)
main.BackgroundColor3 = Color3.fromRGB(24,24,30)
Instance.new("UICorner", main).CornerRadius = UDim.new(0,20)

-- STROKE
local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(120,120,255)
stroke.Thickness = 2

-- DRAG FUNCTIONALITY
local drag, start, pos
main.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag=true start=i.Position pos=main.Position
    end
end)
UIS.InputChanged:Connect(function(i)
    if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
        local d=i.Position-start
        main.Position=UDim2.fromScale(
            pos.X.Scale+d.X/camera.ViewportSize.X,
            pos.Y.Scale+d.Y/camera.ViewportSize.Y
        )
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end
end)

-- MINIMIZE / CLOSE
local min = Instance.new("TextButton", main)
min.Text="–"
min.Size=UDim2.fromScale(0.05,0.06)
min.Position=UDim2.fromScale(0.88,0.01)

local close = Instance.new("TextButton", main)
close.Text="X"
close.Size=UDim2.fromScale(0.05,0.06)
close.Position=UDim2.fromScale(0.94,0.01)

local minimized=false
min.MouseButton1Click:Connect(function()
    minimized=not minimized
    TS:Create(main,TweenInfo.new(0.3),{
        Size=minimized and UDim2.fromScale(0.7,0.1) or UDim2.fromScale(0.7,0.75)
    }):Play()
end)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
    blur:Destroy()
end)

-- HOVER SOUND
local hoverSound = Instance.new("Sound", main)
hoverSound.SoundId = "rbxassetid://9118823101"
hoverSound.Volume = 0.4

-- TOGGLE + SLIDER FUNCTION
local function toggleSlider(text,y,min,max,apply)
    local on=false
    local label=Instance.new("TextLabel",main)
    label.Position=UDim2.fromScale(0.05,y)
    label.Size=UDim2.fromScale(0.4,0.05)
    label.Text=text
    label.TextScaled=true
    label.BackgroundTransparency=1

    local toggle=Instance.new("TextButton",main)
    toggle.Position=UDim2.fromScale(0.47,y)
    toggle.Size=UDim2.fromScale(0.12,0.05)
    toggle.Text="OFF"

    local bar=Instance.new("Frame",main)
    bar.Position=UDim2.fromScale(0.62,y)
    bar.Size=UDim2.fromScale(0.3,0.03)
    bar.BackgroundColor3=Color3.fromRGB(50,50,60)

    local fill=Instance.new("Frame",bar)
    fill.BackgroundColor3=Color3.fromRGB(120,120,255)

    toggle.MouseButton1Click:Connect(function()
        on=not on
        toggle.Text=on and "ON" or "OFF"
        hoverSound:Play()
        if not on then apply(nil) end
    end)

    bar.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then
            local move
            move=UIS.InputChanged:Connect(function(m)
                if m.UserInputType==Enum.UserInputType.MouseMovement then
                    local pct=math.clamp((m.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
                    fill.Size=UDim2.fromScale(pct,1)
                    if on then apply(math.floor(min+(max-min)*pct)) end
                end
            end)
            UIS.InputEnded:Once(function() move:Disconnect() save() end)
        end
    end)
end

-- FEATURES SLIDERS / TOGGLES
toggleSlider("Speed",0.15,0,2000,function(v)
    if hum then hum.WalkSpeed=v or 16 end
    cfg.Speed=v
end)
toggleSlider("Jump",0.22,0,800,function(v)
    if hum then hum.JumpPower=v or 50 end
    cfg.Jump=v
end)
toggleSlider("Hip",0.29,0,100,function(v)
    if hum then hum.HipHeight=v or 0 end
    cfg.Hip=v
end)
toggleSlider("FOV",0.36,70,150,function(v)
    if camera then camera.FieldOfView=v or 70 end
    cfg.FOV=v
end)
toggleSlider("Fly Speed",0.43,0,600,function(v)
    cfg.FlySpeed=v
end)

-- NEW FEATURES
-- Noclip
local noclip = false
RS.Stepped:Connect(function()
    if noclip and hrp then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

toggleSlider("Noclip",0.50,0,1,function(v)
    noclip = v==1
end)

-- ESP
local espEnabled = false
local espBoxes = {}
local function createESP(p)
    if p==player or espBoxes[p] then return end
    local box = Instance.new("BoxHandleAdornment")
    box.Adornee = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
    box.Size = Vector3.new(2, 5, 1)
    box.Color3 = Color3.fromRGB(255,0,0)
    box.Transparency = 0.5
    box.AlwaysOnTop = true
    box.Parent = camera
    espBoxes[p] = box
end

local function removeESP(p)
    if espBoxes[p] then espBoxes[p]:Destroy() espBoxes[p]=nil end
end

Players.PlayerAdded:Connect(function(p)
    if espEnabled then createESP(p) end
end)
Players.PlayerRemoving:Connect(removeESP)

RS.RenderStepped:Connect(function()
    if espEnabled then
        for _,p in pairs(Players:GetPlayers()) do
            createESP(p)
        end
    else
        for _,p in pairs(Players:GetPlayers()) do
            removeESP(p)
        end
    end
end)

toggleSlider("ESP",0.57,0,1,function(v)
    espEnabled = v==1
end)

-- TELEPORT
UIS.InputBegan:Connect(function(i,g)
    if g then return end
    if i.KeyCode == Enum.KeyCode.T then -- press T to teleport
        local mouse = player:GetMouse()
        if hrp then hrp.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0,3,0)) end
    end
end)

-- OWNER MODE GREETING
if ownerMode then
    local prompt = Instance.new("TextLabel", main)
    prompt.Position = UDim2.fromScale(0.05,0.05)
    prompt.Size = UDim2.fromScale(0.6,0.05)
    prompt.Text = "Welcome Mr.Goofer, please input the key"
    prompt.TextScaled = true
    prompt.BackgroundTransparency = 1
end
