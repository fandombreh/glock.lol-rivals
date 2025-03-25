--// Aimbot GUI for Rivals FPS - Styled as "glock.lol" //--
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--// Aimbot Settings
local AimbotEnabled = false
local AimbotKey = Enum.UserInputType.MouseButton2 -- Right Click
local AimSmoothness = 0.15
local MaxFOV = 100
local TeamCheck = true

--// Create GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleButton = Instance.new("TextButton")
local SmoothnessSlider = Instance.new("TextButton")
local FOVSlider = Instance.new("TextButton")
local Footer = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "glock.lol"

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BackgroundTransparency = 0.1
MainFrame.Size = UDim2.new(0, 250, 0, 200)
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true

-- Animate Frame In
local tweenIn = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Position = UDim2.new(0.05, 0, 0.1, 0)})
tweenIn:Play()

Title.Parent = MainFrame
Title.Text = "glock.lol"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.TextAlignment = Enum.TextAlignment.Center
Title.TextStrokeTransparency = 0.5

-- Aimbot Toggle Button
ToggleButton.Parent = MainFrame
ToggleButton.Size = UDim2.new(0.8, 0, 0, 40)
ToggleButton.Position = UDim2.new(0.1, 0, 0.2, 0)
ToggleButton.Text = "Aimbot: OFF"
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.Gotham
ToggleButton.TextSize = 18
ToggleButton.TextStrokeTransparency = 0.5
ToggleButton.BorderSizePixel = 0
ToggleButton.AutoButtonColor = true

-- Smoothness Slider Button
SmoothnessSlider.Parent = MainFrame
SmoothnessSlider.Size = UDim2.new(0.8, 0, 0, 40)
SmoothnessSlider.Position = UDim2.new(0.1, 0, 0.45, 0)
SmoothnessSlider.Text = "Smoothness: " .. AimSmoothness
SmoothnessSlider.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SmoothnessSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
SmoothnessSlider.Font = Enum.Font.Gotham
SmoothnessSlider.TextSize = 18
SmoothnessSlider.TextStrokeTransparency = 0.5
SmoothnessSlider.BorderSizePixel = 0
SmoothnessSlider.AutoButtonColor = true

-- FOV Slider Button
FOVSlider.Parent = MainFrame
FOVSlider.Size = UDim2.new(0.8, 0, 0, 40)
FOVSlider.Position = UDim2.new(0.1, 0, 0.7, 0)
FOVSlider.Text = "FOV: " .. MaxFOV
FOVSlider.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
FOVSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
FOVSlider.Font = Enum.Font.Gotham
FOVSlider.TextSize = 18
FOVSlider.TextStrokeTransparency = 0.5
FOVSlider.BorderSizePixel = 0
FOVSlider.AutoButtonColor = true

-- Footer with info
Footer.Parent = MainFrame
Footer.Text = "glock.lol | Aimbot"
Footer.Size = UDim2.new(1, 0, 0, 30)
Footer.Position = UDim2.new(0, 0, 1, -30)
Footer.TextColor3 = Color3.fromRGB(200, 200, 200)
Footer.BackgroundTransparency = 1
Footer.Font = Enum.Font.Gotham
Footer.TextSize = 14
Footer.TextAlignment = Enum.TextAlignment.Center

--// Functions
local function GetClosestEnemy()
    local closestEnemy = nil
    local closestDist = MaxFOV

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if TeamCheck and player.Team == LocalPlayer.Team then
                continue
            end
            
            local targetPos = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            local mousePos = UserInputService:GetMouseLocation()
            local distance = (Vector2.new(targetPos.X, targetPos.Y) - mousePos).Magnitude

            if distance < closestDist then
                closestDist = distance
                closestEnemy = player.Character.HumanoidRootPart
            end
        end
    end
    return closestEnemy
end

RunService.RenderStepped:Connect(function()
    if AimbotEnabled and UserInputService:IsMouseButtonPressed(AimbotKey) then
        local target = GetClosest
