local DaviHub = {}
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

function DaviHub:CreateWindow(settings)
    settings = settings or {}
    local windowName = settings.Name or "HubTitle"
    local themeColor = settings.ThemeColor or Color3.fromRGB(35, 35, 35)
    local textColor = settings.TextColor or Color3.fromRGB(255, 255, 255)

    -- ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = PlayerGui
    ScreenGui.Name = windowName
    ScreenGui.ResetOnSpawn = false

    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = themeColor
    MainFrame.Size = UDim2.new(0.5, 0, 0.6, 0)
    MainFrame.Position = UDim2.new(0.25, 0, 0.2, 0)

    local UICorner = Instance.new("UICorner", MainFrame)
    UICorner.CornerRadius = UDim.new(0, 16)

    -- Title Bar
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
    TitleText.Size = UDim2.new(0.5, 0, 1, 0)
    TitleText.Position = UDim2.new(0.05, 0, 0, 0)

    -- Minimize Button
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Parent = TitleBar
    MinimizeButton.Text = "-"
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.TextSize = 20
    MinimizeButton.TextColor3 = textColor
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    MinimizeButton.Size = UDim2.new(0.1, 0, 1, 0)
    MinimizeButton.Position = UDim2.new(0.8, 0, 0, 0)

    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Parent = TitleBar
    CloseButton.Text = "X"
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 20
    CloseButton.TextColor3 = Color3.fromRGB(255, 85, 85)
    CloseButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    CloseButton.Size = UDim2.new(0.1, 0, 1, 0)
    CloseButton.Position = UDim2.new(0.9, 0, 0, 0)

    -- Tabs Container
    local TabsContainer = Instance.new("Frame")
    TabsContainer.Parent = MainFrame
    TabsContainer.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabsContainer.Size = UDim2.new(0.2, 0, 0.9, 0)
    TabsContainer.Position = UDim2.new(0, 0, 0.1, 0)

    local TabsLayout = Instance.new("UIListLayout", TabsContainer)
    TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabsLayout.Padding = UDim.new(0, 5)

    -- Content Area (with scrollbar)
    local ContentFrame = Instance.new("ScrollingFrame")
    ContentFrame.Parent = MainFrame
    ContentFrame.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
    ContentFrame.Size = UDim2.new(0.8, 0, 0.9, 0)
    ContentFrame.Position = UDim2.new(0.2, 0, 0.1, 0)
    ContentFrame.CanvasSize = UDim2.new(0, 0, 2, 0) -- Scrollable content
    ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)

    local Pages = {}

    -- Minimize and Close Functionality
    MinimizeButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Dragging functionality
    local isDragging = false
    local dragStart
    local startPos

    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)

    TitleBar.InputChanged:Connect(function(input)
        if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    TitleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = false
        end
    end)

    -- Add Tab Functionality
    local function AddTab(tabName)
        local TabButton = Instance.new("TextButton")
        TabButton.Parent = TabsContainer
        TabButton.Text = tabName
        TabButton.Font = Enum.Font.GothamBold
        TabButton.TextSize = 14
        TabButton.TextColor3 = Color3.fromRGB(173, 216, 230)
        TabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        TabButton.Size = UDim2.new(1, 0, 0, 40)

        local UICorner = Instance.new("UICorner", TabButton)
        UICorner.CornerRadius = UDim.new(0, 10)

        local Page = Instance.new("Frame")
        Page.Parent = ContentFrame
        Page.Visible = false
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1

        Pages[TabButton] = Page

        TabButton.MouseButton1Click:Connect(function()
            for button, page in pairs(Pages) do
                button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                page.Visible = false
            end
            TabButton.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
            Page.Visible = true
        end)

        return Page
    end

    return {
        AddTab = AddTab,
    }
end

return DaviHub
