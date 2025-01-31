local DaviHub = {}
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")

function DaviHub:CreateWindow(settings)
    settings = settings or {}
    local windowName = settings.Name or "DaviHub"
    local themeColor = settings.ThemeColor or Color3.fromRGB(46, 46, 46)
    local textColor = settings.TextColor or Color3.fromRGB(255, 255, 255)
    local openAnimation = settings.OpenAnimation or true

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = PlayerGui
    ScreenGui.Name = windowName
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame")
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = themeColor
    MainFrame.Size = UDim2.new(0.4, 0, 0.6, 0)
    MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
    MainFrame.ClipsDescendants = true
    MainFrame.Active = true
    MainFrame.Draggable = true

    local UICorner = Instance.new("UICorner", MainFrame)
    UICorner.CornerRadius = UDim.new(0, 16)

    local TitleBar = Instance.new("Frame")
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TitleBar.Size = UDim2.new(1, 0, 0.1, 0)

    local TitleText = Instance.new("TextLabel")
    TitleText.Parent = TitleBar
    TitleText.Text = windowName
    TitleText.Font = Enum.Font.GothamBold
    TitleText.TextSize = 22
    TitleText.TextColor3 = textColor
    TitleText.BackgroundTransparency = 1
    TitleText.Size = UDim2.new(0.8, 0, 1, 0)

    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Parent = TitleBar
    MinimizeButton.Text = "-"
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.TextSize = 20
    MinimizeButton.TextColor3 = textColor
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    MinimizeButton.Size = UDim2.new(0.1, 0, 1, 0)
    MinimizeButton.Position = UDim2.new(0.8, 0, 0, 0)

    local CloseButton = Instance.new("TextButton")
    CloseButton.Parent = TitleBar
    CloseButton.Text = "X"
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 20
    CloseButton.TextColor3 = Color3.fromRGB(255, 85, 85)
    CloseButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    CloseButton.Size = UDim2.new(0.1, 0, 1, 0)
    CloseButton.Position = UDim2.new(0.9, 0, 0, 0)

    local TabsContainer = Instance.new("Frame")
    TabsContainer.Parent = MainFrame
    TabsContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabsContainer.Size = UDim2.new(0.2, 0, 0.9, 0)
    TabsContainer.Position = UDim2.new(0, 0, 0.1, 0)

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Parent = MainFrame
    ContentFrame.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
    ContentFrame.Size = UDim2.new(0.8, 0, 0.9, 0)
    ContentFrame.Position = UDim2.new(0.2, 0, 0.1, 0)

    local TabsLayout = Instance.new("UIListLayout", TabsContainer)
    TabsLayout.Padding = UDim.new(0, 5)
    TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local Pages = {}
    local CurrentTab = nil

    if openAnimation then
        MainFrame.Position = UDim2.new(0.3, 0, -0.8, 0)
        TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0.3, 0, 0.2, 0)}):Play()
    end

    MinimizeButton.MouseButton1Click:Connect(function()
        local visible = not ContentFrame.Visible
        ContentFrame.Visible = visible
        TabsContainer.Visible = visible
    end)

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local function AddTab(tabName)
        local TabButton = Instance.new("TextButton")
        TabButton.Parent = TabsContainer
        TabButton.Text = tabName
        TabButton.Font = Enum.Font.GothamBold
        TabButton.TextSize = 18
        TabButton.TextColor3 = textColor
        TabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        TabButton.Size = UDim2.new(1, 0, 0, 30)

        local Page = Instance.new("ScrollingFrame")
        Page.Parent = ContentFrame
        Page.Visible = false
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Pages[TabButton] = Page

        TabButton.MouseButton1Click:Connect(function()
            if CurrentTab then
                CurrentTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                Pages[CurrentTab].Visible = false
            end
            CurrentTab = TabButton
            TabButton.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
            Page.Visible = true
        end)

        if not CurrentTab then
            TabButton.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
            Page.Visible = true
            CurrentTab = TabButton
        end

        return Page
    end

    local function AddButton(parent, text, callback)
        local Button = Instance.new("TextButton")
