-- Optional client-side welcome/instructions UI for the Blockwelt port.
-- Place this LocalScript in StarterPlayer > StarterPlayerScripts.
-- Roblox supplies the movement and mobile controls automatically.

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "BlockweltHUD"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

local hint = Instance.new("TextLabel")
hint.Name = "ControlsHint"
hint.AnchorPoint = Vector2.new(0.5, 0)
hint.Position = UDim2.new(0.5, 0, 0, 14)
hint.Size = UDim2.new(0, 460, 0, 42)
hint.BackgroundColor3 = Color3.fromRGB(23, 49, 77)
hint.BackgroundTransparency = 0.16
hint.BorderSizePixel = 0
hint.Text = "Blockwelt  •  WASD bewegen  •  Leertaste springen  •  Kamera mit der Maus drehen"
hint.TextColor3 = Color3.new(1, 1, 1)
hint.TextScaled = true
hint.Font = Enum.Font.GothamBold
hint.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = hint

local constraint = Instance.new("UITextSizeConstraint")
constraint.MinTextSize = 12
constraint.MaxTextSize = 20
constraint.Parent = hint

-- Make the instruction banner less intrusive after a few seconds.
task.delay(8, function()
    if hint.Parent then
        for i = 1, 20 do
            hint.BackgroundTransparency = 0.16 + (i / 20) * 0.84
            hint.TextTransparency = i / 20
            task.wait(0.04)
        end
        if gui.Parent then
            gui:Destroy()
        end
    end
end)
