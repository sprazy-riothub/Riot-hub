# Riot-hub
-- 🔥 Riot-hub for Steal a Brainrot (2026) - Optimized for Delta Executor
-- GitHub: https://github.com/YOURUSERNAME/Riot-hub
-- Features: Auto Steal + Steal Boost, Auto Duel, Infinite Jump, Speed Boost

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

print("🚀 Riot-hub loaded for Steal a Brainrot! | Delta Executor")

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RiotHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 420, 0, 400)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(255, 50, 150)
Title.Text = "🔥 RIOT-HUB - Steal a Brainrot"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -45, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.TextScaled = true
CloseBtn.Parent = MainFrame
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Variables
local autoStealEnabled = false
local stealBoostSpeed = 0.2   -- Lower = faster steal boost (0.1 is very aggressive)
local autoDuelEnabled = false
local infiniteJumpEnabled = false
local speedBoostValue = 50

local yOffset = 60

local function CreateToggle(name, defaultText, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.9, 0, 0, 45)
    Btn.Position = UDim2.new(0.05, 0, 0, yOffset)
    Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    Btn.Text = name .. " " .. defaultText
    Btn.TextColor3 = Color3.new(1,1,1)
    Btn.TextScaled = true
    Btn.Font = Enum.Font.Gotham
    Btn.Parent = MainFrame
    
    local enabled = false
    Btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        Btn.Text = name .. (enabled and " [ON]" or " [OFF]")
        Btn.BackgroundColor3 = enabled and Color3.fromRGB(0, 170, 100) or Color3.fromRGB(45, 45, 60)
        callback(enabled)
    end)
    
    yOffset = yOffset + 55
    return Btn
end

-- Auto Steal with Steal Boost setting
CreateToggle("Auto Steal", "[OFF]", function(state)
    autoStealEnabled = state
    if state then
        spawn(function()
            while autoStealEnabled and Character and Character.Parent do
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("Model") and (obj:FindFirstChild("Brainrot") or string.find(obj.Name:lower(), "brainrot")) then
                        if obj:FindFirstChild("ProximityPrompt") then
                            fireproximityprompt(obj.ProximityPrompt)
                        end
                    end
                end
                wait(stealBoostSpeed)  -- Steal Boost controls this delay
            end
        end)
    end
end)

-- Steal Boost Settings (simple toggle for Fast / Normal)
CreateToggle("Steal Boost (Fast)", "[OFF]", function(state)
    if state then
        stealBoostSpeed = 0.1   -- Very fast
        print("Steal Boost: FAST mode (0.1s)")
    else
        stealBoostSpeed = 0.3   -- Normal
        print("Steal Boost: Normal mode (0.3s)")
    end
end)

-- Auto Duel
CreateToggle("Auto Duel", "[OFF]", function(state)
    autoDuelEnabled = state
    if state then
        spawn(function()
            while autoDuelEnabled do
                -- Basic auto duel logic - fires duel request to nearby players if possible
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and plr.Character then
                        local distance = (plr.Character.HumanoidRootPart.Position - RootPart.Position).Magnitude
                        if distance < 50 then
                            -- Replace with actual duel remote if known, or use proximity/fireclick
                            print("Auto Duel triggered on " .. plr.Name)
                            -- Example: fire remote here if you find the duel remote name
                        end
                    end
                end
                wait(1)
            end
        end)
    end
end)

-- Infinite Jump
CreateToggle("Infinite Jump", "[OFF]", function(state)
    infiniteJumpEnabled = state
    if state then
        UserInputService.JumpRequest:Connect(function()
            if infiniteJumpEnabled and Humanoid then
                Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end)

-- Speed Boost
CreateToggle("Speed Boost", "[OFF]", function(state)
    if state then
        Humanoid.WalkSpeed = speedBoostValue
        print("Speed Boost ON: " .. speedBoostValue)
    else
        Humanoid.WalkSpeed = 16
        print("Speed Boost OFF")
    end
end)

print("✅ Riot-hub GUI loaded for Delta Executor!")
print("Features: Auto Steal + Steal Boost, Auto Duel, Infinite Jump, Speed Boost")

-- Draggable GUI
local dragging = false
local dragStart, startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Re-apply features on respawn
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
    RootPart = newChar:WaitForChild("HumanoidRootPart")
end)
