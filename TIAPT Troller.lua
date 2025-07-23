-- troll is a pinning tower

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Positions
local pos1 = CFrame.new(-32.2157059, 103.095421, 203.99501, -0.0685840771, 6.4190786e-08, 0.997645319, 2.04414818e-09, 1, -6.42017639e-08, -0.997645319, -2.36388376e-09, -0.0685840771)
local pos2 = CFrame.new(-35.2373428, 103.085167, 217.281784, -0.954966962, -1.78434316e-08, -0.29671219, -1.28240252e-09, 1, -5.60097639e-08, 0.29671219, -5.31069695e-08, -0.954966962)

-- GUI Setup
local gui = Instance.new("ScreenGui")
gui.Name = "TIAPTGui"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 120)
frame.Position = UDim2.new(0.5, -125, 0.5, -60)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local frameCorner = Instance.new("UICorner", frame)
frameCorner.CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "TIAPT Troller."
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.BackgroundTransparency = 1

local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.8, 0, 0, 40)
button.Position = UDim2.new(0.1, 0, 0.5, 0)
button.Text = "Troll"
button.Font = Enum.Font.GothamBold
button.TextColor3 = Color3.new(1, 1, 1)
button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
button.TextScaled = true

local buttonCorner = Instance.new("UICorner", button)
buttonCorner.CornerRadius = UDim.new(0, 8)

-- Teleport Logic
button.MouseButton1Click:Connect(function()
	local char = player.Character or player.CharacterAdded:Wait()
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.CFrame = pos2
		task.wait(0.01)
		hrp.CFrame = pos1
	end
end)
