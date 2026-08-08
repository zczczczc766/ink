local A=game:GetService("StarterGui")
A:SetCore("SendNotification",{Title="正在执行 ink_美化",Text="加载中...",Duration=1})
task.wait(0.6)
A:SetCore("SendNotification",{Title="脚本启动成功",Text="正在加载界面...",Duration=2})
task.wait(0.3)
A:SetCore("SendNotification",{Title="作者声明",Text="开源的4000+\n没惹你就开源的自动给我30年寿命",Duration=3})

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

local C=B:CreateWindow({Icon="moon",Title=gradient("ink_美化",Color3.fromRGB(180,180,180),Color3.fromRGB(100,100,100)),Author=gradient("@墨水依旧 司空",Color3.fromRGB(180,180,180),Color3.fromRGB(100,100,100)),Folder="ink_美化",Size=UDim2.fromOffset(520,410),Background="rbxassetid://99065227044934",BackgroundImageTransparency=0.25,Theme="Dark",User={Enabled=false},SideBarWidth=160,ScrollBarEnabled=true})
C:EditOpenButton({Title=gradient("ink_美化",Color3.fromRGB(180,180,180),Color3.fromRGB(100,100,100)),Icon="moon",StrokeThickness=2,Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(180,180,180)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(150,150,150)),ColorSequenceKeypoint.new(1,Color3.fromRGB(100,100,100))}),Draggable=true})

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
    Title = "欢迎使用 ink_美化",
    Desc = "作者：墨水依旧和司空\n墨水快手号:zczczczc766\n司空快手号:smalldesikon111和smalldesikon\n开源并公开的4000+\n没惹你就开源的自动给我30年寿命\n公益脚本禁止倒卖",
    Image = "rbxassetid://107039115828792",
    ImageSize = 100,
})
Z:Button({Title="复制作者QQ", Callback=function() setclipboard("2047955671") A:SetCore("SendNotification",{Title="已复制", Text="作者QQ：2047955671", Duration=2}) end})
Z:Button({Title="复制作者QQ群", Callback=function() setclipboard("1101093219") A:SetCore("SendNotification",{Title="已复制", Text="作者QQ群：1101093219", Duration=2}) end})
Z:Button({Title="复制作者副群", Callback=function() setclipboard("1063828524") A:SetCore("SendNotification",{Title="已复制", Text="作者副群：1063828524", Duration=2}) end})

local CosmeticsTab = D:Tab({Title="角色美化", Icon="sparkles"})

local player = game.Players.LocalPlayer
local accessoryStates = {}
local wornAccessories = {}

local savedBodyDescriptions = {}
local bodyPartOriginal = {}

-- 只处理“无头”和“断腿”。
-- 不依赖 Humanoid:ApplyDescription()，避免注入器/游戏客户端拦截导致按钮无效果。
local function getBodyParts(char, kind)
    local parts = {}
    if kind == "无头" then
        local head = char:FindFirstChild("Head")
        if head and head:IsA("BasePart") then
            table.insert(parts, head)
        end
    elseif kind == "断腿" then
        -- R15
        for _, n in ipairs({"RightUpperLeg", "RightLowerLeg", "RightFoot"}) do
            local p = char:FindFirstChild(n)
            if p and p:IsA("BasePart") then
                table.insert(parts, p)
            end
        end
        -- R6
        local r6 = char:FindFirstChild("Right Leg")
        if r6 and r6:IsA("BasePart") then
            table.insert(parts, r6)
        end
    end
    return parts
end

local function setLocalHidden(part, hidden)
    if not part or not part:IsA("BasePart") then return end
    if hidden then
        if bodyPartOriginal[part] == nil then
            bodyPartOriginal[part] = {
                Transparency = part.Transparency,
                LocalTransparencyModifier = part.LocalTransparencyModifier,
            }
        end
        part.LocalTransparencyModifier = 1
    else
        local old = bodyPartOriginal[part]
        if old then
            part.Transparency = old.Transparency
            part.LocalTransparencyModifier = old.LocalTransparencyModifier
            bodyPartOriginal[part] = nil
        end
    end
end

local function applyBodyPart(name, enabled)
    local char = player.Character
    if not char then return end

    if enabled then
        -- 先取消旧状态，避免重复保存/重复处理
        if name == "无头" then
            for _, p in ipairs(getBodyParts(char, "无头")) do
                setLocalHidden(p, true)
            end

            -- 隐藏脸部贴图/动态脸，确保不会残留一张脸。
            for _, obj in ipairs(char:GetDescendants()) do
                if obj:IsA("Decal") and (obj.Name == "face" or obj.Parent.Name == "Head") then
                    if bodyPartOriginal[obj] == nil then
                        bodyPartOriginal[obj] = {
                            Transparency = obj.Transparency
                        }
                    end
                    obj.Transparency = 1
                end
            end

        elseif name == "断腿" then
            -- 断腿的核心是只隐藏右腿；左右腿不会一起消失。
            for _, p in ipairs(getBodyParts(char, "断腿")) do
                setLocalHidden(p, true)
            end
        end
    else
        if name == "无头" then
            for part, old in pairs(bodyPartOriginal) do
                if typeof(part) == "Instance" and part.Parent then
                    if part:IsA("BasePart") then
                        part.Transparency = old.Transparency
                        part.LocalTransparencyModifier = old.LocalTransparencyModifier
                    elseif part:IsA("Decal") then
                        part.Transparency = old.Transparency
                    end
                end
                bodyPartOriginal[part] = nil
            end
        elseif name == "断腿" then
            for part, old in pairs(bodyPartOriginal) do
                if typeof(part) == "Instance" and part.Parent and part:IsA("BasePart") then
                    part.Transparency = old.Transparency
                    part.LocalTransparencyModifier = old.LocalTransparencyModifier
                    bodyPartOriginal[part] = nil
                end
            end
        end
    end
end

-- 持续维持本地外观，防止游戏自己的角色刷新逻辑马上把透明度改回去。
task.spawn(function()
    while task.wait(0.25) do
        local char = player.Character
        if char then
            if accessoryStates["无头"] then
                applyBodyPart("无头", true)
            end
            if accessoryStates["断腿"] then
                applyBodyPart("断腿", true)
            end
        end
    end
end)

local function loadAccessory(id, name)
    -- 只改变“无头”和“断腿”。
    -- 其它饰品完全保持原来的 loadAccessory 逻辑。
    if name == "无头" then
        applyBodyPart(name, true)
        return
    elseif name == "断腿" then
        applyBodyPart(name, true)
        return
    end

    task.defer(function()
        pcall(function()
            local char = player.Character
            if not char then return end

            if wornAccessories[name] then
                wornAccessories[name]:Destroy()
                wornAccessories[name] = nil
            end

            local acc = game:GetObjects("rbxassetid://" .. tostring(id))[1]
            if not acc then return end

            local handle = acc:FindFirstChild("Handle", true)
            if not handle or not handle:IsA("BasePart") then
                acc:Destroy()
                return
            end

            local A1 = handle:FindFirstChildOfClass("Attachment")
            if not A1 then
                acc.Parent = char
                handle.Anchored = false
                handle.Massless = true
                local weld = Instance.new("Weld", handle)
                weld.Part0 = handle
                weld.Part1 = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
                weld.C0 = CFrame.new(0, 0.5, 0)
                wornAccessories[name] = acc
                return
            end

            local A0 = nil
            local searchParts = {"Head", "HumanoidRootPart", "UpperTorso", "Torso", "LowerTorso"}
            for _, partName in ipairs(searchParts) do
                local part = char:FindFirstChild(partName)
                if part then
                    A0 = part:FindFirstChild(A1.Name, true)
                    if A0 then break end
                end
            end

            if not A0 then
                acc.Parent = char
                handle.Anchored = false
                handle.Massless = true
                local weld = Instance.new("Weld", handle)
                weld.Part0 = handle
                weld.Part1 = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
                weld.C0 = CFrame.new(0, 0.5, 0)
                wornAccessories[name] = acc
                return
            end

            acc.Parent = char
            handle.Anchored = false
            handle.Massless = true
            handle.CFrame = A0.WorldCFrame * A1.CFrame:Inverse()

            local weld = Instance.new("WeldConstraint", handle)
            weld.Part0 = handle
            weld.Part1 = A0.Parent

            wornAccessories[name] = acc
        end)
    end)
end

local function removeAccessory(name)
    if name == "无头" or name == "断腿" then
        applyBodyPart(name, false)
        return
    end

    if wornAccessories[name] then
        wornAccessories[name]:Destroy()
        wornAccessories[name] = nil
    end
end

local accessories = {
    {name = "无头", id = 15093053680},
    {name = "超级快乐脸", id = 158380697314856},
    {name = "断腿", id = 139607718},
    {name = "8位皇家王冠", id = 10159600649},
    {name = "8位血条", id = 10159610478},
    {name = "美金气球", id = 14559645454},
    {name = "火角", id = 215718515},
    {name = "冰角", id = 74891470},
    {name = "毒角", id = 1744060292},
    {name = "紫色瓦尔基里", id = 1402432199},
    {name = "8位章鱼先生", id = 507795810},
    {name = "红色多米诺王冠", id = 42211680},
    {name = "火焰莫西干", id = 191101707},
    {name = "闪亮女武神", id = 1180433861},
}

for _, acc in ipairs(accessories) do
    accessoryStates[acc.name] = false
    CosmeticsTab:Toggle({
        Title = acc.name,
        Value = false,
        Callback = function(state)
            accessoryStates[acc.name] = state
            if state then
                loadAccessory(acc.id, acc.name)
            else
                removeAccessory(acc.name)
            end
        end
    })
end

player.CharacterAdded:Connect(function(char)
    savedBodyDescriptions = {}
    task.wait(0.8)
    for _, acc in ipairs(accessories) do
        if accessoryStates[acc.name] then
            loadAccessory(acc.id, acc.name)
        end
    end
end)

task.wait(0.1)
A:SetCore("SendNotification",{Title="加载成功",Text="ink_美化 已正常运行",Duration=3})