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

task.spawn(function()
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