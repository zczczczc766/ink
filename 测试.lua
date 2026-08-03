local A=game:GetService("StarterGui")
A:SetCore("SendNotification",{Title="正在执行 ink_HUB",Text="加载中...",Duration=1})
task.wait(0.6)
A:SetCore("SendNotification",{Title="脚本启动成功",Text="正在加载界面...",Duration=2})

local function gradient(text,startColor,endColor)
    local result=""
    local chars={}
    for uchar in text:gmatch("[%z\1-\127\194-\244][\128-\191]*") do table.insert(chars,uchar) end
    local length=#chars
    for i=1,length do
        local t=(i-1)/math.max(length-1,1)
        local r=startColor.R+(endColor.R-startColor.R)*t
        local g=startColor.G+(endColor.G-startColor.G)*t
        local b=startColor.B+(endColor.B-startColor.B)*t
        result=result..string.format('<font color="rgb(%d,%d,%d)">%s</font>',math.floor(r*255),math.floor(g*255),math.floor(b*255),chars[i])
    end
    return result
end

local B=loadstring(game:HttpGet("https://raw.githubusercontent.com/951357nvjn/dyzs/refs/heads/main/winduiYI.lua"))()
if not B then A:SetCore("SendNotification",{Title="加载失败",Text="WindUI 库加载失败",Duration=3}) return end
B.Transparency=0.3
B:SetTheme("Dark")

local C=B:CreateWindow({Icon="moon",Title=gradient("ink_HUB",Color3.fromRGB(180,180,180),Color3.fromRGB(100,100,100)),Author=gradient("@墨水依旧",Color3.fromRGB(180,180,180),Color3.fromRGB(100,100,100)),Folder="ink_HUB",Size=UDim2.fromOffset(520,410),Background="rbxassetid://99065227044934",BackgroundImageTransparency=0.25,Theme="Dark",User={Enabled=false},SideBarWidth=160,ScrollBarEnabled=true})
C:EditOpenButton({Title=gradient("ink_HUB",Color3.fromRGB(180,180,180),Color3.fromRGB(100,100,100)),Icon="moon",StrokeThickness=2,Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(180,180,180)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(150,150,150)),ColorSequenceKeypoint.new(1,Color3.fromRGB(100,100,100))}),Draggable=true})

local windowFrame=C and (C.UIElements and C.UIElements.Main or C.Frame or C.Gui or C)
if windowFrame then
    local stroke=Instance.new("UIStroke")
    stroke.Name="RainbowStroke"
    stroke.Thickness=2
    stroke.Color=Color3.new(1,1,1)
    stroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
    local grad=Instance.new("UIGradient")
    grad.Name="RainbowGradient"
    grad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(180,180,180)),ColorSequenceKeypoint.new(0.3,Color3.fromRGB(150,150,150)),ColorSequenceKeypoint.new(0.7,Color3.fromRGB(120,120,120)),ColorSequenceKeypoint.new(1,Color3.fromRGB(90,90,90))})
    grad.Enabled=true
    grad.Offset=Vector2.new(0,0)
    grad.Parent=stroke
    stroke.Parent=windowFrame
    task.spawn(function()
        local rotationSpeed=40
        while stroke and stroke.Parent do
            task.wait(0.01)
            grad.Rotation=(grad.Rotation+rotationSpeed*0.1)%360
        end
    end)
end

local D=C:Section({Title="功能菜单",Opened=true})

local Z=D:Tab({Title="公告",Icon="bell"})
Z:Button({Title="欢迎使用 ink_HUB\n作者：墨水依旧\n快手号：zczczczc766\n公益脚本禁止倒卖\n认准 ink_HUB",Callback=function()end})
Z:Button({Title="复制作者QQ",Callback=function()setclipboard("2047955671") A:SetCore("SendNotification",{Title="已复制",Text="作者QQ：2047955671",Duration=2})end})
Z:Button({Title="复制作者QQ群",Callback=function()setclipboard("1101093219") A:SetCore("SendNotification",{Title="已复制",Text="作者QQ群：1101093219",Duration=2})end})
Z:Button({Title="复制作者QQ副群",Callback=function()setclipboard("1063828524") A:SetCore("SendNotification",{Title="已复制",Text="作者QQ副群：1063828524",Duration=2})end})

local E=D:Tab({Title="通用",Icon="settings"})

local LocalPlayer=game.Players.LocalPlayer
local speedEnabled=false
local jumpEnabled=false
local speedValue=16
local jumpValue=50

E:Toggle({Title="启用修改速度",Value=false,Callback=function(s)
    speedEnabled=s
    local char=LocalPlayer.Character
    if char then
        local hum=char:FindFirstChildOfClass("Humanoid")
        if hum then
            if s then hum.WalkSpeed=speedValue else hum.WalkSpeed=16 end
        end
    end
end})

E:Slider({Title="修改速度",Value={Min=16,Max=100,Default=16},Callback=function(v)
    speedValue=v
    if speedEnabled then
        local char=LocalPlayer.Character
        if char then
            local hum=char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed=v end
        end
    end
end})

E:Toggle({Title="启用修改跳跃高度",Value=false,Callback=function(s)
    jumpEnabled=s
    local char=LocalPlayer.Character
    if char then
        local hum=char:FindFirstChildOfClass("Humanoid")
        if hum then
            if s then hum.JumpPower=jumpValue else hum.JumpPower=50 end
        end
    end
end})

E:Slider({Title="修改跳跃高度",Value={Min=20,Max=200,Default=50},Callback=function(v)
    jumpValue=v
    if jumpEnabled then
        local char=LocalPlayer.Character
        if char then
            local hum=char:FindFirstChildOfClass("Humanoid")
            if hum then hum.JumpPower=v end
        end
    end
end})

E:Button({Title="飞行",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/zczczczc766/ink/refs/heads/main/%E9%A3%9E%E8%A1%8C%E8%84%9A%E6%9C%AC.lua"))()end})

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.1)
    local hum=char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed=speedEnabled and speedValue or 16
        hum.JumpPower=jumpEnabled and jumpValue or 50
    end
end)

local noclipEnabled=false
local function applyNoClip(s)
    local char=game.Players.LocalPlayer.Character
    if not char then return end
    for _,part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide=not s
        end
    end
end
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    if noclipEnabled then
        task.wait(0.1)
        applyNoClip(true)
    end
end)
E:Toggle({Title="穿墙",Value=false,Callback=function(s)noclipEnabled=s applyNoClip(s)end})

local Lighting=game:GetService("Lighting")
local origBright=Lighting.Brightness
E:Toggle({Title="高亮",Value=false,Callback=function(s)
    if s then
        Lighting.Brightness=5
        Lighting.Ambient=Color3.new(1,1,1)
        Lighting.OutdoorAmbient=Color3.new(1,1,1)
    else
        Lighting.Brightness=origBright        Lighting.Ambient=Color3.new(0.5,0.5,0.5)
        Lighting.OutdoorAmbient=Color3.new(0.5,0.5,0.5)
    end
end})

E:Button({Title="防甩飞",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/Linux6699/DaHubRevival/main/AntiFling.lua"))()end})

E:Button({Title = "祖国人",Callback = function()loadstring(game:HttpGet("https://raw.githubusercontent.com/giobolqv1/homelander-by-GioBolqv1-/main/homelander.lua"))()end})

E:Button({Title="无敌少侠飞行",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/396abc/Script/refs/heads/main/MobileFly.lua"))()end})

E:Button({Title="无敌少侠大全",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/giobolqv1/invincible-characters-animations-by-GioBolqv1-/refs/heads/main/universal.lua"))()end})

local function forceChatVisible()
    local player=game.Players.LocalPlayer
    local StarterGui=game:GetService("StarterGui")
    local CoreGui=game:GetService("CoreGui")
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat,true)
    local chatFrame=player.PlayerGui:FindFirstChild("Chat")
    if not chatFrame then chatFrame=CoreGui:FindFirstChild("Chat") end
    if chatFrame and chatFrame:IsA("Frame") then
        chatFrame.Visible=true
        chatFrame.Position=UDim2.new(0,0,0.5,0)
        chatFrame.Size=UDim2.new(0.3,0,0.4,0)
        chatFrame.BackgroundTransparency=0.5
        local function forceVisible(obj)
            if obj:IsA("Frame") or obj:IsA("ScrollingFrame") or obj:IsA("TextBox") or obj:IsA("TextLabel") or obj:IsA("ImageLabel") then
                obj.Visible=true
                obj.Position=UDim2.new(0,0,0,0)
                obj.Size=UDim2.new(1,0,1,0)
                obj.BackgroundTransparency=0.3
                obj.TextTransparency=0
                obj.TextColor3=Color3.new(1,1,1)
            end
            for _,child in ipairs(obj:GetChildren()) do forceVisible(child) end
        end
        forceVisible(chatFrame)
    end
    local textChat=game:GetService("TextChatService")
    if textChat then
        pcall(function()
            textChat.ChatWindowConfiguration.Enabled=true
            textChat.ChatInputBarConfiguration.Enabled=true
        end)
        local chatWindows=CoreGui:FindFirstChild("ChatWindow")
        if chatWindows then chatWindows.Visible=true end
    end
end

E:Button({Title="强制显示聊天框",Callback=function()forceChatVisible()end})

E:Button({Title="走路撞人",Callback=function()loadstring(game:HttpGet(('https://raw.githubusercontent.com/0Ben1/fe/main/obf_5wpM7bBcOPspmX7lQ3m75SrYNWqxZ858ai3tJdEAId6jSI05IOUB224FQ0VSAswH.lua.txt'),true))()end})

E:Button({Title="铁拳打人",Callback=function()loadstring(game:HttpGet(('https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt'),true))()end})

local P = D:Tab({Title="透视专区", Icon="eye"})

local Workspace, RunService, Players, CoreGui = game:GetService("Workspace"), game:GetService("RunService"), game:GetService("Players"), game:GetService("CoreGui")

local ESP = {
    Enabled = false, TeamCheck = true, MaxDistance = 2000, FontSize = 11,
    FadeOut = { OnDistance = true, OnDeath = false, OnLeave = false },
    Options = { Teamcheck = true, TeamcheckRGB = Color3.fromRGB(119, 120, 255), Friendcheck = true, FriendcheckRGB = Color3.fromRGB(119, 120, 255), Highlight = true, HighlightRGB = Color3.fromRGB(119, 120, 255) },
    Drawing = {
        Chams = { Enabled = false, Thermal = false, FillRGB = Color3.fromRGB(119, 120, 255), Fill_Transparency = 100, OutlineRGB = Color3.fromRGB(119, 120, 255), Outline_Transparency = 0, VisibleCheck = true },
        Names = { Enabled = false, RGB = Color3.fromRGB(255, 255, 255) },
        Flags = { Enabled = false },
        Distances = { Enabled = false, Position = "Text", RGB = Color3.fromRGB(255, 255, 255) },
        Weapons = { Enabled = false, WeaponTextRGB = Color3.fromRGB(119, 120, 255), Outlined = false, Gradient = false, GradientRGB1 = Color3.fromRGB(255, 255, 255), GradientRGB2 = Color3.fromRGB(119, 120, 255) },
        Healthbar = { Enabled = false, HealthText = true, Lerp = false, HealthTextRGB = Color3.fromRGB(255, 255, 255), Width = 1.25, Gradient = false, GradientRGB1 = Color3.fromRGB(200, 0, 0), GradientRGB2 = Color3.fromRGB(60, 60, 125), GradientRGB3 = Color3.fromRGB(119, 120, 255) },
        Boxes = { Animate = true, RotationSpeed = 300, Gradient = true, GradientRGB1 = Color3.fromRGB(140, 180, 255), GradientRGB2 = Color3.fromRGB(180, 120, 255), GradientFill = false, GradientFillRGB1 = Color3.fromRGB(119, 120, 255), GradientFillRGB2 = Color3.fromRGB(0,0,0), Filled = { Enabled = false, Transparency = 0.75, RGB = Color3.fromRGB(119, 120, 255) }, Full = { Enabled = false, RGB = Color3.fromRGB(255,255,255) }, Corner = { Enabled = false, RGB = Color3.fromRGB(255,255,255) } }
    },
    Connections = { RunService = RunService },
    Fonts = {}
}

local lplayer = Players.LocalPlayer
local camera = Workspace.CurrentCamera
local Cam = Workspace.CurrentCamera
local RotationAngle, Tick = -45, tick()

local Functions = {}
do
    function Functions:Create(Class, Properties)
        local _Instance = typeof(Class) == 'string' and Instance.new(Class) or Class
        for Property, Value in pairs(Properties) do _Instance[Property] = Value end
        return _Instance
    end
    function Functions:FadeOutOnDist(element, distance)
        local transparency = math.max(0.1, 1 - (distance / ESP.MaxDistance))
        if element:IsA("TextLabel") then element.TextTransparency = 1 - transparency
        elseif element:IsA("ImageLabel") then element.ImageTransparency = 1 - transparency
        elseif element:IsA("UIStroke") then element.Transparency = 1 - transparency
        elseif element:IsA("Frame") then element.BackgroundTransparency = 1 - transparency
        elseif element:IsA("Highlight") then element.FillTransparency = 1; element.OutlineTransparency = 1 - transparency end
    end
    function Functions:GetRainbow()
        local t = tick() * 1.5
        local r = 0.7 + 0.3 * math.sin(t * 2 + 0)
        local g = 0.7 + 0.3 * math.sin(t * 2 + 2)
        local b = 0.9 + 0.1 * math.sin(t * 2 + 4)
        return Color3.new(r, g, b)
    end
end

local ScreenGui = Functions:Create("ScreenGui", { Parent = CoreGui, Name = "ESPHolder" })

local function DupeCheck(plr)
    if ScreenGui:FindFirstChild(plr.Name) then ScreenGui[plr.Name]:Destroy() end
end

local function ESPRender(plr)
    coroutine.wrap(DupeCheck)(plr)
    local Name = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(0.5, 0, 0, -11), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0), RichText = true})
    local Distance = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(0.5, 0, 0, 11), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0), RichText = true})
    local Weapon = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(0.5, 0, 0, 31), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0), RichText = true})
    local Box = Functions:Create("Frame", {Parent = ScreenGui, BackgroundTransparency = 1, BorderSizePixel = 0})
    local Outline = Functions:Create("UIStroke", {Parent = Box, Enabled = true, Transparency = 0, Color = Color3.fromRGB(255,255,255), Thickness = 1, LineJoinMode = Enum.LineJoinMode.Miter})
    local Gradient2 = Functions:Create("UIGradient", {Parent = Outline, Enabled = true, Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 180, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 120, 255))})})
    local Healthbar = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0})
    local BehindHealthbar = Functions:Create("Frame", {Parent = ScreenGui, ZIndex = -1, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0})
    local HealthbarGradient = Functions:Create("UIGradient", {Parent = Healthbar, Enabled = ESP.Drawing.Healthbar.Gradient, Rotation = -90, Color = ColorSequence.new{ColorSequenceKeypoint.new(0, ESP.Drawing.Healthbar.GradientRGB1), ColorSequenceKeypoint.new(0.5, ESP.Drawing.Healthbar.GradientRGB2), ColorSequenceKeypoint.new(1, ESP.Drawing.Healthbar.GradientRGB3)}})
    local HealthText = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(0.5, 0, 0, 31), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0)})
    local Chams = Functions:Create("Highlight", {Parent = ScreenGui, FillTransparency = 1, OutlineTransparency = 0, OutlineColor = Color3.fromRGB(255,255,255), DepthMode = "AlwaysOnTop"})
    local LeftTop = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
    local LeftSide = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
    local RightTop = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
    local RightSide = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
    local BottomSide = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
    local BottomDown = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
    local BottomRightSide = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
    local BottomRightDown = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
    local Flag1 = Functions:Create("TextLabel", {Parent = ScreenGui, Size = UDim2.new(0, 60, 0, 16), Position = UDim2.new(0.5, 0, 0, -25), BackgroundTransparency = 1, Font = Enum.Font.Code, TextSize = 11, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0,0,0), TextColor3 = Color3.fromRGB(255,255,255)})
    local Flag2 = Functions:Create("TextLabel", {Parent = ScreenGui, Size = UDim2.new(0, 60, 0, 16), Position = UDim2.new(0.5, 0, 0, -25), BackgroundTransparency = 1, Font = Enum.Font.Code, TextSize = 11, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0,0,0), TextColor3 = Color3.fromRGB(255,255,255)})

    local function UpdateESP()
        local function Updater()
            if not ESP.Enabled then
                Box.Visible = false; Name.Visible = false; Distance.Visible = false; Weapon.Visible = false
                Healthbar.Visible = false; BehindHealthbar.Visible = false; HealthText.Visible = false
                LeftTop.Visible = false; LeftSide.Visible = false; BottomSide.Visible = false; BottomDown.Visible = false
                RightTop.Visible = false; RightSide.Visible = false; BottomRightSide.Visible = false; BottomRightDown.Visible = false
                Flag1.Visible = false; Chams.Enabled = false; Flag2.Visible = false
                return
            end
            if not plr.Character or not plr.Character:FindFirstChild("Humanoid") then
                Box.Visible = false; Name.Visible = false; Distance.Visible = false; Weapon.Visible = false
                Healthbar.Visible = false; BehindHealthbar.Visible = false; HealthText.Visible = false
                LeftTop.Visible = false; LeftSide.Visible = false; BottomSide.Visible = false; BottomDown.Visible = false
                RightTop.Visible = false; RightSide.Visible = false; BottomRightSide.Visible = false; BottomRightDown.Visible = false
                Flag1.Visible = false; Chams.Enabled = false; Flag2.Visible = false
                return
            end
        if ESP.TeamCheck and plr.Team == lplayer.Team and plr ~= lplayer then
            Box.Visible = false; Name.Visible = false; Distance.Visible = false; Weapon.Visible = false
            Healthbar.Visible = false; BehindHealthbar.Visible = false; HealthText.Visible = false
            LeftTop.Visible = false; LeftSide.Visible = false; BottomSide.Visible = false; BottomDown.Visible = false
            RightTop.Visible = false; RightSide.Visible = false; BottomRightSide.Visible = false; BottomRightDown.Visible = false
            Flag1.Visible = false; Chams.Enabled = false; Flag2.Visible = false
            return
        end
        local Humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
        if not Humanoid or Humanoid.Health <= 0 then
            Box.Visible = false; Name.Visible = false; Distance.Visible = false; Weapon.Visible = false
            Healthbar.Visible = false; BehindHealthbar.Visible = false; HealthText.Visible = false
            LeftTop.Visible = false; LeftSide.Visible = false; BottomSide.Visible = false; BottomDown.Visible = false
            RightTop.Visible = false; RightSide.Visible = false; BottomRightSide.Visible = false; BottomRightDown.Visible = false
            Flag1.Visible = false; Chams.Enabled = false; Flag2.Visible = false
            return
        end
        local Head = plr.Character:FindFirstChild("Head")
        local Root = plr.Character:FindFirstChild("HumanoidRootPart")
        if not Head or not Root then
            Box.Visible = false; Name.Visible = false; Distance.Visible = false; Weapon.Visible = false
            Healthbar.Visible = false; BehindHealthbar.Visible = false; HealthText.Visible = false
            LeftTop.Visible = false; LeftSide.Visible = false; BottomSide.Visible = false; BottomDown.Visible = false
            RightTop.Visible = false; RightSide.Visible = false; BottomRightSide.Visible = false; BottomRightDown.Visible = false
            Flag1.Visible = false; Chams.Enabled = false; Flag2.Visible = false
            return
        end
        local Dist = (Root.Position - (lplayer.Character and lplayer.Character:FindFirstChild("HumanoidRootPart") and lplayer.Character.HumanoidRootPart.Position or Vector3.new(0,0,0))).Magnitude
        if Dist > ESP.MaxDistance then
            Box.Visible = false; Name.Visible = false; Distance.Visible = false; Weapon.Visible = false
            Healthbar.Visible = false; BehindHealthbar.Visible = false; HealthText.Visible = false
            LeftTop.Visible = false; LeftSide.Visible = false; BottomSide.Visible = false; BottomDown.Visible = false
            RightTop.Visible = false; RightSide.Visible = false; BottomRightSide.Visible = false; BottomRightDown.Visible = false
            Flag1.Visible = false; Chams.Enabled = false; Flag2.Visible = false
            return
        end
        local Pos, OnScreen = camera:WorldToViewportPoint(Root.Position)
        if not OnScreen then
            Box.Visible = false; Name.Visible = false; Distance.Visible = false; Weapon.Visible = false
            Healthbar.Visible = false; BehindHealthbar.Visible = false; HealthText.Visible = false
            LeftTop.Visible = false; LeftSide.Visible = false; BottomSide.Visible = false; BottomDown.Visible = false
            RightTop.Visible = false; RightSide.Visible = false; BottomRightSide.Visible = false; BottomRightDown.Visible = false
            Flag1.Visible = false; Chams.Enabled = false; Flag2.Visible = false
            return
        end
        local RootPos = Root.Position
        local HeadPos = Head.Position
        local bottom = RootPos - Vector3.new(0, 1.8, 0)
        local top = HeadPos + Vector3.new(0, 0.8, 0)
        local width = 1.5
        local half = width / 2
        local corners = {
            top + Vector3.new(-half, 0, -half), top + Vector3.new(half, 0, -half),
            top + Vector3.new(half, 0, half), top + Vector3.new(-half, 0, half),
            bottom + Vector3.new(-half, 0, -half), bottom + Vector3.new(half, 0, -half),
            bottom + Vector3.new(half, 0, half), bottom + Vector3.new(-half, 0, half)
        }
        local screen = {}
        for _, p in ipairs(corners) do
            local v, on = camera:WorldToViewportPoint(p)
            if not on then
                Box.Visible = false; Name.Visible = false; Distance.Visible = false; Weapon.Visible = false
                Healthbar.Visible = false; BehindHealthbar.Visible = false; HealthText.Visible = false
                LeftTop.Visible = false; LeftSide.Visible = false; BottomSide.Visible = false; BottomDown.Visible = false
                RightTop.Visible = false; RightSide.Visible = false; BottomRightSide.Visible = false; BottomRightDown.Visible = false
                Flag1.Visible = false; Chams.Enabled = false; Flag2.Visible = false
                return
            end
            table.insert(screen, Vector2.new(v.X, v.Y))
        end
        local minX, maxX = screen[1].X, screen[1].X
        local minY, maxY = screen[1].Y, screen[1].Y
        for i = 2, #screen do
            local v = screen[i]
            if v.X < minX then minX = v.X end
            if v.X > maxX then maxX = v.X end
            if v.Y < minY then minY = v.Y end
            if v.Y > maxY then maxY = v.Y end
        end
        local w = maxX - minX
        local h = maxY - minY
        Box.Position = UDim2.new(0, minX, 0, minY)
        Box.Size = UDim2.new(0, w, 0, h)
        Box.Visible = ESP.Drawing.Boxes.Full.Enabled or ESP.Drawing.Boxes.Corner.Enabled
        if ESP.Drawing.Boxes.Full.Enabled then
            Outline.Enabled = true
            Outline.Color = ESP.Drawing.Boxes.Full.RGB
            Outline.Thickness = 1
            if ESP.Drawing.Boxes.Gradient then
                Gradient2.Enabled = true
                Gradient2.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, ESP.Drawing.Boxes.GradientRGB1), ColorSequenceKeypoint.new(1, ESP.Drawing.Boxes.GradientRGB2)})
            else
                Gradient2.Enabled = false
            end
        else
            Outline.Enabled = false
        end
        if ESP.Drawing.Boxes.Corner.Enabled then
            LeftTop.Visible = true; LeftSide.Visible = true; BottomSide.Visible = true; BottomDown.Visible = true
            RightTop.Visible = true; RightSide.Visible = true; BottomRightSide.Visible = true; BottomRightDown.Visible = true
            LeftTop.Size = UDim2.new(0, 6, 0, 1); LeftTop.Position = UDim2.new(0, minX, 0, minY)
            LeftSide.Size = UDim2.new(0, 1, 0, 6); LeftSide.Position = UDim2.new(0, minX, 0, minY)
            BottomSide.Size = UDim2.new(0, 6, 0, 1); BottomSide.Position = UDim2.new(0, minX + w - 6, 0, minY)
            BottomDown.Size = UDim2.new(0, 1, 0, 6); BottomDown.Position = UDim2.new(0, minX + w - 1, 0, minY)
            RightTop.Size = UDim2.new(0, 6, 0, 1); RightTop.Position = UDim2.new(0, minX, 0, minY + h - 1)
            RightSide.Size = UDim2.new(0, 1, 0, 6); RightSide.Position = UDim2.new(0, minX, 0, minY + h - 6)
            BottomRightSide.Size = UDim2.new(0, 6, 0, 1); BottomRightSide.Position = UDim2.new(0, minX + w - 6, 0, minY + h - 1)
            BottomRightDown.Size = UDim2.new(0, 1, 0, 6); BottomRightDown.Position = UDim2.new(0, minX + w - 1, 0, minY + h - 6)
            LeftTop.BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB
            LeftSide.BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB
            BottomSide.BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB
            BottomDown.BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB
            RightTop.BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB
            RightSide.BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB
            BottomRightSide.BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB
            BottomRightDown.BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB
        else
            LeftTop.Visible = false; LeftSide.Visible = false; BottomSide.Visible = false; BottomDown.Visible = false
            RightTop.Visible = false; RightSide.Visible = false; BottomRightSide.Visible = false; BottomRightDown.Visible = false
        end
        Name.Visible = ESP.Drawing.Names.Enabled
        if Name.Visible then
            Name.Text = plr.Name
            Name.Position = UDim2.new(0, minX + w/2 - 50, 0, minY - 20)
            Name.TextColor3 = ESP.Drawing.Names.RGB
            if ESP.FadeOut.OnDistance then Functions:FadeOutOnDist(Name, Dist) end
        end
        Distance.Visible = ESP.Drawing.Distances.Enabled
        if Distance.Visible then
            Distance.Text = math.floor(Dist) .. "m"
            Distance.Position = UDim2.new(0, minX + w/2 - 30, 0, maxY + 4)
            Distance.TextColor3 = ESP.Drawing.Distances.RGB
            if ESP.FadeOut.OnDistance then Functions:FadeOutOnDist(Distance, Dist) end
        end
        Weapon.Visible = ESP.Drawing.Weapons.Enabled
        if Weapon.Visible then
            local tool = plr.Character:FindFirstChildOfClass("Tool")
            Weapon.Text = tool and tool.Name or "none"
            Weapon.Position = UDim2.new(0, minX + w/2 + 30, 0, maxY + 4)
            Weapon.TextColor3 = ESP.Drawing.Weapons.WeaponTextRGB
            if ESP.FadeOut.OnDistance then Functions:FadeOutOnDist(Weapon, Dist) end
        end
        Healthbar.Visible = ESP.Drawing.Healthbar.Enabled
        BehindHealthbar.Visible = Healthbar.Visible
        if Healthbar.Visible then
            local hp = Humanoid.Health / Humanoid.MaxHealth
            Healthbar.Size = UDim2.new(0, math.max(0, w * hp), 0, 3)
            Healthbar.Position = UDim2.new(0, minX, 0, minY - 6)
            Healthbar.BackgroundColor3 = Color3.new(1 - hp, hp, 0)
            BehindHealthbar.Size = UDim2.new(0, w, 0, 3)
            BehindHealthbar.Position = UDim2.new(0, minX, 0, minY - 6)
            HealthText.Visible = ESP.Drawing.Healthbar.HealthText
if HealthText.Visible then
    HealthText.Text = math.floor(Humanoid.Health) .. "/" .. math.floor(Humanoid.MaxHealth)
    HealthText.Position = UDim2.new(0, minX + w/2 - 50, 0, minY - 25)
    HealthText.TextColor3 = ESP.Drawing.Healthbar.HealthTextRGB
end
Chams.Enabled = ESP.Drawing.Chams.Enabled
if Chams.Enabled then
    Chams.Adornee = plr.Character
    Chams.OutlineColor = ESP.Drawing.Chams.OutlineRGB
    Chams.FillColor = ESP.Drawing.Chams.FillRGB
    Chams.OutlineTransparency = ESP.Drawing.Chams.Outline_Transparency
    Chams.FillTransparency = ESP.Drawing.Chams.Fill_Transparency / 100
end
Flag1.Visible = false
Flag2.Visible = false
end
Updater()
end
local connection
connection = RunService.RenderStepped:Connect(function()
    UpdateESP()
end)
plr.AncestryChanged:Connect(function()
    if not plr.Parent then
        connection:Disconnect()
        ScreenGui:FindFirstChild(plr.Name):Destroy()
    end
end)
end

for _, v in pairs(Players:GetPlayers()) do
    if v.Name ~= lplayer.Name then coroutine.wrap(ESPRender)(v) end
end
Players.PlayerAdded:Connect(function(v) coroutine.wrap(ESPRender)(v) end)

local espGroup = P:Section({ Title = "透视设置", Opened = true })
espGroup:Toggle({ Title = "ESP 总开关", Value = ESP.Enabled, Callback = function(s) ESP.Enabled = s end })
espGroup:Toggle({ Title = "队伍检测", Value = ESP.TeamCheck, Callback = function(s) ESP.TeamCheck = s end })
espGroup:Toggle({ Title = "名字显示", Value = ESP.Drawing.Names.Enabled, Callback = function(s) ESP.Drawing.Names.Enabled = s end })
espGroup:Toggle({ Title = "距离显示", Value = ESP.Drawing.Distances.Enabled, Callback = function(s) ESP.Drawing.Distances.Enabled = s end })
espGroup:Toggle({ Title = "武器显示", Value = ESP.Drawing.Weapons.Enabled, Callback = function(s) ESP.Drawing.Weapons.Enabled = s end })
espGroup:Toggle({ Title = "血量条", Value = ESP.Drawing.Healthbar.Enabled, Callback = function(s) ESP.Drawing.Healthbar.Enabled = s end })
espGroup:Toggle({ Title = "方框", Value = ESP.Drawing.Boxes.Full.Enabled, Callback = function(s) ESP.Drawing.Boxes.Full.Enabled = s end })
espGroup:Toggle({ Title = "角标", Value = ESP.Drawing.Boxes.Corner.Enabled, Callback = function(s) ESP.Drawing.Boxes.Corner.Enabled = s end })
espGroup:Toggle({ Title = "高亮描边", Value = ESP.Drawing.Chams.Enabled, Callback = function(s) ESP.Drawing.Chams.Enabled = s end })
      
local TransTab=D:Tab({Title="传送",Icon="send"})

local selectedPlayer=nil

local function getPlayerNames()
    local names={}
    for _,p in ipairs(game:GetService("Players"):GetPlayers()) do
        if p~=game.Players.LocalPlayer then
            table.insert(names,p.Name)
        end
    end
    if #names==0 then
        table.insert(names,"无其他玩家")
    end
    return names
end

local playerDropdown=TransTab:Dropdown({Title="选择玩家",Values=getPlayerNames(),Value="无其他玩家",Callback=function(v)selectedPlayer=v end})

TransTab:Button({Title="刷新列表",Callback=function()
    local newNames=getPlayerNames()
    playerDropdown:SetValues(newNames)
    if #newNames>0 then selectedPlayer=newNames[1] end
    A:SetCore("SendNotification",{Title="已刷新",Text="玩家列表已更新",Duration=2})
end})

TransTab:Button({Title="传送",Callback=function()
    if not selectedPlayer or selectedPlayer=="无其他玩家" then
        A:SetCore("SendNotification",{Title="错误",Text="请先选择一名玩家",Duration=2})
        return
    end
    local target=game:GetService("Players"):FindFirstChild(selectedPlayer)
    if not target or not target.Character then
        A:SetCore("SendNotification",{Title="错误",Text="目标玩家不存在或没有角色",Duration=2})
              A:SetCore("SendNotification",{Title="错误",Text="目标玩家不存在或没有角色",Duration=2})
        return
    end
    local targetRoot=target.Character:FindFirstChild("HumanoidRootPart")
    if not targetRoot then
        A:SetCore("SendNotification",{Title="错误",Text="目标玩家没有HumanoidRootPart",Duration=2})
        return
    end
    local localChar=game.Players.LocalPlayer.Character
    if not localChar then
        A:SetCore("SendNotification",{Title="错误",Text="你没有角色",Duration=2})
        return
    end
    local localRoot=localChar:FindFirstChild("HumanoidRootPart")
    if not localRoot then
        A:SetCore("SendNotification",{Title="错误",Text="你没有HumanoidRootPart",Duration=2})
        return
    end
    localRoot.CFrame=targetRoot.CFrame*CFrame.new(0,0,3)
    A:SetCore("SendNotification",{Title="传送成功",Text="已传送到 "..selectedPlayer.." 旁边",Duration=2})
end})

local MusicTab = D:Tab({Title="音乐播放器", Icon="music"})

local currentSound = nil
local currentVolume = 0.5
local currentSpeed = 1
local musicId = ""

MusicTab:Input({
    Title = "音乐ID",
    Placeholder = "请输入音乐ID",
    Callback = function(text)
        musicId = text
    end
})

MusicTab:Input({
    Title = "音量",
    Placeholder = "请输入数字",
    Callback = function(text)
        local val = tonumber(text)
        if val then
            val = math.clamp(val, 0, 10000000000)
            currentVolume = val
            if currentSound then
                currentSound.Volume = currentVolume
            end
        end
    end
})

MusicTab:Input({
    Title = "速度",
    Placeholder = "请输入数字",
    Callback = function(text)
        local val = tonumber(text)
        if val then
            val = math.clamp(val, 0.01, 2)
            currentSpeed = val
            if currentSound then
                currentSound.PlaybackSpeed = currentSpeed
            end
        end
    end
})

MusicTab:Button({
    Title = "播放音乐",
    Callback = function()
        if musicId == "" then
            A:SetCore("SendNotification",{Title="提示", Text="请先输入音乐ID", Duration=2})
            return
        end
        if currentSound then
            currentSound:Destroy()
            currentSound = nil
        end
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://" .. musicId
        sound.Volume = currentVolume
        sound.PlaybackSpeed = currentSpeed
        sound.Looped = true   
        sound.Parent = game.Players.LocalPlayer.Character or workspace
        sound:Play()
        currentSound = sound
        A:SetCore("SendNotification",{Title="播放中", Text="音乐ID: " .. musicId .. "（循环播放）", Duration=2})
    end
})

MusicTab:Button({
    Title = "停止音乐",
    Callback = function()
        if currentSound then
            currentSound:Stop()
            currentSound:Destroy()
            currentSound = nil
            A:SetCore("SendNotification",{Title="已停止", Text="音乐已停止", Duration=2})
        else
            A:SetCore("SendNotification",{Title="提示", Text="当前没有正在播放的音乐", Duration=2})
        end
    end
})

local L=D:Tab({Title="FE",Icon="zap"})
L:Button({Title="coolgui",Callback=function()loadstring(game:GetObjects("rbxassetid://8127297852")[1].Source)()end})
L:Button({Title="被遗弃人物",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/CyberNinja103/brodwa/refs/heads/main/ForsakationHub"))()end})
L:Button({Title="R15下蹲",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/Azizanzz0/Scripts/refs/heads/main/Crouching.txt"))()end})
L:Button({Title="爬行",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/0Ben1/fe/main/obf_vZDX8j5ggfAf58QhdJ59BVEmF6nmZgq4Mcjt2l8wn16CiStIW2P6EkNc605qv9K4.lua.txt"))()end})
L:Button({Title="免费动作",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/Gazer-Ha/Free-emote/refs/heads/main/Delta%20mad%20stuffs"))()end})
L:Button({Title="假延迟",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/RENZXW/RENZXW-SCRIPTS/main/fakeLAGRENZXW.txt"))()end})
L:Button({Title="假VR(仅自然灾害)",Callback=function()loadstring(game:HttpGet("https://pastefy.app/MvKHpycG/raw"))()end})
L:Button({Title="冲刺",Callback=function()loadstring(game:HttpGet("https://pastefy.app/ZhKVgCK3/raw"))()end})

local M=D:Tab({Title="漏洞",Icon="bug"})
M:Button({Title="AC6音乐播放器",Callback=function()loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FE-Ac6-Music-Vulnerability-25536"))()end})
M:Button({Title="后门执行器1",Callback=function()loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-LALOL-hub-without-hint-19587"))()end})
M:Button({Title="后门执行器2",Callback=function()loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Starlight-Scanner-213808"))()end})
M:Button({Title="UnethicalNetworks f3x gui v9",Callback=function()loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-UnethicalNetworks-f3x-gui-v9-124640"))()end})
M:Button({Title="UnethicalNetworks f3x gui v6 v7 v8",Callback=function()loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-UnethicalNetworks-f3x-gui-v6v7v8-121690"))()end})

local P=D:Tab({Title="其它脚本",Icon="code"})
P:Button({Title="被遗弃角色|皮肤修改器",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/zczczczc766/ink/refs/heads/main/%E8%A2%AB%E9%81%97%E5%BC%83%E8%A7%92%E8%89%B2or%E7%9A%AE%E8%82%A4%E5%88%87%E6%8D%A2%E5%99%A8.lua"))()end})
P:Button({Title="夜脚本",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/ylt410/roblox-Script/refs/heads/main/yejiaoben"))()end})
P:Button({Title="ROB脚本",Callback=function()loadstring(game:HttpGet("https://raw.gitcode.com/ROB5201314/robscript/raw/main/ROB.V3"))()end})

local N=D:Tab({Title="末日砖块",Icon="target"})
local O=D:Tab({Title="被遗弃",Icon="ghost"})

O:Toggle({Title="改视野",Value=false,Callback=function()
    local player=game.Players.LocalPlayer
    local remote=game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent")
    local fovObject=player:WaitForChild("PlayerData"):WaitForChild("Settings"):WaitForChild("Game"):WaitForChild("FieldOfView")
    local bytes=string.char(0x02,0x00,0x00,0x00,0x00,0x00,0x00,0x5E,0x40)
    remote:FireServer("UpdateSettings",{fovObject,buffer.fromstring(bytes)})
end})

local guestBlockEnabled=false
local guestBlockThread=nil

O:Toggle({Title="访客格挡",Value=false,Callback=function(s)
    guestBlockEnabled=s
    if s then
        if guestBlockThread then task.cancel(guestBlockThread) end
        guestBlockThread=task.spawn(function()
            local Event = game:GetService("ReplicatedStorage").Modules.Network.Network.RemoteEvent
            while guestBlockEnabled do
                Event:FireServer("UseActorAbility",{(function(bytes)local b=buffer.create(#bytes)for i=1,#bytes do buffer.writeu8(b,i-1,bytes[i])end return b end)({3,5,0,0,0,66,108,111,99,107})})
                task.wait(0.01)
            end
        end)
    else
        if guestBlockThread then task.cancel(guestBlockThread) guestBlockThread=nil end
    end
end})

local guestChargeEnabled=false
local guestChargeThread=nil

O:Toggle({Title="访客大运",Value=false,Callback=function(s)    guestChargeEnabled=s
    if s then
        if guestChargeThread then task.cancel(guestChargeThread) end
        guestChargeThread=task.spawn(function()
            local Event = game:GetService("ReplicatedStorage").Modules.Network.Network.RemoteEvent
            while guestChargeEnabled do
                Event:FireServer("UseActorAbility",{(function(bytes)local b=buffer.create(#bytes)for i=1,#bytes do buffer.writeu8(b,i-1,bytes[i])end return b end)({3,6,0,0,0,67,104,97,114,103,101})})
                task.wait(0.01)
            end
        end)
    else
        if guestChargeThread then task.cancel(guestChargeThread) guestChargeThread=nil end
    end
end})

local shedletskySlashEnabled=false
local shedletskySlashThread=nil

O:Toggle({Title="谢德大运",Value=false,Callback=function(s)
    shedletskySlashEnabled=s
    if s then
        if shedletskySlashThread then task.cancel(shedletskySlashThread) end
        shedletskySlashThread=task.spawn(function()
            local Event = game:GetService("ReplicatedStorage").Modules.Network.Network.RemoteEvent
            while shedletskySlashEnabled do
                Event:FireServer("UseActorAbility",{(function(bytes)local b=buffer.create(#bytes)for i=1,#bytes do buffer.writeu8(b,i-1,bytes[i])end return b end)({3,5,0,0,0,83,108,97,115,104})})
                task.wait(0.01)
            end
        end)
    else
        if shedletskySlashThread then task.cancel(shedletskySlashThread) shedletskySlashThread=nil end
    end
end})

local pizzaThrowEnabled=false
local pizzaThrowThread=nil

O:Toggle({Title="披萨投喂",Value=false,Callback=function(s)
    pizzaThrowEnabled=s
    if s then
        if pizzaThrowThread then task.cancel(pizzaThrowThread) end
        pizzaThrowThread=task.spawn(function()
            local Event = game:GetService("ReplicatedStorage").Modules.Network.Network.RemoteEvent
            while pizzaThrowEnabled do
                Event:FireServer("UseActorAbility",{(function(bytes)local b=buffer.create(#bytes)for i=1,#bytes do buffer.writeu8(b,i-1,bytes[i])end return b end)({3,10,0,0,0,84,104,114,111,119,80,105,122,122,97})})
                task.wait(0.01)
            end
        end)
    else
        if pizzaThrowThread then task.cancel(pizzaThrowThread) pizzaThrowThread=nil end
    end
end})

local noobDestructionEnabled=false
local noobDestructionThread=nil

O:Toggle({Title="noob破坏世界",Value=false,Callback=function(s)
    noobDestructionEnabled=s
    if s then
        if noobDestructionThread then task.cancel(noobDestructionThread) end
        noobDestructionThread=task.spawn(function()
            local Event = game:GetService("ReplicatedStorage").Modules.Network.Network.RemoteEvent
            while noobDestructionEnabled do
                Event:FireServer("UseActorAbility",{(function(bytes)local b=buffer.create(#bytes)for i=1,#bytes do buffer.writeu8(b,i-1,bytes[i])end return b end)({3,8,0,0,0,84,105,109,101,115,116,111,112})})
                task.wait(0.01)
            end
        end)
    else
        if noobDestructionThread then task.cancel(noobDestructionThread) noobDestructionThread=nil end
    end
end})

local clone007Enabled=false
local clone007Thread=nil

O:Toggle({Title="007分身",Value=false,Callback=function(s)    clone007Enabled=s
    if s then
        if clone007Thread then task.cancel(clone007Thread) end
        clone007Thread=task.spawn(function()
            local Event = game:GetService("ReplicatedStorage").Modules.Network.Network.RemoteEvent
            while clone007Enabled do
                Event:FireServer("UseActorAbility",{(function(bytes)local b=buffer.create(#bytes)for i=1,#bytes do buffer.writeu8(b,i-1,bytes[i])end return b end)({3,5,0,0,0,67,108,111,110,101})})
                task.wait(0.01)
            end
        end)
    else
        if clone007Thread then task.cancel(clone007Thread) clone007Thread=nil end
    end
end})

local taphMineEnabled=false
local taphMineThread=nil

O:Toggle({Title="塔夫放雷",Value=false,Callback=function(s)
    taphMineEnabled=s
    if s then
        if taphMineThread then task.cancel(taphMineThread) end
        taphMineThread=task.spawn(function()
            local Event = game:GetService("ReplicatedStorage").Modules.Network.Network.RemoteEvent
            while taphMineEnabled do
                Event:FireServer("UseActorAbility",{(function(bytes)local b=buffer.create(#bytes)for i=1,#bytes do buffer.writeu8(b,i-1,bytes[i])end return b end)({3,16,0,0,0,83,117,98,115,112,97,99,101,84,114,105,112,109,105,110,101})})
                task.wait(0.01)
            end
        end)
    else
        if taphMineThread then task.cancel(taphMineThread) taphMineThread=nil end
    end
end})

local flashbangEnabled=false
local flashbangThread=nil

O:Toggle({Title="闪光弹",Value=false,Callback=function(s)
    flashbangEnabled=s
    if s then
        if flashbangThread then task.cancel(flashbangThread) end
        flashbangThread=task.spawn(function()
            local Event = game:GetService("ReplicatedStorage").Modules.Network.Network.RemoteEvent
            while flashbangEnabled do
                Event:FireServer("UseActorAbility",{(function(bytes)local b=buffer.create(#bytes)for i=1,#bytes do buffer.writeu8(b,i-1,bytes[i])end return b end)({3,9,0,0,0,70,108,97,115,104,98,97,110,103})})
                task.wait(0.01)
            end
        end)
    else
        if flashbangThread then task.cancel(flashbangThread) flashbangThread=nil end
    end
end})

local guest666Enabled=false
local guest666Thread=nil

O:Toggle({Title="访客666大运",Value=false,Callback=function(s)    guest666Enabled=s
    if s then
        if guest666Thread then task.cancel(guest666Thread) end
        guest666Thread=task.spawn(function()
            local Event = game:GetService("ReplicatedStorage").Modules.Network.Network.RemoteEvent
            while guest666Enabled do
                Event:FireServer("UseActorAbility",{(function(bytes)local b=buffer.create(#bytes)for i=1,#bytes do buffer.writeu8(b,i-1,bytes[i])end return b end)({3,14,0,0,0,68,101,109,111,110,105,99,80,117,114,115,117,105,116})})
                task.wait(0.01)
            end
        end)
    else
        if guest666Thread then task.cancel(guest666Thread) guest666Thread=nil end
    end
end})

local CatTab = D:Tab({Title="猫入侵者", Icon="cat"})

local weaponCDEnabled = false
local weaponCDThread = nil

CatTab:Toggle({
    Title = "武器无CD",
    Value = false,
    Callback = function(state)
        if state then
            weaponCDEnabled = true
            _G.StopWeaponCD = false
            weaponCDThread = task.spawn(function()
                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local Players = game:GetService("Players")
                local LocalPlayer = Players.LocalPlayer

                local Weapons = require(ReplicatedStorage.Modules.Storage.Weapons)
                for _, weapon in pairs(Weapons) do
                    if type(weapon) == "table" then
                        weapon.Cooldown = 0
                    end
                end

                local oldGetServerTimeNow = workspace.GetServerTimeNow
                workspace.GetServerTimeNow = function(self, ...)
                    return oldGetServerTimeNow(self, ...) + 999999
                end

                local CooldownEvent = ReplicatedStorage.Events.Cooldown
                for _, conn in ipairs(getconnections(CooldownEvent.Event)) do
                    conn:Disable()
                end

                local WeaponEvent = ReplicatedStorage.Events.WeaponEvent
                _G.WeaponFiring = false

                function startRapidFire()
                    if _G.WeaponFiring then return end
                    _G.WeaponFiring = true
                    task.spawn(function()
                        while _G.WeaponFiring and not _G.StopWeaponCD do
                            local cam = workspace.CurrentCamera
                            local mouse = LocalPlayer:GetMouse()
                            local ray = cam:ViewportPointToRay(mouse.X, mouse.Y)
                            WeaponEvent:FireServer(ray.Direction.Unit, true)
                            task.wait(0.01)
                        end
                        _G.WeaponFiring = false
                    end)
                end

                function stopRapidFire()
                    _G.WeaponFiring = false
                end

                startRapidFire()

                task.spawn(function()
                    while not _G.StopWeaponCD do
                        local char = LocalPlayer.Character
                        if char then
                            for _, tool in ipairs(char:GetChildren()) do
                                if tool:IsA("Tool") then
                                    tool:SetAttribute("LastActivation", 0)
                                    tool:SetAttribute("LastUse", 0)
                                end
                            end
                        end
                        local backpack = LocalPlayer:FindFirstChild("Backpack")
                        if backpack then
                            for _, tool in ipairs(backpack:GetChildren()) do
                                if tool:IsA("Tool") then
                                    tool:SetAttribute("LastActivation", 0)
                                    tool:SetAttribute("LastUse", 0)
                                end
                            end
                        end
                        task.wait(0.1)
                    end
                end)

                task.spawn(function()
                    while not _G.StopWeaponCD do
                        LocalPlayer:SetAttribute("GlobalHealCooldownEnd", 0)
                        LocalPlayer:SetAttribute("MedicMedkitReadyAt", 0)
                        task.wait(0.1)
                    end
                end)

                while not _G.StopWeaponCD do
                    task.wait(1)
                end
            end)
        else
            weaponCDEnabled = false
            _G.StopWeaponCD = true
            if weaponCDThread then
                task.cancel(weaponCDThread)
                weaponCDThread = nil
            end
            if _G.WeaponFiring then
                _G.WeaponFiring = false
            end
        end
    end
})

local Players=game:GetService("Players")
local player=Players.LocalPlayer
local mouse=player:GetMouse()

local bombState={active=false,thread=nil,fireEvent=nil}
local rocketState={active=false,thread=nil,fireEvent=nil}

local function getBombFire()
    local backpack=player:FindFirstChild("Backpack")
    if not backpack then return nil end
    local timebomb=backpack:FindFirstChild("Timebomb")
    if not timebomb then return nil end
    return timebomb:FindFirstChild("Fire")
end

local function getRocketFire()
    local char=player.Character
    if not char then return nil end
    local launcher=char:FindFirstChild("RocketLauncher")
    if not launcher then return nil end
    return launcher:FindFirstChild("Fire")
end

local function bombLoop()
    local lastRetryTime=0
    while bombState.active do
        local char=player.Character
        if char then
            local rootPart=char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
            if rootPart then
                if not bombState.fireEvent or not bombState.fireEvent.Parent then
                    local now=tick()
                    if now-lastRetryTime>0.2 then
                        lastRetryTime=now
                        bombState.fireEvent=getBombFire()
                    end
                end
                if bombState.fireEvent then
                    bombState.fireEvent:FireServer(rootPart.CFrame)
                end
            end
        end
        task.wait(0.01)
    end
end

local function rocketLoop()
    while rocketState.active do
        if rocketState.fireEvent then
            rocketState.fireEvent:FireServer(mouse.Hit.p)
        end
        task.wait(0.01)
    end
end

N:Toggle({Title="炸弹",Value=false,Callback=function()
    if bombState.active then
        bombState.active=false
        if bombState.thread then
            task.wait(0.02)
            bombState.thread=nil
        end
    end
    bombState.active=true
    bombState.fireEvent=nil
    bombState.thread=task.spawn(bombLoop)
end})

N:Toggle({Title="火箭筒",Value=false,Callback=function(s)
    if s then
        local fire=getRocketFire()
        if not fire then
            warn("火箭筒 Fire 获取失败")
            return
        end
        rocketState.fireEvent=fire
        rocketState.active=true
        rocketState.thread=task.spawn(rocketLoop)
    else
        rocketState.active=false
        if rocketState.thread then
            task.wait(0.02)
            rocketState.thread=nil
        end
        rocketState.fireEvent=nil
    end
end})

task.wait(0.1)
A:SetCore("SendNotification",{Title="加载成功",Text="ink_HUB 已正常运行",Duration=3})

task.spawn(function()
    local Players=game:GetService("Players")
    local localPlayer=Players.LocalPlayer
    local authorNames={"zczczczc722","zczczczc766","UnethicalNetworks4"}
    local taggedPlayers={}
    local function isAuthor(player)
        for _,name in ipairs(authorNames) do
            if player.Name==name then return true end
        end
        return false
    end
    local function addTag(char)
        if not char or not char:IsA("Model") then return end
        local head=char:FindFirstChild("Head")
        if not head then return end
        if head:FindFirstChild("AuthorTag") then return end
        local bill=Instance.new("BillboardGui")
        bill.Name="AuthorTag"
        bill.Size=UDim2.new(0,160,0,35)
        bill.AlwaysOnTop=true
        bill.StudsOffset=Vector3.new(0,2.8,0)
        bill.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
        bill.Parent=head
        bill.Enabled=true
        local frame=Instance.new("Frame")
        frame.Size=UDim2.new(1,0,1,0)
        frame.BackgroundColor3=Color3.fromRGB(0,0,0)
        frame.BackgroundTransparency=0.5
        frame.BorderSizePixel=5
        frame.BorderColor3=Color3.fromRGB(180,180,180)
        frame.Parent=bill
        local grad=Instance.new("UIGradient")
        grad.Color=ColorSequence.new({
            ColorSequenceKeypoint.new(0,Color3.fromRGB(180,180,180)),
            ColorSequenceKeypoint.new(0.3,Color3.fromRGB(150,150,150)),
            ColorSequenceKeypoint.new(0.7,Color3.fromRGB(120,120,120)),
            ColorSequenceKeypoint.new(1,Color3.fromRGB(90,90,90))
        })
        grad.Rotation=0
        grad.Parent=frame
        local label=Instance.new("TextLabel")
        label.Size=UDim2.new(1,0,1,0)
        label.BackgroundTransparency=1
        label.Text="脚本作者"
        label.TextColor3=Color3.new(1,1,1)
        label.TextScaled=true
        label.Font=Enum.Font.GothamBold
        label.Parent=bill
        task.spawn(function()
            while bill and bill.Parent do
                grad.Rotation=(grad.Rotation+1)%360
                task.wait(0.02)
            end
        end)
        return true
    end
    while true do
        for _,p in ipairs(Players:GetPlayers()) do
            if isAuthor(p) and not taggedPlayers[p.UserId] then
                if p.Character then
                    if addTag(p.Character) then
                        taggedPlayers[p.UserId]=true
                    end
                end
                p.CharacterAdded:Connect(function(char)
                    task.wait(0.5)
                    addTag(char)
                end)
            end
        end
        task.wait(2)
    end
end)