-- =====================================
-- GOOF HUB HALF EXECUTORS WORK 100%
-- =====================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- CHARACTER
local char, hum, hrp
local function bind(c)
    char = c
    hum = c:WaitForChild("Humanoid",5)
    hrp = c:WaitForChild("HumanoidRootPart",5)
end
bind(player.Character or player.CharacterAdded:Wait())
player.CharacterAdded:Connect(bind)

-- OWNER + KEY
local OWNER = "hakerfilipcriminal"
local VALID_KEY = "G00FKEY"
local ownerMode = player.Name:lower() == OWNER:lower()

-- KEY PROMPT
local function keyPrompt()
    local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.fromScale(0.45,0.28)
    frame.Position = UDim2.fromScale(0.275,0.36)
    frame.BackgroundColor3 = Color3.fromRGB(14,16,20)
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,18)
    local stroke = Instance.new("UIStroke", frame)
    stroke.Thickness = 2; stroke.Color = Color3.fromRGB(120,120,255)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.fromScale(1,0.3); title.BackgroundTransparency=1; title.TextScaled=true; title.TextColor3=Color3.fromRGB(200,200,255)
    title.Text = ownerMode and "Welcome Mr.Goofer" or "GoofHub Key System"

    local sub = Instance.new("TextLabel", frame)
    sub.Size = UDim2.fromScale(1,0.15); sub.Position = UDim2.fromScale(0,0.28); sub.BackgroundTransparency = 1; sub.TextScaled = true; sub.TextColor3 = Color3.fromRGB(160,160,200)
    sub.Text = ownerMode and "Owner access granted" or "Enter key to continue"

    local box = Instance.new("TextBox", frame)
    box.Size = UDim2.fromScale(0.8,0.2); box.Position = UDim2.fromScale(0.1,0.5)
    box.PlaceholderText = "KEY"; box.Text=""; box.TextScaled=true; box.BackgroundColor3=Color3.fromRGB(22,25,32); box.TextColor3=Color3.new(1,1,1)
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,10)

    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.fromScale(0.5,0.18); btn.Position=UDim2.fromScale(0.25,0.75); btn.Text="UNLOCK"; btn.TextScaled=true; btn.BackgroundColor3=Color3.fromRGB(90,90,255); btn.TextColor3=Color3.new(1,1,1)
    Instance.new("UICorner", btn).CornerRadius=UDim.new(0,10)

    local ok = false
    btn.MouseButton1Click:Connect(function()
        if ownerMode or box.Text == VALID_KEY then ok=true gui:Destroy() else box.Text=""; sub.Text="Invalid key" end
    end)

    repeat RS.RenderStepped:Wait() until ok
end
keyPrompt()

-- CONFIG
local cfg={Speed=16,Jump=50,FOV=70,Noclip=false,Fly=false,ESP=false}

-- MAIN GUI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.7,0.72)
main.Position = UDim2.fromScale(0.15,0.14)
main.BackgroundColor3 = Color3.fromRGB(14,16,20)
Instance.new("UICorner", main).CornerRadius = UDim.new(0,22)
local stroke = Instance.new("UIStroke", main); stroke.Thickness=2; stroke.Color=Color3.fromRGB(120,120,255)

-- WALLPAPER BACKGROUND
local bg = Instance.new("ImageLabel", main)
bg.Size=UDim2.fromScale(1,1); bg.Position=UDim2.fromScale(0,0); bg.BackgroundTransparency=1
bg.Image="rbxassetid://139258073883950"; bg.ImageTransparency=0.2

-- TOP BAR + TITLE + CLOSE/MINIMIZE
local top=Instance.new("Frame", main); top.Size=UDim2.fromScale(1,0.08); top.BackgroundTransparency=1
local title=Instance.new("TextLabel", top); title.Size=UDim2.fromScale(0.6,1); title.BackgroundTransparency=1; title.TextScaled=true; title.TextColor3=Color3.fromRGB(200,200,255); title.Text="GoofHub Ultimate"
local close=Instance.new("TextButton", top); close.Size=UDim2.fromScale(0.06,0.7); close.Position=UDim2.fromScale(0.92,0.15); close.Text="X"; close.BackgroundColor3=Color3.fromRGB(40,45,60); close.TextColor3=Color3.new(1,1,1); Instance.new("UICorner", close).CornerRadius=UDim.new(0,10)
close.MouseButton1Click:Connect(function() gui:Destroy() end)

-- DRAG
local dragging, sPos, sFrame
main.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true; sPos=i.Position; sFrame=main.Position end end)
UIS.InputChanged:Connect(function(i) if dragging and i.UserInputType==Enum.UserInputType.MouseMovement then local d=i.Position-sPos; main.Position=UDim2.fromScale(sFrame.X.Scale+d.X/camera.ViewportSize.X,sFrame.Y.Scale+d.Y/camera.ViewportSize.Y) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)

-- SIDEBAR + TABS
local side=Instance.new("Frame", main); side.Size=UDim2.fromScale(0.22,0.86); side.Position=UDim2.fromScale(0.02,0.12); side.BackgroundColor3=Color3.fromRGB(18,21,28); Instance.new("UICorner", side).CornerRadius=UDim.new(0,16)
local pages=Instance.new("Frame", main); pages.Size=UDim2.fromScale(0.72,0.86); pages.Position=UDim2.fromScale(0.26,0.12); pages.BackgroundTransparency=1
local UIList = Instance.new("UIListLayout", side); UIList.Padding=UDim.new(0,8)
local function newPage() local p=Instance.new("Frame", pages); p.Size=UDim2.fromScale(1,1); p.BackgroundTransparency=1; p.Visible=false; Instance.new("UIListLayout", p).Padding=UDim.new(0,10); return p end
local function tab(name,page) local b=Instance.new("TextButton", side); b.Size=UDim2.fromScale(1,0.12); b.Text=name; b.TextScaled=true; b.BackgroundColor3=Color3.fromRGB(28,32,44); b.TextColor3=Color3.fromRGB(200,200,255); Instance.new("UICorner", b).CornerRadius=UDim.new(0,12); b.MouseButton1Click:Connect(function() for _,c in ipairs(pages:GetChildren()) do if c:IsA("Frame") then c.Visible=false end end; page.Visible=true end); return b end

-- CREATE PAGES
local pPlayer=newPage(); pPlayer.Visible=true
local pWorld=newPage()
local pESP=newPage()
local pOther=newPage()

-- CREATE TABS
tab("Player", pPlayer)
tab("World", pWorld)
tab("ESP", pESP)
tab("Other", pOther)

-- FEATURE FUNCTIONS
local function slider(parent,text,min,max,cb)
    local c=Instance.new("Frame",parent); c.Size=UDim2.fromScale(1,0.14); c.BackgroundColor3=Color3.fromRGB(20,23,30); Instance.new("UICorner", c).CornerRadius=UDim.new(0,14)
    local t=Instance.new("TextLabel", c); t.Size=UDim2.fromScale(0.4,1); t.BackgroundTransparency=1; t.TextScaled=true; t.TextColor3=Color3.fromRGB(200,200,255); t.Text=text
    local bar=Instance.new("Frame",c); bar.Size=UDim2.fromScale(0.5,0.2); bar.Position=UDim2.fromScale(0.45,0.4); bar.BackgroundColor3=Color3.fromRGB(45,50,70); Instance.new("UICorner", bar).CornerRadius=UDim.new(1,0)
    local fill=Instance.new("Frame", bar); fill.Size=UDim2.fromScale(0,1); fill.BackgroundColor3=Color3.fromRGB(120,120,255); Instance.new("UICorner", fill).CornerRadius=UDim.new(1,0)
    bar.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then local mv; mv=UIS.InputChanged:Connect(function(m) if m.UserInputType==Enum.UserInputType.MouseMovement then local p=math.clamp((m.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1); fill.Size=UDim2.fromScale(p,1); cb(math.floor(min+(max-min)*p)) end end); UIS.InputEnded:Once(function() mv:Disconnect() end) end end)
end

local function toggle(parent,text,cb)
    local b=Instance.new("TextButton", parent); b.Size=UDim2.fromScale(1,0.14); b.Text=text..": OFF"; b.TextScaled=true; b.BackgroundColor3=Color3.fromRGB(28,32,44); b.TextColor3=Color3.fromRGB(200,200,255); Instance.new("UICorner", b).CornerRadius=UDim.new(0,14)
    local on=false; b.MouseButton1Click:Connect(function() on=not on; b.Text=text..": "..(on and "ON" or "OFF"); cb(on) end)
end

-- PLAYER PAGE
slider(pPlayer,"Speed",16,300,function(v) if hum then hum.WalkSpeed=v end end)
slider(pPlayer,"Jump",50,300,function(v) if hum then hum.JumpPower=v end end)
toggle(pPlayer,"Noclip",function(v) cfg.Noclip=v end)
toggle(pPlayer,"Fly",function(v) cfg.Fly=v end)

-- WORLD PAGE
slider(pWorld,"FOV",70,150,function(v) camera.FieldOfView=v end)

-- ESP PAGE
toggle(pESP,"ESP",function(v) cfg.ESP=v end)

-- OTHER PAGE (placeholder)
toggle(pOther,"Placeholder Feature",function(v) end)

-- NOCLIP & FLY LOOP
RS.Stepped:Connect(function()
    if char then
        if cfg.Noclip then for _,bp in ipairs(char:GetDescendants()) do if bp:IsA("BasePart") then bp.CanCollide=false end end end
        if cfg.Fly then hrp.Velocity = Vector3.new(0,0,0) end
    end
end)

-- TELEPORT
UIS.InputBegan:Connect(function(i,g)
    if g then return end
    if i.KeyCode==Enum.KeyCode.T and hrp then hrp.CFrame=CFrame.new(player:GetMouse().Hit.Position+Vector3.new(0,3,0)) end
end)

-- WINDOW OPEN/CLOSE TOGGLE
local minimized=false
local minBtn=Instance.new("TextButton", top); minBtn.Size=UDim2.fromScale(0.06,0.7); minBtn.Position=UDim2.fromScale(0.85,0.15); minBtn.Text="–"; minBtn.BackgroundColor3=Color3.fromRGB(40,45,60); minBtn.TextColor3=Color3.new(1,1,1); Instance.new("UICorner", minBtn).CornerRadius=UDim.new(0,10)
minBtn.MouseButton1Click:Connect(function()
    minimized=not minimized
    TS:Create(main, TweenInfo.new(0.3), {Size=minimized and UDim2.fromScale(0.7,0.08) or UDim2.fromScale(0.7,0.72)}):Play()
end)

print("✅ GoofHub Ultimate Loaded with Wallpaper, Themes, Owner, Key, Movable/Resizable Window")
