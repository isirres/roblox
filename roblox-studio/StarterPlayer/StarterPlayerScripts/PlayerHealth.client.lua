-- Client-side player health display for Roblox Studio.
-- Place this LocalScript in StarterPlayer > StarterPlayerScripts.

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local playerGui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "PlayerHealthHUD"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

local panel = Instance.new("Frame")
panel.Name = "HealthPanel"
panel.AnchorPoint = Vector2.new(1, 0)
panel.Position = UDim2.new(1, -20, 0, 20)
panel.Size = UDim2.fromOffset(220, 58)
panel.BackgroundColor3 = Color3.fromRGB(35, 39, 46)
panel.BorderSizePixel = 0
panel.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = panel

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 20)
title.Position = UDim2.fromOffset(10, 4)
title.BackgroundTransparency = 1
 title.Text = "LEBEN"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 14
 title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = panel

local background = Instance.new("Frame")
background.Position = UDim2.fromOffset(10, 28)
background.Size = UDim2.new(1, -20, 0, 18)
background.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
background.BorderSizePixel = 0
background.Parent = panel

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(0, 7)
barCorner.Parent = background

local fill = Instance.new("Frame")
fill.Size = UDim2.fromScale(1, 1)
fill.BackgroundColor3 = Color3.fromRGB(45, 210, 75)
fill.BorderSizePixel = 0
fill.Parent = background

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(0, 7)
fillCorner.Parent = fill

local label = Instance.new("TextLabel")
label.Size = UDim2.fromScale(1, 1)
label.BackgroundTransparency = 1
label.Text = "100 / 100"
label.TextColor3 = Color3.new(1, 1, 1)
label.TextSize = 12
label.Font = Enum.Font.GothamBold
label.Parent = fill

local function connectCharacter(character)
	local humanoid = character:WaitForChild("Humanoid")

	local function update()
		local ratio = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
		fill.Size = UDim2.fromScale(ratio, 1)
		fill.BackgroundColor3 = Color3.fromRGB(
			math.floor(220 * (1 - ratio) + 45 * ratio),
			math.floor(45 * (1 - ratio) + 210 * ratio),
			75
		)
		label.Text = tostring(math.max(0, math.floor(humanoid.Health))) .. " / " .. tostring(humanoid.MaxHealth)
	end

	humanoid.HealthChanged:Connect(update)
	update()
end

if player.Character then
	connectCharacter(player.Character)
end

player.CharacterAdded:Connect(connectCharacter)
