local CosmeticsTab = D:Tab({Title="角色美化", Icon="sparkles"})

local player = game.Players.LocalPlayer

local accessories = {
    {name = "无头", id = 15093053680},
    {name = "断腿", id = 139607718},
    {name = "无腿", id = 0},
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

local hairHidden = false
local allAccessoriesHidden = false
local accessoryOriginal = {}

local function rememberAccessoryPart(part)
    if not part or not part:IsA("BasePart") then return end
    if accessoryOriginal[part] == nil then
        accessoryOriginal[part] = {
            Transparency = part.Transparency,
            LocalTransparencyModifier = part.LocalTransparencyModifier,
        }
    end
end

local function setAccessoryHidden(accessory, hidden)
    if not accessory or not accessory:IsA("Accessory") then return end
    for _, obj in ipairs(accessory:GetDescendants()) do
        if obj:IsA("BasePart") then
            if hidden then
                rememberAccessoryPart(obj)
                obj.LocalTransparencyModifier = 1
                obj.Transparency = 1
            else
                local old = accessoryOriginal[obj]
                if old then
                    obj.Transparency = old.Transparency
                    obj.LocalTransparencyModifier = old.LocalTransparencyModifier
                    accessoryOriginal[obj] = nil
                end
            end
        end
    end
end

local function isHairAccessory(accessory)
    if not accessory or not accessory:IsA("Accessory") then return false end

    local ok, accessoryType = pcall(function()
        return accessory.AccessoryType
    end)
    if ok and accessoryType == Enum.AccessoryType.Hair then
        return true
    end

    local handle = accessory:FindFirstChild("Handle")
    if handle and handle:FindFirstChild("HairAttachment") then
        return true
    end

    local lowerName = string.lower(accessory.Name)
    return lowerName:find("hair") ~= nil or lowerName:find("头发") ~= nil
end

local function updateAccessoryVisibility()
    local char = player.Character
    if not char then return end

    local exemptNames = {}
    for _, acc in ipairs(accessories) do
        exemptNames[acc.name] = true
    end

    for _, obj in ipairs(char:GetChildren()) do
        if obj:IsA("Accessory") then
            local shouldHide = false
            if allAccessoriesHidden then
                if not exemptNames[obj.Name] then
                    shouldHide = true
                end
            elseif hairHidden and isHairAccessory(obj) then
                shouldHide = true
            end
            setAccessoryHidden(obj, shouldHide)
        end
    end
end

CosmeticsTab:Toggle({
    Title = "去掉头发",
    Value = false,
    Callback = function(state)
        hairHidden = state
        updateAccessoryVisibility()
    end
})

CosmeticsTab:Toggle({
    Title = "去掉所有饰品",
    Value = false,
    Callback = function(state)
        allAccessoriesHidden = state
        updateAccessoryVisibility()
    end
})

local accessoryStates = {}
local wornAccessories = {}

local savedBodyDescriptions = {}
local bodyPartOriginal = {}

local function getBodyParts(char, kind)
    local parts = {}
    if kind == "无头" then
        local head = char:FindFirstChild("Head")
        if head and head:IsA("BasePart") then
            table.insert(parts, head)
        end
    elseif kind == "断腿" then
        for _, n in ipairs({"RightUpperLeg", "RightLowerLeg", "RightFoot"}) do
            local p = char:FindFirstChild(n)
            if p and p:IsA("BasePart") then
                table.insert(parts, p)
            end
        end
        local r6 = char:FindFirstChild("Right Leg")
        if r6 and r6:IsA("BasePart") then
            table.insert(parts, r6)
        end
    elseif kind == "无腿" then
        for _, n in ipairs({"RightUpperLeg","RightLowerLeg","RightFoot","Right Leg"}) do
            local p = char:FindFirstChild(n)
            if p and p:IsA("BasePart") then
                table.insert(parts, p)
            end
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
        part.Transparency = 1
        part.CanCollide = false
        part.CanTouch = false
        part.CanQuery = false
    else
        local old = bodyPartOriginal[part]
        if old then
            part.Transparency = old.Transparency
            part.LocalTransparencyModifier = old.LocalTransparencyModifier
            bodyPartOriginal[part] = nil
        end
    end
end

local KORBLOX_ID = 139607718
local korbloxObject = nil
local korbloxOriginalParts = {}
local korbloxR6DescriptionApplied = false

local function rememberPart(part)
    if not part or not part:IsA("BasePart") or korbloxOriginalParts[part] then return end
    korbloxOriginalParts[part] = {
        Transparency = part.Transparency,
        LocalTransparencyModifier = part.LocalTransparencyModifier,
        CanCollide = part.CanCollide,
        CanTouch = part.CanTouch,
        CanQuery = part.CanQuery,
    }
end

local function hideRightLegPart(part)
    if not part or not part:IsA("BasePart") then return end
    rememberPart(part)
    part.LocalTransparencyModifier = 1
    part.Transparency = 1
    part.CanCollide = false
    part.CanTouch = false
    part.CanQuery = false
end

local function restoreRightLegParts()
    for part, old in pairs(korbloxOriginalParts) do
        if part and part.Parent then
            part.Transparency = old.Transparency
            part.LocalTransparencyModifier = old.LocalTransparencyModifier
            part.CanCollide = old.CanCollide
            part.CanTouch = old.CanTouch
            part.CanQuery = old.CanQuery
        end
    end
    table.clear(korbloxOriginalParts)
end

local function destroyKorblox()
    if korbloxObject then
        pcall(function() korbloxObject:Destroy() end)
        korbloxObject = nil
    end

    local char = player.Character
    if char then
        for _, obj in ipairs(char:GetChildren()) do
            if obj:IsA("CharacterMesh") and obj.Name == "Korblox Deathspeaker Right Leg" then
                pcall(function() obj:Destroy() end)
            end
        end
    end

    korbloxR6DescriptionApplied = false
    restoreRightLegParts()
end

local function getRightLegParts(char)
    local result = {}
    for _, n in ipairs({"RightUpperLeg", "RightLowerLeg", "RightFoot", "Right Leg"}) do
        local p = char:FindFirstChild(n)
        if p and p:IsA("BasePart") then
            table.insert(result, p)
        end
    end
    return result
end

local function isR6(char)
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    return hum and hum.RigType == Enum.HumanoidRigType.R6
end

local function tryApplyR6RightLegDescription(char)
    if not isR6(char) or korbloxR6DescriptionApplied then
        return false
    end

    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return false end

    local ok, desc = pcall(function()
        return hum:GetAppliedDescription()
    end)
    if not ok or not desc then return false end

    local changed = pcall(function()
        desc.RightLeg = KORBLOX_ID
        hum:ApplyDescription(desc)
    end)

    if changed then
        korbloxR6DescriptionApplied = true
        return true
    end

    pcall(function() desc:Destroy() end)
    return false
end

local function weldKorbloxModel(model, char)
    local target =
        char:FindFirstChild("Right Leg")
        or char:FindFirstChild("RightLowerLeg")
        or char:FindFirstChild("RightUpperLeg")

    if not target then return false end

    local primary = model:IsA("BasePart") and model or model:FindFirstChildWhichIsA("BasePart", true)
    if not primary then return false end

    if model:IsA("Model") then
        model.PrimaryPart = primary
    end

    local initialOffset = CFrame.new(0, 25, 0)
    local targetPivot = target.CFrame * initialOffset

    if model:IsA("Model") then
        pcall(function()
            model:PivotTo(targetPivot)
        end)
    else
        primary.CFrame = targetPivot
    end

    pcall(function()
        local bboxCF, bboxSize = model:IsA("Model") and model:GetBoundingBox()
            or primary.CFrame, primary.Size

        local targetTop = target.Position.Y + target.Size.Y * 0.5
        local modelTop = bboxCF.Position.Y + bboxSize.Y * 0.5
        local correction = targetTop - modelTop + 0.05

        local correctedPivot = (model:IsA("Model") and model:GetPivot() or primary.CFrame)
            * CFrame.new(0, correction, 0)

        if model:IsA("Model") then
            model:PivotTo(correctedPivot)
        else
            primary.CFrame = correctedPivot
        end
    end)

    local root = model:IsA("Model") and model.PrimaryPart or primary

    for _, obj in ipairs(model:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Anchored = false
            obj.Massless = true
            obj.CanCollide = false
            obj.CanTouch = false
            obj.CanQuery = false
            if obj ~= root then
                local weld = Instance.new("WeldConstraint")
                weld.Part0 = root
                weld.Part1 = obj
                weld.Parent = root
            end
        end
    end

    local weld = Instance.new("WeldConstraint")
    weld.Part0 = target
    weld.Part1 = root
    weld.Parent = root

    return true
end

local function loadRealKorblox()
    local char = player.Character
    if not char then return false end

    if korbloxObject and korbloxObject.Parent == char then
        for _, p in ipairs(getRightLegParts(char)) do
            hideRightLegPart(p)
        end
        return true
    end

    if isR6(char) then
        tryApplyR6RightLegDescription(char)
    end

    for _, p in ipairs(getRightLegParts(char)) do
        hideRightLegPart(p)
    end

    local ok, objects = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(KORBLOX_ID))
    end)

    if not ok or not objects or not objects[1] then
        return korbloxR6DescriptionApplied
    end

    local asset = objects[1]
    local characterMesh =
        asset:IsA("CharacterMesh") and asset
        or asset:FindFirstChildWhichIsA("CharacterMesh", true)

    if characterMesh then
        characterMesh.Name = "Korblox Deathspeaker Right Leg"
        pcall(function()
            characterMesh.BodyPart = Enum.BodyPart.RightLeg
        end)
        characterMesh.Parent = char
        korbloxObject = characterMesh

        for _, p in ipairs(getRightLegParts(char)) do
            hideRightLegPart(p)
        end

        if accessoryStates["无头"] then
            task.defer(function()
                if player.Character == char then
                    applyBodyPart("无头", true)
                end
            end)
        end
        return true
    end

    local container = asset
    container.Name = "Korblox_139607718"
    container.Parent = char

    if weldKorbloxModel(container, char) then
        korbloxObject = container

        if accessoryStates["无头"] then
            task.defer(function()
                if player.Character == char then
                    applyBodyPart("无头", true)
                end
            end)
        end
        return true
    end

    pcall(function() container:Destroy() end)
    return korbloxR6DescriptionApplied
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
        end

    elseif name == "断腿" then
        if enabled then
            loadRealKorblox()
        else
            destroyKorblox()
        end
    elseif name == "无腿" then
        if enabled then
            for _, p in ipairs(getBodyParts(char, "无腿")) do
                setLocalHidden(p, true)
            end
        else
            for part, old in pairs(bodyPartOriginal) do
                if typeof(part) == "Instance" and part.Parent and part:IsA("BasePart") then
                    part.Transparency = old.Transparency
                    part.LocalTransparencyModifier = old.LocalTransparencyModifier
                end
                bodyPartOriginal[part] = nil
            end
        end
    end
end

task.spawn(function()
    while task.wait(0.25) do
        local char = player.Character
        if char then
            if hairHidden or allAccessoriesHidden then
                updateAccessoryVisibility()
            end
            if accessoryStates["无头"] then
                applyBodyPart("无头", true)
            end
            if accessoryStates["无腿"] then
                for _, p in ipairs(getBodyParts(char, "无腿")) do
                    setLocalHidden(p, true)
                end
            end
            if accessoryStates["断腿"] then
                if isR6(char) and korbloxR6DescriptionApplied then
                    for _, p in ipairs(getRightLegParts(char)) do
                        hideRightLegPart(p)
                    end
                elseif not korbloxObject or korbloxObject.Parent ~= char then
                    applyBodyPart("断腿", true)
                else
                    for _, p in ipairs(getRightLegParts(char)) do
                        hideRightLegPart(p)
                    end
                end
            end
        end
    end
end)

local function loadAccessory(id, name)
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
    if name == "无头" or name == "断腿" or name == "无腿" then
        applyBodyPart(name, false)
        return
    end

    if wornAccessories[name] then
        wornAccessories[name]:Destroy()
        wornAccessories[name] = nil
    end
end

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
    updateAccessoryVisibility()
    for _, acc in ipairs(accessories) do
        if accessoryStates[acc.name] then
            loadAccessory(acc.id, acc.name)
        end
    end
end)