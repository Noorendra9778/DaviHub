DaviHub UI Library for Roblox

DaviHub is a versatile and user-friendly UI library for Roblox that allows developers to easily create and manage custom in-game interfaces. With its simple setup and robust functionality, DaviHub provides a wide range of features for building interactive, stylish, and functional UI elements.

Installation

To use the DaviHub UI library in your Roblox project, load it using the following code:

local DaviHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/YourGitHubUsername/YourRepo/main/DaviHub.lua"))()

Creating a Window

To create a custom window, use the CreateWindow method. Here’s an example:

local Window = DaviHub:CreateWindow({
    Name = "My Custom Hub",             -- The title of your window
    ThemeColor = Color3.fromRGB(50, 150, 255), -- Set the theme color (optional)
    OpenAnimation = true                -- Enable window opening animation (optional)
})

This creates a window with a title, custom theme color, and animation when opening.

Adding Tabs to the Window

You can add multiple tabs to the window using the AddTab method:

local MainTab = Window.AddTab("Main Tab")    -- Adds a tab named "Main Tab"
local SettingsTab = Window.AddTab("Settings Tab")  -- Adds a tab named "Settings Tab"

Adding Buttons to Tabs

To add buttons to each tab, use the AddButton method. You can define an action that will be executed when the button is clicked. Here’s how to add a button to the "Main Tab":

Window.AddButton(MainTab, "Say Hello", function()
    print("Hello from Main Tab!")
end)

Similarly, add a button to the "Settings Tab":

Window.AddButton(SettingsTab, "Change Settings", function()
    print("Settings Changed!")
end)

Available Features

CreateWindow: Initializes a window with a custom name, theme color, and animation.

AddTab: Adds tabs to the window for better organization.

AddButton: Adds interactive buttons to each tab with custom actions.

Customization: Easily customize the window, tab names, button labels, and colors.


Example of Full Setup:

local DaviHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/YourGitHubUsername/YourRepo/main/DaviHub.lua"))()

local Window = DaviHub:CreateWindow({
    Name = "My Custom Hub",
    ThemeColor = Color3.fromRGB(50, 150, 255),
    OpenAnimation = true
})

local MainTab = Window.AddTab("Main Tab")
Window.AddButton(MainTab, "Say Hello", function()
    print("Hello from Main Tab!")
end)

local SettingsTab = Window.AddTab("Settings Tab")
Window.AddButton(SettingsTab, "Change Settings", function()
    print("Settings Changed!")
end)

Contributions

Feel free to contribute by forking this repository and submitting pull requests. If you encounter any issues, please open an issue, and we’ll address it as soon as possible.
