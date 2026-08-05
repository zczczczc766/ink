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

local C=B:CreateWindow({Icon="moon",Title=gradient("ink_HUB",Color3.fromRGB(180,180,180),Color3.fromRGB(100,100,100)),Author=gradient("@墨水依旧 司空",Color3.fromRGB(180,180,180),Color3.fromRGB(100,100,100)),Folder="ink_HUB",Size=UDim2.fromOffset(520,410),Background="rbxassetid://99065227044934",BackgroundImageTransparency=0.25,Theme="Dark",User={Enabled=false},SideBarWidth=160,ScrollBarEnabled=true})
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

local Z = D:Tab({Title="公告", Icon="bell"})
Z:Paragraph({
    Title = "欢迎使用 ink_HUB",
    Desc = "作者：墨水依旧和司空\n墨水快手号:zczczczc766\n司空快手号:smalldesikon111和smalldesikon\n公益脚本禁止倒卖\n认准 ink_HUB",
    Image = "rbxassetid://107039115828792",
    ImageSize = 100,
})
Z:Button({Title="复制作者QQ", Callback=function() setclipboard("2047955671") A:SetCore("SendNotification",{Title="已复制", Text="作者QQ：2047955671", Duration=2}) end})
Z:Button({Title="复制作者QQ群", Callback=function() setclipboard("1101093219") A:SetCore("SendNotification",{Title="已复制", Text="作者QQ群：1101093219", Duration=2}) end})
Z:Button({Title="复制作者副群", Callback=function() setclipboard("1063828524") A:SetCore("SendNotification",{Title="已复制", Text="作者副群：1063828524", Duration=2}) end})

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

E:Slider({
    Title = "视野",
    Value = { Min = 60, Max = 120, Default = 70 },
    Step = 1,
    Callback = function(v)
        workspace.CurrentCamera.FieldOfView = v
    end
})

local xrayenabled = false
local xraytransparency = 0.6
local originaltransparencies = {}

E:Toggle({
    Title = "X光",
    Value = false,
    Callback = function(v)
        xrayenabled = v
        if v then
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and not obj:IsDescendantOf(game.Players.LocalPlayer.Character) then
                    originaltransparencies[obj] = obj.Transparency
                    obj.Transparency = xraytransparency
                end
            end
        else
            for obj, t in pairs(originaltransparencies) do
                if obj and obj.Parent then
                    obj.Transparency = t
                end
            end
            originaltransparencies = {}
        end
    end
})

E:Slider({
    Title = "X光透明度",
    Value = { Min = 0, Max = 100, Default = 60 },
    Step = 1,
    Callback = function(v)
        xraytransparency = v / 100
        if xrayenabled then
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and not obj:IsDescendantOf(game.Players.LocalPlayer.Character) and originaltransparencies[obj] then
                    obj.Transparency = v / 100
                end
            end
        end
    end
})

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

local infJumpEnabled = false
local infJumpConnection = nil

E:Toggle({
    Title = "无限跳",
    Value = false,
    Callback = function(v)
        infJumpEnabled = v
        if v then
            infJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
                local char = game.Players.LocalPlayer.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then
                        hum:ChangeState("Jumping")
                    end
                end
            end)
        else
            if infJumpConnection then
                infJumpConnection:Disconnect()
                infJumpConnection = nil
            end
        end
    end
})

local Lighting=game:GetService("Lighting")
local origBright=Lighting.Brightness
E:Toggle({Title="高亮",Value=false,Callback=function(s)
    if s then
        Lighting.Brightness=5
        Lighting.Ambient=Color3.new(1,1,1)
        Lighting.OutdoorAmbient=Color3.new(1,1,1)
    else
        Lighting.Brightness=origBright        Lighting.Ambient=Color3.new(0.5,0.5,0.5)        Lighting.OutdoorAmbient=Color3.new(0.5,0.5,0.5)
    end
end})

local originallighting = {
    FogEnd = game.Lighting.FogEnd,
    FogStart = game.Lighting.FogStart
}
E:Toggle({
    Title = "无雾",
    Value = false,
    Callback = function(v)
        if v then
            game.Lighting.FogEnd = 100000
            game.Lighting.FogStart = 0
        else
            game.Lighting.FogEnd = originallighting.FogEnd
            game.Lighting.FogStart = originallighting.FogStart
        end
    end
})

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

local P = D:Tab({Title="透视", Icon="eye"})

local espEnabled = false
local outlineEnabled = false
local tracersEnabled = false
local espconfig = {
    espcolor = Color3.fromRGB(255, 255, 255),
    outlinecolor = Color3.fromRGB(255, 255, 255),
    outlinefillcolor = Color3.fromRGB(255, 255, 255),
    tracercolor = Color3.fromRGB(255, 255, 255),
    espsize = 16,
    tracersize = 2,
    outlinetransparency = 0,
    outlinefilltransparency = 1,
    rainbowesp = false,
    rainbowoutline = false,
    rainbowtracers = false,
    rainbowspeed = 5,
    tracerposition = "Bottom"
}
local rainbowhue = 0
local lastupdate = 0
local espobjects = {}
local playerconnections = {}
local tracerlines = {}
local activehighlights = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local function getrainbowcolor()
    local currenttime = tick()
    local speedmultiplier = 11 - espconfig.rainbowspeed
    local increment = 0.001 * speedmultiplier
    if currenttime - lastupdate >= 0.1 then
        rainbowhue = (rainbowhue + increment) % 1
        lastupdate = currenttime
    end
    return Color3.fromHSV(rainbowhue, 1, 1)
end

local function getPlayerWeapon(player)
    if not player.Character then return "无" end
    local tool = player.Character:FindFirstChildWhichIsA("Tool")
    if tool then return tool.Name end
    return "无"
end

local function createesp(player)
    if player == LocalPlayer or espobjects[player] then return end
    local nametext = Drawing.new("Text")
    nametext.Size = espconfig.espsize
    nametext.Center = true
    nametext.Outline = true
    nametext.Color = espconfig.espcolor
    nametext.Font = 2
    nametext.Visible = false
    espobjects[player] = { Name = nametext }
end

local function removeesp(player)
    if espobjects[player] then
        espobjects[player].Name:Remove()
        espobjects[player] = nil
    end
end

local function applyhighlighttocharacter(player, character)
    if not character then return end
    local userid = player.UserId
    if activehighlights[userid] then
        activehighlights[userid]:Destroy()
        activehighlights[userid] = nil
    end
    local highlighter = Instance.new("Highlight")
    highlighter.FillTransparency = espconfig.outlinefilltransparency
    highlighter.OutlineTransparency = espconfig.outlinetransparency
    highlighter.OutlineColor = espconfig.rainbowoutline and getrainbowcolor() or espconfig.outlinecolor
    highlighter.FillColor = espconfig.rainbowoutline and getrainbowcolor() or espconfig.outlinefillcolor
    highlighter.Adornee = character
    highlighter.Parent = character
    activehighlights[userid] = highlighter
end

local function removehighlight(player)
    local userid = player.UserId
    if activehighlights[userid] then
        activehighlights[userid]:Destroy()
        activehighlights[userid] = nil
    end
    if playerconnections[userid] then
        for _, conn in pairs(playerconnections[userid]) do
            if conn then conn:Disconnect() end
        end
        playerconnections[userid] = nil
    end
end

local function setupplayerhighlight(player)
    local userid = player.UserId
    playerconnections[userid] = playerconnections[userid] or {}
    local function oncharacteradded(character)
        if not character then return end
        task.spawn(function()
            local humanoid = character:WaitForChild("Humanoid", 5)
            if not humanoid then return end
            if outlineEnabled then
                applyhighlighttocharacter(player, character)
            end
            table.insert(playerconnections[userid], player:GetPropertyChangedSignal("TeamColor"):Connect(function()
                local highlight = activehighlights[userid]
                if highlight then
                    highlight.OutlineColor = espconfig.rainbowoutline and getrainbowcolor() or (player.TeamColor and player.TeamColor.Color) or espconfig.outlinecolor
                end
            end))
            table.insert(playerconnections[userid], humanoid.Died:Connect(function()
                removehighlight(player)
            end))
        end)
    end
    local charaddedconn = player.CharacterAdded:Connect(oncharacteradded)
    table.insert(playerconnections[userid], charaddedconn)
    if player.Character then oncharacteradded(player.Character) end
end

local function updateesp()
    for player, esp in pairs(espobjects) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            local pos, onscreen = Camera:WorldToViewportPoint(hrp.Position)
            local color = espconfig.rainbowesp and getrainbowcolor() or espconfig.espcolor
            esp.Name.Color = color
            esp.Name.Size = espconfig.espsize
            if onscreen then
                local distance = (Camera.CFrame.Position - hrp.Position).Magnitude
                local weapon = getPlayerWeapon(player)
                esp.Name.Position = Vector2.new(pos.X, pos.Y - 20)
                esp.Name.Text = player.Name .. " | " .. math.floor(distance) .. " 米 | " .. weapon
                esp.Name.Visible = true
            else
                esp.Name.Visible = false
            end
        else
            esp.Name.Visible = false
        end
    end
    if outlineEnabled then
        for _, h in pairs(activehighlights) do
            if h then
                h.OutlineColor = espconfig.rainbowoutline and getrainbowcolor() or espconfig.outlinecolor
                h.FillColor = espconfig.rainbowoutline and getrainbowcolor() or espconfig.outlinefillcolor
            end
        end
    end
end

local function createtracers()
    tracerlines = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local line = Drawing.new("Line")
            line.Thickness = espconfig.tracersize
            line.Transparency = 1
            line.Visible = false
            tracerlines[player] = line
        end
    end
end

local function updatetracers()
    local screenHeight = Camera.ViewportSize.Y
    local fromY
    if espconfig.tracerposition == "Bottom" then fromY = screenHeight
    elseif espconfig.tracerposition == "Middle" then fromY = screenHeight / 2
    elseif espconfig.tracerposition == "Up" then fromY = 0 end
    for player, line in pairs(tracerlines) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local root = player.Character.HumanoidRootPart
            local screenpos, onscreen = Camera:WorldToViewportPoint(root.Position)
            local color = espconfig.rainbowtracers and getrainbowcolor() or espconfig.tracercolor
            if onscreen then
                line.From = Vector2.new(Camera.ViewportSize.X / 2, fromY)
                line.To = Vector2.new(screenpos.X, screenpos.Y)
                line.Color = color
                line.Visible = true
            else
                line.Visible = false
            end
        else
            line.Visible = false
        end
    end
end

Players.PlayerAdded:Connect(function(p)
    if p ~= LocalPlayer then
        if espEnabled then createesp(p) end
        if outlineEnabled then
            playerconnections[p.UserId] = {}
            setupplayerhighlight(p)
        end
        if tracersEnabled then
            local line = Drawing.new("Line")
            line.Thickness = espconfig.tracersize
            line.Transparency = 1
            line.Visible = false
            tracerlines[p] = line
        end
        p.CharacterAdded:Connect(function(c)
            if espEnabled then
                task.wait(0.1)
                if not espobjects[p] then createesp(p) end
            end
            if outlineEnabled then
                task.wait(0.1)
                applyhighlighttocharacter(p, c)
            end
        end)
    end
end)

Players.PlayerRemoving:Connect(function(p)
    removeesp(p)
    removehighlight(p)
    if tracerlines[p] then
        tracerlines[p]:Remove()
        tracerlines[p] = nil
    end
end)

for _, p in pairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then
        p.CharacterAdded:Connect(function(c)
            if espEnabled then
                task.wait(0.1)
                if not espobjects[p] then createesp(p) end
            end
            if outlineEnabled then
                task.wait(0.1)
                applyhighlighttocharacter(p, c)
            end
        end)
    end
end

local espGroup = P:Section({ Title = "基础透视", Opened = true })
espGroup:Toggle({
    Title = "透视",
    Value = false,
    Callback = function(v)
        espEnabled = v
        if v then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then createesp(p) end
            end
            RunService:BindToRenderStep("ESPUpdate", Enum.RenderPriority.Camera.Value + 1, updateesp)
        else
            for p, _ in pairs(espobjects) do removeesp(p) end
            RunService:UnbindFromRenderStep("ESPUpdate")
        end
    end
})
espGroup:Colorpicker({
    Title = "透视颜色",
    Default = Color3.fromRGB(255,255,255),
    Callback = function(v) espconfig.espcolor = v end
})
espGroup:Toggle({
    Title = "轮廓",
    Value = false,
    Callback = function(v)
        outlineEnabled = v
        if v then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then
                    if not playerconnections[p.UserId] then
                        playerconnections[p.UserId] = {}
                    end
                    if p.Character then
                        applyhighlighttocharacter(p, p.Character)
                    end
                    setupplayerhighlight(p)
                end
            end
        else
            for _, p in pairs(Players:GetPlayers()) do
                removehighlight(p)
            end
        end
    end
})
espGroup:Colorpicker({
    Title = "轮廓颜色",
    Default = Color3.fromRGB(255,255,255),
    Callback = function(v)
        espconfig.outlinecolor = v
        if outlineEnabled and not espconfig.rainbowoutline then
            for _, h in pairs(activehighlights) do
                if h then
                    h.OutlineColor = v
                end
            end
        end
    end
})
espGroup:Colorpicker({
    Title = "填充颜色",
    Default = Color3.fromRGB(255,255,255),
    Callback = function(v) espconfig.outlinefillcolor = v end
})
espGroup:Toggle({
    Title = "追踪线",
    Value = false,
    Callback = function(v)
        tracersEnabled = v
        if v then
            createtracers()
            RunService:BindToRenderStep("Tracers", Enum.RenderPriority.Camera.Value + 1, updatetracers)
        else
            RunService:UnbindFromRenderStep("Tracers")
            for _, line in pairs(tracerlines) do line:Remove() end
            tracerlines = {}
        end
    end
})
espGroup:Colorpicker({
    Title = "追踪线颜色",
    Default = Color3.fromRGB(255,255,255),
    Callback = function(v) espconfig.tracercolor = v end
})

local configGroup = P:Section({ Title = "高级配置", Opened = false })
configGroup:Toggle({
    Title = "彩虹透视",
    Value = false,
    Callback = function(v) espconfig.rainbowesp = v end
})
configGroup:Toggle({
    Title = "彩虹轮廓",
    Value = false,
    Callback = function(v) espconfig.rainbowoutline = v end
})
configGroup:Toggle({
    Title = "彩虹追踪线",
    Value = false,
    Callback = function(v) espconfig.rainbowtracers = v end
})
configGroup:Slider({
    Title = "透视大小",
    Value = { Min = 16, Max = 48, Default = 16 },
    Step = 1,
    Callback = function(v) espconfig.espsize = v end
})
configGroup:Dropdown({
    Title = "追踪线位置",
    Values = { "底部", "中间", "顶部" },
    Value = "底部",
    Callback = function(v) espconfig.tracerposition = v end
})
configGroup:Slider({
    Title = "轮廓透明度",
    Value = { Min = 0, Max = 100, Default = 0 },
    Step = 1,
    Callback = function(v) espconfig.outlinetransparency = v / 100 end
})
configGroup:Slider({
    Title = "轮廓填充透明度",
    Value = { Min = 0, Max = 100, Default = 50 },
    Step = 1,
    Callback = function(v) espconfig.outlinefilltransparency = v / 100 end
})
configGroup:Slider({
    Title = "彩虹速度",
    Value = { Min = 1, Max = 10, Default = 5 },
    Step = 1,
    Callback = function(v) espconfig.rainbowspeed = v end
})

local AimTab = D:Tab({Title="自瞄", Icon="crosshair"})

local AimbotSettings = {
    Enabled = false,
    TargetPart = "Head",
    TeamCheck = false,
    WallCheck = false,
    CircleEnabled = false,
    CircleRadius = 100,
    CircleThickness = 2,
    CircleColor = "彩色"
}

local Colors = {
    ["红"] = Color3.fromRGB(255,0,0), ["橙"] = Color3.fromRGB(255,150,0), ["黄"] = Color3.fromRGB(255,255,15),
    ["绿"] = Color3.fromRGB(0,255,0), ["青"] = Color3.fromRGB(0,255,219), ["蓝"] = Color3.fromRGB(0,0,255),
    ["紫"] = Color3.fromRGB(183,0,255), ["彩色"] = nil,
}

local Circle = Drawing.new("Circle")
Circle.Filled = false
Circle.Visible = false

local function getCircleColor()
    if AimbotSettings.CircleColor ~= "彩色" and Colors[AimbotSettings.CircleColor] then
        return Colors[AimbotSettings.CircleColor]
    else
        return Color3.fromHSV((tick() % 5) / 5, 1, 1)
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    if AimbotSettings.CircleEnabled then
        Circle.Visible = true
        Circle.Position = workspace.CurrentCamera.ViewportSize / 2
        Circle.Radius = AimbotSettings.CircleRadius
        Circle.Thickness = AimbotSettings.CircleThickness
        Circle.Color = getCircleColor()
    else
        Circle.Visible = false
    end
end)

local LocalPlayer = game.Players.LocalPlayer
local Camera = workspace.CurrentCamera

local function isValidTarget(player)
    if not player or player == LocalPlayer then return false end
    if not player.Character then return false end
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return false end
    if AimbotSettings.TeamCheck and player.Team == LocalPlayer.Team then return false end
    local part = player.Character:FindFirstChild(AimbotSettings.TargetPart)
    if not part then return false end
    if AimbotSettings.WallCheck then
        local params = RaycastParams.new()
        params.FilterDescendantsInstances = {LocalPlayer.Character, player.Character}
        params.FilterType = Enum.RaycastFilterType.Blacklist
        local result = workspace:Raycast(Camera.CFrame.Position, (part.Position - Camera.CFrame.Position).Unit * 1000, params)
        if result and result.Instance ~= part then return false end
    end
    return true
end

local function getClosestInCircle()
    local closest = nil
    local minDist = math.huge
    local center = Camera.ViewportSize / 2
    for _, p in pairs(game.Players:GetPlayers()) do
        if isValidTarget(p) then
            local head = p.Character:FindFirstChild(AimbotSettings.TargetPart)
            if head then
                local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local screenDist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                    if screenDist <= AimbotSettings.CircleRadius and screenDist < minDist then
                        minDist = screenDist
                        closest = p
                    end
                end
            end
        end
    end
    return closest
end

game:GetService("RunService").Heartbeat:Connect(function()
    if AimbotSettings.Enabled then
        local target = getClosestInCircle()
        if target then
            local part = target.Character:FindFirstChild(AimbotSettings.TargetPart)
            if part then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, part.Position)
            end
        end
    end
end)

AimTab:Toggle({ Title = "开启自瞄", Value = false, Callback = function(s) AimbotSettings.Enabled = s end })
AimTab:Toggle({ Title = "自瞄圆圈", Value = false, Callback = function(s) AimbotSettings.CircleEnabled = s end })
AimTab:Dropdown({ Title = "瞄准部位", Values = { "Head", "HumanoidRootPart" }, Value = "Head", Callback = function(v) AimbotSettings.TargetPart = v end })
AimTab:Toggle({ Title = "队伍验证(没做好)", Value = false, Callback = function(s) AimbotSettings.TeamCheck = s end })
AimTab:Toggle({ Title = "墙体检测(没做好)", Value = false, Callback = function(s) AimbotSettings.WallCheck = s end })
AimTab:Slider({ Title = "圆圈大小", Value = { Min = 30, Max = 500, Default = 100 }, Callback = function(v) AimbotSettings.CircleRadius = v end })
AimTab:Slider({ Title = "圆圈厚度", Value = { Min = 1, Max = 10, Default = 2 }, Callback = function(v) AimbotSettings.CircleThickness = v end })
AimTab:Dropdown({ Title = "圆圈颜色", Values = { "红", "橙", "黄", "绿", "青", "蓝", "紫", "彩色" }, Value = "彩色", Callback = function(v) AimbotSettings.CircleColor = v end })

local bulletTrackEnabled = false
local bulletTrackConnection = nil
local originalProps = {}

local function applyBulletTrack(state)
    if state then
        if bulletTrackConnection then bulletTrackConnection:Disconnect() end
        bulletTrackConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not bulletTrackEnabled then return end
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr == game.Players.LocalPlayer then continue end
                if plr.Character then
                    local char = plr.Character
                    if not originalProps[plr] then
                        originalProps[plr] = {}
                        local parts = {"RightUpperLeg", "LeftUpperLeg", "HeadHB", "HumanoidRootPart"}
                        for _, name in pairs(parts) do
                            local part = char:FindFirstChild(name)
                            if part then
                                originalProps[plr][name] = {
                                    CanCollide = part.CanCollide,
                                    Transparency = part.Transparency,
                                    Size = part.Size
                                }
                            end
                        end
                    end
                    for _, name in pairs({"RightUpperLeg", "LeftUpperLeg", "HeadHB", "HumanoidRootPart"}) do
                        local part = char:FindFirstChild(name)
                        if part then
                            part.CanCollide = false
                            part.Transparency = 0.9
                            part.Size = Vector3.new(13, 13, 13)
                        end
                    end
                end
            end
        end)
    else
        if bulletTrackConnection then
            bulletTrackConnection:Disconnect()
            bulletTrackConnection = nil
        end
        for plr, props in pairs(originalProps) do
            if plr.Character then
                for name, prop in pairs(props) do
                    local part = plr.Character:FindFirstChild(name)
                    if part then
                        part.CanCollide = prop.CanCollide
                        part.Transparency = prop.Transparency
                        part.Size = prop.Size
                    end
                end
            end
            originalProps[plr] = nil
        end
    end
end

AimTab:Toggle({
    Title = "碰撞箱扩展",
    Value = false,
    Callback = function(s)
        bulletTrackEnabled = s
        applyBulletTrack(s)
    end
})

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

local repairEnabled = false
local repairDelay = 1.8
local repairThread = nil

O:Toggle({
    Title = "自动修电箱",
    Value = false,
    Callback = function()
        repairEnabled = not repairEnabled
        if repairEnabled then
            repairThread = task.spawn(function()
                while repairEnabled do
                    pcall(function()
                        local map = workspace:FindFirstChild("Map")
                        local ingame = map and map:FindFirstChild("Ingame")
                        local currentMap = ingame and ingame:FindFirstChild("Map")
                        if currentMap then
                            for _, obj in ipairs(currentMap:GetChildren()) do
                                if obj.Name == "Generator" and obj:FindFirstChild("Progress") and obj.Progress.Value < 100 then
                                    local remote = obj:FindFirstChild("Remotes") and obj.Remotes:FindFirstChild("RE")
                                    if remote then remote:FireServer() end
                                end
                            end
                        end
                    end)
                    task.wait(repairDelay)
                end
            end)
        elseif repairThread then
            task.cancel(repairThread)
            repairThread = nil
        end
    end
})

O:Slider({
    Title = "修电箱延迟[秒]",
    Value = { Min = 1.8, Max = 10, Default = 1.8 },
    Step = 0.1,
    Callback = function(v)
        repairDelay = v
    end
})

local staminaEnabled = false
local staminaMonitor = nil
local sprintModule = nil

O:Toggle({
    Title = "无限体力",
    Value = false,
    Callback = function()
        staminaEnabled = not staminaEnabled
        if staminaEnabled then
            pcall(function()
                if not sprintModule then
                    local success, module = pcall(require, game:GetService("ReplicatedStorage").Systems.Character.Game.Sprinting)
                    if success then sprintModule = module end
                end
                if sprintModule and sprintModule.StaminaLossDisabled ~= nil then
                    sprintModule.StaminaLossDisabled = true
                end
            end)
            if not staminaMonitor then
                staminaMonitor = game:GetService("RunService").Heartbeat:Connect(function()
                    if not staminaEnabled then
                        staminaMonitor:Disconnect()
                        staminaMonitor = nil
                        return
                    end
                    pcall(function()
                        if sprintModule and sprintModule.StaminaLossDisabled ~= nil then
                            sprintModule.StaminaLossDisabled = true
                        end
                    end)
                end)
            end
        else
            if staminaMonitor then
                staminaMonitor:Disconnect()
                staminaMonitor = nil
            end
            pcall(function()
                if sprintModule and sprintModule.StaminaLossDisabled ~= nil then
                    sprintModule.StaminaLossDisabled = false
                end
            end)
        end
    end
})

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

O:Toggle({Title="访客大运",Value=false,Callback=function(s)
    guestChargeEnabled=s
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

O:Toggle({Title="访客666大运",Value=false,Callback=function(s)
    guest666Enabled=s
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

local FlashTab = D:Tab({Title="闪光", Icon="sparkles"})

FlashTab:Section({ Title = "角色增强" })

local noVelocityEnabled = false
local noVelocityConnection = nil
FlashTab:Toggle({
    Title = "无流速",
    Value = false,
    Callback = function(v)
        noVelocityEnabled = v
        if v then
            noVelocityConnection = game:GetService("RunService").Heartbeat:Connect(function()
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = player.Character.HumanoidRootPart
                        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                    end
                end
            end)
        else
            if noVelocityConnection then noVelocityConnection:Disconnect(); noVelocityConnection = nil end
        end
    end
})

local bunnyHopEnabled = false
local bunnyHopDelay = 1
local bunnyHopConnection = nil
FlashTab:Toggle({
    Title = "兔子跳",
    Value = false,
    Callback = function(v)
        bunnyHopEnabled = v
        if v then
            bunnyHopConnection = game:GetService("RunService").Heartbeat:Connect(function()
                local char = game.Players.LocalPlayer.Character
                if not char or not char:FindFirstChild("Humanoid") then return end
                local humanoid = char.Humanoid
                if humanoid:GetState() == Enum.HumanoidStateType.Running and humanoid.FloorMaterial ~= Enum.Material.Air then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    task.wait(bunnyHopDelay)
                end
            end)
        else
            if bunnyHopConnection then bunnyHopConnection:Disconnect(); bunnyHopConnection = nil end
        end
    end
})
FlashTab:Slider({
    Title = "兔子跳延迟",
    Value = { Min = 0, Max = 5, Default = 1 },
    Step = 0.1,
    Callback = function(v) bunnyHopDelay = v end
})

FlashTab:Divider()

local xrayenabled = false
local xraytransparency = 0.6
local originaltransparencies = {}
FlashTab:Toggle({
    Title = "X光",
    Value = false,
    Callback = function(v)
        xrayenabled = v
        if v then
            for _, obj in pairs(game.Workspace:GetDescendants()) do
                if obj:IsA("BasePart") and not obj:IsDescendantOf(game.Players.LocalPlayer.Character) then
                    originaltransparencies[obj] = obj.Transparency
                    obj.Transparency = xraytransparency
                end
            end
        else
            for obj, t in pairs(originaltransparencies) do
                if obj and obj.Parent then obj.Transparency = t end
            end
            originaltransparencies = {}
        end
    end
})
FlashTab:Slider({
    Title = "X光透明度",
    Value = { Min = 0, Max = 100, Default = 60 },
    Step = 1,
    Callback = function(v)
        xraytransparency = v / 100
        if xrayenabled then
            for _, obj in pairs(game.Workspace:GetDescendants()) do
                if obj:IsA("BasePart") and not obj:IsDescendantOf(game.Players.LocalPlayer.Character) and originaltransparencies[obj] then
                    obj.Transparency = v / 100
                end
            end
        end
    end
})

FlashTab:Divider()

local autoRespawnEnabled = false
local autoRespawnDelay = 0
local autoRespawnLastFire = 0
FlashTab:Toggle({
    Title = "自动重生",
    Value = false,
    Callback = function(v)
        autoRespawnEnabled = v
        if v then
            task.spawn(function()
                while autoRespawnEnabled do
                    if not game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name) then
                        if tick() - autoRespawnLastFire >= 1 then
                            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
                            if remotes and remotes:FindFirstChild("Command") then
                                remotes.Command:FireServer("Play")
                            end
                            autoRespawnLastFire = tick()
                        end
                    end
                    task.wait(autoRespawnDelay)
                end
            end)
        end
    end
})
FlashTab:Slider({
    Title = "重生延迟",
    Value = { Min = 0, Max = 3, Default = 0 },
    Step = 0.1,
    Callback = function(v) autoRespawnDelay = v end
})

FlashTab:Section({ Title = "游戏功能" })

local ReplicatedStorage = game:GetService("ReplicatedStorage")
FlashTab:Button({
    Title = "返回大厅",
    Callback = function()
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if remotes and remotes:FindFirstChild("Command") then
            remotes.Command:FireServer("Lobby")
        end
    end
})
FlashTab:Button({
    Title = "开始游戏",
    Callback = function()
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if remotes and remotes:FindFirstChild("Command") then
            remotes.Command:FireServer("Play")
        end
    end
})

FlashTab:Section({ Title = "近战刀具" })

local knifeCloseEnabled = false
local knifeRange = 10
local showKnifeRange = false
local knifeRangeColor = Color3.fromRGB(255,255,255)
local knifeRangeTransparency = 0.5
local rangeSphere = nil
local knifeConnection = nil
local lastKnifeState = nil
local SwapWeapon = nil

task.spawn(function()
    local signalEvents = ReplicatedStorage:FindFirstChild("SignalManager")
    if signalEvents then
        signalEvents = signalEvents:FindFirstChild("SignalEvents")
        if signalEvents then
            SwapWeapon = signalEvents:FindFirstChild("SwapWeapon")
        end
    end
end)

local function updateKnifeRangeSphere()
    local player = game.Players.LocalPlayer
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        if rangeSphere then rangeSphere.Transparency = 1 end
        return
    end
    local root = player.Character.HumanoidRootPart
    if showKnifeRange then
        if not rangeSphere then
            rangeSphere = Instance.new("Part")
            rangeSphere.Name = "KnifeRangeSphere"
            rangeSphere.Shape = Enum.PartType.Ball
            rangeSphere.Material = Enum.Material.ForceField
            rangeSphere.CanCollide = false
            rangeSphere.Anchored = true
            rangeSphere.CastShadow = false
            rangeSphere.Parent = game.Workspace
        end
        rangeSphere.Size = Vector3.new(knifeRange*2, knifeRange*2, knifeRange*2)
        rangeSphere.CFrame = root.CFrame
        rangeSphere.Color = knifeRangeColor
        rangeSphere.Transparency = knifeRangeTransparency
    else
        if rangeSphere then rangeSphere:Destroy(); rangeSphere = nil end
    end
end
game:GetService("RunService").RenderStepped:Connect(updateKnifeRangeSphere)

local function anyEnemyInRange()
    local player = game.Players.LocalPlayer
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (root.Position - plr.Character.HumanoidRootPart.Position).Magnitude
            if dist <= knifeRange then return true end
        end
    end
    return false
end

local function toggleKnifeSwitch()
    if knifeCloseEnabled then
        knifeConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not knifeCloseEnabled then return end
            local inRange = anyEnemyInRange()
            if lastKnifeState == nil or lastKnifeState ~= inRange then
                if SwapWeapon then SwapWeapon:Fire() end
                lastKnifeState = inRange
            end
        end)
    else
        if knifeConnection then knifeConnection:Disconnect(); knifeConnection = nil end
        lastKnifeState = nil
    end
end

FlashTab:Toggle({
    Title = "近战切换刀具",
    Value = false,
    Callback = function(v) knifeCloseEnabled = v; toggleKnifeSwitch() end
})
FlashTab:Slider({
    Title = "刀具范围",
    Value = { Min = 1, Max = 50, Default = 10 },
    Step = 1,
    Callback = function(v) knifeRange = v; updateKnifeRangeSphere() end
})
FlashTab:Toggle({
    Title = "显示刀具范围",
    Value = false,
    Callback = function(v) showKnifeRange = v; updateKnifeRangeSphere() end
})
FlashTab:Colorpicker({
    Title = "范围颜色",
    Default = Color3.fromRGB(255,255,255),
    Transparency = 0.5,
    Callback = function(v, t) knifeRangeColor = v; knifeRangeTransparency = t or 0.5; updateKnifeRangeSphere() end
})

FlashTab:Section({ Title = "开箱" })

local knifeCrateCount = 0
local gunCrateCount = 0
local isOpeningCrates = false
local RollCrate = nil
task.spawn(function()
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    if remotes then RollCrate = remotes:FindFirstChild("RollCrate") end
end)

local function openKnifeCrates()
    if isOpeningCrates then return end
    isOpeningCrates = true
    for i = 1, knifeCrateCount do
        if RollCrate then RollCrate:FireServer("KnifeCrate") end
        task.wait(0.1)
    end
    isOpeningCrates = false
end
local function openGunCrates()
    if isOpeningCrates then return end
    isOpeningCrates = true
    for i = 1, gunCrateCount do
        if RollCrate then RollCrate:FireServer("GunCrate") end
        task.wait(0.1)
    end
    isOpeningCrates = false
end

FlashTab:Button({
    Title = "批量开刀具箱",
    Callback = openKnifeCrates
})
FlashTab:Slider({
    Title = "刀具箱数量",
    Value = { Min = 0, Max = 25, Default = 0 },
    Step = 1,
    Callback = function(v) knifeCrateCount = math.floor(v) end
})
FlashTab:Button({
    Title = "批量开枪箱",
    Callback = openGunCrates
})
FlashTab:Slider({
    Title = "枪箱数量",
    Value = { Min = 0, Max = 15, Default = 0 },
    Step = 1,
    Callback = function(v) gunCrateCount = math.floor(v) end
})

FlashTab:Section({ Title = "弹道" })

local bulletTrailsEnabled = false
local bulletMissColor = Color3.new(1,0,0)
local bulletHitColor = Color3.new(0,1,0)
local tracers = {}
local TRACER_LIFETIME = 1.5
local TRACER_THICKNESS = 0.06
local BALL_SIZE = 6
local OUTLINE_THICKNESS = 2
local FADE_TIME = 1.2
local HIT_RANGE = 3

local function fadeBeam(part)
    local t = 0
    while t < TRACER_LIFETIME do
        t = t + game:GetService("RunService").RenderStepped:Wait()
        part.Transparency = t / TRACER_LIFETIME
    end
    part:Destroy()
end

local function drawTracerSegment(startPos, endPos)
    if not bulletTrailsEnabled then return end
    local beam = Instance.new("Part")
    beam.Anchored = true
    beam.CanCollide = false
    beam.Material = Enum.Material.Neon
    beam.Color = bulletMissColor
    beam.Size = Vector3.new(TRACER_THICKNESS, TRACER_THICKNESS, (startPos - endPos).Magnitude)
    beam.CFrame = CFrame.new(startPos, endPos) * CFrame.new(0,0,-beam.Size.Z/2)
    beam.Transparency = 0
    beam.Parent = game.Workspace
    table.insert(tracers, beam)
    task.spawn(function() fadeBeam(beam) end)
end

local function colorNearestTracer(gibPosition)
    if not bulletTrailsEnabled then return end
    local nearest = nil
    local nearestDist = math.huge
    for _, tracer in ipairs(tracers) do
        if tracer.Parent then
            local dist = (tracer.Position - gibPosition).Magnitude
            if dist < nearestDist then
                nearestDist = dist
                nearest = tracer
            end
        end
    end
    if nearest then nearest.Color = bulletHitColor end
end

local function hitPlayer(position)
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr ~= game.Players.LocalPlayer and plr.Character then
            for _, part in ipairs(plr.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    if (part.Position - position).Magnitude <= HIT_RANGE then
                        return true
                    end
                end
            end
        end
    end
    return false
end

local function makeImpactBall(part)
    if not bulletTrailsEnabled then return end
    local pos = part.Position
    local green = hitPlayer(pos)
    local outlineColor = green and bulletHitColor or bulletMissColor
    local innerColor = green and bulletHitColor or bulletMissColor
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.fromOffset(BALL_SIZE*2, BALL_SIZE*2)
    billboard.AlwaysOnTop = false
    billboard.LightInfluence = 0
    billboard.Parent = part
    local outline = Instance.new("ImageLabel")
    outline.Size = UDim2.fromScale(1,1)
    outline.BackgroundTransparency = 1
    outline.Image = "rbxassetid://1316045217"
    outline.ImageColor3 = outlineColor
    outline.ImageTransparency = 0
    outline.Parent = billboard
    local inner = Instance.new("ImageLabel")
    inner.Size = UDim2.fromOffset(billboard.Size.X.Offset - OUTLINE_THICKNESS*2, billboard.Size.Y.Offset - OUTLINE_THICKNESS*2)
    inner.Position = UDim2.fromOffset(OUTLINE_THICKNESS, OUTLINE_THICKNESS)
    inner.BackgroundTransparency = 1
    inner.Image = "rbxassetid://1316045217"
    inner.ImageColor3 = innerColor
    inner.ImageTransparency = 0
    inner.Parent = billboard
    task.spawn(function()
        local t = 0
        while t < FADE_TIME do
            t = t + game:GetService("RunService").RenderStepped:Wait()
            local alpha = t / FADE_TIME
            outline.ImageTransparency = alpha
            inner.ImageTransparency = alpha
        end
        billboard:Destroy()
    end)
end

local bulletStorage = game.Workspace:FindFirstChild("bulletStorage") or Instance.new("Folder", game.Workspace)
if bulletStorage.Name ~= "bulletStorage" then bulletStorage.Name = "bulletStorage" end
local hitEffectFolder = game.Workspace:FindFirstChild("HitEffect") or Instance.new("Folder", game.Workspace)
if hitEffectFolder.Name ~= "HitEffect" then hitEffectFolder.Name = "HitEffect" end

bulletStorage.ChildAdded:Connect(function(bullet)
    if not bulletTrailsEnabled then return end
    if not bullet:IsA("BasePart") then return end
    local lastPos = bullet.Position
    local conn
    conn = game:GetService("RunService").RenderStepped:Connect(function()
        if bullet and bullet.Parent then
            local newPos = bullet.Position
            drawTracerSegment(lastPos, newPos)
            lastPos = newPos
        else
            conn:Disconnect()
        end
    end)
end)

hitEffectFolder.ChildAdded:Connect(function(obj)
    if not bulletTrailsEnabled then return end
    if obj:IsA("BasePart") then
        if obj.Name == "Gib_T" then colorNearestTracer(obj.Position) end
        if obj.Name == "Gib_G" then makeImpactBall(obj) end
    end
end)

FlashTab:Toggle({
    Title = "显示弹道",
    Value = false,
    Callback = function(v) bulletTrailsEnabled = v end
})
FlashTab:Colorpicker({
    Title = "未击中颜色",
    Default = Color3.new(1,0,0),
    Callback = function(v) bulletMissColor = v end
})
FlashTab:Colorpicker({
    Title = "击中颜色",
    Default = Color3.new(0,1,0),
    Callback = function(v) bulletHitColor = v end
})
   
local BackstreetTab = D:Tab({Title="后街生存", Icon="map"})

local lastPosition = nil
local function teleportTo(pos)
    local char = game.Players.LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    lastPosition = hrp.Position
    hrp.CFrame = CFrame.new(pos)
end

BackstreetTab:Section({ Title = "自动功能" })

local toolLoopEnabled = false
local toolLoopConnection = nil
local function startToolLoop()
    if toolLoopConnection then return end
    local RS = game:GetService("ReplicatedStorage")
    local ToolEvent = RS:WaitForChild("Events"):WaitForChild("ToolEvent")
    toolLoopConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not toolLoopEnabled then return end
        ToolEvent:FireServer("Activated", false)
        task.wait(0.5)
        if not toolLoopEnabled then return end
        ToolEvent:FireServer("Activated", true)
        task.wait(0.5)
    end)
end
local function stopToolLoop()
    toolLoopEnabled = false
    if toolLoopConnection then toolLoopConnection:Disconnect(); toolLoopConnection = nil end
end

BackstreetTab:Toggle({
    Title = "启用自动挖掘",
    Value = false,
    Callback = function(state)
        toolLoopEnabled = state
        if state then startToolLoop() else stopToolLoop() end
    end
})

local stickPickupEnabled = false
local stickPickupConnection = nil
local function startStickPickup()
    if stickPickupConnection then return end
    stickPickupConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not stickPickupEnabled then return end
        local player = game.Players.LocalPlayer
        local backpack = player:FindFirstChild("Backpack")
        if not backpack then return end
        for _, item in pairs(backpack:GetChildren()) do
            if item:IsA("Tool") and item.Name:sub(1,5):lower() == "stick" then
                local char = player.Character or workspace:FindFirstChild(player.Name)
                if char then item.Parent = char end
                break
            end
        end
    end)
end
local function stopStickPickup()
    stickPickupEnabled = false
    if stickPickupConnection then stickPickupConnection:Disconnect(); stickPickupConnection = nil end
end

BackstreetTab:Toggle({
    Title = "自动拿起木棍",
    Value = false,
    Callback = function(state)
        stickPickupEnabled = state
        if state then startStickPickup() else stopStickPickup() end
    end
})

BackstreetTab:Section({ Title = "传送" })

BackstreetTab:Button({ Title = "传送到垃圾大师", Callback = function() teleportTo(Vector3.new(-173.27, 3.50, 47.06)) end })
BackstreetTab:Button({ Title = "传送回原位置", Callback = function()
    if not lastPosition then return end
    local char = game.Players.LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    hrp.CFrame = CFrame.new(lastPosition)
end })

BackstreetTab:Section({ Title = "地点传送" })

BackstreetTab:Button({ Title = "传送到豆子工厂", Callback = function() teleportTo(Vector3.new(-269.05, 3.50, 155.16)) end })
BackstreetTab:Button({ Title = "传送到后街", Callback = function() teleportTo(Vector3.new(-196.88, 3.50, 63.44)) end })
BackstreetTab:Button({ Title = "传送到后街对面", Callback = function() teleportTo(Vector3.new(-184.26, 4.00, -189.72)) end })
BackstreetTab:Button({ Title = "传送到下水道", Callback = function() teleportTo(Vector3.new(-245.42, -22.96, -1349.19)) end })

local NicoTab = D:Tab({Title="nico的下一个机器人", Icon="cpu"})

local bunnyHopEnabled = false
local bunnyHopConnection = nil

NicoTab:Toggle({
    Title = "自动跳跃",
    Value = false,
    Callback = function(v)
        bunnyHopEnabled = v
        if v then
            bunnyHopConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if not bunnyHopEnabled then return end
                local char = game.Players.LocalPlayer.Character
                if not char then return end
                local humanoid = char:FindFirstChild("Humanoid")
                if not humanoid then return end
                if humanoid:GetState() == Enum.HumanoidStateType.Running and humanoid.FloorMaterial ~= Enum.Material.Air then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        else
            if bunnyHopConnection then
                bunnyHopConnection:Disconnect()
                bunnyHopConnection = nil
            end
        end
    end
})

local CatTab = D:Tab({ Title = "猫入侵者", Icon = "cat" })

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

local DogPoliceTab = D:Tab({Title="狗对警察", Icon="dog"})

local leashEnabled = false
local leashThread = nil
DogPoliceTab:Toggle({
    Title = "安全套狗",
    Value = false,
    Callback = function(s)
        if s then
            leashEnabled = true
            _G.StopLeash = false
            leashThread = task.spawn(function()
                local Players = game:GetService("Players")
                local RunService = game:GetService("RunService")
                local LocalPlayer = Players.LocalPlayer
                local Index = 1
                local PlayerList = {}
                local TARGETS_PER_EXECUTION = 5
                RunService.Stepped:Connect(function()
                    if _G.StopLeash then return end
                    local Character = LocalPlayer.Character
                    if not Character then return end
                    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                    if not HumanoidRootPart then return end
                    local Tool = Character:FindFirstChildOfClass("Tool")
                    if not (Tool and Tool.Name:find("Leash")) then return end
                    PlayerList = {}
                    for _, Player in ipairs(Players:GetPlayers()) do
                        if Player ~= LocalPlayer and Player.Character and (not Player.Team or Player.Team ~= LocalPlayer.Team) then
                            table.insert(PlayerList, Player)
                        end
                    end
                    if #PlayerList == 0 then return end
                    if Index > #PlayerList then Index = 1 end
                    local targetsToHit = math.min(TARGETS_PER_EXECUTION, #PlayerList)
                    for i = 1, targetsToHit do
                        local Target = PlayerList[Index]
                        if Target and Target.Character then
                            pcall(function()
                                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("LeachEvent"):FireServer(Target.Character)
                            end)
                        end
                        Index = Index + 1
                        if Index > #PlayerList then Index = 1 end
                    end
                    task.wait(0.01)
                end)
                while not _G.StopLeash do task.wait(1) end
            end)
        else
            _G.StopLeash = true
            if leashThread then task.cancel(leashThread); leashThread = nil end
        end
    end
})

local robotEnabled = false
local robotThread = nil
DogPoliceTab:Toggle({
    Title = "愤怒机器人",
    Value = false,
    Callback = function(s)
        if s then
            robotEnabled = true
            _G.StopRobot = false
            robotThread = task.spawn(function()
                local Players = game:GetService("Players")
                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local RunService = game:GetService("RunService")
                local LocalPlayer = Players.LocalPlayer
                local FireEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("FireEvent")
                local fireRate = 0.1
                local lastFire = 0
                local soundId = "rbxassetid://6534948092"
                local multiFireCount = 3
                local allowedWeapons = {["Shotgun"]=true, ["AR"]=true, ["Heavy Sniper"]=true, ["Pistol"]=true}
                local function playSound()
                    local sound = Instance.new("Sound")
                    sound.SoundId = soundId
                    sound.Volume = 1
                    sound.Parent = workspace
                    sound:Play()
                    sound.Ended:Connect(function() sound:Destroy() end)
                end
                local function getWeapons()
                    local char = LocalPlayer.Character
                    if not char then return {} end
                    local weapons = {}
                    for _, v in ipairs(char:GetChildren()) do
                        if v:IsA("Tool") and allowedWeapons[v.Name] then
                            table.insert(weapons, v)
                        end
                    end
                    return weapons
                end
                local function getEnemies()
                    local enemies = {}
                    for _, plr in ipairs(Players:GetPlayers()) do
                        if plr ~= LocalPlayer and plr.Team ~= LocalPlayer.Team then
                            local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                            local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
                            if root and hum and hum.Health > 0 then
                                table.insert(enemies, root)
                            end
                        end
                    end
                    return enemies
                end
                RunService.Heartbeat:Connect(function()
                    if _G.StopRobot then return end
                    if tick() - lastFire < fireRate then return end
                    lastFire = tick()
                    local weapons = getWeapons()
                    local enemies = getEnemies()
                    if #weapons == 0 or #enemies == 0 then return end
                    for _, root in ipairs(enemies) do
                        local targetPos = root.Position
                        for _, weapon in ipairs(weapons) do
                            for i = 1, multiFireCount do
                                FireEvent:FireServer("Fire", weapon, Vector3.new(targetPos.X, targetPos.Y, targetPos.Z))
                                playSound()
                            end
                        end
                    end
                end)
                while not _G.StopRobot do task.wait(1) end
            end)
        else
            _G.StopRobot = true
            if robotThread then task.cancel(robotThread); robotThread = nil end
        end
    end
})

local moneyLeashEnabled = false
local moneyLeashThread = nil
DogPoliceTab:Toggle({
    Title = "疯狂套狗刷钱",
    Value = false,
    Callback = function(s)
        if s then
            moneyLeashEnabled = true
            _G.StopMoneyLeash = false
            moneyLeashThread = task.spawn(function()
                local Players = game:GetService("Players")
                local RunService = game:GetService("RunService")
                local LocalPlayer = Players.LocalPlayer
                local Index = 1
                local PlayerList = {}
                local LockedPosition = nil
                RunService.Stepped:Connect(function()
                    if _G.StopMoneyLeash then return end
                    local Character = LocalPlayer.Character
                    if not Character then return end
                    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                    if not HumanoidRootPart then return end
                    local Tool = Character:FindFirstChildOfClass("Tool")
                    if not (Tool and Tool.Name:find("Leash")) then
                        LockedPosition = nil
                        return
                    end
                    if not LockedPosition then
                        LockedPosition = HumanoidRootPart.Position
                    end
                    HumanoidRootPart.CFrame = CFrame.new(LockedPosition)
                    PlayerList = {}
                    for _, Player in ipairs(Players:GetPlayers()) do
                        if Player ~= LocalPlayer and Player.Character and (not Player.Team or Player.Team ~= LocalPlayer.Team) then
                            table.insert(PlayerList, Player)
                        end
                    end
                    if #PlayerList == 0 then return end
                    if Index > #PlayerList then Index = 1 end
                    local Target = PlayerList[Index]
                    if Target and Target.Character then
                        pcall(function()
                            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("LeachEvent"):FireServer(Target.Character)
                        end)
                    end
                    Index = Index + 1
                    task.wait(0.1)
                end)
                while not _G.StopMoneyLeash do task.wait(1) end
            end)
        else
            _G.StopMoneyLeash = true
            if moneyLeashThread then task.cancel(moneyLeashThread); moneyLeashThread = nil end
        end
    end
})

local biteEnabled = false
local biteThread = nil
DogPoliceTab:Toggle({
    Title = "狗疯狂咬警察",
    Value = false,
    Callback = function(s)
        if s then
            biteEnabled = true
            _G.StopBite = false
            biteThread = task.spawn(function()
                local Players = game:GetService("Players")
                local RunService = game:GetService("RunService")
                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local player = Players.LocalPlayer
                local biteRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("DogBiteEvent")
                local currentTarget = nil
                local lastBite = 0
                local BITE_INTERVAL = 0.01
                local OFFSET = Vector3.new(0, 0, 0.5)
                local DOGS_TEAM_NAME = "Dogs"
                local ESCAPED_TEAM_NAME = "Escaped"
                local function isAllowedTeam()
                    local team = player.Team
                    if not team then return false end
                    return team.Name == DOGS_TEAM_NAME or team.Name == ESCAPED_TEAM_NAME
                end
                local function isProtected(p)
                    if p == player then return true end
                    if not p.Team then return true end
                    if p.Team == player.Team then return true end
                    if p.Team.Name == DOGS_TEAM_NAME then return true end
                    if p.Team.Name == ESCAPED_TEAM_NAME then return true end
                    return false
                end
                local function pickNextTarget()
                    for _, p in ipairs(Players:GetPlayers()) do
                        if not isProtected(p) then
                            local char = p.Character
                            if char then
                                local h = char:FindFirstChildOfClass("Humanoid")
                                local root = char:FindFirstChild("HumanoidRootPart")
                                if h and root and h.Health > 0 then
                                    return p
                                end
                            end
                        end
                    end
                    return nil
                end
                player.CharacterAdded:Connect(function()
                    if isAllowedTeam() then
                        task.wait(1)
                        currentTarget = pickNextTarget()
                    end
                end)
                player:GetPropertyChangedSignal("Team"):Connect(function()
                    if not isAllowedTeam() then
                        _G.StopBite = true
                        currentTarget = nil
                    end
                end)
                RunService.Heartbeat:Connect(function()
                    if _G.StopBite then return end
                    if not isAllowedTeam() then return end
                    if not player.Character then return end
                    if not currentTarget or not currentTarget.Character then
                        currentTarget = pickNextTarget()
                        if not currentTarget then return end
                    end
                    local tRoot = currentTarget.Character:FindFirstChild("HumanoidRootPart")
                    local hum = currentTarget.Character:FindFirstChildOfClass("Humanoid")
                    if tRoot and hum then
                        if hum.Health <= 0 then
                            currentTarget = pickNextTarget()
                            return
                        end
                        player.Character:PivotTo(tRoot.CFrame * CFrame.new(OFFSET))
                        local now = tick()
                        if now - lastBite >= BITE_INTERVAL then
                            biteRemote:FireServer()
                            lastBite = now
                        end
                    end
                end)
                Players.PlayerRemoving:Connect(function(p)
                    if p == currentTarget then
                        currentTarget = pickNextTarget()
                    end
                end)
                while not _G.StopBite do task.wait(1) end
            end)
        else
            _G.StopBite = true
            if biteThread then task.cancel(biteThread); biteThread = nil end
        end
    end
})

local medkitEnabled = false
local medkitThread = nil
DogPoliceTab:Toggle({
    Title = "自动购买医疗箱",
    Value = false,
    Callback = function(s)
        if s then
            medkitEnabled = true
            _G.StopMedkit = false
            medkitThread = task.spawn(function()
                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local Players = game:GetService("Players")
                local player = Players.LocalPlayer
                local backpack = player:WaitForChild("Backpack")
                local remote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("PurchaseItemRequest")
                local function hasMedkit()
                    for _, item in pairs(backpack:GetChildren()) do
                        if item.Name == "Medkit" then
                            return true
                        end
                    end
                    return false
                end
                while not _G.StopMedkit do
                    if not hasMedkit() then
                        remote:FireServer("Medkit")
                        task.wait(0.01)
                        remote:FireServer("Medkit")
                    end
                    task.wait(0.01)
                end
            end)
        else
            _G.StopMedkit = true
            if medkitThread then task.cancel(medkitThread); medkitThread = nil end
        end
    end
})                

local muzzleEnabled = false
local muzzleThread = nil

DogPoliceTab:Toggle({
    Title = "拿起锁狗嘴自动锁",
    Value = false,
    Callback = function(s)
        if s then
            muzzleEnabled = true
            _G.StopMuzzle = false
            muzzleThread = task.spawn(function()
                local Players = game:GetService("Players")
                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local LocalPlayer = Players.LocalPlayer
                while not _G.StopMuzzle do
                    local localTeam = LocalPlayer.Team
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Team ~= localTeam then
                            local char = player.Character or player:WaitForChild("Character", 3)
                            if char then
                                pcall(function()
                                    ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("MuzzleEvent"):FireServer(char)
                                end)
                            end
                        end
                    end
                    task.wait(0)
                end
            end)
        else
            _G.StopMuzzle = true
            if muzzleThread then
                task.cancel(muzzleThread)
                muzzleThread = nil
            end
        end
    end
})

local CleanTab = D:Tab({Title="清洁键帽", Icon="sparkles"})

local scrubEnabled = false
local scrubThread = nil
CleanTab:Toggle({
    Title = "快速擦键帽",
    Value = false,
    Callback = function(s)
        if s then
            scrubEnabled = true
            _G.StopScrub = false
            scrubThread = task.spawn(function()
                local RS = game:GetService("ReplicatedStorage")
                local remote = RS:WaitForChild("ffrostflame_bridgenet2@1.0.0"):WaitForChild("dataRemoteEvent")
                local args = {{{Action = "Scrub"}, "\a"}}
                local multiplier = 99
                while not _G.StopScrub do
                    for i = 1, multiplier do
                        remote:FireServer(unpack(args))
                    end
                    task.wait(0.01)
                end
            end)
        else
            _G.StopScrub = true
            if scrubThread then task.cancel(scrubThread); scrubThread = nil end
        end
    end
})

local spongeEnabled = false
local spongeThread = nil
CleanTab:Toggle({
    Title = "重复拿起海绵",
    Value = false,
    Callback = function(s)
        if s then
            spongeEnabled = true
            _G.StopSponge = false
            spongeThread = task.spawn(function()
                local plr = game.Players.LocalPlayer
                local char = plr.Character or plr.CharacterAdded:Wait()
                local hum = char:WaitForChild("Humanoid")
                while not _G.StopSponge do
                    local sponge = plr.Backpack:FindFirstChild("Sponge") or char:FindFirstChild("Sponge")
                    if sponge then
                        pcall(function()
                            hum:EquipTool(sponge)
                        end)
                    end
                    task.wait(0.01)
                end
            end)
        else
            _G.StopSponge = true
            if spongeThread then task.cancel(spongeThread); spongeThread = nil end
        end
    end
})

local HitTab = D:Tab({Title="击打动作", Icon="zap"})

local hitEnabled = false
local hitThread = nil

HitTab:Toggle({
    Title = "击飞所有人",
    Value = false,
    Callback = function(s)
        if s then
            hitEnabled = true
            _G.StopHit = false
            hitThread = task.spawn(function()
                local Players = game:GetService("Players")
                local LocalPlayer = Players.LocalPlayer
                while not _G.StopHit do
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer then
                            local char = player.Character
                            if char then
                                local root = char:FindFirstChild("HumanoidRootPart")
                                if root then
                                    pcall(function()
                                        root.Velocity = Vector3.new(0, 150, 0)
                                    end)
                                end
                            end
                        end
                    end
                    task.wait(0.05)
                end
            end)
        else
            _G.StopHit = true
            if hitThread then
                task.cancel(hitThread)
                hitThread = nil
            end
        end
    end
})

local BlockWarTab = D:Tab({Title="方块战争", Icon="pickaxe"})

local mineEnabled = false
local mineThread = nil
local originalMineSeconds = nil
local originalBreakSeconds = nil
local originalBreakSecondsForHP = nil
local originalBrickHPForBought = nil

BlockWarTab:Toggle({
    Title = "稿子秒挖",
    Value = false,
    Callback = function(s)
        if s then
            mineEnabled = true
            _G.StopMine = false
            mineThread = task.spawn(function()
                local RS = game:GetService("ReplicatedStorage")
                while not _G.StopMine do
                    pcall(function()
                        local MineDefs = require(RS.Modules.Configs.MineDefs)
                        if MineDefs and MineDefs.MineSeconds then
                            if not originalMineSeconds then
                                originalMineSeconds = MineDefs.MineSeconds
                            end
                            MineDefs.MineSeconds = function() return 0 end
                        end
                    end)
                    pcall(function()
                        local BBC = require(RS.Modules.Configs.BlockBreakConfig)
                        if BBC.BreakSeconds then
                            if not originalBreakSeconds then
                                originalBreakSeconds = BBC.BreakSeconds
                            end
                            BBC.BreakSeconds = function() return 0 end
                        end
                        if BBC.BreakSecondsForHP then
                            if not originalBreakSecondsForHP then
                                originalBreakSecondsForHP = BBC.BreakSecondsForHP
                            end
                            BBC.BreakSecondsForHP = function() return 0 end
                        end
                    end)
                    pcall(function()
                        local GUC = require(RS.Modules.Configs.GeneratorUpgradeConfig)
                        if GUC and GUC.BrickHPForBought then
                            if not originalBrickHPForBought then
                                originalBrickHPForBought = GUC.BrickHPForBought
                            end
                            GUC.BrickHPForBought = function() return 0 end
                        end
                    end)
                    task.wait(1)
                end
            end)
        else
            _G.StopMine = true
            if mineThread then task.cancel(mineThread); mineThread = nil end
            pcall(function()
                local RS = game:GetService("ReplicatedStorage")
                local MineDefs = require(RS.Modules.Configs.MineDefs)
                if MineDefs and originalMineSeconds then
                    MineDefs.MineSeconds = originalMineSeconds
                end
                local BBC = require(RS.Modules.Configs.BlockBreakConfig)
                if BBC and originalBreakSeconds then
                    BBC.BreakSeconds = originalBreakSeconds
                end
                if BBC and originalBreakSecondsForHP then
                    BBC.BreakSecondsForHP = originalBreakSecondsForHP
                end
                local GUC = require(RS.Modules.Configs.GeneratorUpgradeConfig)
                if GUC and originalBrickHPForBought then
                    GUC.BrickHPForBought = originalBrickHPForBought
                end
            end)
            originalMineSeconds = nil
            originalBreakSeconds = nil
            originalBreakSecondsForHP = nil
            originalBrickHPForBought = nil
        end
    end
})

local weaponEnabled = false
local weaponThread = nil
local weaponConnections = {}
local originalWeaponData = {}

BlockWarTab:Toggle({
    Title = "近战武器无CD",
    Value = false,
    Callback = function(s)
        if s then
            weaponEnabled = true
            _G.StopWeapon = false
            weaponThread = task.spawn(function()
                local RS = game:GetService("ReplicatedStorage")
                local Players = game:GetService("Players")
                local Run = game:GetService("RunService")
                local LP = Players.LocalPlayer

                pcall(function()
                    local Reg = require(RS.Data.Registries.WeaponRegistry)
                    if Reg and Reg.Entries then
                        for k, v in pairs(Reg.Entries) do
                            if not originalWeaponData[k] then
                                originalWeaponData[k] = {
                                    HitDelay = v.HitDelay,
                                    HitDuration = v.HitDuration,
                                    Cooldown = v.Cooldown,
                                    ComboTimeout = v.ComboTimeout
                                }
                            end
                            v.HitDelay = 0
                            v.HitDuration = 0.05
                            v.Cooldown = 0
                            v.ComboTimeout = 0
                        end
                    end
                end)

                LP:SetAttribute("AttackSpeedMul", 999999)
                local attrConn = LP:GetAttributeChangedSignal("AttackSpeedMul"):Connect(function()
                    if not _G.StopWeapon and LP:GetAttribute("AttackSpeedMul") ~= 999999 then
                        LP:SetAttribute("AttackSpeedMul", 999999)
                    end
                end)
                table.insert(weaponConnections, attrConn)

                LP:SetAttribute("StunEndsAt", 0)
                local stunConn = LP:GetAttributeChangedSignal("StunEndsAt"):Connect(function()
                    if not _G.StopWeapon and (LP:GetAttribute("StunEndsAt") or 0) > workspace:GetServerTimeNow() then
                        LP:SetAttribute("StunEndsAt", 0)
                    end
                end)
                table.insert(weaponConnections, stunConn)

                local heartbeatConn = Run.Heartbeat:Connect(function()
                    if _G.StopWeapon then return end
                    LP:SetAttribute("StunEndsAt", 0)
                    pcall(function()
                        for _, m in ipairs(getloadedmodules and getloadedmodules() or {}) do
                            if m and m.SwingState then
                                m.SwingState.cooldownEndsAt = -1
                                m.SwingState.duration = 0
                            end
                        end
                    end)
                end)
                table.insert(weaponConnections, heartbeatConn)

                local CombatRemotes = RS:WaitForChild("GameEvents"):WaitForChild("CombatRemotes")
                local AtkRemote = CombatRemotes:WaitForChild("Combat_RequestAttack")
                local last = 0

                local atkConn = Run.Heartbeat:Connect(function()
                    if _G.StopWeapon then return end
                    if tick() - last < 0.05 then return end
                    local char = LP.Character
                    local tool = char and char:FindFirstChildWhichIsA("Tool")
                    if tool then
                        local ok, wtype = pcall(function()
                            return require(RS.Data.Registries.WeaponRegistry).GetTypeFromTool(tool)
                        end)
                        if ok and wtype then
                            last = tick()
                            pcall(function()
                                AtkRemote:FireServer(wtype)
                            end)
                        end
                    end
                end)
                table.insert(weaponConnections, atkConn)

                while not _G.StopWeapon do
                    task.wait(1)
                end
            end)
        else
            _G.StopWeapon = true
            if weaponThread then task.cancel(weaponThread); weaponThread = nil end
            for _, conn in ipairs(weaponConnections) do
                pcall(function() conn:Disconnect() end)
            end
            weaponConnections = {}
            pcall(function()
                local RS = game:GetService("ReplicatedStorage")
                local Players = game:GetService("Players")
                local LP = Players.LocalPlayer
                local Reg = require(RS.Data.Registries.WeaponRegistry)
                if Reg and Reg.Entries then
                    for k, v in pairs(Reg.Entries) do
                        if originalWeaponData[k] then
                            v.HitDelay = originalWeaponData[k].HitDelay
                            v.HitDuration = originalWeaponData[k].HitDuration
                            v.Cooldown = originalWeaponData[k].Cooldown
                            v.ComboTimeout = originalWeaponData[k].ComboTimeout
                        end
                    end
                end
                LP:SetAttribute("AttackSpeedMul", 1)
                LP:SetAttribute("StunEndsAt", 0)
            end)
            originalWeaponData = {}
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
    local authorNames={"zczczczc722","zczczczc766","UnethicalNetworks4","ddhjjj10000","smalldesikon"}
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