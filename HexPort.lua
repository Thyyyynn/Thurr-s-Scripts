-- HexPort Server Joiner GUI with Close Button
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "HexPortGUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 320, 0, 200)
Frame.Position = UDim2.new(0.5, -160, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderColor3 = Color3.fromRGB(160, 0, 255)
Frame.Active = true
Frame.Draggable = true

-- Title
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, -30, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Server Joiner Through Job ID"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.Code
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
local CloseBtn = Instance.new("TextButton", Frame)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
CloseBtn.BorderColor3 = Color3.fromRGB(160, 0, 255)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.Code
CloseBtn.TextSize = 18

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Place ID (lighter bg)
local PlaceBox = Instance.new("TextBox", Frame)
PlaceBox.Size = UDim2.new(1, -20, 0, 25)
PlaceBox.Position = UDim2.new(0, 10, 0, 40)
PlaceBox.Text = tostring(game.PlaceId)
PlaceBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35) -- lighter shade
PlaceBox.BorderColor3 = Color3.fromRGB(160, 0, 255)
PlaceBox.TextColor3 = Color3.fromRGB(255, 255, 255)
PlaceBox.Font = Enum.Font.Code
PlaceBox.TextSize = 16

-- Job ID (lighter bg, blank by default)
local JobBox = Instance.new("TextBox", Frame)
JobBox.Size = UDim2.new(1, -20, 0, 25)
JobBox.Position = UDim2.new(0, 10, 0, 70)
JobBox.Text = "" -- blank
JobBox.PlaceholderText = "Paste target JobId here"
JobBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
JobBox.BorderColor3 = Color3.fromRGB(160, 0, 255)
JobBox.TextColor3 = Color3.fromRGB(255, 255, 255)
JobBox.Font = Enum.Font.Code
JobBox.TextSize = 16

-- Join Server Button
local JoinBtn = Instance.new("TextButton", Frame)
JoinBtn.Size = UDim2.new(0.48, -5, 0, 25)
JoinBtn.Position = UDim2.new(0, 10, 0, 105)
JoinBtn.Text = "Join Server"
JoinBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
JoinBtn.BorderColor3 = Color3.fromRGB(160, 0, 255)
JoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
JoinBtn.Font = Enum.Font.Code
JoinBtn.TextSize = 16

-- Fill IDs Button
local FillBtn = Instance.new("TextButton", Frame)
FillBtn.Size = UDim2.new(0.48, -5, 0, 25)
FillBtn.Position = UDim2.new(0.52, 0, 0, 105)
FillBtn.Text = "Fill Current IDs"
FillBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
FillBtn.BorderColor3 = Color3.fromRGB(160, 0, 255)
FillBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FillBtn.Font = Enum.Font.Code
FillBtn.TextSize = 16

-- Copy JobId Button
local CopyBtn = Instance.new("TextButton", Frame)
CopyBtn.Size = UDim2.new(1, -20, 0, 25)
CopyBtn.Position = UDim2.new(0, 10, 0, 135)
CopyBtn.Text = "Copy My JobId"
CopyBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
CopyBtn.BorderColor3 = Color3.fromRGB(160, 0, 255)
CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyBtn.Font = Enum.Font.Code
CopyBtn.TextSize = 16

-- Join New Server Button
local NewServerBtn = Instance.new("TextButton", Frame)
NewServerBtn.Size = UDim2.new(1, -20, 0, 25)
NewServerBtn.Position = UDim2.new(0, 10, 0, 165)
NewServerBtn.Text = "Join New Server"
NewServerBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
NewServerBtn.BorderColor3 = Color3.fromRGB(160, 0, 255)
NewServerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NewServerBtn.Font = Enum.Font.Code
NewServerBtn.TextSize = 16

-- Functions
JoinBtn.MouseButton1Click:Connect(function()
    if tonumber(PlaceBox.Text) and JobBox.Text ~= "" then
        TeleportService:TeleportToPlaceInstance(tonumber(PlaceBox.Text), JobBox.Text, player)
    end
end)

FillBtn.MouseButton1Click:Connect(function()
    PlaceBox.Text = tostring(game.PlaceId)
    JobBox.Text = game.JobId
end)

CopyBtn.MouseButton1Click:Connect(function()
    setclipboard(game.JobId)
end)

NewServerBtn.MouseButton1Click:Connect(function()
    local servers = HttpService:JSONDecode(game:HttpGetAsync(
        "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    ))
    for _, s in pairs(servers.data) do
        if s.playing < s.maxPlayers then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id, player)
            break
        end
    end
end)
