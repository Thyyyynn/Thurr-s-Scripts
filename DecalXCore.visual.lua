-- DecalXCore - c00lkidd-style Decal & Skybox GUI (compact version)
-- Theme: black, red outline, no UICorner, draggable. Parent: CoreGui

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

--=== UI ===--
local gui = Instance.new("ScreenGui")
gui.Name = "DecalXCore"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 240, 0, 150) -- smaller frame
frame.Position = UDim2.new(0.5, -120, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderColor3 = Color3.fromRGB(255, 0, 0)
frame.BorderSizePixel = 3
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1, 0, 0, 26) -- smaller title
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "DecalXCore"
title.TextColor3 = Color3.fromRGB(255, 0, 0)
title.Font = Enum.Font.Code
title.TextScaled = false
title.TextSize = 18

-- Input
local decalBox = Instance.new("TextBox")
decalBox.Parent = frame
decalBox.Size = UDim2.new(1, -20, 0, 28) -- smaller input box
decalBox.Position = UDim2.new(0, 10, 0, 34)
decalBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
decalBox.BorderColor3 = Color3.fromRGB(255, 0, 0)
decalBox.BorderSizePixel = 2
decalBox.Text = "Decal ID"
decalBox.PlaceholderText = "Enter Decal/Texture ID"
decalBox.TextColor3 = Color3.fromRGB(255, 0, 0)
decalBox.Font = Enum.Font.Code
decalBox.TextScaled = false
decalBox.TextSize = 16
decalBox.ClearTextOnFocus = false

local function makeButton(text, y)
	local b = Instance.new("TextButton")
	b.Parent = frame
	b.Size = UDim2.new(1, -40, 0, 28) -- smaller button
	b.Position = UDim2.new(0, 20, 0, y)
	b.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	b.BorderColor3 = Color3.fromRGB(255, 0, 0)
	b.BorderSizePixel = 2
	b.Text = text
	b.TextColor3 = Color3.fromRGB(255, 0, 0)
	b.Font = Enum.Font.Code
	b.TextScaled = false
	b.TextSize = 16
	return b
end

local decalSpamBtn = makeButton("Decal Spam", 70)
local skyboxBtn    = makeButton("Set Skybox", 104)

--=== Helpers ===--

local faces = Enum.NormalId:GetEnumItems()

local function ensureFaceImage(part, face, asset)
	local found
	for _, child in ipairs(part:GetChildren()) do
		if (child:IsA("Decal") or child:IsA("Texture")) and child.Face == face then
			found = child
			break
		end
	end
	if not found then
		found = Instance.new("Decal")
		found.Face = face
		found.Parent = part
	end
	found.Texture = asset
end

local function applyEverywhere(assetIdStr)
	local asset = "rbxassetid://" .. assetIdStr
	local partsHit, meshesHit = 0, 0

	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") then
			for _, face in ipairs(faces) do
				ensureFaceImage(obj, face, asset)
			end
			partsHit += 1

			if obj:IsA("MeshPart") then
				pcall(function() obj.TextureID = asset end)
				meshesHit += 1
			end

			local sm = obj:FindFirstChildOfClass("SpecialMesh")
			if sm then
				pcall(function() sm.TextureId = asset end)
				meshesHit += 1
			end

			for _, child in ipairs(obj:GetChildren()) do
				if child.ClassName == "Mesh" then
					pcall(function() child.TextureId = asset end)
					meshesHit += 1
				end
			end
		end
	end

	print(string.format("DecalXCore: Applied to %d parts; %d mesh textures updated.", partsHit, meshesHit))
end

--=== Actions ===--

decalSpamBtn.MouseButton1Click:Connect(function()
	local id = tonumber(decalBox.Text)
	if not id then
		warn("DecalXCore: Invalid ID")
		return
	end
	print("DecalXCore: Spamming decal/texture id", id, "across all parts and meshes...")
	applyEverywhere(tostring(id))
end)

skyboxBtn.MouseButton1Click:Connect(function()
	local id = tonumber(decalBox.Text)
	if not id then
		warn("DecalXCore: Invalid Skybox ID")
		return
	end
	local asset = "rbxassetid://" .. id

	for _, v in ipairs(Lighting:GetChildren()) do
		if v:IsA("Sky") then v:Destroy() end
	end

	local sky = Instance.new("Sky")
	sky.SkyboxBk = asset
	sky.SkyboxFt = asset
	sky.SkyboxLf = asset
	sky.SkyboxRt = asset
	sky.SkyboxUp = asset
	sky.SkyboxDn = asset
	sky.Parent = Lighting

	print("DecalXCore: Set skybox to id", id)
end)
