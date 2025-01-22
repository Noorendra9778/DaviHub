-- DaviHub UI Library
local DaviHub = {}
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")

-- Create the main UI window
function DaviHub:CreateWindow(settings)
    settings = settings or {}
    local windowName = settings.Name or "DaviHub"
    local themeColor = settings.ThemeColor or Color3.fromRGB(143, 4, 182)
    local openAnimation = settings.OpenAnimation or true

    -- Main ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = PlayerGui
    ScreenGui.Name = windowName
    ScreenGui.ResetOnSpawn = false

    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = themeColor
    MainFrame.Size = UDim2.new(0.4, 0, 0.6, 0) -- Scaled size for PC and mobile
    MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
    MainFrame.ClipsDescendants = true
    MainFrame.Active = true
    MainFrame.Draggable = true

    -- UI Corner (Rounded Edges)
    local UICorner = Instance.new("UICorner", MainFrame)
    UICorner.CornerRadius = UDim.new(0, 10)

    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = themeColor
    TitleBar.Size = UDim2.new(1, 0, 0.1, 0)

    -- Title Text
    local TitleText = Instance.new("TextLabel")
    TitleText.Parent = TitleBar
    TitleText.Text = windowName
    TitleText.Font = Enum.Font.SourceSansBold
    TitleText.TextSize = 20
    TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleText.BackgroundTransparency = 1
    TitleText.Size = UDim2.new(1, 0, 1, 0)

    -- Minimize Button
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Parent = TitleBar
    MinimizeButton.Text = "_"
    MinimizeButton.Font = Enum.Font.SourceSansBold
    MinimizeButton.TextSize = 20
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
    MinimizeButton.Size = UDim2.new(0.1, 0, 1, 0)
    MinimizeButton.Position = UDim2.new(0.8, 0, 0, 0)

    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Parent = TitleBar
    CloseButton.Text = "X"
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.TextSize = 20
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    CloseButton.Size = UDim2.new(0.1, 0, 1, 0)
    CloseButton.Position = UDim2.new(0.9, 0, 0, 0)

    -- Tabs and Content Area
    local TabsContainer = Instance.new("Frame")
    TabsContainer.Parent = MainFrame
    TabsContainer.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabsContainer.Size = UDim2.new(0.2, 0, 0.9, 0)
    TabsContainer.Position = UDim2.new(0, 0, 0.1, 0)

    local TabsLayout = Instance.new("UIListLayout", TabsContainer)
    TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabsLayout.Padding = UDim.new(0, 5)

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Parent = MainFrame
    ContentFrame.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
    ContentFrame.Size = UDim2.new(0.8, 0, 0.9, 0)
    ContentFrame.Position = UDim2.new(0.2, 0, 0.1, 0)

    local Pages = {}

    -- Animations
    if openAnimation then
        MainFrame.Position = UDim2.new(0.3, 0, -0.8, 0)
        TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0.3, 0, 0.2, 0)}):Play()
    end

    -- Minimize Functionality
    local isMinimized = false
    MinimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        ContentFrame.Visible = not isMinimized
        TabsContainer.Visible = not isMinimized
    end)

    -- Close Functionality
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Add Tab
    local function AddTab(tabName)
        local TabButton = Instance.new("TextButton")
        TabButton.Parent = TabsContainer
        TabButton.Text = tabName
        TabButton.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
        TabButton.Size = UDim2.new(1, 0, 0, 30)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)

        local Page = Instance.new("ScrollingFrame")
        Page.Parent = ContentFrame
        Page.Visible = false
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.CanvasSize = UDim2.new(0, 0, 0, 500)
        Page.BackgroundTransparency = 1

        local PageLayout = Instance.new("UIListLayout", Page)
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Padding = UDim.new(0, 5)

        Pages[TabButton] = Page

        TabButton.MouseButton1Click:Connect(function()
            for button, page in pairs(Pages) do
                button.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
                page.Visible = false
            end
            TabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            Page.Visible = true
        end)

        if #TabsContainer:GetChildren() == 2 then
            TabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            Page.Visible = true
        end

        return Page
    end

    -- Add Button
    local function AddButton(parent, text, callback)
        local Button = Instance.new("TextButton")
        Button.Parent = parent
        Button.Text = text
        Button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Size = UDim2.new(1, 0, 0, 30)

        Button.MouseButton1Click:Connect(function()
            if callback then callback() end
        end)
    end

    return {
        AddTab = AddTab,
        AddButton = AddButton,
    }
end

return DaviHub