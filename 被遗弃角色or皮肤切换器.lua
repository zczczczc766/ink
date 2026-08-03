local A=game:GetService("StarterGui")
A:SetCore("SendNotification",{Title="正在执行 角色|皮肤切换器",Text="加载中...",Duration=1})
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

local C=B:CreateWindow({Icon="moon",Title=gradient("被遗弃角色|皮肤切换器",Color3.fromRGB(180,180,180),Color3.fromRGB(100,100,100)),Author=gradient("@墨水依旧",Color3.fromRGB(180,180,180),Color3.fromRGB(100,100,100)),Folder="被遗弃角色|皮肤切换器",Size=UDim2.fromOffset(520,410),Background="rbxassetid://99065227044934",BackgroundImageTransparency=0.25,Theme="Dark",User={Enabled=false},SideBarWidth=160,ScrollBarEnabled=true})
C:EditOpenButton({Title=gradient("被遗弃角色|皮肤切换器",Color3.fromRGB(180,180,180),Color3.fromRGB(100,100,100)),Icon="moon",StrokeThickness=2,Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(180,180,180)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(150,150,150)),ColorSequenceKeypoint.new(1,Color3.fromRGB(100,100,100))}),Draggable=true})

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

local KillerTab=D:Tab({Title="杀手",Icon="skull"})
KillerTab:Button({Title="13号星期五杰森",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Killers"):WaitForChild("!Slasher_FRIDAY"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})
KillerTab:Button({Title="3月18号约翰",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Killers"):WaitForChild("!JohnDoe_MARCH"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})
KillerTab:Button({Title="马",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Killers"):WaitForChild("!Horse"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})
KillerTab:Button({Title="谢德",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Killers"):WaitForChild("!DoppelgangerShedletsky"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})
KillerTab:Button({Title="剑术大师",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Killers"):WaitForChild("ShedletskyFunny"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})
KillerTab:Button({Title="苏库娜",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Killers"):WaitForChild("!SukunaKiller"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})
KillerTab:Button({Title="黑木",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Killers"):WaitForChild("!Herobrine"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})
KillerTab:Button({Title="猫",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Killers"):WaitForChild("!Cat"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})
KillerTab:Button({Title="烈焰石",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Killers"):WaitForChild("!Brimstone"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})

local SurvivorTab=D:Tab({Title="幸存",Icon="user"})
SurvivorTab:Button({Title="noob_世界",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Survivors"):WaitForChild("!NoobTheWorld"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})
SurvivorTab:Button({Title="武术家",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Survivors"):WaitForChild("#MArtist"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})
SurvivorTab:Button({Title="特种部队",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Survivors"):WaitForChild("#SWATOfficer"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})
SurvivorTab:Button({Title="中毒者",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Survivors"):WaitForChild("1xFunny"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})
SurvivorTab:Button({Title="腐化者",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Survivors"):WaitForChild("JohnDoeFunny"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})
SurvivorTab:Button({Title="小孩",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Survivors"):WaitForChild("c00lkiddFunny"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})

local SkinTab=D:Tab({Title="皮肤",Icon="palette"})
SkinTab:Button({Title="KJ",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Skins"):WaitForChild("Survivors"):WaitForChild("Guest1337"):WaitForChild("#KJGuest"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})
SkinTab:Button({Title="小谢德",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Skins"):WaitForChild("Survivors"):WaitForChild("Shedletsky"):WaitForChild("#LittleGuyShedletsky"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})
SkinTab:Button({Title="小披萨",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Skins"):WaitForChild("Survivors"):WaitForChild("Elliot"):WaitForChild("#LittleGuyElliot"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})
SkinTab:Button({Title="小noob",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Skins"):WaitForChild("Survivors"):WaitForChild("Noob"):WaitForChild("#LittleNoob"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})
SkinTab:Button({Title="小建筑工",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Skins"):WaitForChild("Survivors"):WaitForChild("Builderman"):WaitForChild("#LittleGuyBuilderman"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})
SkinTab:Button({Title="小007",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Skins"):WaitForChild("Survivors"):WaitForChild("007n7"):WaitForChild("#LittleGuy007n7"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})
SkinTab:Button({Title="婴儿两次",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Skins"):WaitForChild("Survivors"):WaitForChild("TwoTime"):WaitForChild("!BabyTwoTime"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})
SkinTab:Button({Title="小访客",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Skins"):WaitForChild("Survivors"):WaitForChild("Guest1337"):WaitForChild("#LittleGuyGuest"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})
SkinTab:Button({Title="小塔夫",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Skins"):WaitForChild("Survivors"):WaitForChild("Taph"):WaitForChild("#LittleTaph"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})
SkinTab:Button({Title="小卡尔",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Skins"):WaitForChild("Survivors"):WaitForChild("Dusekkar"):WaitForChild("#LittleGuyDusekkar"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})
SkinTab:Button({Title="小维罗妮卡",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Skins"):WaitForChild("Survivors"):WaitForChild("Veeronica"):WaitForChild("#LittleGalVeeronica"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})
SkinTab:Button({Title="小机会",Callback=function()
    local args={"EquipState",{game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Skins"):WaitForChild("Survivors"):WaitForChild("Chance"):WaitForChild("#LittleGuyChance"),buffer.fromstring("\001\001")}}
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end})

task.wait(0.1)
A:SetCore("SendNotification",{Title="加载成功",Text="角色|皮肤切换器已正常运行",Duration=3})