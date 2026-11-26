-- Roblox Studio port of the Blockwelt demo.
-- Place this Script in ServerScriptService.

local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local oldWorld = Workspace:FindFirstChild("BlockweltGenerated")
if oldWorld then
    oldWorld:Destroy()
end

local world = Instance.new("Folder")
world.Name = "BlockweltGenerated"
world.Parent = Workspace

local function part(name, size, position, color, material, parent, shape)
    local object = Instance.new("Part")
    object.Name = name
    object.Size = size
    object.Position = position
    object.Anchored = true
    object.TopSurface = Enum.SurfaceType.Smooth
    object.BottomSurface = Enum.SurfaceType.Smooth
    object.Material = material or Enum.Material.SmoothPlastic
    object.Color = color
    if shape then
        object.Shape = shape
    end
    object.Parent = parent or world
    return object
end

Lighting.ClockTime = 14
Lighting.Brightness = 2
Lighting.Ambient = Color3.fromRGB(145, 155, 165)
Lighting.OutdoorAmbient = Color3.fromRGB(170, 180, 190)

-- A continuous, level grassy surface.
part("Grassland", Vector3.new(420, 4, 420), Vector3.new(0, -2, 0), Color3.fromRGB(105, 170, 78), Enum.Material.Grass)

-- Roads and sidewalks.
local roadColor = Color3.fromRGB(76, 80, 84)
local sidewalkColor = Color3.fromRGB(190, 188, 174)
part("MainRoad", Vector3.new(420, 0.18, 18), Vector3.new(0, 0.08, 0), roadColor, Enum.Material.Asphalt)
part("CrossRoad", Vector3.new(18, 0.18, 420), Vector3.new(0, 0.08, 0), roadColor, Enum.Material.Asphalt)
part("NorthSidewalk", Vector3.new(420, 0.22, 3), Vector3.new(0, 0.15, -10.5), sidewalkColor, Enum.Material.Concrete)
part("SouthSidewalk", Vector3.new(420, 0.22, 3), Vector3.new(0, 0.15, 10.5), sidewalkColor, Enum.Material.Concrete)
part("WestSidewalk", Vector3.new(3, 0.22, 420), Vector3.new(-10.5, 0.15, 0), sidewalkColor, Enum.Material.Concrete)
part("EastSidewalk", Vector3.new(3, 0.22, 420), Vector3.new(10.5, 0.15, 0), sidewalkColor, Enum.Material.Concrete)

-- Small dashed road markings.
for x = -195, 195, 18 do
    part("RoadMarking", Vector3.new(8, 0.04, 0.35), Vector3.new(x, 0.19, 0), Color3.fromRGB(245, 229, 153), Enum.Material.SmoothPlastic)
end
for z = -195, 195, 18 do
    part("RoadMarking", Vector3.new(0.35, 0.04, 8), Vector3.new(0, 0.19, z), Color3.fromRGB(245, 229, 153), Enum.Material.SmoothPlastic)
end

local function makeTree(x, z, scale)
    scale = scale or 1
    part("TreeTrunk", Vector3.new(1.2, 5, 1.2) * scale, Vector3.new(x, 2.5 * scale, z), Color3.fromRGB(112, 75, 43), Enum.Material.Wood)
    part("TreeLeavesLower", Vector3.new(5, 3.2, 5) * scale, Vector3.new(x, 5.2 * scale, z), Color3.fromRGB(54, 133, 67), Enum.Material.Grass)
    part("TreeLeavesUpper", Vector3.new(3.8, 3, 3.8) * scale, Vector3.new(x, 7.6 * scale, z), Color3.fromRGB(70, 154, 76), Enum.Material.Grass)
end

local function makeHouse(x, z, wallColor, roofColor, rotation)
    local model = Instance.new("Model")
    model.Name = "BlockHouse"
    model.Parent = world

    local function housePart(name, size, offset, color, material)
        local p = part(name, size, Vector3.new(x, 0, z) + offset, color, material, model)
        p.Orientation = Vector3.new(0, rotation or 0, 0)
        return p
    end

    housePart("Walls", Vector3.new(14, 9, 12), Vector3.new(0, 4.5, 0), wallColor, Enum.Material.Brick)
    housePart("Roof", Vector3.new(15, 1.2, 13), Vector3.new(0, 9.6, 0), roofColor, Enum.Material.Slate)
    housePart("Door", Vector3.new(2.4, 4.5, 0.25), Vector3.new(0, 2.25, -6.13), Color3.fromRGB(93, 62, 42), Enum.Material.Wood)
    housePart("WindowLeft", Vector3.new(2.6, 2.2, 0.2), Vector3.new(-4.3, 5.1, -6.14), Color3.fromRGB(141, 211, 230), Enum.Material.Glass)
    housePart("WindowRight", Vector3.new(2.6, 2.2, 0.2), Vector3.new(4.3, 5.1, -6.14), Color3.fromRGB(141, 211, 230), Enum.Material.Glass)
    housePart("Chimney", Vector3.new(2, 4, 2), Vector3.new(4.4, 12, 1.8), Color3.fromRGB(125, 65, 53), Enum.Material.Brick)
end

makeHouse(-29, -32, Color3.fromRGB(255, 190, 85), Color3.fromRGB(117, 67, 45), 0)
makeHouse(29, -35, Color3.fromRGB(239, 125, 113), Color3.fromRGB(92, 63, 54), 0)
makeHouse(-38, 32, Color3.fromRGB(104, 170, 230), Color3.fromRGB(70, 75, 91), 180)
makeHouse(39, 37, Color3.fromRGB(193, 145, 223), Color3.fromRGB(83, 66, 94), 180)

-- Park, fountain, and benches.
part("ParkPath", Vector3.new(42, 0.12, 30), Vector3.new(0, 0.07, -27), Color3.fromRGB(205, 194, 164), Enum.Material.Ground)
part("FountainBase", Vector3.new(18, 0.7, 18), Vector3.new(0, 0.48, -27), Color3.fromRGB(117, 166, 190), Enum.Material.Marble, world, Enum.PartType.Cylinder)
part("FountainWater", Vector3.new(14, 0.18, 14), Vector3.new(0, 0.92, -27), Color3.fromRGB(75, 176, 218), Enum.Material.Glass, world, Enum.PartType.Cylinder)
part("FountainPillar", Vector3.new(2, 3, 2), Vector3.new(0, 2.5, -27), Color3.fromRGB(223, 224, 214), Enum.Material.Marble)
for _, x in ipairs({-15, 15}) do
    part("BenchSeat", Vector3.new(5, 0.35, 1.4), Vector3.new(x, 1.1, -27), Color3.fromRGB(132, 84, 48), Enum.Material.Wood)
    part("BenchBack", Vector3.new(5, 1.5, 0.3), Vector3.new(x, 1.9, -27.6), Color3.fromRGB(132, 84, 48), Enum.Material.Wood)
    for _, dx in ipairs({-1.8, 1.8}) do
        part("BenchLeg", Vector3.new(0.35, 1, 0.35), Vector3.new(x + dx, 0.55, -27), Color3.fromRGB(65, 66, 69), Enum.Material.Metal)
    end
end

-- A consistent line of trees along the quieter roads.
for i = 0, 17 do
    local z = -120 + i * 14
    makeTree(-24, z, 0.85 + (i % 3) * 0.08)
    makeTree(24, z, 0.9)
end
for i = 0, 9 do
    local x = -105 + i * 23
    makeTree(x, -62, 0.85)
    makeTree(x, 63, 0.9)
end

-- Flowers and small stones, generated deterministically for repeatable builds.
local rng = Random.new(41)
local flowerColors = {
    Color3.fromRGB(255, 216, 92),
    Color3.fromRGB(244, 126, 150),
    Color3.fromRGB(245, 245, 231),
}
for i = 1, 180 do
    local x = rng:NextNumber(-180, 180)
    local z = rng:NextNumber(-180, 180)
    if math.abs(x) > 18 and math.abs(z) > 18 then
        local color = flowerColors[rng:NextInteger(1, #flowerColors)]
        part("Flower", Vector3.new(0.35, 0.22, 0.35), Vector3.new(x, 0.18, z), color, Enum.Material.Neon)
    end
end

-- Place the spawn in the central plaza; Roblox's built-in character controller
-- handles walking, jumping, gravity, and keeping the avatar on the ground.
local spawn = Instance.new("SpawnLocation")
spawn.Name = "BlockweltSpawn"
spawn.Size = Vector3.new(8, 0.3, 8)
spawn.Position = Vector3.new(0, 0.15, 20)
spawn.Anchored = true
spawn.Neutral = true
spawn.Transparency = 1
spawn.CanCollide = false
spawn.Parent = world

print("Blockwelt generated. Use Roblox's default character controls to explore.")
