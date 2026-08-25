-- 加载 Rayfield UI 库
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 创建窗口
local Window = Rayfield:CreateWindow({
    Name = "LC害人精",
    LoadingTitle = "加载中...",
    LoadingSubtitle = "by 制作组",
    ConfigurationSaving = { Enabled = false }
})

-- 创建标签页
local MainTab = Window:CreateTab("Main [-]", "home")
local CombatTab = Window:CreateTab("战斗 [-]", "swords")
local CharacterTab = Window:CreateTab("角色 [-]", "user")
local ESPTab = Window:CreateTab("视觉 [-]", "eye")  -- 新增视觉标签页

-- 主页制作人显示
MainTab:CreateLabel("制作人：GB黑槍之神制作 B站UID:3493104875211423")

-- ==================== 全局服务 ====================
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")   -- 用于警告文字渐隐

-- ==================== 角色 - 旋转功能 ====================
local spinEnabled = false
local spinSpeed = 300
local spinConnection = nil

local function toggleSpin(enabled)
    if enabled then
        if spinConnection then spinConnection:Disconnect() end
        spinConnection = RunService.Heartbeat:Connect(function(dt)
            if not spinEnabled then return end
            local char = localPlayer.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not root or not hum then return end
            if hum.AutoRotate ~= false then hum.AutoRotate = false end
            root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(spinSpeed) * dt, 0)
        end)
    else
        if spinConnection then spinConnection:Disconnect(); spinConnection = nil end
        local char = localPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.AutoRotate = true end
        end
    end
end

CharacterTab:CreateToggle({ Name = "旋转", CurrentValue = false, Callback = function(v) spinEnabled = v; toggleSpin(v) end })
CharacterTab:CreateSlider({ Name = "旋转速度", Range = {0,2000}, Increment = 50, Suffix = "度/秒", CurrentValue = spinSpeed, Callback = function(v) spinSpeed = v end })

-- ==================== 角色 - 移动速度 ====================
local currentWalkSpeed = 16
local function applyWalkSpeed(s)
    local char = localPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = s end
    end
end
localPlayer.CharacterAdded:Connect(function() task.wait(0.1); applyWalkSpeed(currentWalkSpeed) end)
CharacterTab:CreateSlider({ Name = "移动速度", Range = {16,40}, Increment = 1, CurrentValue = 16, Callback = function(v) currentWalkSpeed = v; applyWalkSpeed(v) end })

-- ==================== 主页 - 甩飞 ====================
local flyMainEnabled, flyUI, flyFeatureEnabled, flyTarget, flyOriginalCFrame = false, nil, false, nil, nil
local flyLoopConn, flyForceConn

local function startFly()
    if flyLoopConn then return end
    flyLoopConn = task.spawn(function()
        while task.wait(0.03) do
            if not flyFeatureEnabled or not flyTarget then continue end
            local char = flyTarget.Character
            if not char or not char:FindFirstChild("Humanoid") then flyTarget = nil; continue end
            if char.Humanoid.Health <= 0 then flyTarget = nil; continue end
            local myChar = localPlayer.Character
            local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local trgHRP = char:FindFirstChild("HumanoidRootPart")
            if myHRP and trgHRP then
                local off = trgHRP.Velocity.Magnitude < 0.1 and 0 or 7
                local goal = trgHRP.CFrame * CFrame.new(0,0,-off) * CFrame.Angles(0,math.rad(-3),0)
                myHRP.CFrame = myHRP.CFrame:Lerp(goal,0.4)
                myHRP.Velocity = Vector3.zero
                myHRP.RotVelocity = Vector3.zero
            end
        end
    end)
    flyForceConn = task.spawn(function()
        while task.wait() do
            if not flyFeatureEnabled then continue end
            local hum = localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid")
            if hum then hum:Move(Vector3.one * 1e31) end
        end
    end)
end

local function stopFly()
    flyFeatureEnabled = false
    flyTarget = nil; flyOriginalCFrame = nil
    if flyLoopConn then task.cancel(flyLoopConn); flyLoopConn = nil end
    if flyForceConn then task.cancel(flyForceConn); flyForceConn = nil end
end

local function onChat(msg)
    if not flyFeatureEnabled then return end
    if msg:sub(1,6):lower() ~= ";kill " then return end
    local name = msg:sub(7)
    local function find(text)
        text = text:lower()
        for _,p in pairs(Players:GetPlayers()) do
            if string.find(p.Name:lower(), text) or string.find(p.DisplayName:lower(), text) then return p end
        end
    end
    local plr = find(name)
    if plr and plr.Character and plr.Character:FindFirstChild("Humanoid") then
        flyTarget = plr
        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            flyOriginalCFrame = localPlayer.Character.HumanoidRootPart.CFrame
        end
    end
end
localPlayer.Chatted:Connect(onChat)

local function createFlyBtn()
    if flyUI then flyUI:Destroy() end
    local sg = Instance.new("ScreenGui", game.CoreGui)
    sg.ResetOnSpawn = false; flyUI = sg
    local btn = Instance.new("TextButton", sg)
    btn.Size = UDim2.new(0,80,0,30); btn.Position = UDim2.new(0.05,0,0.15,0)
    btn.BackgroundColor3 = Color3.new(0,0,0); btn.BackgroundTransparency = 0.05
    btn.Text = "FLY OFF"; btn.TextColor3 = Color3.new(1,1,1); btn.TextSize = 10
    local drag, startInput, startPos
    btn.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then drag=true; startInput=i.Position; startPos=btn.Position end end)
    btn.InputChanged:Connect(function(i) if drag then local d=i.Position-startInput; btn.Position=UDim2.new(startPos.X.Scale, startPos.X.Offset+d.X, startPos.Y.Scale, startPos.Y.Offset+d.Y) end end)
    btn.InputEnded:Connect(function() drag=false end)
    btn.MouseButton1Click:Connect(function()
        flyFeatureEnabled = not flyFeatureEnabled
        btn.Text = flyFeatureEnabled and "FLY ON" or "FLY OFF"
        if flyFeatureEnabled then startFly() else stopFly() end
    end)
end

local function removeFlyBtn()
    if flyUI then flyUI:Destroy(); flyUI = nil end
    stopFly()
    if flyLoopConn then task.cancel(flyLoopConn) end
    if flyForceConn then task.cancel(flyForceConn) end
end

MainTab:CreateToggle({ Name = "甩飞", CurrentValue = false, Callback = function(v) flyMainEnabled=v; if v then createFlyBtn() else removeFlyBtn() end end })

-- ==================== 主页 - 传送攻击 ====================
local tpAttackEnabled, tpAttackUI = false, nil
local function tpToNearest()
    local char = localPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local nearest = nil; local minDist = math.huge
    for _,p in pairs(Players:GetPlayers()) do
        if p ~= localPlayer and p.Team ~= localPlayer.Team then
            local ec = p.Character
            if ec then
                local er = ec:FindFirstChild("HumanoidRootPart")
                local eh = ec:FindFirstChildOfClass("Humanoid")
                if er and eh and eh.Health > 0 then
                    local d = (root.Position - er.Position).Magnitude
                    if d < minDist then minDist = d; nearest = er end
                end
            end
        end
    end
    if nearest then
        local behind = nearest.Position - nearest.CFrame.LookVector * 3
        root.CFrame = CFrame.lookAt(behind, nearest.Position)
        root.Velocity = Vector3.zero
        root.RotVelocity = Vector3.zero
    end
end

local function createTpBtn()
    if tpAttackUI then tpAttackUI:Destroy() end
    local sg = Instance.new("ScreenGui", game.CoreGui); sg.ResetOnSpawn = false; tpAttackUI = sg
    local btn = Instance.new("TextButton", sg)
    btn.Size = UDim2.new(0,100,0,30); btn.Position = UDim2.new(0.1,0,0.2,0)
    btn.BackgroundColor3 = Color3.new(0.2,0.2,0.2); btn.BackgroundTransparency = 0.1
    btn.Text = "传送攻击"; btn.TextColor3 = Color3.new(1,1,1); btn.TextSize = 12
    local drag, sI, sP
    btn.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then drag=true; sI=i.Position; sP=btn.Position end end)
    btn.InputChanged:Connect(function(i) if drag then local d=i.Position-sI; btn.Position=UDim2.new(sP.X.Scale, sP.X.Offset+d.X, sP.Y.Scale, sP.Y.Offset+d.Y) end end)
    btn.InputEnded:Connect(function() drag=false end)
    btn.MouseButton1Click:Connect(tpToNearest)
end

MainTab:CreateToggle({ Name = "传送攻击", CurrentValue = false, Callback = function(v) tpAttackEnabled=v; if v then createTpBtn() else if tpAttackUI then tpAttackUI:Destroy(); tpAttackUI=nil end end end })

-- ==================== 主页 - 悬浮传送（距离缩短，速度加快） ====================
local orbitEnabled, orbitActive, orbitTarget = false, false, nil
local orbitUI, orbitBtn, orbitConn, orbitAngle = nil, nil, nil, 0
local orbitRadius, orbitFloatAmp, orbitFloatFreq, orbitSpeed = 5, 3, 6, 8
local targetAcquireTime = 0
local SWITCH_DELAY = 1.5

local function getNearestEnemy()
    local char = localPlayer.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local nearest, minDist = nil, math.huge
    for _,p in pairs(Players:GetPlayers()) do
        if p ~= localPlayer and p.Team ~= localPlayer.Team then
            local ec = p.Character
            if ec then
                local er = ec:FindFirstChild("HumanoidRootPart")
                local eh = ec:FindFirstChildOfClass("Humanoid")
                if er and eh and eh.Health > 0 then
                    local d = (root.Position - er.Position).Magnitude
                    if d < minDist then minDist = d; nearest = p end
                end
            end
        end
    end
    return nearest
end

local function updateOrbitBtnText()
    if orbitBtn then
        if orbitActive and orbitTarget then orbitBtn.Text = "停止 - "..orbitTarget.Name
        elseif orbitActive then orbitBtn.Text = "停止 (无目标)"
        else orbitBtn.Text = "点击选择目标" end
    end
end

local function stopOrbit()
    orbitActive = false; orbitTarget = nil; targetAcquireTime = 0
    if orbitConn then orbitConn:Disconnect(); orbitConn = nil end
    local char = localPlayer.Character
    if char then local hum = char:FindFirstChildOfClass("Humanoid") if hum then hum.AutoRotate = true end end
    updateOrbitBtnText()
end

local function startOrbit()
    if orbitConn then return end
    if not orbitTarget then local near = getNearestEnemy() if near then orbitTarget = near else return end end
    targetAcquireTime = tick()
    orbitActive = true
    orbitConn = RunService.Heartbeat:Connect(function(dt)
        if not orbitActive then return end
        local function switchToNewTarget()
            local newTarget = getNearestEnemy()
            if newTarget then orbitTarget = newTarget; targetAcquireTime = tick(); updateOrbitBtnText()
            else stopOrbit() end
        end
        if orbitTarget then
            local char = orbitTarget.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if not hum or hum.Health <= 0 or not root then switchToNewTarget() return
            elseif tick() - targetAcquireTime >= SWITCH_DELAY then switchToNewTarget() return end
        else switchToNewTarget() return end

        local myChar = localPlayer.Character
        if not myChar then return end
        local myRoot = myChar:FindFirstChild("HumanoidRootPart")
        local myHum = myChar:FindFirstChildOfClass("Humanoid")
        if not myRoot or not myHum then return end
        local targetChar = orbitTarget.Character
        if not targetChar then switchToNewTarget(); return end
        local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
        if not targetRoot then switchToNewTarget(); return end
        if myHum.AutoRotate ~= false then myHum.AutoRotate = false end
        orbitAngle = orbitAngle + orbitSpeed * dt
        local vertOffset = math.sin(os.clock() * orbitFloatFreq) * orbitFloatAmp
        local targetPos = targetRoot.Position
        local horizDir = Vector3.new(math.cos(orbitAngle), 0, math.sin(orbitAngle))
        local desiredPos = targetPos + horizDir * orbitRadius + Vector3.new(0, vertOffset, 0)
        myRoot.CFrame = CFrame.lookAt(desiredPos, targetPos)
        myRoot.Velocity = Vector3.zero
        myRoot.RotVelocity = Vector3.zero
    end)
    updateOrbitBtnText()
end

local function createOrbitUI()
    if orbitUI then orbitUI:Destroy() end
    local sg = Instance.new("ScreenGui", game.CoreGui); sg.ResetOnSpawn = false; orbitUI = sg
    local btn = Instance.new("TextButton", sg)
    btn.Size = UDim2.new(0,140,0,30); btn.Position = UDim2.new(0.15,0,0.25,0)
    btn.BackgroundColor3 = Color3.new(0.1,0.1,0.1); btn.BackgroundTransparency = 0.2
    btn.Text = "点击选择目标"; btn.TextColor3 = Color3.new(1,1,1); btn.TextSize = 11
    orbitBtn = btn
    local drag, sI, sP
    btn.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then drag=true; sI=i.Position; sP=btn.Position end end)
    btn.InputChanged:Connect(function(i) if drag then local d=i.Position-sI; btn.Position=UDim2.new(sP.X.Scale, sP.X.Offset+d.X, sP.Y.Scale, sP.Y.Offset+d.Y) end end)
    btn.InputEnded:Connect(function() drag=false end)
    btn.MouseButton1Click:Connect(function()
        if orbitActive then stopOrbit()
        else
            local nearest = getNearestEnemy()
            if nearest then orbitTarget = nearest; targetAcquireTime = tick(); startOrbit()
            else btn.Text = "无可用目标" task.delay(1.5, function() if btn and not orbitActive then btn.Text = "点击选择目标" end end) end
        end
    end)
end

local function removeOrbitUI()
    if orbitUI then orbitUI:Destroy(); orbitUI = nil end
    orbitBtn = nil; stopOrbit()
end

MainTab:CreateToggle({ Name = "悬浮传送", CurrentValue = false, Callback = function(v) orbitEnabled=v; if v then createOrbitUI() else removeOrbitUI() end end })

-- ==================== 主页 - 防踢 ====================
local antiKickEnabled = false
local antiKickConnections = {}

local function setupAntiKick()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local oldNamecall = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        if antiKickEnabled and getnamecallmethod() == "Kick" and self == localPlayer then
            return
        end
        return oldNamecall(self, ...)
    end)
    setreadonly(mt, true)

    local conn1 = localPlayer.CharacterRemoving:Connect(function()
        if antiKickEnabled then
            localPlayer:LoadCharacter()
        end
    end)
    table.insert(antiKickConnections, conn1)

    local conn2 = RunService.Stepped:Connect(function()
        if not antiKickEnabled then return end
        local char = localPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local root = char.HumanoidRootPart
            root.CFrame = root.CFrame + Vector3.new(math.random(-5,5)/100, 0, math.random(-5,5)/100)
        end
    end)
    table.insert(antiKickConnections, conn2)

    local conn3 = localPlayer.OnTeleport:Connect(function(state)
        if antiKickEnabled and state == Enum.TeleportState.Started then
            TeleportService:Teleport(game.PlaceId, localPlayer)
        end
    end)
    table.insert(antiKickConnections, conn3)
end

MainTab:CreateToggle({ Name = "防踢保护", CurrentValue = false, Callback = function(v)
    antiKickEnabled = v
    if v and #antiKickConnections == 0 then
        setupAntiKick()
    elseif not v then
        for _, conn in ipairs(antiKickConnections) do
            conn:Disconnect()
        end
        antiKickConnections = {}
    end
end})

-- ==================== 主页 - 无减速 [新增] ====================
local noSlowEnabled = false
local noSlowConnection = nil

MainTab:CreateToggle({ Name = "无减速", CurrentValue = false, Callback = function(v)
    noSlowEnabled = v
    if v then
        if noSlowConnection then noSlowConnection:Disconnect() end
        noSlowConnection = RunService.Heartbeat:Connect(function()
            if not noSlowEnabled then return end
            local char = localPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    -- 如果速度低于设定值（默认为16或用户调整的值），立即恢复到currentWalkSpeed
                    if hum.WalkSpeed < currentWalkSpeed then
                        hum.WalkSpeed = currentWalkSpeed
                    end
                end
            end
        end)
    else
        if noSlowConnection then
            noSlowConnection:Disconnect()
            noSlowConnection = nil
        end
    end
end})

-- ==================== 视觉标签页 - ESP透视 ====================
local espEnabled = false
local espRefreshEnabled = false
local espRefreshTimer = nil
local highlights = {}

local function clearESP()
    for _, hl in pairs(highlights) do
        hl:Destroy()
    end
    highlights = {}
end

local function updateESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player == localPlayer then continue end
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local root = char.HumanoidRootPart
            local hl = highlights[player]
            if not hl or not hl.Parent then
                hl = Instance.new("Highlight")
                hl.Name = "ESP_Highlight"
                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                hl.Parent = char
                highlights[player] = hl
            end
            if player.Team == localPlayer.Team then
                hl.FillColor = Color3.new(0, 0, 1)
                hl.OutlineColor = Color3.new(0, 0, 1)
            else
                hl.FillColor = Color3.new(1, 0, 0)
                hl.OutlineColor = Color3.new(1, 0, 0)
            end
            hl.Enabled = espEnabled
        else
            if highlights[player] then
                highlights[player]:Destroy()
                highlights[player] = nil
            end
        end
    end
end

local function startESPRefresh()
    espRefreshTimer = task.spawn(function()
        while espRefreshEnabled do
            task.wait(30)
            updateESP()
        end
    end)
end

ESPTab:CreateToggle({ Name = "ESP透视", CurrentValue = false, Callback = function(v)
    espEnabled = v
    if not v then clearESP() else updateESP() end
end})

ESPTab:CreateToggle({ Name = "自动刷新阵营(30秒)", CurrentValue = false, Callback = function(v)
    espRefreshEnabled = v
    if v then
        if espRefreshTimer then task.cancel(espRefreshTimer) end
        startESPRefresh()
    else
        if espRefreshTimer then task.cancel(espRefreshTimer); espRefreshTimer = nil end
    end
end})

Players.PlayerAdded:Connect(function() if espEnabled then task.wait(0.5) updateESP() end end)
Players.PlayerRemoving:Connect(function(player) if highlights[player] then highlights[player]:Destroy(); highlights[player] = nil end end)

-- ==================== 战斗 - 杀戮光环 ====================
local killAuraEnabled = false
local killAuraRange = 25
local killAuraCooldown = 0.3
local killAuraLastAttack = 0
local killAuraConn = nil
local packets = nil

local success, result = pcall(function() return require(ReplicatedStorage.REFERENCES.PacketReference) end)
if success then packets = result end

local function getNearestEnemyForKill()
    local char = localPlayer.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local nearest, minDist = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= localPlayer and p.Team ~= localPlayer.Team then
            local ec = p.Character
            if ec then
                local er = ec:FindFirstChild("HumanoidRootPart")
                local eh = ec:FindFirstChildOfClass("Humanoid")
                if er and eh and eh.Health > 0 then
                    local d = (root.Position - er.Position).Magnitude
                    if d < minDist and d <= killAuraRange then minDist = d; nearest = p end
                end
            end
        end
    end
    return nearest
end

local function killAuraHeartbeat()
    local char = localPlayer.Character
    if not char then return end
    local tool = char:FindFirstChildOfClass("Tool")
    if not tool or not packets then return end

    local target = getNearestEnemyForKill()
    if not target or not target.Character then return end
    local targetHead = target.Character:FindFirstChild("Head")
    local targetHum = target.Character:FindFirstChildOfClass("Humanoid")
    if not targetHead or not targetHum or targetHum.Health <= 0 then return end

    local now = os.clock()
    if now - killAuraLastAttack >= killAuraCooldown then
        killAuraLastAttack = now
        local meleeArgs = {
            Type = "Humanoid",
            Tool = tool,
            hitInstance = targetHead,
            knockbackOrigin = Vector3.zero,
            knockbackDirection = Vector3.zero
        }
        packets.MeleeHitRegistration.send(meleeArgs)
    end
end

local function startKillAura()
    if killAuraConn then return end
    killAuraConn = RunService.Heartbeat:Connect(killAuraHeartbeat)
end

local function stopKillAura()
    if killAuraConn then killAuraConn:Disconnect(); killAuraConn = nil end
end

CombatTab:CreateToggle({ Name = "杀戮光环", CurrentValue = false, Callback = function(v)
    killAuraEnabled = v
    if v then startKillAura() else stopKillAura() end
end})

CombatTab:CreateSlider({ Name = "攻击距离", Range = {5,30}, Increment = 1, CurrentValue = 25, Callback = function(v) killAuraRange = v end })
CombatTab:CreateSlider({ Name = "攻击速度", Range = {0.1,1}, Increment = 0.05, Suffix = "秒", CurrentValue = 0.3, Callback = function(v) killAuraCooldown = v end })

-- ==================== 战斗 - 超强杀戮 ====================
local superKillEnabled = false
local superKillConn = nil
local SUPER_ATTACK_RANGE = 30
local SUPER_ATTACK_SPEED = 0.1
local superLastAttack = 0

-- 超强杀戮警告UI
local superKillWarning = nil

local function showSuperKillWarning()
    if superKillWarning then
        superKillWarning:Destroy()
    end
    local sg = Instance.new("ScreenGui")
    sg.Name = "SuperKillWarning"
    sg.ResetOnSpawn = false
    sg.Parent = game.CoreGui
    superKillWarning = sg

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.8, 0, 0.7, 0)
    frame.Position = UDim2.new(0.1, 0, 0.15, 0)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BackgroundTransparency = 0.5
    frame.Parent = sg

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "超强杀戮Bug极多谨慎使用"
    label.TextColor3 = Color3.new(1, 0, 0)
    label.TextScaled = true
    label.Font = Enum.Font.SourceSansBold
    label.Parent = frame

    task.delay(5, function()
        local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local tweenFrame = TweenService:Create(frame, tweenInfo, {BackgroundTransparency = 1})
        local tweenLabel = TweenService:Create(label, tweenInfo, {TextTransparency = 1})
        tweenFrame:Play()
        tweenLabel:Play()
        tweenFrame.Completed:Connect(function()
            sg:Destroy()
            if superKillWarning == sg then
                superKillWarning = nil
            end
        end)
    end)
end

local function superKillLoop()
    if not superKillEnabled then return end
    local char = localPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Team ~= localPlayer.Team and player.Character then
            local enemyRoot = player.Character:FindFirstChild("HumanoidRootPart")
            local enemyHum = player.Character:FindFirstChildOfClass("Humanoid")
            if enemyRoot and enemyHum and enemyHum.Health > 0 then
                local dist = (root.Position - enemyRoot.Position).Magnitude
                if dist <= SUPER_ATTACK_RANGE then
                    local now = os.clock()
                    if now - superLastAttack >= SUPER_ATTACK_SPEED then
                        superLastAttack = now
                        enemyHum:TakeDamage(100)
                    end
                end
            end
        end
    end
end

CombatTab:CreateToggle({ Name = "超强杀戮", CurrentValue = false, Callback = function(v)
    superKillEnabled = v
    if v then
        showSuperKillWarning()
        if not superKillConn then
            superKillConn = RunService.Heartbeat:Connect(superKillLoop)
        end
    else
        if superKillConn then superKillConn:Disconnect(); superKillConn = nil end
    end
end})

RunService.Heartbeat:Connect(function()
    if superKillEnabled and not superKillConn then
        superKillConn = RunService.Heartbeat:Connect(superKillLoop)
    end
end)

-- ==================== 占位标签 ====================
CombatTab:CreateLabel("战斗功能已加载")