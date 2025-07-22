--// Key System GUI with hint and hub loader

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local correctKey = "ThxTyThanks" -- your key

-- GUI Setup
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "KeySystem"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 200)
frame.Position = UDim2.new(0.5, -160, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "🔐 Enter Access Key"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255, 255, 255)

local hint = Instance.new("TextLabel", frame)
hint.Size = UDim2.new(1, -20, 0, 20)
hint.Position = UDim2.new(0, 10, 0, 45)
hint.BackgroundTransparency = 1
hint.Text = "🔎 Check 'imskeyding' description for the key"
hint.Font = Enum.Font.Gotham
hint.TextScaled = true
hint.TextColor3 = Color3.fromRGB(180, 180, 180)
hint.TextWrapped = true

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0.8, 0, 0, 40)
box.Position = UDim2.new(0.1, 0, 0.5, 0)
box.PlaceholderText = "Enter Key..."
box.Text = ""
box.Font = Enum.Font.Gotham
box.TextScaled = true
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)

local submit = Instance.new("TextButton", frame)
submit.Size = UDim2.new(0.8, 0, 0, 40)
submit.Position = UDim2.new(0.1, 0, 0.75, 0)
submit.Text = "Submit"
submit.Font = Enum.Font.GothamBold
submit.TextScaled = true
submit.TextColor3 = Color3.fromRGB(255, 255, 255)
submit.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
Instance.new("UICorner", submit).CornerRadius = UDim.new(0, 8)

submit.MouseButton1Click:Connect(function()
	if box.Text == correctKey then
		submit.Text = "✅ Access Granted!"
		wait(1)
		gui:Destroy()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Thyyyynn/Script-test/refs/heads/main/Hubtestbyme.lua"))()
	else
		submit.Text = "❌ Invalid Key"
		wait(1.5)
		submit.Text = "Submit"
	end
end)
