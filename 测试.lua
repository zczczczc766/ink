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

E:Toggle({
    Title="启用修改速度",
    Value=false,
    Callback=function(s)
        speedEnabled=s
        local char=LocalPlayer.Character
        if char then
            local hum=char:FindFirstChildOfClass("Humanoid")
            if hum then
                if s then
                    hum.WalkSpeed=speedValue
                else
                    hum.WalkSpeed=16
                end
            end
        end
    end
})

E:Slider({
    Title="修改速度",
    Value={Min=16,Max=100,Default=16},
    Callback=function(v)
        speedValue=v
        if speedEnabled then
            local char=LocalPlayer.Character
            if char then
                local hum=char:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed=v end
            end
        end
    end
})

E:Toggle({
    Title="启用修改跳跃高度",
    Value=false,
    Callback=function(s)
        jumpEnabled=s
        local char=LocalPlayer.Character
        if char then
            local hum=char:FindFirstChildOfClass("Humanoid")
            if hum then
                if s then
                    hum.JumpPower=jumpValue
                else
                    hum.JumpPower=50
                end
            end
        end
    end
})

E:Slider({
    Title="修改跳跃高度",
    Value={Min=20,Max=200,Default=50},
    Callback=function(v)
        jumpValue=v
        if jumpEnabled then
            local char=LocalPlayer.Character
            if char then
                local hum=char:FindFirstChildOfClass("Humanoid")
                if hum then hum.JumpPower=v end
            end
        end
    end
})

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.1)
    local hum=char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed=speedEnabled and speedValue or 16
        hum.JumpPower=jumpEnabled and jumpValue or 50
    end
end)

E:Button({Title="飞行",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/mciklw/mciklwscript/refs/heads/main/flyvthree"))()end})

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
        Lighting.Brightness=origBright
        Lighting.Ambient=Color3.new(0.5,0.5,0.5)
        Lighting.OutdoorAmbient=Color3.new(0.5,0.5,0.5)
    end
end})

E:Button({Title="防甩飞",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/Linux6699/DaHubRevival/main/AntiFling.lua"))()end})

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

local playerDropdown=TransTab:Dropdown({
    Title="选择玩家",
    Values=getPlayerNames(),
    Value="无其他玩家",
    Callback=function(v)
        selectedPlayer=v
    end
})

TransTab:Button({Title="刷新列表",Callback=function()
    local newNames=getPlayerNames()
    playerDropdown:SetValues(newNames)
    if #newNames>0 then
        selectedPlayer=newNames[1]
    end
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

local L=D:Tab({Title="FE",Icon="zap"})
L:Button({Title="coolgui",Callback=function()loadstring(game:GetObjects("rbxassetid://8127297852")[1].Source)()end})
L:Button({Title="被遗弃人物",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/CyberNinja103/brodwa/refs/heads/main/ForsakationHub"))()end})
L:Button({Title="R15下蹲",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/Azizanzz0/Scripts/refs/heads/main/Crouching.txt"))()end})
L:Button({Title="爬行",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/0Ben1/fe/main/obf_vZDX8j5ggfAf58QhdJ59BVEmF6nmZgq4Mcjt2l8wn16CiStIW2P6EkNc605qv9K4.lua.txt"))()end})

local M=D:Tab({Title="漏洞",Icon="bug"})
M:Button({Title="AC6音乐播放器",Callback=function()loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FE-Ac6-Music-Vulnerability-25536"))()end})
M:Button({Title="后门执行器1",Callback=function()loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-LALOL-hub-without-hint-19587"))()end})
M:Button({Title="后门执行器2",Callback=function()loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Starlight-Scanner-213808"))()end})
M:Button({Title="UnethicalNetworks f3x gui v9",Callback=function()loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-UnethicalNetworks-f3x-gui-v9-124640"))()end})
M:Button({Title="UnethicalNetworks f3x gui v6 v7 v8",Callback=function()loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-UnethicalNetworks-f3x-gui-v6v7v8-121690"))()end})

local N=D:Tab({Title="末日砖块",Icon="target"})
local O=D:Tab({Title="被遗弃",Icon="ghost"})

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

O:Toggle({Title="改视野",Value=false,Callback=function()
    local remote=game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent")
    local fovObj=player:WaitForChild("PlayerData"):WaitForChild("Settings"):WaitForChild("Game"):WaitForChild("FieldOfView")
    remote:FireServer("UpdateSettings",{fovObj,string.char(0x02,0x00,0x00,0x00,0x00,0x00,0x00,0x5E,0x40)})
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