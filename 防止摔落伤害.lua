local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local lp = Players.LocalPlayer
if not lp then
    lp = Players.PlayerAdded:Wait()
end

local State = {
    Collapsed = false,
    Enabled = false
}

local isDesktop = not UserInputService.TouchEnabled
local UI_SCALE = isDesktop and 1.3 or 1.0

local Gui = Instance.new("ScreenGui")
Gui.Name = "AntiFallGUI"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = lp:WaitForChild("PlayerGui")

local W = 200
local H_EXPAND = 100
local H_COLLAPSE = 25
local TITLE_H = 25

local Main = Instance.new("Frame")
Main.Name = "MainFrame"
Main.Size = UDim2.new(0, W, 0, H_EXPAND)
Main.Position = UDim2.new(0.5, -W/2, 0, 10)
Main.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Main.BackgroundTransparency = 0.30
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = Gui

local uiScale = Instance.new("UIScale")
uiScale.Scale = UI_SCALE
uiScale.Parent = Main

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 255, 255)
MainStroke.Thickness = 1.3
MainStroke.Transparency = 0.3
MainStroke.Parent = Main

local Title = Instance.new("Frame")
Title.Name = "TitleBar"
Title.Size = UDim2.new(1, 0, 0, TITLE_H)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.BorderSizePixel = 0
Title.Parent = Main

local StatusDot = Instance.new("Frame")
StatusDot.Name = "StatusDot"
StatusDot.Size = UDim2.new(0, 8, 0, 8)
StatusDot.Position = UDim2.new(0, 8, 0.5, -4)
StatusDot.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
StatusDot.BackgroundTransparency = 0.2
StatusDot.BorderSizePixel = 0
StatusDot.Parent = Title

local StatusDotCorner = Instance.new("UICorner")
StatusDotCorner.CornerRadius = UDim.new(1, 0)
StatusDotCorner.Parent = StatusDot

local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(1, -30, 1, 0)
TitleText.Position = UDim2.new(0, 20, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "防摔"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 14
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = Title

local TitleGrad = Instance.new("UIGradient")
TitleGrad.Name = "TitleGrad"
TitleGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
})
TitleGrad.Parent = TitleText

local CollapseBtn = Instance.new("TextButton")
CollapseBtn.Name = "CollapseBtn"
CollapseBtn.Size = UDim2.new(0, 20, 1, 0)
CollapseBtn.Position = UDim2.new(1, -25, 0, 0)
CollapseBtn.BackgroundTransparency = 1
CollapseBtn.Text = "−"
CollapseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CollapseBtn.TextSize = 18
CollapseBtn.Font = Enum.Font.SourceSansBold
CollapseBtn.Parent = Title

local Body = Instance.new("Frame")
Body.Name = "Body"
Body.Size = UDim2.new(1, 0, 1, -TITLE_H)
Body.Position = UDim2.new(0, 0, 0, TITLE_H)
Body.BackgroundTransparency = 1
Body.BorderSizePixel = 0
Body.Parent = Main

local function updateCollapseVisual()
    local targetSize = State.Collapsed and H_COLLAPSE or H_EXPAND
    local targetBodySize = State.Collapsed and 0 or H_EXPAND - TITLE_H
    CollapseBtn.Text = State.Collapsed and "+" or "−"
    Main.Size = UDim2.new(0, W, 0, targetSize)
    Body.Size = UDim2.new(1, 0, 0, targetBodySize)
    Body.Visible = not State.Collapsed
end

CollapseBtn.MouseButton1Click:Connect(function()
    State.Collapsed = not State.Collapsed
    updateCollapseVisual()
end)

local BTN_W = 140
local BTN_H = 45
local GLASS_BASE = 0.82
local GLASS_HOVER = 0.76
local GLASS_DOWN = 0.70

local ToggleGlass = Instance.new("Frame")
ToggleGlass.Name = "ToggleGlass"
ToggleGlass.Size = UDim2.new(0, BTN_W, 0, BTN_H)
ToggleGlass.Position = UDim2.new(0.5, -BTN_W/2, 0.5, -BTN_H/2)
ToggleGlass.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ToggleGlass.BackgroundTransparency = GLASS_BASE
ToggleGlass.BorderSizePixel = 0
ToggleGlass.Parent = Body

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 9)
ToggleCorner.Parent = ToggleGlass

local ToggleBgGrad = Instance.new("UIGradient")
ToggleBgGrad.Name = "ToggleBgGrad"
ToggleBgGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(245, 250, 247)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(215, 230, 222)),
})
ToggleBgGrad.Rotation = 90
ToggleBgGrad.Parent = ToggleGlass

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(200, 255, 220)
ToggleStroke.Thickness = 1.2
ToggleStroke.Transparency = 0.45
ToggleStroke.Parent = ToggleGlass

local ToggleStrokeGrad = Instance.new("UIGradient")
ToggleStrokeGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 255, 235)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 255, 210)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 255, 235)),
})
ToggleStrokeGrad.Rotation = 20
ToggleStrokeGrad.Parent = ToggleStroke

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleButton"
ToggleBtn.Size = UDim2.new(1, 0, 1, 0)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Text = ""
ToggleBtn.AutoButtonColor = false
ToggleBtn.Parent = ToggleGlass

local ToggleText = Instance.new("TextLabel")
ToggleText.Size = UDim2.new(1, 0, 1, 0)
ToggleText.BackgroundTransparency = 1
ToggleText.Text = "开启"
ToggleText.TextColor3 = Color3.fromRGB(190, 215, 200)
ToggleText.TextSize = 16
ToggleText.Font = Enum.Font.SourceSansBold
ToggleText.Parent = ToggleBtn

local ToggleTextGrad = Instance.new("UIGradient")
ToggleTextGrad.Name = "ToggleTextGrad"
ToggleTextGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(190, 215, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(190, 215, 200))
})
ToggleTextGrad.Rotation = 0
ToggleTextGrad.Parent = ToggleText

local function UpdateToggleVisual()
    if State.Enabled then
        ToggleText.Text = "已开启"
        ToggleText.TextColor3 = Color3.fromRGB(250, 255, 252)
        ToggleTextGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(0.3, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(0.55, Color3.fromRGB(140, 235, 170)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 190, 90))
        })
        ToggleTextGrad.Rotation = 0
        ToggleStrokeGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 250)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 255, 180)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 250)),
        })
        ToggleStroke.Transparency = 0.2
        StatusDot.BackgroundColor3 = Color3.fromRGB(60, 255, 120)

        TitleGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 255, 210)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 190, 90))
        })

        -- 边框改为灰色
        MainStroke.Color = Color3.fromRGB(128, 128, 128)
    else
        ToggleText.Text = "开启"
        ToggleText.TextColor3 = Color3.fromRGB(190, 215, 200)
        ToggleTextGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(190, 215, 200)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(190, 215, 200))
        })
        ToggleTextGrad.Rotation = 0
        ToggleStrokeGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(135, 170, 145)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(110, 185, 140)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 170, 145)),
        })
        ToggleStroke.Transparency = 0.45
        StatusDot.BackgroundColor3 = Color3.fromRGB(180, 180, 180)

        TitleGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
        })

        MainStroke.Color = Color3.fromRGB(255, 255, 255)
    end
end

ToggleBtn.MouseEnter:Connect(function()
    ToggleGlass.BackgroundTransparency = GLASS_HOVER
end)
ToggleBtn.MouseLeave:Connect(function()
    ToggleGlass.BackgroundTransparency = GLASS_BASE
end)
ToggleBtn.MouseButton1Down:Connect(function()
    ToggleGlass.BackgroundTransparency = GLASS_DOWN
end)
ToggleBtn.MouseButton1Up:Connect(function()
    ToggleGlass.BackgroundTransparency = GLASS_HOVER
end)

local dragging = false
local dragStart = nil
local startPos = nil

Main.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X / UI_SCALE,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y / UI_SCALE
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
local hb = RunService.Heartbeat
local rsd = RunService.RenderStepped
local z = Vector3.zero
local isEnabled = false
local currentConnections = {}
local hasNotifiedFirstTime = false

local function applyAntiFall(character)
    if not character then return end
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 5)
    if not humanoidRootPart then return end

    local connection = hb:Connect(function()
        if not humanoidRootPart or not humanoidRootPart.Parent then
            if connection then connection:Disconnect() end
            return
        end
        local velocity = humanoidRootPart.AssemblyLinearVelocity
        humanoidRootPart.AssemblyLinearVelocity = z
        rsd:Wait()
        humanoidRootPart.AssemblyLinearVelocity = velocity
    end)
    table.insert(currentConnections, connection)
end

local function removeAntiFall()
    for _, connection in ipairs(currentConnections) do
        if connection then connection:Disconnect() end
    end
    currentConnections = {}
end

lp.CharacterAdded:Connect(function(character)
    if isEnabled then
        applyAntiFall(character)
    end
end)

local function toggleAntiFall()
    isEnabled = not isEnabled
    State.Enabled = isEnabled
    UpdateToggleVisual()

    if isEnabled then
        if lp.Character then
            applyAntiFall(lp.Character)
        end
    else
        removeAntiFall()
    end
end

ToggleBtn.MouseButton1Click:Connect(toggleAntiFall)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 16, 0, 16)
CloseBtn.Position = UDim2.new(1, -22, 0, 4)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "关闭UI"
CloseBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = Title

CloseBtn.MouseButton1Click:Connect(function()
    Gui:Destroy()
end)

UpdateToggleVisual()
updateCollapseVisual()