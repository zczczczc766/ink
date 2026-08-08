local RunService = game:GetService("RunService")
local lp = game.Players.LocalPlayer

local function applyAntiFall(character)
    if not character then return end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local conn
    conn = RunService.Heartbeat:Connect(function()
        if not hrp or not hrp.Parent then
            conn:Disconnect()
            return
        end
        local vel = hrp.AssemblyLinearVelocity
        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        RunService.RenderStepped:Wait()
        hrp.AssemblyLinearVelocity = vel
    end)
end

if lp.Character then
    applyAntiFall(lp.Character)
end

lp.CharacterAdded:Connect(function(char)
    task.wait(0.1)
    applyAntiFall(char)
end)