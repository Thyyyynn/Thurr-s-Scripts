--// Server Joiner Through Job ID (Black + Purple, no UICorner, Draggable)
--// Full script, mobile-friendly dragging, CoreGui parent

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

-- Helper: notify (SetCore)
local function notify(title, text, duration)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = title or "Notice",
			Text = text or "",
			Duration = duration or 4
		})
	end)
end

-- UI
local gui = Instance.new("ScreenGui")
gui.Name = "ServerJoinerByJobID"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame")
frame.Name = "Main"
frame.Size = UDim2.new(0, 360, 0, 210)
frame.Position = UDim2.new(0.5, -180, 0.4, -105)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderColor3 = Color3.fromRGB(150, 60, 255) -- purple outline
frame.BorderSizePixel = 3
frame.Active = true
frame.Parent = gui

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
titleBar.BorderColor3 = Color3.fromRGB(150, 60, 255)
titleBar.BorderSizePixel = 0
titleBar.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -30, 1, 0)
title.Position = UDim2.new(0, 8, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Server Joiner Through Job ID"
title.TextColor3 = Color3.fromRGB(200, 170, 255)
title.Font = Enum.Font.Code
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 3)
closeBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 40)
closeBtn.BorderColor3 = Color3.fromRGB(150, 60, 255)
closeBtn.BorderSizePixel = 2
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.Code
closeBtn.TextSize = 16
closeBtn.Parent = titleBar
closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- Labels & inputs
local labelPlace = Instance.new("TextLabel")
labelPlace.Size = UDim2.new(0, 90, 0, 26)
labelPlace.Position = UDim2.new(0, 10, 0, 40)
labelPlace.BackgroundTransparency = 1
labelPlace.Text = "Place ID:"
labelPlace.TextColor3 = Color3.fromRGB(200, 170, 255)
labelPlace.Font = Enum.Font.Code
labelPlace.TextSize = 16
labelPlace.TextXAlignment = Enum.TextXAlignment.Left
labelPlace.Parent = frame

local placeBox = Instance.new("TextBox")
placeBox.Size = UDim2.new(1, -120, 0, 28)
placeBox.Position = UDim2.new(0, 100, 0, 38)
placeBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
placeBox.BorderColor3 = Color3.fromRGB(150, 60, 255)
placeBox.BorderSizePixel = 2
placeBox.Text = tostring(game.PlaceId)
placeBox.TextColor3 = Color3.fromRGB(220, 200, 255)
placeBox.Font = Enum.Font.Code
placeBox.TextSize = 16
placeBox.ClearTextOnFocus = false
placeBox.Parent = frame

local labelJob = Instance.new("TextLabel")
labelJob.Size = UDim2.new(0, 90, 0, 26)
labelJob.Position = UDim2.new(0, 10, 0, 76)
labelJob.BackgroundTransparency = 1
labelJob.Text = "Job ID:"
labelJob.TextColor3 = Color3.fromRGB(200, 170, 255)
labelJob.Font = Enum.Font.Code
labelJob.TextSize = 16
labelJob.TextXAlignment = Enum.TextXAlignment.Left
labelJob.Parent = frame

local jobBox = Instance.new("TextBox")
jobBox.Size = UDim2.new(1, -120, 0, 28)
jobBox.Position = UDim2.new(0, 100, 0, 74)
jobBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
jobBox.BorderColor3 = Color3.fromRGB(150, 60, 255)
jobBox.BorderSizePixel = 2
jobBox.Text = ""
jobBox.PlaceholderText = "Paste target JobId here"
jobBox.TextColor3 = Color3.fromRGB(220, 200, 255)
jobBox.Font = Enum.Font.Code
jobBox.TextSize = 16
jobBox.ClearTextOnFocus = false
jobBox.Parent = frame

-- Buttons
local joinBtn = Instance.new("TextButton")
joinBtn.Size = UDim2.new(0.5, -15, 0, 34)
joinBtn.Position = UDim2.new(0, 10, 0, 114)
joinBtn.BackgroundColor3 = Color3.fromRGB(25, 0, 40)
joinBtn.BorderColor3 = Color3.fromRGB(150, 60, 255)
joinBtn.BorderSizePixel = 2
joinBtn.Text = "Join Server"
joinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
joinBtn.Font = Enum.Font.Code
joinBtn.TextSize = 16
joinBtn.Parent = frame

local myIdsBtn = Instance.new("TextButton")
myIdsBtn.Size = UDim2.new(0.5, -15, 0, 34)
myIdsBtn.Position = UDim2.new(0.5, 5, 0, 114)
myIdsBtn.BackgroundColor3 = Color3.fromRGB(25, 0, 40)
myIdsBtn.BorderColor3 = Color3.fromRGB(150, 60, 255)
myIdsBtn.BorderSizePixel = 2
myIdsBtn.Text = "Fill Current IDs"
myIdsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
myIdsBtn.Font = Enum.Font.Code
myIdsBtn.TextSize = 16
myIdsBtn.Parent = frame

local copyJobBtn = Instance.new("TextButton")
copyJobBtn.Size = UDim2.new(1, -20, 0, 30)
copyJobBtn.Position = UDim2.new(0, 10, 0, 154)
copyJobBtn.BackgroundColor3 = Color3.fromRGB(25, 0, 40)
copyJobBtn.BorderColor3 = Color3.fromRGB(150, 60, 255)
copyJobBtn.BorderSizePixel = 2
copyJobBtn.Text = "Copy My JobId"
copyJobBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
copyJobBtn.Font = Enum.Font.Code
copyJobBtn.TextSize = 16
copyJobBtn.Parent = frame

-- Actions
myIdsBtn.MouseButton1Click:Connect(function()
	placeBox.Text = tostring(game.PlaceId)
	jobBox.Text = tostring(game.JobId or "")
	notify("Server Joiner", "Filled with your current PlaceId & JobId.", 3)
end)

copyJobBtn.MouseButton1Click:Connect(function()
	local jid = tostring(game.JobId or "")
	if jid == "" then
		notify("Copy JobId", "No JobId found in this environment.", 3)
		return
	end
	local ok = pcall(setclipboard, jid)
	if ok then
		notify("Copy JobId", "Copied JobId to clipboard.", 3)
	else
		notify("Copy JobId", "Clipboard not available on this executor.", 3)
	end
end)

joinBtn.MouseButton1Click:Connect(function()
	local placeIdNum = tonumber(placeBox.Text)
	local jobIdStr = tostring(jobBox.Text or ""):gsub("%s+", "")

	if not placeIdNum then
		notify("Join Failed", "Invalid PlaceId.", 4)
		return
	end
	if jobIdStr == "" or #jobIdStr < 8 then
		notify("Join Failed", "Invalid JobId.", 4)
		return
	end

	notify("Teleporting...", "Attempting to join target server…", 3)
	local ok, err = pcall(function()
		TeleportService:TeleportToPlaceInstance(placeIdNum, jobIdStr, LocalPlayer)
	end)
	if not ok then
		notify("Teleport Error", tostring(err), 6)
	end
end)

-- Mobile-friendly dragging (manual)
do
	local UIS = game:GetService("UserInputService")
	local dragging = false
	local dragInput, dragStart, startPos

	local function update(input)
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end

	titleBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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

	titleBar.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

-- Initial heads-up
notify("Server Joiner", "Enter JobId (and PlaceId if needed), then press Join.", 5)
