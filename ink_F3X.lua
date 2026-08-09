--[=[
 d888b  db    db d888888b      .d888b.      db      db    db  .d8b.  
88' Y8b 88    88   `88'        VP  `8D      88      88    88 d8' `8b 
88      88    88    88            odD'      88      88    88 88ooo88 
88  ooo 88    88    88          .88'        88      88    88 88~~~88 
88. ~8~ 88b  d88   .88.        j88.         88booo. 88b  d88 88   88    @uniquadev
 Y888P  ~Y8888P' Y888888P      888888D      Y88888P ~Y8888P' YP   YP  CONVERTER 

designed using localmaze gui creator
]=]

-- Instances: 27 | Scripts: 0 | Modules: 0 | Tags: 0
local LMG2L = {};

-- Players.godwhy532.PlayerGui.ScreenGui
LMG2L["ScreenGui_1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
LMG2L["ScreenGui_1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;


-- Players.godwhy532.PlayerGui.ScreenGui.Frame
LMG2L["Frame_2"] = Instance.new("Frame", LMG2L["ScreenGui_1"]);
LMG2L["Frame_2"]["BorderSizePixel"] = 0;
LMG2L["Frame_2"]["BackgroundColor3"] = Color3.fromRGB(16, 35, 32);
LMG2L["Frame_2"]["AutomaticSize"] = Enum.AutomaticSize.None;
LMG2L["Frame_2"]["Size"] = UDim2.new(0, 560, 0, 650);
LMG2L["Frame_2"]["Position"] = UDim2.new(0, 26, 0, 118);


-- Players.godwhy532.PlayerGui.ScreenGui.Frame.UICorner
LMG2L["UICorner_3"] = Instance.new("UICorner", LMG2L["Frame_2"]);



-- Players.godwhy532.PlayerGui.ScreenGui.Frame.ImageLabel
LMG2L["ImageLabel_4"] = Instance.new("ImageLabel", LMG2L["Frame_2"]);
LMG2L["ImageLabel_4"]["BorderSizePixel"] = 0;
LMG2L["ImageLabel_4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
-- LMG2L["ImageLabel_4"]["ImageContent"] = ;
LMG2L["ImageLabel_4"]["Image"] = [[rbxassetid://132893898645050]];
LMG2L["ImageLabel_4"]["Size"] = UDim2.new(0, 540, 0, 630);
LMG2L["ImageLabel_4"]["Position"] = UDim2.new(0, 10, 0, 10);


-- Players.godwhy532.PlayerGui.ScreenGui.Frame.ScrollingFrame
LMG2L["ScrollingFrame_5"] = Instance.new("ScrollingFrame", LMG2L["Frame_2"]);
LMG2L["ScrollingFrame_5"]["BorderSizePixel"] = 0;
LMG2L["ScrollingFrame_5"]["BackgroundColor3"] = Color3.fromRGB(28, 29, 28);
LMG2L["ScrollingFrame_5"]["Size"] = UDim2.new(0, 540, 0, 565);
LMG2L["ScrollingFrame_5"]["Position"] = UDim2.new(0, 10, 0, 72);
LMG2L["ScrollingFrame_5"]["CanvasSize"] = UDim2.new(0, 0, 0, 1200);
LMG2L["ScrollingFrame_5"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y;
LMG2L["ScrollingFrame_5"]["ScrollingDirection"] = Enum.ScrollingDirection.Y;
LMG2L["ScrollingFrame_5"]["ScrollBarThickness"] = 8;
LMG2L["ScrollingFrame_5"]["ClipsDescendants"] = true;


-- Players.godwhy532.PlayerGui.ScreenGui.Frame.TextBox
LMG2L["TextBox_6"] = Instance.new("TextBox", LMG2L["Frame_2"]);
LMG2L["TextBox_6"]["BorderSizePixel"] = 0;
LMG2L["TextBox_6"]["TextSize"] = 36;
LMG2L["TextBox_6"]["BackgroundColor3"] = Color3.fromRGB(11, 27, 8);
LMG2L["TextBox_6"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LMG2L["TextBox_6"]["Size"] = UDim2.new(0, 520, 0, 54);
LMG2L["TextBox_6"]["Position"] = UDim2.new(0, 20, 0, 10);
LMG2L["TextBox_6"]["Text"] = [[Rob45 f3x gui]];
LMG2L["TextBox_6"]["ClearTextOnFocus"] = false;
LMG2L["TextBox_6"]["TextEditable"] = false;


-- Players.godwhy532.PlayerGui.ScreenGui.Frame.TextBox.UICorner
LMG2L["UICorner_7"] = Instance.new("UICorner", LMG2L["TextBox_6"]);



-- Players.godwhy532.PlayerGui.ScreenGui.Frame.TextButton
LMG2L["TextButton_8"] = Instance.new("TextButton", LMG2L["ScrollingFrame_5"]);
LMG2L["TextButton_8"]["BorderSizePixel"] = 0;
LMG2L["TextButton_8"]["TextSize"] = 28;
LMG2L["TextButton_8"]["BackgroundColor3"] = Color3.fromRGB(151, 64, 255);
LMG2L["TextButton_8"]["FontFace"] = Font.new([[rbxasset://fonts/families/BuilderSans.json]], Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal);

LMG2L["TextButton_8"]["Size"] = UDim2.new(0, 510, 0, 54);
LMG2L["TextButton_8"]["BorderColor3"] = Color3.fromRGB(44, 193, 154);
LMG2L["TextButton_8"]["Text"] = [[skybox]];
LMG2L["TextButton_8"]["Style"] = Enum.ButtonStyle.RobloxRoundDropdownButton;
LMG2L["TextButton_8"]["Position"] = UDim2.new(0, 10, 0, 8);
LMG2L["TextButton_8"].MouseButton1Click:Connect(function()
local player = game.Players.LocalPlayer
local char = player.Character
local tool
for i,v in player:GetDescendants() do
    if v.Name == "SyncAPI" then
        tool = v.Parent
    end
end
for i,v in game.ReplicatedStorage:GetDescendants() do
    if v.Name == "SyncAPI" then
        tool = v.Parent
    end
end
remote = tool.SyncAPI.ServerEndpoint
function _(args)
    remote:InvokeServer(unpack(args))
end
function SetCollision(part,boolean)
    local args = {
        [1] = "SyncCollision",
        [2] = {
            [1] = {
                ["Part"] = part,
                ["CanCollide"] = boolean
            }
        }
    }
    _(args)
end
function SetAnchor(boolean,part)
    local args = {
        [1] = "SyncAnchor",
        [2] = {
            [1] = {
                ["Part"] = part,
                ["Anchored"] = boolean
            }
        }
    }
    _(args)
end
function CreatePart(cf,parent)
    local args = {
        [1] = "CreatePart",
        [2] = "Normal",
        [3] = cf,
        [4] = parent
    }
    _(args)
end
function DestroyPart(part)
    local args = {
        [1] = "Remove",
        [2] = {
            [1] = part
        }
    }
    _(args)
end
function MovePart(part,cf)
    local args = {
        [1] = "SyncMove",
        [2] = {
            [1] = {
                ["Part"] = part,
                ["CFrame"] = cf
            }
        }
    }
    _(args)
end
function Resize(part,size,cf)
    local args = {
        [1] = "SyncResize",
        [2] = {
            [1] = {
                ["Part"] = part,
                ["CFrame"] = cf,
                ["Size"] = size
            }
        }
    }
    _(args)
end
function AddMesh(part)
    local args = {
        [1] = "CreateMeshes",
        [2] = {
            [1] = {
                ["Part"] = part
            }
        }
    }
    _(args)
end

function SetMesh(part,meshid)
    local args = {
        [1] = "SyncMesh",
        [2] = {
            [1] = {
                ["Part"] = part,
                ["MeshId"] = "rbxassetid://"..meshid
            }
        }
    }
    _(args)
end
function SetTexture(part, texid)
    local args = {
        [1] = "SyncMesh",
        [2] = {
            [1] = {
                ["Part"] = part,
                ["TextureId"] = "rbxassetid://"..texid
            }
        }
    }
    _(args)
end
function SetName(part, stringg)
    local args = {
        [1] = "SetName",
        [2] = {
            [1] = part
        },
        [3] = stringg
    }

    _(args)
end
function MeshResize(part,size)
    local args = {
        [1] = "SyncMesh",
        [2] = {
            [1] = {
                ["Part"] = part,
                ["Scale"] = size
            }
        }
    }
    _(args)
end
function Weld(part1, part2,lead)
    local args = {
        [1] = "CreateWelds",
        [2] = {
            [1] = part1,
            [2] = part2
        },
        [3] = lead
    }
    _(args)

end
function SetLocked(part,boolean)
    local args = {
        [1] = "SetLocked",
        [2] = {
            [1] = part
        },
        [3] = boolean
    }
    _(args)
end
function SetTrans(part,int)
    local args = {
        [1] = "SyncMaterial",
        [2] = {
            [1] = {
                ["Part"] = part,
                ["Transparency"] = int
            }
        }
    }
    _(args)
end
function CreateSpotlight(part)
    local args = {
        [1] = "CreateLights",
        [2] = {
            [1] = {
                ["Part"] = part,
                ["LightType"] = "SpotLight"
            }
        }
    }
    _(args)
end
function SyncLighting(part,brightness)
    local args = {
        [1] = "SyncLighting",
        [2] = {
            [1] = {
                ["Part"] = part,
                ["LightType"] = "SpotLight",
                ["Brightness"] = brightness
            }
        }
    }
    _(args)
end
function Color(part,color)
    local args = {
        [1] = "SyncColor",
        [2] = {
            [1] = {
                ["Part"] = part,
                ["Color"] = color,
                ["UnionColoring"] = false
            }
        }
    }
    _(args)
end
function SpawnDecal(part,side)
    local args = {
        [1] = "CreateTextures",
        [2] = {
            [1] = {
                ["Part"] = part,
                ["Face"] = side,
                ["TextureType"] = "Decal"
            }
        }
    }

    _(args)
end
function AddDecal(part,asset,side)
    local args = {
        [1] = "SyncTexture",
        [2] = {
            [1] = {
                ["Part"] = part,
                ["Face"] = side,
                ["TextureType"] = "Decal",
                ["Texture"] = "rbxassetid://".. asset
            }
        }
    }
    _(args)
end

function Sky(id)
    local e = char.HumanoidRootPart.CFrame.x
    local f = char.HumanoidRootPart.CFrame.y
    local g = char.HumanoidRootPart.CFrame.z
    local spawnPos = CFrame.new(math.floor(e), math.floor(f), math.floor(g)) + Vector3.new(0, 6, 0)
    
    CreatePart(spawnPos, workspace)
    task.wait(0.2) 

    local skyPart
    for i, v in workspace:GetDescendants() do
        if v:IsA("BasePart") and (v.Position - spawnPos.p).Magnitude < 1 then
            skyPart = v
            SetName(v, "RandomSpinSky")
            AddMesh(v)
            SetMesh(v, "111891702759441")
            SetTexture(v, id)
            MeshResize(v, Vector3.new(2500, 2500, 2500))
            SetLocked(v, true)
            SetAnchor(true, v)
            SetCollision(v, false)
            break
        end
    end

    if skyPart then
        local t = 0
        local baseSpeed = 14
        local randomness = 14
        
        game:GetService("RunService").Heartbeat:Connect(function(dt)
            t = t + dt
            
            local rotX = math.sin(t * 1.5) * randomness
            local rotY = t * baseSpeed 
            local rotZ = math.cos(t * 2.1) * randomness
            
            local newCf = spawnPos * CFrame.Angles(
                math.rad(rotX), 
                math.rad(rotY), 
                math.rad(rotZ)
            )
            
            MovePart(skyPart, newCf)
        end)
    end
end

Sky("98398077305252")

end)
-- Players.godwhy532.PlayerGui.ScreenGui.Frame.TextButton
LMG2L["TextButton_9"] = Instance.new("TextButton", LMG2L["ScrollingFrame_5"]);
LMG2L["TextButton_9"]["BorderSizePixel"] = 0;
LMG2L["TextButton_9"]["TextSize"] = 28;
LMG2L["TextButton_9"]["BackgroundColor3"] = Color3.fromRGB(151, 64, 255);
LMG2L["TextButton_9"]["FontFace"] = Font.new([[rbxasset://fonts/families/BuilderSans.json]], Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal);
LMG2L["TextButton_9"]["Size"] = UDim2.new(0, 510, 0, 54);
LMG2L["TextButton_9"]["BorderColor3"] = Color3.fromRGB(44, 193, 154);
LMG2L["TextButton_9"]["Text"] = [[decal]];
LMG2L["TextButton_9"]["Style"] = Enum.ButtonStyle.RobloxRoundDropdownButton;
LMG2L["TextButton_9"]["Position"] = UDim2.new(0, 10, 0, 72);
LMG2L["TextButton_9"].MouseButton1Click:Connect(function()
local player = game.Players.LocalPlayer
	local char = player.Character
	local tool
	for i,v in player:GetDescendants() do
		if v.Name == "SyncAPI" then
			tool = v.Parent
		end
	end
	for i,v in game.ReplicatedStorage:GetDescendants() do
		if v.Name == "SyncAPI" then
			tool = v.Parent
		end
	end
	remote = tool.SyncAPI.ServerEndpoint
	function _(args)
		remote:InvokeServer(unpack(args))
	end
	function SetCollision(part,boolean)
		local args = {
			[1] = "SyncCollision",
			[2] = {
				[1] = {
					["Part"] = part,
					["CanCollide"] = boolean
				}
			}
		}
		_(args)
	end
	function SetAnchor(boolean,part)
		local args = {
			[1] = "SyncAnchor",
			[2] = {
				[1] = {
					["Part"] = part,
					["Anchored"] = boolean
				}
			}
		}
		_(args)
	end
	function CreatePart(cf,parent)
		local args = {
			[1] = "CreatePart",
			[2] = "Normal",
			[3] = cf,
			[4] = parent
		}
		_(args)
	end
	function DestroyPart(part)
		local args = {
			[1] = "Remove",
			[2] = {
				[1] = part
			}
		}
		_(args)
	end
	function MovePart(part,cf)
		local args = {
			[1] = "SyncMove",
			[2] = {
				[1] = {
					["Part"] = part,
					["CFrame"] = cf
				}
			}
		}
		_(args)
	end
	function Resize(part,size,cf)
		local args = {
			[1] = "SyncResize",
			[2] = {
				[1] = {
					["Part"] = part,
					["CFrame"] = cf,
					["Size"] = size
				}
			}
		}
		_(args)
	end
	function AddMesh(part)
		local args = {
			[1] = "CreateMeshes",
			[2] = {
				[1] = {
					["Part"] = part
				}
			}
		}
		_(args)
	end

	function SetMesh(part,meshid)
		local args = {
			[1] = "SyncMesh",
			[2] = {
				[1] = {
					["Part"] = part,
					["MeshId"] = "rbxassetid://"..meshid
				}
			}
		}
		_(args)
	end
	function SetTexture(part, texid)
		local args = {
			[1] = "SyncMesh",
			[2] = {
				[1] = {
					["Part"] = part,
					["TextureId"] = "rbxassetid://"..texid
				}
			}
		}
		_(args)
	end
	function SetName(part, stringg)
		local args = {
			[1] = "SetName",
			[2] = {
				[1] = part
			},
			[3] = stringg
		}

		_(args)
	end
	function MeshResize(part,size)
		local args = {
			[1] = "SyncMesh",
			[2] = {
				[1] = {
					["Part"] = part,
					["Scale"] = size
				}
			}
		}
		_(args)
	end
	function Weld(part1, part2,lead)
		local args = {
			[1] = "CreateWelds",
			[2] = {
				[1] = part1,
				[2] = part2
			},
			[3] = lead
		}
		_(args)

	end
	function SetLocked(part,boolean)
		local args = {
			[1] = "SetLocked",
			[2] = {
				[1] = part
			},
			[3] = boolean
		}
		_(args)
	end
	function SetTrans(part,int)
		local args = {
			[1] = "SyncMaterial",
			[2] = {
				[1] = {
					["Part"] = part,
					["Transparency"] = int
				}
			}
		}
		_(args)
	end
	function CreateSpotlight(part)
		local args = {
			[1] = "CreateLights",
			[2] = {
				[1] = {
					["Part"] = part,
					["LightType"] = "SpotLight"
				}
			}
		}
		_(args)
	end
	function SyncLighting(part,brightness)
		local args = {
			[1] = "SyncLighting",
			[2] = {
				[1] = {
					["Part"] = part,
					["LightType"] = "SpotLight",
					["Brightness"] = brightness
				}
			}
		}
		_(args)
	end
	function Color(part,color)
		local args = {
			[1] = "SyncColor",
			[2] = {
				[1] = {
					["Part"] = part,
					["Color"] = color --[[Color3]],
					["UnionColoring"] = false
				}
			}
		}
		_(args)
	end
	function SpawnDecal(part,side)
		local args = {
			[1] = "CreateTextures",
			[2] = {
				[1] = {
					["Part"] = part,
					["Face"] = side,
					["TextureType"] = "Decal"
				}
			}
		}

		_(args)
	end
	function AddDecal(part,asset,side)
		local args = {
			[1] = "SyncTexture",
			[2] = {
				[1] = {
					["Part"] = part,
					["Face"] = side,
					["TextureType"] = "Decal",
					["Texture"] = "rbxassetid://".. asset
				}
			}
		}
		_(args)
	end

	function spam(id)
		for i,v in game.workspace:GetDescendants() do
			if v:IsA("BasePart") then
				spawn(function()
					SetLocked(v,false)
					SpawnDecal(v,Enum.NormalId.Front)
					AddDecal(v,id,Enum.NormalId.Front)

					SpawnDecal(v,Enum.NormalId.Back)
					AddDecal(v,id,Enum.NormalId.Back)

					SpawnDecal(v,Enum.NormalId.Right)
					AddDecal(v,id,Enum.NormalId.Right)

					SpawnDecal(v,Enum.NormalId.Left)
					AddDecal(v,id,Enum.NormalId.Left)

					SpawnDecal(v,Enum.NormalId.Bottom)
					AddDecal(v,id,Enum.NormalId.Bottom)

					SpawnDecal(v,Enum.NormalId.Top)
					AddDecal(v,id,Enum.NormalId.Top)
				end)
			end
		end 
	end
	spam("98398077305252")
	
end)
-- Players.godwhy532.PlayerGui.ScreenGui.Frame.TextButton
LMG2L["TextButton_a"] = Instance.new("TextButton", LMG2L["ScrollingFrame_5"]);
LMG2L["TextButton_a"]["BorderSizePixel"] = 0;
LMG2L["TextButton_a"]["TextSize"] = 28;
LMG2L["TextButton_a"]["BackgroundColor3"] = Color3.fromRGB(151, 64, 255);
LMG2L["TextButton_a"]["FontFace"] = Font.new([[rbxasset://fonts/families/BuilderSans.json]], Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal);
LMG2L["TextButton_a"]["Size"] = UDim2.new(0, 510, 0, 54);
LMG2L["TextButton_a"]["BorderColor3"] = Color3.fromRGB(44, 193, 154);
LMG2L["TextButton_a"]["Text"] = [[particles]];
LMG2L["TextButton_a"]["Style"] = Enum.ButtonStyle.RobloxRoundDropdownButton;
LMG2L["TextButton_a"]["Position"] = UDim2.new(0, 10, 0, 136);
LMG2L["TextButton_a"].MouseButton1Click:Connect(function()
local Player = game.Players.LocalPlayer
local NewAssetID = "rbxassetid://132893898645050"

local function GetF3XRemote()  
    for _, v in pairs(game:GetDescendants()) do  
        if v.Name == "SyncAPI" then 
            return v:FindFirstChild("ServerEndpoint") or v 
        end  
    end  
end  

local function F3X_Invoke(...)  
    local remote = GetF3XRemote()  
    if remote then 
        remote:InvokeServer(...) 
    end  
end  

print("Fixed Script: Anti-Gravity Mode Activated")

task.spawn(function()  
    while true do  
        local char = Player.Character  
        if char and char:FindFirstChild("Head") then  
            -- Vị trí xuất phát (Trên đầu 4 studs)
            local headPos = char.Head.Position
            local spawnPos = headPos + Vector3.new(0, 4, 0) 
            local currentCF = CFrame.new(spawnPos) 

            -- 1. Tạo Part (Giữ nguyên tư thế đứng thẳng)
            F3X_Invoke("CreatePart", "Normal", currentCF, workspace)  
            
            task.spawn(function()  
                task.wait(0.1) -- Đợi server tạo Part xong
                
                for _, p in pairs(workspace:GetChildren()) do  
                    if p:IsA("BasePart") and (p.Position - spawnPos).Magnitude < 2 then  
                        
                        -- 2. Thiết lập hiển thị (Size 10x10, Tàng hình khối gạch)
                        F3X_Invoke("SyncMaterial", {{["Part"] = p, ["Transparency"] = 1}})
                        F3X_Invoke("SyncCanCollide", {{["Part"] = p, ["CanCollide"] = false}})
                        F3X_Invoke("SyncResize", {{["Part"] = p, ["CFrame"] = currentCF, ["Size"] = Vector3.new(10, 10, 0.1)}})  
                        
                        -- 3. Dán Texture ID mới của bạn
                        local faces = {Enum.NormalId.Front, Enum.NormalId.Back}  
                        for _, face in pairs(faces) do  
                            F3X_Invoke("CreateTextures", {{["Part"] = p, ["Face"] = face, ["TextureType"] = "Decal"}})  
                            F3X_Invoke("SyncTexture", {{["Part"] = p, ["Face"] = face, ["TextureType"] = "Decal", ["Texture"] = NewAssetID}})  
                        end  
                        
                        -- 4. BAY LÊN (Sửa lỗi rơi: Giữ Anchored và dùng SyncMove thông minh)
                        -- Chúng ta dùng 15 bước, mỗi bước bay lên 2 studs để vừa mượt vừa không lag
                        for i = 1, 15 do
                            if p and p.Parent then
                                currentCF = currentCF * CFrame.new(0, 2, 0) -- Mỗi lần nhích lên 2 studs
                                F3X_Invoke("SyncMove", {{["Part"] = p, ["CFrame"] = currentCF}})
                                task.wait(0.2) -- Đợi 0.2s mỗi bước để tạo hiệu ứng trôi chậm
                            end
                        end
                        
                        -- 5. Xóa Part sau khi bay xong
                        F3X_Invoke("Remove", {p})  
                        break 
                    end  
                end  
            end)  
        end  
        task.wait(2.5) -- Tốc độ tạo hạt mới (Giảm spam để tránh lag tối đa)
    end  
end)

end)
-- Players.godwhy532.PlayerGui.ScreenGui.Frame.TextButton
LMG2L["TextButton_b"] = Instance.new("TextButton", LMG2L["ScrollingFrame_5"]);
LMG2L["TextButton_b"]["BorderSizePixel"] = 0;
LMG2L["TextButton_b"]["TextSize"] = 28;
LMG2L["TextButton_b"]["BackgroundColor3"] = Color3.fromRGB(151, 64, 255);
LMG2L["TextButton_b"]["FontFace"] = Font.new([[rbxasset://fonts/families/BuilderSans.json]], Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal);
LMG2L["TextButton_b"]["Size"] = UDim2.new(0, 510, 0, 54);
LMG2L["TextButton_b"]["BorderColor3"] = Color3.fromRGB(44, 193, 154);
LMG2L["TextButton_b"]["Text"] = [[theme]];
LMG2L["TextButton_b"]["Style"] = Enum.ButtonStyle.RobloxRoundDropdownButton;
LMG2L["TextButton_b"]["Position"] = UDim2.new(0, 10, 0, 200);
LMG2L["TextButton_b"].MouseButton1Click:Connect(function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommand

	RequestCommand:InvokeServer(";music 78973045684083")
	RequestCommand:InvokeServer(";pitch 0.3")
	RequestCommand:InvokeServer(";volume inf")
	
end)
-- Players.godwhy532.PlayerGui.ScreenGui.Frame.TextButton
LMG2L["TextButton_c"] = Instance.new("TextButton", LMG2L["ScrollingFrame_5"]);
LMG2L["TextButton_c"]["BorderSizePixel"] = 0;
LMG2L["TextButton_c"]["TextSize"] = 28;
LMG2L["TextButton_c"]["BackgroundColor3"] = Color3.fromRGB(151, 64, 255);
LMG2L["TextButton_c"]["FontFace"] = Font.new([[rbxasset://fonts/families/BuilderSans.json]], Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal);
LMG2L["TextButton_c"]["Size"] = UDim2.new(0, 510, 0, 54);
LMG2L["TextButton_c"]["BorderColor3"] = Color3.fromRGB(44, 193, 154);
LMG2L["TextButton_c"]["Text"] = [[Kill all]];
LMG2L["TextButton_c"]["Style"] = Enum.ButtonStyle.RobloxRoundDropdownButton;
LMG2L["TextButton_c"]["Position"] = UDim2.new(0, 10, 0, 264);
LMG2L["TextButton_c"].MouseButton1Click:Connect(function()
local player = game.Players.LocalPlayer
	local char = player.Character
	local tool
	for i,v in player:GetDescendants() do
		if v.Name == "SyncAPI" then
			tool = v.Parent
		end
	end
	for i,v in game.ReplicatedStorage:GetDescendants() do
		if v.Name == "SyncAPI" then
			tool = v.Parent
		end
	end
	--craaa
	remote = tool.SyncAPI.ServerEndpoint
	function _(args)
		remote:InvokeServer(unpack(args))
	end
	function SetCollision(part,boolean)
		local args = {
			[1] = "SyncCollision",
			[2] = {
				[1] = {
					["Part"] = part,
					["CanCollide"] = boolean
				}
			}
		}
		_(args)
	end
	function SetAnchor(boolean,part)
		local args = {
			[1] = "SyncAnchor",
			[2] = {
				[1] = {
					["Part"] = part,
					["Anchored"] = boolean
				}
			}
		}
		_(args)
	end
	function CreatePart(cf,parent)
		local args = {
			[1] = "CreatePart",
			[2] = "Normal",
			[3] = cf,
			[4] = parent
		}
		_(args)
	end
	function DestroyPart(part)
		local args = {
			[1] = "Remove",
			[2] = {
				[1] = part
			}
		}
		_(args)
	end
	function MovePart(part,cf)
		local args = {
			[1] = "SyncMove",
			[2] = {
				[1] = {
					["Part"] = part,
					["CFrame"] = cf
				}
			}
		}
		_(args)
	end
	function Resize(part,size,cf)
		local args = {
			[1] = "SyncResize",
			[2] = {
				[1] = {
					["Part"] = part,
					["CFrame"] = cf,
					["Size"] = size
				}
			}
		}
		_(args)
	end
	function AddMesh(part)
		local args = {
			[1] = "CreateMeshes",
			[2] = {
				[1] = {
					["Part"] = part
				}
			}
		}
		_(args)
	end

	function SetMesh(part,meshid)
		local args = {
			[1] = "SyncMesh",
			[2] = {
				[1] = {
					["Part"] = part,
					["MeshId"] = "rbxassetid://"..meshid
				}
			}
		}
		_(args)
	end
	function SetTexture(part, texid)
		local args = {
			[1] = "SyncMesh",
			[2] = {
				[1] = {
					["Part"] = part,
					["TextureId"] = "rbxassetid://"..texid
				}
			}
		}
		_(args)
	end
	function SetName(part, stringg)
		local args = {
			[1] = "SetName",
			[2] = {
				[1] = workspace.Part
			},
			[3] = stringg
		}

		_(args)
	end
	function MeshResize(part,size)
		local args = {
			[1] = "SyncMesh",
			[2] = {
				[1] = {
					["Part"] = part,
					["Scale"] = size
				}
			}
		}
		_(args)
	end
	function Weld(part1, part2,lead)
		local args = {
			[1] = "CreateWelds",
			[2] = {
				[1] = part1,
				[2] = part2
			},
			[3] = lead
		}
		_(args)

	end
	function SetLocked(part,boolean)
		local args = {
			[1] = "SetLocked",
			[2] = {
				[1] = part
			},
			[3] = boolean
		}
		_(args)
	end
	function SetTrans(part,int)
		local args = {
			[1] = "SyncMaterial",
			[2] = {
				[1] = {
					["Part"] = part,
					["Transparency"] = int
				}
			}
		}
		_(args)
	end
	function CreateSpotlight(part)
		local args = {
			[1] = "CreateLights",
			[2] = {
				[1] = {
					["Part"] = part,
					["LightType"] = "SpotLight"
				}
			}
		}
		_(args)
	end
	function SyncLighting(part,brightness)
		local args = {
			[1] = "SyncLighting",
			[2] = {
				[1] = {
					["Part"] = part,
					["LightType"] = "SpotLight",
					["Brightness"] = brightness
				}
			}
		}
		_(args)
	end

	function KillAll()
		for i,v in game.Players:GetPlayers() do
			spawn(function()
				SetLocked(v.Character.Head,false)
				DestroyPart(v.Character.Head)
			end)
		end
	end
	KillAll()
	
end)
-- Players.godwhy532.PlayerGui.ScreenGui.Frame.TextButton
LMG2L["TextButton_d"] = Instance.new("TextButton", LMG2L["ScrollingFrame_5"]);
LMG2L["TextButton_d"]["BorderSizePixel"] = 0;
LMG2L["TextButton_d"]["TextSize"] = 28;
LMG2L["TextButton_d"]["BackgroundColor3"] = Color3.fromRGB(151, 64, 255);
LMG2L["TextButton_d"]["FontFace"] = Font.new([[rbxasset://fonts/families/BuilderSans.json]], Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal);

LMG2L["TextButton_d"]["Size"] = UDim2.new(0, 510, 0, 54);
LMG2L["TextButton_d"]["BorderColor3"] = Color3.fromRGB(44, 193, 154);
LMG2L["TextButton_d"]["Text"] = [[hint message]];
LMG2L["TextButton_d"]["Style"] = Enum.ButtonStyle.RobloxRoundDropdownButton;
LMG2L["TextButton_d"]["Position"] = UDim2.new(0, 10, 0, 328);
LMG2L["TextButton_d"].MouseButton1Click:Connect(function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommand

	RequestCommand:InvokeServer(";serverMessage Rob45 is here to destroy")
	RequestCommand:InvokeServer(";serverHint team.Rob45 join today!")

end)
-- Players.godwhy532.PlayerGui.ScreenGui.Frame.TextButton
LMG2L["TextButton_e"] = Instance.new("TextButton", LMG2L["ScrollingFrame_5"]);
LMG2L["TextButton_e"]["BorderSizePixel"] = 0;
LMG2L["TextButton_e"]["TextSize"] = 28;
LMG2L["TextButton_e"]["BackgroundColor3"] = Color3.fromRGB(151, 64, 255);
LMG2L["TextButton_e"]["FontFace"] = Font.new([[rbxasset://fonts/families/BuilderSans.json]], Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal);

LMG2L["TextButton_e"]["Size"] = UDim2.new(0, 510, 0, 54);
LMG2L["TextButton_e"]["BorderColor3"] = Color3.fromRGB(44, 193, 154);
LMG2L["TextButton_e"]["Text"] = [[fuck part]];
LMG2L["TextButton_e"]["Style"] = Enum.ButtonStyle.RobloxRoundDropdownButton;
LMG2L["TextButton_e"]["Position"] = UDim2.new(0, 10, 0, 392);
LMG2L["TextButton_e"].MouseButton1Click:Connect(function()
local player = game.Players.LocalPlayer
		local char = player.Character
		local tool
		for i,v in player:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
		for i,v in game.ReplicatedStorage:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
		remote = tool.SyncAPI.ServerEndpoint
		function _(args)
			remote:InvokeServer(unpack(args))
		end
		function SetCollision(part,boolean)
			local args = {
				[1] = "SyncCollision",
				[2] = {
					[1] = {
						["Part"] = part,
						["CanCollide"] = boolean
					}
				}
			}
			_(args)
		end
		function SetAnchor(boolean,part)
			local args = {
				[1] = "SyncAnchor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Anchored"] = boolean
					}
				}
			}
			_(args)
		end
		function CreatePart(cf,parent)
			local args = {
				[1] = "CreatePart",
				[2] = "Normal",
				[3] = cf,
				[4] = parent
			}
			_(args)
		end
		function DestroyPart(part)
			local args = {
				[1] = "Remove",
				[2] = {
					[1] = part
				}
			}
			_(args)
		end
		function MovePart(part,cf)
			local args = {
				[1] = "SyncMove",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf
					}
				}
			}
			_(args)
		end
		function Resize(part,size,cf)
			local args = {
				[1] = "SyncResize",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf,
						["Size"] = size
					}
				}
			}
			_(args)
		end
		function AddMesh(part)
			local args = {
				[1] = "CreateMeshes",
				[2] = {
					[1] = {
						["Part"] = part
					}
				}
			}
			_(args)
		end
	
		function SetMesh(part,meshid)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["MeshId"] = "rbxassetid://"..meshid
					}
				}
			}
			_(args)
		end
		function SetTexture(part, texid)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["TextureId"] = "rbxassetid://"..texid
					}
				}
			}
			_(args)
		end
		function SetName(part, stringg)
			local args = {
				[1] = "SetName",
				[2] = {
					[1] = part
				},
				[3] = stringg
			}
	
			_(args)
		end
		function MeshResize(part,size)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["Scale"] = size
					}
				}
			}
			_(args)
		end
		function Weld(part1, part2,lead)
			local args = {
				[1] = "CreateWelds",
				[2] = {
					[1] = part1,
					[2] = part2
				},
				[3] = lead
			}
			_(args)
	
		end
		function SetLocked(part,boolean)
			local args = {
				[1] = "SetLocked",
				[2] = {
					[1] = part
				},
				[3] = boolean
			}
			_(args)
		end
		function SetTrans(part,int)
			local args = {
				[1] = "SyncMaterial",
				[2] = {
					[1] = {
						["Part"] = part,
						["Transparency"] = int
					}
				}
			}
			_(args)
		end
		function CreateSpotlight(part)
			local args = {
				[1] = "CreateLights",
				[2] = {
					[1] = {
						["Part"] = part,
						["LightType"] = "SpotLight"
					}
				}
			}
			_(args)
		end
		function SyncLighting(part,brightness)
			local args = {
				[1] = "SyncLighting",
				[2] = {
					[1] = {
						["Part"] = part,
						["LightType"] = "SpotLight",
						["Brightness"] = brightness
					}
				}
			}
			_(args)
		end
		function Color(part,color)
			local args = {
				[1] = "SyncColor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Color"] = color --[[Color3]],
						["UnionColoring"] = false
					}
				}
			}
			_(args)
		end
	
	
		function randomise()
			for i,v in game.Workspace:GetDescendants() do
				if v:IsA("BasePart") then
					spawn(function()
						SetLocked(v,false)
						MovePart(v,v.CFrame * CFrame.Angles(math.random(0,1), math.random(0,1), math.random(0,1)))
					end)
				end
			end
		end
		randomise()
		
end)
-- Players.godwhy532.PlayerGui.ScreenGui.Frame.TextButton
LMG2L["TextButton_f"] = Instance.new("TextButton", LMG2L["ScrollingFrame_5"]);
LMG2L["TextButton_f"]["BorderSizePixel"] = 0;
LMG2L["TextButton_f"]["TextSize"] = 28;
LMG2L["TextButton_f"]["BackgroundColor3"] = Color3.fromRGB(151, 64, 255);
LMG2L["TextButton_f"]["FontFace"] = Font.new([[rbxasset://fonts/families/BuilderSans.json]], Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal);

LMG2L["TextButton_f"]["Size"] = UDim2.new(0, 510, 0, 54);
LMG2L["TextButton_f"]["BorderColor3"] = Color3.fromRGB(44, 193, 154);
LMG2L["TextButton_f"]["Text"] = [[troll rain]];
LMG2L["TextButton_f"]["Style"] = Enum.ButtonStyle.RobloxRoundDropdownButton;
LMG2L["TextButton_f"]["Position"] = UDim2.new(0, 10, 0, 456);
LMG2L["TextButton_f"].MouseButton1Click:Connect(function()
local player = game.Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local tool

	for i, v in player:GetDescendants() do
		if v.Name == "SyncAPI" then
			tool = v.Parent
		end
	end

	for i, v in game.ReplicatedStorage:GetDescendants() do
		if v.Name == "SyncAPI" then
			tool = v.Parent
		end
	end

	local remote = tool.SyncAPI.ServerEndpoint

	function _(args)
		remote:InvokeServer(unpack(args))
	end

	function SetCollision(part, boolean)
		local args = {
			[1] = "SyncCollision",
			[2] = {
				[1] = {
					["Part"] = part,
					["CanCollide"] = boolean
				}
			}
		}
		_(args)
	end

	function SetAnchor(boolean, part)
		local args = {
			[1] = "SyncAnchor",
			[2] = {
				[1] = {
					["Part"] = part,
					["Anchored"] = boolean
				}
			}
		}
		_(args)
	end

	function CreatePart(cf)
		local args = {
			[1] = "CreatePart",
			[2] = "Normal",
			[3] = cf,
			[4] = workspace
		}
		_(args)
	end

	function Resize(part, size, cf)
		local args = {
			[1] = "SyncResize",
			[2] = {
				[1] = {
					["Part"] = part,
					["CFrame"] = cf,
					["Size"] = size
				}
			}
		}
		_(args)
	end

	function AddMesh(part)
		local args = {
			[1] = "CreateMeshes",
			[2] = {
				[1] = {
					["Part"] = part
				}
			}
		}
		_(args)
	end

	function SetMesh(part, meshid)
		local args = {
			[1] = "SyncMesh",
			[2] = {
				[1] = {
					["Part"] = part,
					["MeshId"] = "rbxassetid://" .. meshid
				}
			}
		}
		_(args)
	end

	function SetTexture(part, texid)
		local args = {
			[1] = "SyncMesh",
			[2] = {
				[1] = {
					["Part"] = part,
					["TextureId"] = "rbxassetid://" .. texid
				}
			}
		}
		_(args)
	end

	function MeshResize(part, size)
		local args = {
			[1] = "SyncMesh",
			[2] = {
				[1] = {
					["Part"] = part,
					["Scale"] = size
				}
			}
		}
		_(args)
	end

	function SetName(part, stringg)
		local args = {
			[1] = "SetName",
			[2] = {
				[1] = workspace.Part
			},
			[3] = stringg
		}
		_(args)
	end

	function Sky(id)
		local hrp = char:WaitForChild("HumanoidRootPart")
		local cf = hrp.CFrame
		CreatePart(CFrame.new(cf.Position + Vector3.new(0, 6, 0)))
		for _, v in workspace:GetDescendants() do
			if v:IsA("BasePart") and v.CFrame.Position == cf.Position + Vector3.new(0, 6, 0) then
				SetAnchor(true, v)
				AddMesh(v)
				SetMesh(v, "14832966960")
				SetTexture(v, id)
				MeshResize(v, Vector3.new(0, 0, 0))
			end
		end
	end

	local function createRainToads()
		while true do
			wait(0.01) -- Here they change the appearance time of the Toads or other meshes
			if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
				local hrpcf = player.Character.HumanoidRootPart.CFrame
				local x = hrpcf.x
				local z = hrpcf.z
				local randint = math.random(-600, 600)
				local randint2 = math.random(-600, 600)
				local xloc = randint + x
				local zloc = randint2 + z
				local cf = player.Character.HumanoidRootPart.CFrame.y + 400

				spawn(function()
					local newToad = CreatePart(CFrame.new(math.floor(xloc), math.random(cf, cf + 400), math.floor(zloc)))
					for i, v in game.Workspace:GetDescendants() do
						if v.Name == "Part" and v.Parent == workspace and v.CFrame.x == math.floor(xloc) and v.CFrame.z == math.floor(zloc) then
							SetName(v, "Get trolled u fagz") -- Here the name of the toad changes
							SetAnchor(false, v)
							AddMesh(v)
							Resize(v, Vector3.new(50, 50, 30), v.CFrame)
							MeshResize(v, Vector3.new(15, 15, 15))
							SetMesh(v, "9403473283") -- Here put it A custom mesh
							SetTexture(v, "9403473396") -- X2
							SetCollision(v, true)
							v.Orientation = Vector3.new(0, 0, 0)

							v.CFrame = v.CFrame + Vector3.new(0, 0, 0)

							local sound = Instance.new("Sound", v)
							sound.SoundId = "rbxassetid://132893898645050" -- Here the noise or another sound To the toads or other things It works when they appear 
							sound.Volume = 0
							sound.PlayOnRemove = true
							sound:Destroy()
						end
					end
				end)
			else
				wait(1)
			end
		end
	end

	coroutine.wrap(createRainToads)()

	Sky("95921788891849") -- Here they change the skybox id
	
end)
-- Players.godwhy532.PlayerGui.ScreenGui.Frame.TextButton
LMG2L["TextButton_10"] = Instance.new("TextButton", LMG2L["ScrollingFrame_5"]);
LMG2L["TextButton_10"]["BorderSizePixel"] = 0;
LMG2L["TextButton_10"]["TextSize"] = 28;
LMG2L["TextButton_10"]["BackgroundColor3"] = Color3.fromRGB(151, 64, 255);
LMG2L["TextButton_10"]["FontFace"] = Font.new([[rbxasset://fonts/families/BuilderSans.json]], Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal);

LMG2L["TextButton_10"]["Size"] = UDim2.new(0, 510, 0, 54);
LMG2L["TextButton_10"]["BorderColor3"] = Color3.fromRGB(44, 193, 154);
LMG2L["TextButton_10"]["Text"] = [[disco]];
LMG2L["TextButton_10"]["Style"] = Enum.ButtonStyle.RobloxRoundDropdownButton;
LMG2L["TextButton_10"]["Position"] = UDim2.new(0, 10, 0, 520);
LMG2L["TextButton_10"].MouseButton1Click:Connect(function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommand

	RequestCommand:InvokeServer(";disco")
	RequestCommand:InvokeServer(";fog 07")

end)
-- Players.godwhy532.PlayerGui.ScreenGui.Frame.TextButton
LMG2L["TextButton_11"] = Instance.new("TextButton", LMG2L["ScrollingFrame_5"]);
LMG2L["TextButton_11"]["BorderSizePixel"] = 0;
LMG2L["TextButton_11"]["TextSize"] = 28;
LMG2L["TextButton_11"]["BackgroundColor3"] = Color3.fromRGB(151, 64, 255);
LMG2L["TextButton_11"]["FontFace"] = Font.new([[rbxasset://fonts/families/BuilderSans.json]], Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal);

LMG2L["TextButton_11"]["Size"] = UDim2.new(0, 510, 0, 54);
LMG2L["TextButton_11"]["BorderColor3"] = Color3.fromRGB(44, 193, 154);
LMG2L["TextButton_11"]["Text"] = [[chat all]];
LMG2L["TextButton_11"]["Style"] = Enum.ButtonStyle.RobloxRoundDropdownButton;
LMG2L["TextButton_11"]["Position"] = UDim2.new(0, 10, 0, 584);
LMG2L["TextButton_11"].MouseButton1Click:Connect(function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommand

	RequestCommand:InvokeServer(";chat all Rob45 was here!")
	
end)
-- Players.godwhy532.PlayerGui.ScreenGui.Frame.TextButton
LMG2L["TextButton_12"] = Instance.new("TextButton", LMG2L["ScrollingFrame_5"]);
LMG2L["TextButton_12"]["BorderSizePixel"] = 0;
LMG2L["TextButton_12"]["TextSize"] = 28;
LMG2L["TextButton_12"]["BackgroundColor3"] = Color3.fromRGB(151, 64, 255);
LMG2L["TextButton_12"]["FontFace"] = Font.new([[rbxasset://fonts/families/BuilderSans.json]], Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal);

LMG2L["TextButton_12"]["Size"] = UDim2.new(0, 510, 0, 54);
LMG2L["TextButton_12"]["BorderColor3"] = Color3.fromRGB(44, 193, 154);
LMG2L["TextButton_12"]["Text"] = [[mesh all]];
LMG2L["TextButton_12"]["Style"] = Enum.ButtonStyle.RobloxRoundDropdownButton;
LMG2L["TextButton_12"]["Position"] = UDim2.new(0, 10, 0, 648);
LMG2L["TextButton_12"].MouseButton1Click:Connect(function()
local player = game.Players.LocalPlayer
		local char = player.Character
		local backpack = player.Backpack
	
		local function getf3x()
			for _, v in ipairs(backpack:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
			for _, v in ipairs(char:GetChildren()) do
				if v:FindFirstChild("SyncAPI") then
					return v
				end
			end
	
			return nil
		end
	
		-- get all info
	
		local f3x = getf3x()
		if not f3x then
			warn("you dont have f3x skid")
		end
		local syncapi = f3x.SyncAPI
		local serverendpoint = syncapi.ServerEndpoint
	
		local meshTypes = {
			Enum.MeshType.Brick,
			Enum.MeshType.Cylinder,
			Enum.MeshType.FileMesh,
			Enum.MeshType.Head,
			Enum.MeshType.Sphere,
			Enum.MeshType.Wedge
		}
		
		local function makemesh(part)
			local args = {
				[1] = "CreateMeshes",
				[2] = {
					[1] = {
						["Part"] = part
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
	
		local function syncmeshtype(part, type1)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["MeshType"] = type1,
						["Part"] = part
					}
				}
			}
			serverendpoint:InvokeServer(unpack(args))
		end
		
		local randomMeshType = meshTypes[math.random(1, #meshTypes)]
		
		local function applymesh()
			for _, v in ipairs(workspace:GetDescendants()) do
				spawn(function()
					makemesh(v)
					syncmeshtype(v, randomMeshType)
				end)
			end
		end
		
		applymesh()
		
end)
-- Players.godwhy532.PlayerGui.ScreenGui.Frame.TextButton
LMG2L["TextButton_13"] = Instance.new("TextButton", LMG2L["ScrollingFrame_5"]);
LMG2L["TextButton_13"]["BorderSizePixel"] = 0;
LMG2L["TextButton_13"]["TextSize"] = 28;
LMG2L["TextButton_13"]["BackgroundColor3"] = Color3.fromRGB(151, 64, 255);
LMG2L["TextButton_13"]["FontFace"] = Font.new([[rbxasset://fonts/families/BuilderSans.json]], Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal);

LMG2L["TextButton_13"]["Size"] = UDim2.new(0, 510, 0, 54);
LMG2L["TextButton_13"]["BorderColor3"] = Color3.fromRGB(44, 193, 154);
LMG2L["TextButton_13"]["Text"] = [[face all]];
LMG2L["TextButton_13"]["Style"] = Enum.ButtonStyle.RobloxRoundDropdownButton;
LMG2L["TextButton_13"]["Position"] = UDim2.new(0, 10, 0, 712);
LMG2L["TextButton_13"].MouseButton1Click:Connect(function()
local success, errorMessage = pcall(function()
		local player = game.Players.LocalPlayer
		local char = player.Character or player.CharacterAdded:Wait()
		local tool
		for i,v in player:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
		for i,v in game.ReplicatedStorage:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
		remote = tool.SyncAPI.ServerEndpoint
		function _(args)
			remote:InvokeServer(unpack(args))
		end


		function CreatePart(cf,parent)
			local args = {
				[1] = "CreatePart",
				[2] = "Normal",
				[3] = cf,
				[4] = parent
			}
			_(args)
		end
		function SetName(part, stringg)
			local args = {
				[1] = "SetName",
				[2] = { [1] = part },
				[3] = stringg
			}
			_(args)
		end
		function Resize(part,size,cf)
			local args = {
				[1] = "SyncResize",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf,
						["Size"] = size
					}
				}
			}
			_(args)
		end
		function SetTrans(part,int)
			local args = {
				[1] = "SyncMaterial",
				[2] = {
					[1] = {
						["Part"] = part,
						["Transparency"] = int
					}
				}
			}
			_(args)
		end
		function SetAnchor(boolean,part)
			local args = {
				[1] = "SyncAnchor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Anchored"] = boolean
					}
				}
			}
			_(args)
		end


		function SpawnDecal(part,side)
			local args = {
				[1] = "CreateTextures",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = side,
						["TextureType"] = "Decal"
					}
				}
			}
			_(args)
		end
		function AddDecal(part,asset,side)
			local args = {
				[1] = "SyncTexture",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = side,
						["TextureType"] = "Decal",
						["Texture"] = "rbxassetid://".. asset
					}
				}
			}
			_(args)
		end


		function SetCollision(part, boolean)
			local args = {
				[1] = "SyncCollision",
				[2] = {
					[1] = {
						["Part"] = part,
						["CanCollide"] = boolean
					}
				}
			}
			_(args)
		end

		-- ==========================================
		--              配置你的贴纸 ID
		-- ==========================================
		local DECAL_ID = "98398077305252" --ID


		local playerMasks = {}

		for _, p in pairs(game.Players:GetPlayers()) do
			local pChar = p.Character
			if pChar then
				local head = pChar:FindFirstChild("Head")
				if head and head:IsA("BasePart") then


					local faceCFrame = head.CFrame * CFrame.new(0, 0, -0.6) 
					CreatePart(faceCFrame, workspace)

					spawn(function()
						task.wait(0.04)
						for _, newPart in pairs(workspace:GetChildren()) do
							if newPart:IsA("BasePart") and newPart.Name == "Part" and (newPart.Position - faceCFrame.Position).Magnitude < 1.5 then


								SetCollision(newPart, false) 

								SetName(newPart, p.Name .. "_FollowMask")
								Resize(newPart, Vector3.new(2, 2, 0.1), faceCFrame)
								SetTrans(newPart, 1)
								SetAnchor(true, newPart)


								SpawnDecal(newPart, Enum.NormalId.Front)
								task.wait(0.02)
								AddDecal(newPart, DECAL_ID, Enum.NormalId.Front)


								SetCollision(newPart, false)


								playerMasks[p] = newPart
								break
							end
						end
					end)

				end
			end
		end

		spawn(function()
			while true do
				for targetPlayer, maskPart in pairs(playerMasks) do
					if targetPlayer and targetPlayer.Parent and maskPart and maskPart.Parent then
						local pChar = targetPlayer.Character
						if pChar then
							local head = pChar:FindFirstChild("Head")
							if head and pChar:FindFirstChildOfClass("Humanoid") and pChar:FindFirstChildOfClass("Humanoid").Health > 0 then

								local currentFaceCF = head.CFrame * CFrame.new(0, 0, -0.6)


								spawn(function()
									local args = {
										[1] = "SyncMove",
										[2] = {
											[1] = {
												["Part"] = maskPart,
												["CFrame"] = currentFaceCF
											}
										}
									}
									_(args)

									SetCollision(maskPart, false)
								end)

							end
						end
					else
						playerMasks[targetPlayer] = nil
					end
				end

				task.wait(0)
			end
		end)



	end)
	
end)
-- Players.godwhy532.PlayerGui.ScreenGui.Frame.TextButton
LMG2L["TextButton_14"] = Instance.new("TextButton", LMG2L["ScrollingFrame_5"]);
LMG2L["TextButton_14"]["BorderSizePixel"] = 0;
LMG2L["TextButton_14"]["TextSize"] = 28;
LMG2L["TextButton_14"]["BackgroundColor3"] = Color3.fromRGB(151, 64, 255);
LMG2L["TextButton_14"]["FontFace"] = Font.new([[rbxasset://fonts/families/BuilderSans.json]], Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal);

LMG2L["TextButton_14"]["Size"] = UDim2.new(0, 510, 0, 54);
LMG2L["TextButton_14"]["BorderColor3"] = Color3.fromRGB(44, 193, 154);
LMG2L["TextButton_14"]["Text"] = [[Unanchor]];
LMG2L["TextButton_14"]["Style"] = Enum.ButtonStyle.RobloxRoundDropdownButton;
LMG2L["TextButton_14"]["Position"] = UDim2.new(0, 10, 0, 776);
LMG2L["TextButton_14"].MouseButton1Click:Connect(function()
local player = game.Players.LocalPlayer
	local char = player.Character
	local tool
	for i,v in player:GetDescendants() do
		if v.Name == "SyncAPI" then
			tool = v.Parent
		end
	end
	for i,v in game.ReplicatedStorage:GetDescendants() do
		if v.Name == "SyncAPI" then
			tool = v.Parent
		end
	end
	--craaa
	remote = tool.SyncAPI.ServerEndpoint
	function _(args)
		remote:InvokeServer(unpack(args))
	end
	function SetCollision(part,boolean)
		local args = {
			[1] = "SyncCollision",
			[2] = {
				[1] = {
					["Part"] = part,
					["CanCollide"] = boolean
				}
			}
		}
		_(args)
	end
	function SetAnchor(boolean,part)
		local args = {
			[1] = "SyncAnchor",
			[2] = {
				[1] = {
					["Part"] = part,
					["Anchored"] = boolean
				}
			}
		}
		_(args)
	end
	function CreatePart(cf,parent)
		local args = {
			[1] = "CreatePart",
			[2] = "Normal",
			[3] = cf,
			[4] = parent
		}
		_(args)
	end
	function DestroyPart(part)
		local args = {
			[1] = "Remove",
			[2] = {
				[1] = part
			}
		}
		_(args)
	end
	function MovePart(part,cf)
		local args = {
			[1] = "SyncMove",
			[2] = {
				[1] = {
					["Part"] = part,
					["CFrame"] = cf
				}
			}
		}
		_(args)
	end
	function Resize(part,size,cf)
		local args = {
			[1] = "SyncResize",
			[2] = {
				[1] = {
					["Part"] = part,
					["CFrame"] = cf,
					["Size"] = size
				}
			}
		}
		_(args)
	end
	function AddMesh(part)
		local args = {
			[1] = "CreateMeshes",
			[2] = {
				[1] = {
					["Part"] = part
				}
			}
		}
		_(args)
	end

	function SetMesh(part,meshid)
		local args = {
			[1] = "SyncMesh",
			[2] = {
				[1] = {
					["Part"] = part,
					["MeshId"] = "rbxassetid://"..meshid
				}
			}
		}
		_(args)
	end
	function SetTexture(part, texid)
		local args = {
			[1] = "SyncMesh",
			[2] = {
				[1] = {
					["Part"] = part,
					["TextureId"] = "rbxassetid://"..texid
				}
			}
		}
		_(args)
	end
	function SetName(part, stringg)
		local args = {
			[1] = "SetName",
			[2] = {
				[1] = workspace.Part
			},
			[3] = stringg
		}

		_(args)
	end
	function MeshResize(part,size)
		local args = {
			[1] = "SyncMesh",
			[2] = {
				[1] = {
					["Part"] = part,
					["Scale"] = size
				}
			}
		}
		_(args)
	end
	function Weld(part1, part2,lead)
		local args = {
			[1] = "CreateWelds",
			[2] = {
				[1] = part1,
				[2] = part2
			},
			[3] = lead
		}
		_(args)

	end
	function SetLocked(part,boolean)
		local args = {
			[1] = "SetLocked",
			[2] = {
				[1] = part
			},
			[3] = boolean
		}
		_(args)
	end
	function SetTrans(part,int)
		local args = {
			[1] = "SyncMaterial",
			[2] = {
				[1] = {
					["Part"] = part,
					["Transparency"] = int
				}
			}
		}
		_(args)
	end
	function CreateSpotlight(part)
		local args = {
			[1] = "CreateLights",
			[2] = {
				[1] = {
					["Part"] = part,
					["LightType"] = "SpotLight"
				}
			}
		}
		_(args)
	end
	function SyncLighting(part,brightness)
		local args = {
			[1] = "SyncLighting",
			[2] = {
				[1] = {
					["Part"] = part,
					["LightType"] = "SpotLight",
					["Brightness"] = brightness
				}
			}
		}
		_(args)
	end

	function Unanchor()
		for i,v in game.Workspace:GetDescendants() do
			spawn(function()
				SetLocked(v,false)
				SetAnchor(false,v)
			end)
		end
	end
	Unanchor()
	
end)
-- Players.godwhy532.PlayerGui.ScreenGui.Frame.TextButton
LMG2L["TextButton_15"] = Instance.new("TextButton", LMG2L["ScrollingFrame_5"]);
LMG2L["TextButton_15"]["BorderSizePixel"] = 0;
LMG2L["TextButton_15"]["TextSize"] = 28;
LMG2L["TextButton_15"]["BackgroundColor3"] = Color3.fromRGB(151, 64, 255);
LMG2L["TextButton_15"]["FontFace"] = Font.new([[rbxasset://fonts/families/BuilderSans.json]], Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal);

LMG2L["TextButton_15"]["Size"] = UDim2.new(0, 510, 0, 54);
LMG2L["TextButton_15"]["BorderColor3"] = Color3.fromRGB(44, 193, 154);
LMG2L["TextButton_15"]["Text"] = [[baseplatel]];
LMG2L["TextButton_15"]["Style"] = Enum.ButtonStyle.RobloxRoundDropdownButton;
LMG2L["TextButton_15"]["Position"] = UDim2.new(0, 10, 0, 840);
LMG2L["TextButton_15"].MouseButton1Click:Connect(function()
local player = game.Players.LocalPlayer
	local char = player.Character
	local tool
	for i,v in player:GetDescendants() do
		if v.Name == "SyncAPI" then
			tool = v.Parent
		end
	end
	for i,v in game.ReplicatedStorage:GetDescendants() do
		if v.Name == "SyncAPI" then
			tool = v.Parent
		end
	end
	--craaa
	remote = tool.SyncAPI.ServerEndpoint
	function _(args)
		remote:InvokeServer(unpack(args))
	end
	function SetCollision(part,boolean)
		local args = {
			[1] = "SyncCollision",
			[2] = {
				[1] = {
					["Part"] = part,
					["CanCollide"] = boolean
				}
			}
		}
		_(args)
	end
	function SetAnchor(boolean,part)
		local args = {
			[1] = "SyncAnchor",
			[2] = {
				[1] = {
					["Part"] = part,
					["Anchored"] = boolean
				}
			}
		}
		_(args)
	end
	function CreatePart(cf,parent,types)
		local args = {
			[1] = "CreatePart",
			[2] = types,
			[3] = cf,
			[4] = parent
		}
		_(args)
	end
	function DestroyPart(part)
		local args = {
			[1] = "Remove",
			[2] = {
				[1] = part
			}
		}
		_(args)
	end
	function MovePart(part,cf)
		local args = {
			[1] = "SyncMove",
			[2] = {
				[1] = {
					["Part"] = part,
					["CFrame"] = cf
				}
			}
		}
		_(args)
	end
	function Resize(part,size,cf)
		local args = {
			[1] = "SyncResize",
			[2] = {
				[1] = {
					["Part"] = part,
					["CFrame"] = cf,
					["Size"] = size
				}
			}
		}
		_(args)
	end
	function AddMesh(part)
		local args = {
			[1] = "CreateMeshes",
			[2] = {
				[1] = {
					["Part"] = part
				}
			}
		}
		_(args)
	end

	function SetMesh(part,meshid)
		local args = {
			[1] = "SyncMesh",
			[2] = {
				[1] = {
					["Part"] = part,
					["MeshId"] = "rbxassetid://"..meshid
				}
			}
		}
		_(args)
	end
	function SetTexture(part, texid)
		local args = {
			[1] = "SyncMesh",
			[2] = {
				[1] = {
					["Part"] = part,
					["TextureId"] = "rbxassetid://"..texid
				}
			}
		}
		_(args)
	end
	function SetName(part, stringg)
		local args = {
			[1] = "SetName",
			[2] = {
				[1] = workspace.Part
			},
			[3] = stringg
		}

		_(args)
	end
	function MeshResize(part,size)
		local args = {
			[1] = "SyncMesh",
			[2] = {
				[1] = {
					["Part"] = part,
					["Scale"] = size
				}
			}
		}
		_(args)
	end
	function Weld(part1, part2,lead)
		local args = {
			[1] = "CreateWelds",
			[2] = {
				[1] = part1,
				[2] = part2
			},
			[3] = lead
		}
		_(args)

	end
	function SetLocked(part,boolean)
		local args = {
			[1] = "SetLocked",
			[2] = {
				[1] = part
			},
			[3] = boolean
		}
		_(args)
	end
	function SetTrans(part,int)
		local args = {
			[1] = "SyncMaterial",
			[2] = {
				[1] = {
					["Part"] = part,
					["Transparency"] = int
				}
			}
		}
		_(args)
	end
	function CreateSpotlight(part)
		local args = {
			[1] = "CreateLights",
			[2] = {
				[1] = {
					["Part"] = part,
					["LightType"] = "SpotLight"
				}
			}
		}
		_(args)
	end
	function SyncLighting(part,brightness)
		local args = {
			[1] = "SyncLighting",
			[2] = {
				[1] = {
					["Part"] = part,
					["LightType"] = "SpotLight",
					["Brightness"] = brightness
				}
			}
		}
		_(args)
	end

	function Material(part,mate)
		local args = {
			[1] = "SyncMaterial",
			[2] = {
				[1] = {
					["Part"] = part,
					["Material"] = mate
				}
			}
		}
		_(args)
	end
	function Color(part,color)
		local args = {
			[1] = "SyncColor",
			[2] = {
				[1] = {
					["Part"] = part,
					["Color"] = color --[[Color3]],
					["UnionColoring"] = false
				}
			}
		}
		_(args)
	end
	function toptexturecreate(part)
		local args = {
			[1] = "CreateTextures",
			[2] = {
				[1] = {
					["Part"] = part,
					["Face"] = Enum.NormalId.Top,
					["TextureType"] = "Texture"
				}
			}
		}

		_(args)
	end
	function toptextureadd(part)
		local args = {
			[1] = "SyncTexture",
			[2] = {
				[1] = {
					["Part"] = part,
					["Face"] = Enum.NormalId.Top,
					["TextureType"] = "Texture",
					["Texture"] = "rbxassetid://132893898645050",
					["StudsPerTileV"] = 20,
					["StudsPerTileU"] = 20
				}
			}
		}
		_(args)
	end
	hrpx = math.floor(char.HumanoidRootPart.CFrame.x)
	hrpz = math.floor(char.HumanoidRootPart.CFrame.z)
	hrpy = math.floor(char.HumanoidRootPart.CFrame.y)
	function SpawnBasePlate()
		CreatePart(CFrame.new(hrpx,hrpy-20,hrpz),workspace,"Spawn")
		for i,v in game.Workspace:GetChildren() do
			if v:IsA("BasePart") and v.CFrame.y == hrpy - 20 and v.CFrame.x == hrpx then
				spawn(function()
					Resize(v,Vector3.new(1000,2,1000),CFrame.new(hrpx,hrpy-20,hrpz))
					Color(v,Color3.fromRGB(0,0,0))
					toptexturecreate(v)
					toptextureadd(v)
					while wait(1) do
						pcall(function()SetLocked(v,true)end)
					end
				end)
			end
		end
	end
	SpawnBasePlate()

end)
-- Players.godwhy532.PlayerGui.ScreenGui.Frame.TextButton
LMG2L["TextButton_16"] = Instance.new("TextButton", LMG2L["ScrollingFrame_5"]);
LMG2L["TextButton_16"]["BorderSizePixel"] = 0;
LMG2L["TextButton_16"]["TextSize"] = 28;
LMG2L["TextButton_16"]["BackgroundColor3"] = Color3.fromRGB(151, 64, 255);
LMG2L["TextButton_16"]["FontFace"] = Font.new([[rbxasset://fonts/families/BuilderSans.json]], Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal);

LMG2L["TextButton_16"]["Size"] = UDim2.new(0, 510, 0, 54);
LMG2L["TextButton_16"]["BorderColor3"] = Color3.fromRGB(44, 193, 154);
LMG2L["TextButton_16"]["Text"] = [[notice all]];
LMG2L["TextButton_16"]["Style"] = Enum.ButtonStyle.RobloxRoundDropdownButton;
LMG2L["TextButton_16"]["Position"] = UDim2.new(0, 10, 0, 904);
LMG2L["TextButton_16"].MouseButton1Click:Connect(function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommand

	RequestCommand:InvokeServer(";notice all Rob45 was here!1")
	
end)
-- Players.godwhy532.PlayerGui.ScreenGui.Frame.TextButton
LMG2L["TextButton_17"] = Instance.new("TextButton", LMG2L["ScrollingFrame_5"]);
LMG2L["TextButton_17"]["BorderSizePixel"] = 0;
LMG2L["TextButton_17"]["TextSize"] = 28;
LMG2L["TextButton_17"]["BackgroundColor3"] = Color3.fromRGB(151, 64, 255);
LMG2L["TextButton_17"]["FontFace"] = Font.new([[rbxasset://fonts/families/BuilderSans.json]], Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal);

LMG2L["TextButton_17"]["Size"] = UDim2.new(0, 510, 0, 54);
LMG2L["TextButton_17"]["BorderColor3"] = Color3.fromRGB(44, 193, 154);
LMG2L["TextButton_17"]["Text"] = [[realm]];
LMG2L["TextButton_17"]["Style"] = Enum.ButtonStyle.RobloxRoundDropdownButton;
LMG2L["TextButton_17"]["Position"] = UDim2.new(0, 10, 0, 968);
LMG2L["TextButton_17"].MouseButton1Click:Connect(function()
--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	RequestCommand:InvokeServer(";btools me")
	wait(0.4)
	RequestCommand:InvokeServer(";punish all")
	wait(0.1)
	local player = game.Players.LocalPlayer
	local char = player.Character
	local backpack = player.Backpack

	local function getf3x()
		for _, v in ipairs(backpack:GetChildren()) do
			if v:FindFirstChild("SyncAPI") then
				return v
			end
		end
		for _, v in ipairs(char:GetChildren()) do
			if v:FindFirstChild("SyncAPI") then
				return v
			end
		end

		return nil
	end
	local f3x = getf3x()
	if not f3x then
		warn("you dont have f3x skid")
	end
	local syncapi = f3x.SyncAPI
	local serverendpoint = syncapi.ServerEndpoint

	local function delete(part)
		local args = {
			[1] = "Remove",
			[2] = {
				[1] = part
			}
		}
		serverendpoint:InvokeServer(unpack(args))
	end

	local function deleteall()
		for _, v in ipairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") or v:IsA("UnionOperation") then
				spawn(function()
					delete(v)
				end)
			end
		end
	end

	deleteall()

	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	RequestCommand:InvokeServer(";fogcolor black ;time")
	local player = game.Players.LocalPlayer
	local char = player.Character
	local backpack = player.Backpack

	local function getf3x()
		for _, v in ipairs(backpack:GetChildren()) do
			if v:FindFirstChild("SyncAPI") then
				return v
			end
		end
		for _, v in ipairs(char:GetChildren()) do
			if v:FindFirstChild("SyncAPI") then
				return v
			end
		end

		return nil
	end
	local f3x = getf3x()
	if not f3x then
		warn("you dont have f3x skid")
	end
	local syncapi = f3x.SyncAPI
	local serverendpoint = syncapi.ServerEndpoint

	local function resize(part,size,cf)
		local args = {
			[1] = "SyncResize",
			[2] = {
				[1] = {
					["Part"] = part,
					["CFrame"] = cf,
					["Size"] = size
				}
			}
		}
		serverendpoint:InvokeServer(unpack(args))
	end

	local function syncmaterial(part,mate,trans)
		local args = {
			[1] = "SyncMaterial",
			[2] = {
				[1] = {
					["Part"] = part,
					["Material"] = mate
				}
			}
		}
		serverendpoint:InvokeServer(unpack(args))
	end
	local function transparency(part,trans)
		local args = {
			[1] = "SyncMaterial",
			[2] = {
				[1] = {
					["Part"] = part,
					["Transparency"] = trans
				}
			}
		}
		serverendpoint:InvokeServer(unpack(args))
	end

	local function color(part, color)
		local args = {
			[1] = "SyncColor",
			[2] = {
				[1] = {
					["Part"] = part,
					["Color"] = color --[[Color3]],
					["UnionColoring"] = false
				}
			}
		}
		serverendpoint:InvokeServer(unpack(args))
	end

	local function syncmeshid(part, id)
		local args = {
			[1] = "SyncMesh",
			[2] = {
				[1] = {
					["Part"] = part,
					["MeshId"] = "rbxassetid://"..id
				}
			}
		}
		serverendpoint:InvokeServer(unpack(args))
	end

	local function makemesh(part)
		local args = {
			[1] = "CreateMeshes",
			[2] = {
				[1] = {
					["Part"] = part
				}
			}
		}
		serverendpoint:InvokeServer(unpack(args))
	end

	local function syncmeshsize(part, vectora)
		local args = {
			[1] = "SyncMesh",
			[2] = {
				[1] = {
					["Part"] = part,
					["Scale"] = vectora
				}
			}
		}
		serverendpoint:InvokeServer(unpack(args))
	end

	local function syncmeshtexture(part, id)
		local args = {
			[1] = "SyncMesh",
			[2] = {
				[1] = {
					["Part"] = part,
					["TextureId"] =	"rbxassetid://"..id
				}
			}
		}
		serverendpoint:InvokeServer(unpack(args))
	end

	local function name(part, stringa)
		local args = {
			[1] = "SetName",
			[2] = {
				[1] = part
			},
			[3] = stringa
		}
		serverendpoint:InvokeServer(unpack(args))
	end

	local function lock(part, boolean)
		local args = {
			[1] = "SetLocked",
			[2] = {
				[1] = part
			},
			[3] = boolean
		}
		serverendpoint:InvokeServer(unpack(args))
	end

	local function setcollision(part, booleana)
		local args = {
			[1] = "SyncCollision",
			[2] = {
				[1] = {
					["Part"] = part,
					["CanCollide"] = booleana
				}
			}
		}
		serverendpoint:InvokeServer(unpack(args))
	end

	local function setanchor(part, boolean)
		local args = {
			[1] = "SyncAnchor",
			[2] = {
				[1] = {
					["Part"] = part,
					["Anchored"] = boolean
				}
			}
		}
		serverendpoint:InvokeServer(unpack(args))
	end

	local function createdecal(part, side)
		local args = {
			[1] = "CreateTextures",
			[2] = {
				[1] = {
					["Part"] = part,
					["Face"] = side,
					["TextureType"] = "Decal"
				}
			}
		}
		serverendpoint:InvokeServer(unpack(args))
	end
	local function setdecal(part, asset, side)
		local args = {
			[1] = "SyncTexture",
			[2] = {
				[1] = {
					["Part"] = part,
					["Face"] = side,
					["TextureType"] = "Decal",
					["Texture"] = "rbxassetid://".. asset
				}
			}
		}
		serverendpoint:InvokeServer(unpack(args))
	end

	local function makerealmbase()
		local position = CFrame.new(0, 5, 0)
		local base = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)
		resize(base, Vector3.new(512, 16, 512), position)
		syncmaterial(base, Enum.Material.Concrete)
		color(base, Color3.new(0.513725, 0.513725, 0.513725))
		name(base, "loltroll")
		lock(base, true)

		local spawnpos = CFrame.new(34.5, 8.1, -26)
		local spawna = serverendpoint:InvokeServer("CreatePart", "Spawn", spawnpos, workspace)
		resize(spawna, Vector3.new(20, 10, 20), spawnpos)
		name(spawna, "SpawnLocation")
		lock(spawna, true)

		createdecal(spawna, Enum.NormalId.Top)
		setdecal(spawna, "98398077305252", Enum.NormalId.Top) -- ganti decalnya pake decal lu
		transparency(spawna, 1)

		local pos = CFrame.new(74.143, 24, -25.232)

		local rules = serverendpoint:InvokeServer("CreatePart", "Normal", pos, workspace)

		transparency(rules, 0)
		setcollision(rules, false)
		createdecal(rules, Enum.NormalId.Left)
		setdecal(rules, "98398077305252", Enum.NormalId.Left)
		color(rules, Color3.new(1, 1, 1))
		resize(rules, Vector3.new(4, 23, 37), pos)


		local pos = CFrame.new(1.143, 24, -25.232)

		local bad = serverendpoint:InvokeServer("CreatePart", "Normal", pos, workspace)

		transparency(bad, 1)
		setcollision(bad, false)
		createdecal(bad, Enum.NormalId.Right)
		setdecal(bad, "98398077305252", Enum.NormalId.Right)
		resize(bad, Vector3.new(4, 23, 37), pos)

	end

	local function sky()
		local position = CFrame.new(0, 5, 0)
		local sky = serverendpoint:InvokeServer("CreatePart", "Normal", position, workspace)

		makemesh(sky)
		syncmeshid(sky, "98398077305252")
		syncmeshtexture(sky, "98398077305252")
		syncmeshsize(sky, Vector3.new(10000, 10000, 10000))
		lock(sky, true)
		name(sky, "riposku")
		setcollision(sky, false)
	end





	local function unanchorall()
		for _, v in ipairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") or v:IsA("UnionOperation") then
				spawn(function()
					setanchor(v, false)
				end)
			end
		end
	end

	local function realm()
		sky()
		makerealmbase()
	end

	realm()

	RequestCommand:InvokeServer(";res all")
	wait(0.3)
	RequestCommand:InvokeServer(";r6 all")
	RequestCommand:InvokeServer(";time 14")
	wait(0.7)
	RequestCommand:InvokeServer(";music 106854483888506 ;volume inf  ;savemap ;char all Rob45")
RequestCommand:InvokeServer(";alert all hacked? L?")
RequestCommand:InvokeServer(";m now you gonna cry about it? muhahaha hacked server")
RequestCommand:InvokeServer(";h rip game rip server you got hacked")
RequestCommand:InvokeServer(";sm NOOBS EZ HACKED WELCOME TO Rob45 REALM MUAHAHAH")
RequestCommand:InvokeServer(";h haxxed")
RequestCommand:InvokeServer(";m this game is ruined by me so it cool my realm is cool yes or not?")
RequestCommand:InvokeServer(";m Rob45")
RequestCommand:InvokeServer(";h Rob45")
RequestCommand:InvokeServer(";m Do you think you can escape from U.N.,?")
RequestCommand:InvokeServer(";M Rob45")
RequestCommand:InvokeServer(";sm Unethical_Network3: hahaha")
RequestCommand:InvokeServer(";M Rob45Rob45Rob45")
RequestCommand:InvokeServer(";SM Rob45")
RequestCommand:InvokeServer(";alert all SUCCESSFULY HACKED SERVER")
RequestCommand:InvokeServer(";systemmessage Rob45")
RequestCommand:InvokeServer(";m Rob45")
RequestCommand:InvokeServer(";M hacker BY Rob45")
RequestCommand:InvokeServer(";SM FE BYPASSED BY U.N. LOL")
RequestCommand:InvokeServer(";M L HACKED NOOBS?")
RequestCommand:InvokeServer(";FIRE ALL")
RequestCommand:InvokeServer(";EXPLODE OTHERS")
RequestCommand:InvokeServer(";M ALLAHU AKBAR")
RequestCommand:InvokeServer(";M GOT FE BYPASSED LOL")
RequestCommand:InvokeServer(";SM ALRIGHT CHANGING MUSIC")
RequestCommand:InvokeServer(";MUSIC 99695831392938  ;VOLUME INF")

end)

--[[
    UI 重排：小型竖版 + 可拖动 + 两列按钮 + 上下滚动
    只调整界面，不改动原按钮点击功能。
]]
do
    local UIS = game:GetService("UserInputService")
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    local frame = LMG2L["Frame_2"]
    local title = LMG2L["TextBox_6"]
    local scroll = LMG2L["ScrollingFrame_5"]
    local oldImage = LMG2L["ImageLabel_4"]

    -- 删除原来的背景图片，避免遮挡/占空间
    if oldImage then
        oldImage:Destroy()
    end

    -- 小型竖版窗口
    frame.Size = UDim2.new(0, 400, 0, 520)
    frame.Position = UDim2.new(0, 20, 0, 100)
    frame.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    frame.BorderSizePixel = 2
    frame.ClipsDescendants = true

    -- 标题
    title.Size = UDim2.new(0, 380, 0, 46)
    title.Position = UDim2.new(0, 10, 0, 8)
    title.TextSize = 25
    title.BackgroundColor3 = Color3.fromRGB(11, 27, 8)
    title.TextColor3 = Color3.fromRGB(180, 255, 190)
    title.ZIndex = 5

    -- 功能滚动区域
    scroll.Size = UDim2.new(0, 380, 0, 452)
    scroll.Position = UDim2.new(0, 10, 0, 60)
    scroll.BackgroundColor3 = Color3.fromRGB(28, 29, 28)
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 6
    scroll.ScrollingDirection = Enum.ScrollingDirection.Y
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.ScrollingEnabled = true
    scroll.ClipsDescendants = true

    -- 两列排列
    local grid = scroll:FindFirstChild("Rob45Grid")
    if grid then grid:Destroy() end
    grid = Instance.new("UIGridLayout")
    grid.Name = "Rob45Grid"
    grid.Parent = scroll
    grid.CellSize = UDim2.new(0, 180, 0, 48)
    grid.CellPadding = UDim2.new(0, 8, 0, 8)
    grid.FillDirection = Enum.FillDirection.Horizontal
    grid.FillDirectionMaxCells = 2
    grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
    grid.VerticalAlignment = Enum.VerticalAlignment.Top
    grid.SortOrder = Enum.SortOrder.LayoutOrder

    local buttons = {}
    for _, child in ipairs(scroll:GetChildren()) do
        if child:IsA("TextButton") then
            table.insert(buttons, child)
        end
    end

    -- 按原来的上下顺序排列，每排两个
    table.sort(buttons, function(a, b)
        local ay = a.Position.Y.Offset
        local by = b.Position.Y.Offset
        return ay < by
    end)

    for i, button in ipairs(buttons) do
        button.LayoutOrder = i
        button.Size = UDim2.new(0, 180, 0, 48)
        button.Position = UDim2.new(0, 0, 0, 0)
        button.TextSize = 20
        button.AutoButtonColor = true
    end

    -- 内容不足时保留一点底部空间
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)

    -- 只允许通过标题拖动窗口，避免和滚动手势冲突
    local dragging = false
    local dragStart
    local startPos
    local dragInput

    local function updateDrag(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end

    title.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    title.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateDrag(input)
        end
    end)
end

return LMG2L["ScreenGui_1"], require;