local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WeaponStarterUI"
screenGui.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 110)
frame.Position = UDim2.new(0.5, -100, 0.5, -55)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
frame.BackgroundTransparency = 0.15
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 28)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "末日砖块辅助"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 17
title.Font = Enum.Font.GothamBold
title.Parent = frame

local bombBtn = Instance.new("TextButton")
bombBtn.Size = UDim2.new(0, 160, 0, 30)
bombBtn.Position = UDim2.new(0.5, -80, 0, 36)
bombBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
bombBtn.Text = "启动炸弹"
bombBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
bombBtn.TextSize = 15
bombBtn.Font = Enum.Font.GothamSemibold
bombBtn.BorderSizePixel = 0
local bc1 = Instance.new("UICorner")
bc1.CornerRadius = UDim.new(0, 6)
bc1.Parent = bombBtn
bombBtn.Parent = frame

local rocketBtn = Instance.new("TextButton")
rocketBtn.Size = UDim2.new(0, 160, 0, 30)
rocketBtn.Position = UDim2.new(0.5, -80, 0, 72)
rocketBtn.BackgroundColor3 = Color3.fromRGB(200, 120, 30)
rocketBtn.Text = "启动火箭筒"
rocketBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
rocketBtn.TextSize = 15
rocketBtn.Font = Enum.Font.GothamSemibold
rocketBtn.BorderSizePixel = 0
local bc2 = Instance.new("UICorner")
bc2.CornerRadius = UDim.new(0, 6)
bc2.Parent = rocketBtn
rocketBtn.Parent = frame

local bombThread = nil
local rocketThread = nil
local bombActive = false
local rocketActive = false

local function bombLoop()
    local success, fireEvent = pcall(function()
        local backpack = player:WaitForChild("Backpack")
        local timebomb = backpack:WaitForChild("Timebomb")
        return timebomb:WaitForChild("Fire")
    end)
    if not success or not fireEvent then
        bombActive = false
        return
    end
    while bombActive do
        task.wait(0.01)
        local char = player.Character
        if char then
            local rootPart = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
            if rootPart then
                fireEvent:FireServer(rootPart.CFrame)
            end
        end
    end
end

local function rocketLoop()
    local success, fireEvent = pcall(function()
        local char = player.Character or player.CharacterAdded:Wait()
        local launcher = char:WaitForChild("RocketLauncher")
        return launcher:WaitForChild("Fire")
    end)
    if not success or not fireEvent then
        rocketActive = false
        return
    end
    while rocketActive do
        task.wait(0.01)
        local char = player.Character
        if char then
            fireEvent:FireServer(mouse.Hit.p)
        end
    end
end

bombBtn.MouseButton1Click:Connect(function()
    if bombThread then
        bombActive = false
        task.wait(0.02)
    end
    bombActive = true
    bombThread = task.spawn(bombLoop)
end)

rocketBtn.MouseButton1Click:Connect(function()
    if rocketThread then
        rocketActive = false
        task.wait(0.02)
    end
    rocketActive = true
    rocketThread = task.spawn(rocketLoop)
end)

screenGui.AncestryChanged:Connect(function()
    if not screenGui.Parent then
        bombActive = false
        rocketActive = false
    end
end)