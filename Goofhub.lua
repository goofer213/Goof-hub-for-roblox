--====================================================
-- GOOFHUB CLEAN BUILD (XENO AND OTHER 1.3.10 SAFE)
--====================================================

-- SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")

-- PLAYER
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- CONFIG
local PLACE_ID = 123974602339071
local OWNER = "hakerfilipcriminal"
local VALID_KEY = "G00FKEY"

local INFINITE_YIELD_URL = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"
local BREAKIN2_URL = "https://raw.githubusercontent.com/EnesXVC/Breakin2/main/script"

local isOwner = player.Name:lower() == OWNER:lower()

--====================================================
-- KEY SYSTEM
--====================================================
local function KeyPrompt()
    local gui = Instance.new("ScreenGui", PlayerGui)
    gui.Name = "GoofHub_Key"

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.fromScale(0.4,0.25)
    frame.Position = UDim2.fromScale(0.3,0.375)
    frame.BackgroundColor3 = Color3.fromRGB(20,20,28)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,14)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.fromScale(1,0.3)
    title.BackgroundTransparency = 1
    title.TextScaled = true
    title.TextColor3 = Color3.fromRGB(200,200,255)
    title.Text = isOwner and "Welcome Mr.Goofer" or "Enter GoofHub Key"

    local box = Instance.new("TextBox", frame)
    box.Size = UDim2.fromScale(0.8,0.25)
    box.Position = UDim2.fromScale(0.1,0.4)
    box.TextScaled = true
    box.PlaceholderText = "KEY"
    box.BackgroundColor3 = Color3.fromRGB(35,35,45)
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,10)

    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.fromScale(0.5,0.2)
    btn.Position = UDim2.fromScale(0.25,0.7)
    btn.Text = "UNLOCK"
    btn.TextScaled = true
    btn.BackgroundColor3 = Color3.fromRGB(90,90,255)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

    local unlocked = false
    btn.MouseButton1Click:Connect(function()
        if isOwner or box.Text == VALID_KEY then
            unlocked = true
            gui:Destroy()
        else
            box.Text = ""
        end
    end)

    repeat RS.RenderStepped:Wait() until unlocked
end

KeyPrompt()

--====================================================
-- AUTO JOIN GAME
--====================================================
if game.PlaceId ~= PLACE_ID then
    TeleportService:Teleport(PLACE_ID, player)
    return
end

--====================================================
-- MAIN UI (NO CHAT CONTROL)
--====================================================
local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "GoofHub"

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.6,0.65)
main.Position = UDim2.fromScale(0.2,0.18)
main.BackgroundColor3 = Color3.fromRGB(18,18,25)
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.fromScale(1,0.1)
title.BackgroundTransparency = 1
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(200,200,255)
title.Text = "GoofHub"

-- DRAG
local dragging, dragStart, startPos
main.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = i.Position
        startPos = main.Position
    end
end)
UIS.InputChanged:Connect(function(i)
    if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = i.Position - dragStart
        main.Position = UDim2.fromScale(
            startPos.X.Scale + delta.X / workspace.CurrentCamera.ViewportSize.X,
            startPos.Y.Scale + delta.Y / workspace.CurrentCamera.ViewportSize.Y
        )
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

--====================================================
-- SCRIPT LOADERS
--====================================================
local function loadIY()
    loadstring(game:HttpGet(INFINITE_YIELD_URL, true))()
end

local function loadBN2()
    loadstring(game:HttpGet(BREAKIN2_URL, true))()
end

--====================================================
-- CHAT COMMAND SYSTEM (ONLY ?load)
--====================================================
player.Chatted:Connect(function(msg)
    msg = msg:lower()

    if msg == "?load iy" then
        loadIY()
    elseif msg == "?load bn2" then
        loadBN2()
    end
end)

--====================================================
print("[GoofHub] Loaded successfully")
