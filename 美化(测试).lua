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

-- 只重写“无头”和“断腿”部分；其它饰品逻辑保持原样。
local function getBodyParts(char, kind)
    local parts = {}
    if kind == "无头" then
        local p = char:FindFirstChild("Head")
        if p and p:IsA("BasePart") then table.insert(parts, p) end
    elseif kind == "断腿" then
        for _, n in ipairs({"RightUpperLeg", "RightLowerLeg", "RightFoot", "Right Leg"}) do
            local p = char:FindFirstChild(n)
            if p and p:IsA("BasePart") then table.insert(parts, p) end
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
                CanCollide = part.CanCollide,
                CanTouch = part.CanTouch,
                CanQuery = part.CanQuery,
            }
        end
        part.LocalTransparencyModifier = 1
        part.CanCollide = false
        part.CanTouch = false
        part.CanQuery = false
    else
        local old = bodyPartOriginal[part]
        if old then
            part.Transparency = old.Transparency
            part.LocalTransparencyModifier = old.LocalTransparencyModifier
            part.CanCollide = old.CanCollide
            part.CanTouch = old.CanTouch
            part.CanQuery = old.CanQuery
            bodyPartOriginal[part] = nil
        end
    end
end

local KORBLOX_ID = 139607718
local korbloxActive = false
local korbloxAsset = nil
local savedRightLegDescription = nil
local savedRightLegTransparency = {}

local function isR6(char)
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    return hum and hum.RigType == Enum.HumanoidRigType.R6
end

local function saveAndHideRightLeg(char)
    for _, p in ipairs(getBodyParts(char, "断腿")) do
        if not savedRightLegTransparency[p] then
            savedRightLegTransparency[p] = {
                Transparency = p.Transparency,
                LocalTransparencyModifier = p.LocalTransparencyModifier,
                CanCollide = p.CanCollide,
                CanTouch = p.CanTouch,
                CanQuery = p.CanQuery,
            }
        end
        p.LocalTransparencyModifier = 1
        p.CanCollide = false
        p.CanTouch = false
        p.CanQuery = false
    end
end

local function restoreRightLegTransparency()
    for p, old in pairs(savedRightLegTransparency) do
        if p and p.Parent then
            p.Transparency = old.Transparency
            p.LocalTransparencyModifier = old.LocalTransparencyModifier
            p.CanCollide = old.CanCollide
            p.CanTouch = old.CanTouch
            p.CanQuery = old.CanQuery
        end
    end
    table.clear(savedRightLegTransparency)
end

local function removeKorbloxAsset()
    if korbloxAsset and korbloxAsset.Parent then
        pcall(function() korbloxAsset:Destroy() end)
    end
    korbloxAsset = nil
end

local function keepHeadless()
    if accessoryStates["无头"] then
        local char = player.Character
        if char then
            for _, p in ipairs(getBodyParts(char, "无头")) do
                setLocalHidden(p, true)
            end
            for _, obj in ipairs(char:GetDescendants()) do
                if obj:IsA("Decal") and (obj.Name == "face" or (obj.Parent and obj.Parent.Name == "Head")) then
                    if bodyPartOriginal[obj] == nil then
                        bodyPartOriginal[obj] = {Transparency = obj.Transparency}
                    end
                    obj.Transparency = 1
                end
            end
        end
    end
end

local function applyKorbloxR15(char)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return false end

    local ok, current = pcall(function() return hum:GetAppliedDescription() end)
    if not ok or not current then return false end

    if not savedRightLegDescription then
        savedRightLegDescription = current:Clone()
    end

    local changed = pcall(function()
        current.RightLeg = KORBLOX_ID
    end)
    if not changed then return false end

    local applied = pcall(function()
        hum:ApplyDescription(current)
    end)
    if not applied then return false end

    -- ApplyDescription may rebuild body parts. Re-hide only the original visible right-leg parts.
    task.defer(function()
        if player.Character == char and korbloxActive then
            saveAndHideRightLeg(char)
            keepHeadless()
        end
    end)
    return true
end

local function applyKorbloxR6(char)
    -- R6 has a real Right Leg body slot. Use CharacterMesh if the asset exposes one.
    removeKorbloxAsset()
    local ok, objects = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(KORBLOX_ID))
    end)
    if not ok or not objects or not objects[1] then return false end

    local asset = objects[1]
    local mesh = asset:IsA("CharacterMesh") and asset or asset:FindFirstChildWhichIsA("CharacterMesh", true)
    if not mesh then
        pcall(function() asset:Destroy() end)
        return false
    end

    mesh.Name = "KorbloxRightLeg_139607718"
    pcall(function() mesh.BodyPart = Enum.BodyPart.RightLeg end)
    mesh.Parent = char
    korbloxAsset = mesh

    saveAndHideRightLeg(char)
    keepHeadless()
    return true
end

local function loadRealKorblox()
    local char = player.Character
    if not char then return false end
    if korbloxActive then return true end

    korbloxActive = true
    local ok = false

    if isR6(char) then
        ok = applyKorbloxR6(char)
    else
        ok = applyKorbloxR15(char)
    end

    if not ok then
        korbloxActive = false
        removeKorbloxAsset()
        savedRightLegDescription = nil
        restoreRightLegTransparency()
        return false
    end
    return true
end

local function destroyKorblox()
    korbloxActive = false
    removeKorbloxAsset()

    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum and savedRightLegDescription then
        pcall(function() hum:ApplyDescription(savedRightLegDescription) end)
    end
    savedRightLegDescription = nil
    restoreRightLegTransparency()
end

local function applyBodyPart(name, enabled)
    local char = player.Character
    if not char then return end

    if name == "无头" then
        if enabled then
            for _, p in ipairs(getBodyParts(char, "无头")) do
                setLocalHidden(p, true)
            end
            for _, obj in ipairs(char:GetDescendants()) do
                if obj:IsA("Decal") and (obj.Name == "face" or (obj.Parent and obj.Parent.Name == "Head")) then
                    if bodyPartOriginal[obj] == nil then
                        bodyPartOriginal[obj] = {Transparency = obj.Transparency}
                    end
                    obj.Transparency = 1
                end
            end
        else
            for obj, old in pairs(bodyPartOriginal) do
                if obj and obj.Parent then
                    if obj:IsA("BasePart") then
                        obj.Transparency = old.Transparency
                        obj.LocalTransparencyModifier = old.LocalTransparencyModifier
                        if old.CanCollide ~= nil then obj.CanCollide = old.CanCollide end
                        if old.CanTouch ~= nil then obj.CanTouch = old.CanTouch end
                        if old.CanQuery ~= nil then obj.CanQuery = old.CanQuery end
                    elseif obj:IsA("Decal") then
                        obj.Transparency = old.Transparency
                    end
                end
                bodyPartOriginal[obj] = nil
            end
        end
    elseif name == "断腿" then
        if enabled then
            loadRealKorblox()
        else
            destroyKorblox()
        end
    end
end

-- 持续维持本地外观，但不会每 0.25 秒重复 ApplyDescription。
task.spawn(function()
    while task.wait(0.25) do
        local char = player.Character
        if char then
            if accessoryStates["无头"] then
                applyBodyPart("无头", true)
            end
            if accessoryStates["断腿"] and korbloxActive then
                if isR6(char) then
                    if not korbloxAsset or not korbloxAsset.Parent then
                        korbloxActive = false
                        loadRealKorblox()
                    else
                        saveAndHideRightLeg(char)
                    end
                else
                    -- R15 的 ApplyDescription 已经完成；这里只防止游戏本地刷新把原腿显示回来。
                    saveAndHideRightLeg(char)
                end
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
