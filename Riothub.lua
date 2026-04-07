-- Riot-hub for Steal a Brainrot
-- GitHub: https://github.com/YOURUSERNAME/Riot-hub
-- Version: 1.0

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

print("🚀 Riot-hub loaded for Steal a Brainrot!")

-- Simple GUI Hub using Synapse/Fluxus/Krnl style (works with most executors)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RiotHub"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 400, 0, 300)
Frame.Position = UDim2.new(0.5, -200, 0.5, -150)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(255, 0, 100) -- Brainrot pink vibe
Title.Text = "🔥 Riot-hub - Steal a Brainrot"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextScaled = true
Title.Parent = Frame

-- Example Toggle Button
local function createToggle(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, 60 + (#Frame:GetChildren()-2)*50)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Text = name .. " [OFF]"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Parent = Frame
    
    local enabled = false
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        btn.Text = name .. (enabled and " [ON]" or " [OFF]")
        callback(enabled)
    end)
end

-- Add your features here
createToggle("Auto Steal", function(state)
    print("Auto Steal:", state and "Enabled" or "Disabled")
    -- TODO: Add actual auto steal loop here (e.g. find nearby brainrots and claim)
end)

createToggle("Speed Boost", function(state)
    if state then
        LocalPlayer.Character.Humanoid.WalkSpeed = 100
    else
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

createToggle("Noclip", function(state)
    -- Basic noclip example
    if state then
        -- Implement noclip (collision off)
        print("Noclip ON - be careful!")
    end
end)

createToggle("Instant Teleport to Base", function(state)
    if state and LocalPlayer.Character then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0) -- Replace with your base coords
    end
end)

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeBtn.Parent = Frame
closeBtn.MouseButton1Click:Connect(function()
    ScreenGui: Close()
end)

print("✅ Riot-hub GUI ready! Join Steal a Brainrot and execute this script.")
