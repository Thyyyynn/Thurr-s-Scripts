local correctKey = "skiddo123"
local player = game.Players.LocalPlayer

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "KeySystem"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 160)
frame.Position = UDim2.new(0.5, -150, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "Enter Key"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.TextScaled = true

local box = Instance.new("TextBox", frame)
box.PlaceholderText = "Check 'ImSKeyDing' desc"
box.Size = UDim2.new(0.8, 0, 0, 40)
box.Position = UDim2.new(0.1, 0, 0.4, 0)
box.Font = Enum.Font.Gotham
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
box.TextScaled = true
Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)

local submit = Instance.new("TextButton", frame)
submit.Size = UDim2.new(0.8, 0, 0, 40)
submit.Position = UDim2.new(0.1, 0, 0.7, 0)
submit.Text = "Submit"
submit.Font = Enum.Font.GothamBold
submit.TextColor3 = Color3.fromRGB(255, 255, 255)
submit.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
submit.TextScaled = true
Instance.new("UICorner", submit).CornerRadius = UDim.new(0, 8)

submit.MouseButton1Click:Connect(function()
	if box.Text == correctKey then
		submit.Text = "✅ Correct!"
		wait(1)
		gui:Destroy()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Thyyyynn/Script-test/refs/heads/main/Hubtestbyme.lua"))()
	else
		submit.Text = "❌ Wrong Key!"
		wait(1.5)
		submit.Text = "Submit"
	end
end)
