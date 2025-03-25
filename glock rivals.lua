local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local AimbotEnabled = false
local AimbotKey = Enum.UserInputType.MouseButton2
local AimSmoothness = 0.15
local MaxFOV = 100
local TeamCheck = true
local PredictionAmount = 0.5

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleButton = Instance.new("TextButton")
local SmoothnessSlider = Instance.new("TextButton")
local FOVSlider = Instance.new("TextButton")
local PredictionSlider = Instance.new("TextButton")
local Footer = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "glock.lol"

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BackgroundTransparency = 0.2
MainFrame.Size = UDim2.new(0, 250, 0, 290)
MainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

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

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = Title

ToggleButton.Parent = MainFrame
ToggleButton.Size = UDim2.new(0.8, 0, 0, 40)
ToggleButton.Position = UDim2.new(0.1, 0, 0.2, 0)
ToggleButton.Text = "Aimbot: OFF"
ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.Gotham
ToggleButton.TextSize = 18
ToggleButton.TextStrokeTransparency = 0.5
ToggleButton.BorderSizePixel = 0
ToggleButton.AutoButtonColor = true

SmoothnessSlider.Parent = MainFrame
SmoothnessSlider.Size = UDim2.new(0.8, 0, 0, 40)
SmoothnessSlider.Position = UDim2.new(0.1, 0, 0.45, 0)
SmoothnessSlider.Text = "Smoothness: " .. AimSmoothness
SmoothnessSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SmoothnessSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
SmoothnessSlider.Font = Enum.Font.Gotham
SmoothnessSlider.TextSize = 18
SmoothnessSlider.TextStrokeTransparency = 0.5
SmoothnessSlider.BorderSizePixel = 0
SmoothnessSlider.AutoButtonColor = true

FOVSlider.Parent = MainFrame
FOVSlider.Size = UDim2.new(0.8, 0, 0, 40)
FOVSlider.Position = UDim2.new(0.1, 0, 0.7, 0)
FOVSlider.Text = "FOV: " .. MaxFOV
FOVSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
FOVSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
FOVSlider.Font = Enum.Font.Gotham
FOVSlider.TextSize = 18
FOVSlider.TextStrokeTransparency = 0.5
FOVSlider.BorderSizePixel = 0
FOVSlider.AutoButtonColor = true

PredictionSlider.Parent = MainFrame
PredictionSlider.Size = UDim2.new(0.8, 0, 0, 40)
PredictionSlider.Position = UDim2.new(0.1, 0, 0.85, 0)
PredictionSlider.Text = "Prediction: " .. PredictionAmount
PredictionSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
PredictionSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
PredictionSlider.Font = Enum.Font.Gotham
PredictionSlider.TextSize = 18
PredictionSlider.TextStrokeTransparency = 0.5
PredictionSlider.BorderSizePixel = 0
PredictionSlider.AutoButtonColor = true

Footer.Parent = MainFrame
Footer.Text = "glock.lol | Aimbot"
Footer.Size = UDim2.new(1, 0, 0, 30)
Footer.Position = UDim2.new(0, 0, 1, -30)
Footer.TextColor3 = Color3.fromRGB(200, 200, 200)
Footer.BackgroundTransparency = 1
Footer.Font = Enum.Font.Gotham
Footer.TextSize = 14
Footer.TextAlignment = Enum.TextAlignment.Center

local FooterCorner = Instance.new("UICorner")
FooterCorner.CornerRadius = UDim.new(0, 8)
FooterCorner.Parent = Footer

local function onHover(button)
    local tween = TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)})
    tween:Play()
end

local function offHover(button)
    local tween = TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)})
    tween:Play()
end

ToggleButton.MouseEnter:Connect(function() onHover(ToggleButton) end)
ToggleButton.MouseLeave:Connect(function() offHover(ToggleButton) end)

SmoothnessSlider.MouseEnter:Connect(function() onHover(SmoothnessSlider) end)
SmoothnessSlider.MouseLeave:Connect(function() offHover(SmoothnessSlider) end)

FOVSlider.MouseEnter:Connect(function() onHover(FOVSlider) end)
FOVSlider.MouseLeave:Connect(function() offHover(FOVSlider) end)

PredictionSlider.MouseEnter:Connect(function() onHover(PredictionSlider) end)
PredictionSlider.MouseLeave:Connect(function() offHover(PredictionSlider) end)

ToggleButton.MouseButton1Click:Connect(function()
    AimbotEnabled = not AimbotEnabled
    if AimbotEnabled then
        ToggleButton.Text = "Aimbot: ON"
    else
        ToggleButton.Text = "Aimbot: OFF"
    end
end)

SmoothnessSlider.MouseButton1Click:Connect(function()
    AimSmoothness = AimSmoothness + 0.05
    if AimSmoothness > 1 then AimSmoothness = 0.1 end
    SmoothnessSlider.Text = "Smoothness: " .. string.format("%.2f", AimSmoothness)
end)

FOVSlider.MouseButton1Click:Connect(function()
    MaxFOV = MaxFOV + 10
    if MaxFOV > 200 then MaxFOV = 100 end
    FOVSlider.Text = "FOV: " .. MaxFOV
end)

PredictionSlider.MouseButton1Click:Connect(function()
    PredictionAmount = PredictionAmount + 0.1
    if PredictionAmount > 1 then PredictionAmount = 0.1 end
    PredictionSlider.Text = "Prediction: " .. string.format("%.1f", PredictionAmount)
end)

local function PredictPosition(target)
    if target:FindFirstChild("Humanoid") and target:FindFirstChild("HumanoidRootPart") then
        local targetVelocity = target.HumanoidRootPart.Velocity
        if targetVelocity.Magnitude > 0 then
            return target.HumanoidRootPart.Position + targetVelocity * PredictionAmount
        end
    end
    return target.HumanoidRootPart.Position
end

RunService.RenderStepped:Connect(function()
    if AimbotEnabled and UserInputService:IsMouseButtonPressed(AimbotKey) then
        local closestEnemy = GetClosestEnemy()
        if closestEnemy then
            local targetPos = PredictPosition(closestEnemy)
            local direction = (targetPos - Camera.CFrame.Position).unit
            local newCFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, targetPos), AimSmoothness)
            Camera.CFrame = newCFrame
        end
    end
end)

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
