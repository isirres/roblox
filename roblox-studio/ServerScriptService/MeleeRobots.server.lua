-- 10 melee robots for Roblox Studio.
-- Place this Script in ServerScriptService.
-- Each player and robot has 100 HP. Roblox's humanoid system controls health and death.

local Players = game:GetService("Players")

local NPC_COUNT = 10
local NPC_FOLDER_NAME = "MeleeRobots"
local ATTACK_RANGE = 7
local ATTACK_DAMAGE = 10
local ATTACK_COOLDOWN = 1

local oldFolder = workspace:FindFirstChild(NPC_FOLDER_NAME)
if oldFolder then
	oldFolder:Destroy()
end

local folder = Instance.new("Folder")
folder.Name = NPC_FOLDER_NAME
folder.Parent = workspace

local function weldPart(root, part)
	local weld = Instance.new("WeldConstraint")
	weld.Part0 = root
	weld.Part1 = part
	weld.Parent = root
end

local function createRobot(index)
	local model = Instance.new("Model")
	model.Name = "MeleeRobot" .. index

	local root = Instance.new("Part")
	root.Name = "HumanoidRootPart"
	root.Size = Vector3.new(2, 2, 1)
	root.Color = Color3.fromRGB(70, 80, 95)
	root.Material = Enum.Material.Metal
	root.Parent = model

	local torso = Instance.new("Part")
	torso.Name = "Torso"
	torso.Size = Vector3.new(3, 3.5, 1.6)
	torso.Color = Color3.fromRGB(75, 145, 180)
	torso.Material = Enum.Material.Metal
	torso.CanCollide = false
	torso.CFrame = root.CFrame * CFrame.new(0, 1.1, 0)
	torso.Parent = model

	local head = Instance.new("Part")
	head.Name = "Head"
	head.Size = Vector3.new(2.2, 1.8, 2)
	head.Shape = Enum.PartType.Ball
	head.Color = Color3.fromRGB(210, 215, 220)
	head.Material = Enum.Material.Metal
	head.CanCollide = false
	head.CFrame = root.CFrame * CFrame.new(0, 3.5, 0)
	head.Parent = model

	local leftLeg = Instance.new("Part")
	leftLeg.Name = "Left Leg"
	leftLeg.Size = Vector3.new(0.9, 2.2, 1)
	leftLeg.Color = Color3.fromRGB(55, 65, 75)
	leftLeg.Material = Enum.Material.Metal
	leftLeg.CFrame = root.CFrame * CFrame.new(-0.85, -1.9, 0)
	leftLeg.Parent = model

	local rightLeg = Instance.new("Part")
	rightLeg.Name = "Right Leg"
	rightLeg.Size = Vector3.new(0.9, 2.2, 1)
	rightLeg.Color = Color3.fromRGB(55, 65, 75)
	rightLeg.Material = Enum.Material.Metal
	rightLeg.CFrame = root.CFrame * CFrame.new(0.85, -1.9, 0)
	rightLeg.Parent = model

	for _, decorativePart in ipairs({torso, head, leftLeg, rightLeg}) do
		weldPart(root, decorativePart)
	end

	local humanoid = Instance.new("Humanoid")
	humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
	humanoid.MaxHealth = 100
	humanoid.Health = 100
	humanoid.WalkSpeed = 10
	humanoid.Parent = model

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "HealthBar"
	billboard.Adornee = head
	billboard.AlwaysOnTop = true
	billboard.Size = UDim2.fromOffset(120, 24)
	billboard.StudsOffset = Vector3.new(0, 3, 0)
	billboard.Parent = model

	local background = Instance.new("Frame")
	background.Name = "Background"
	background.Size = UDim2.fromScale(1, 1)
	background.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	background.BorderSizePixel = 0
	background.Parent = billboard

	local fill = Instance.new("Frame")
	fill.Name = "Fill"
	fill.Size = UDim2.fromScale(1, 1)
	fill.BackgroundColor3 = Color3.fromRGB(45, 210, 75)
	fill.BorderSizePixel = 0
	fill.Parent = background

	local label = Instance.new("TextLabel")
	label.Size = UDim2.fromScale(1, 1)
	label.BackgroundTransparency = 1
	label.Text = "100 / 100"
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextStrokeTransparency = 0.25
	label.TextScaled = true
	label.Font = Enum.Font.GothamBold
	label.Parent = background

	local updateHealth = function()
		local ratio = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
		fill.Size = UDim2.fromScale(ratio, 1)
		fill.BackgroundColor3 = Color3.fromRGB(
			math.floor(220 * (1 - ratio) + 45 * ratio),
			math.floor(45 * (1 - ratio) + 210 * ratio),
			75
		)
		label.Text = tostring(math.max(0, math.floor(humanoid.Health))) .. " / " .. tostring(humanoid.MaxHealth)
	end

	humanoid.HealthChanged:Connect(updateHealth)
	updateHealth()

	model.PrimaryPart = root
	model.Parent = folder

	local angle = (index - 1) / NPC_COUNT * math.pi * 2
	local distance = 18 + (index % 3) * 7
	local x = math.cos(angle) * distance
	local z = 20 + math.sin(angle) * distance
	root.CFrame = CFrame.new(x, 3.1, z)

	return model, humanoid, root
end

local function nearestPlayer(root)
	local nearestCharacter = nil
	local nearestDistance = ATTACK_RANGE

	for _, player in ipairs(Players:GetPlayers()) do
		local character = player.Character
		local playerRoot = character and character:FindFirstChild("HumanoidRootPart")
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if playerRoot and humanoid and humanoid.Health > 0 then
			local distance = (playerRoot.Position - root.Position).Magnitude
			if distance < nearestDistance then
				nearestDistance = distance
				nearestCharacter = character
			end
		end
	end

	return nearestCharacter
end

for i = 1, NPC_COUNT do
	local model, humanoid, root = createRobot(i)

	task.spawn(function()
		while model.Parent and humanoid.Health > 0 do
			local target = nearestPlayer(root)

			if target then
				local targetHumanoid = target:FindFirstChildOfClass("Humanoid")
				if targetHumanoid and targetHumanoid.Health > 0 then
					local targetRoot = target:FindFirstChild("HumanoidRootPart")
					if targetRoot then
						local lookDirection = targetRoot.Position - root.Position
						lookDirection = Vector3.new(lookDirection.X, 0, lookDirection.Z)
						if lookDirection.Magnitude > 0.1 then
							root.CFrame = CFrame.lookAt(root.Position, root.Position + lookDirection)
						end
						targetHumanoid:TakeDamage(ATTACK_DAMAGE)
					end
				end
				task.wait(ATTACK_COOLDOWN)
			else
				local angle = math.random() * math.pi * 2
				local distance = math.random(8, 28)
				local destination = root.Position + Vector3.new(
					math.cos(angle) * distance,
					0,
					math.sin(angle) * distance
				)
				destination = Vector3.new(
					math.clamp(destination.X, -60, 60),
					root.Position.Y,
					math.clamp(destination.Z, -70, 70)
				)
				humanoid:MoveTo(destination)
				task.wait(math.random(1, 3))
			end
		end
	end)

	humanoid.Died:Connect(function()
		task.wait(3)
		if model.Parent then
			model:Destroy()
		end
	end)
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local humanoid = character:WaitForChild("Humanoid")
		humanoid.MaxHealth = 100
		humanoid.Health = 100
	end)
end)

for _, player in ipairs(Players:GetPlayers()) do
	if player.Character then
		local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.MaxHealth = 100
			humanoid.Health = 100
		end
	end
end

print("Created 10 melee robots with 100 HP. Player UI must be enabled separately.")
