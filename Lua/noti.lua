return function()
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local LocalPlayer = Players.LocalPlayer
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

    local NotifUI = Instance.new("ScreenGui")
    NotifUI.Name = "NotifUI"
    NotifUI.Parent = PlayerGui
    NotifUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local Holder = Instance.new("ScrollingFrame")
    Holder.Name = "Holder"
    Holder.Parent = NotifUI
    Holder.Active = true
    Holder.AnchorPoint = Vector2.new(1, 0)
    Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Holder.BackgroundTransparency = 1
    Holder.BorderSizePixel = 0
    Holder.Position = UDim2.new(1, 0, 0.1, 0)
    Holder.Size = UDim2.new(0.25, 0, 1, 0)
    Holder.CanvasSize = UDim2.new(0, 0, 0, 0)

    local Sorter = Instance.new("UIListLayout")
    Sorter.Name = "Sorter"
    Sorter.Parent = Holder
    Sorter.HorizontalAlignment = Enum.HorizontalAlignment.Center
    Sorter.SortOrder = Enum.SortOrder.LayoutOrder
    Sorter.VerticalAlignment = Enum.VerticalAlignment.Center
    Sorter.Padding = UDim.new(0, 15)

    local function CreateNotification(Options)
        if type(Options) ~= "table" then
            warn("CreateNotification: Options should be a table")
            return
        end

        local Buttons = Options.Buttons or {}
        local Title = Options.Title or ""
        local Content = Options.Content or ""
        local Length = Options.Length or 5
        local NeverExpire = Options.NeverExpire or false

        local Dismiss = Instance.new("Frame")
        local UICorner = Instance.new("UICorner")
        local TextLabel = Instance.new("TextLabel")
        local TextLabel_2 = Instance.new("TextLabel")

        Dismiss.Name = "Notification"
        Dismiss.Parent = Holder
        Dismiss.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Dismiss.BackgroundTransparency = 1
        Dismiss.BorderSizePixel = 0
        Dismiss.Size = UDim2.new(0, 262, 0, 132)
        Dismiss.Position = UDim2.new(0, 0, 0, 0)
        Dismiss.Visible = true

        UICorner.Parent = Dismiss

        TextLabel.Parent = Dismiss
        TextLabel.BackgroundTransparency = 1
        TextLabel.Position = UDim2.new(0.057, 0, 0.053, 0)
        TextLabel.Size = UDim2.new(0, 194, 0, 29)
        TextLabel.Font = Enum.Font.GothamMedium
        TextLabel.Text = Title
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.TextSize = 16
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel.TextTransparency = 1

        TextLabel_2.Parent = Dismiss
        TextLabel_2.BackgroundTransparency = 1
        TextLabel_2.Position = UDim2.new(0.057, 0, 0.303, 0)
        TextLabel_2.Size = UDim2.new(0, 233, 0, 52)
        TextLabel_2.Font = Enum.Font.Gotham
        TextLabel_2.Text = Content
        TextLabel_2.TextColor3 = Color3.fromRGB(234, 234, 234)
        TextLabel_2.TextSize = 14
        TextLabel_2.TextWrapped = true
        TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel_2.TextYAlignment = Enum.TextYAlignment.Top
        TextLabel_2.TextTransparency = 1

        local buttons = {}

        for i, buttonInfo in ipairs(Buttons) do
            local btn = Instance.new("TextButton")
            btn.Parent = Dismiss
            btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            btn.BorderSizePixel = 0
            btn.Size = UDim2.new(0, 233, 0, 29)
            btn.Position = UDim2.new(0.057, 0, 0.697 + (i - 1) * 0.15, 0)
            btn.Font = Enum.Font.GothamMedium
            btn.Text = buttonInfo.Title or "Button"
            btn.TextColor3 = Color3.fromRGB(0, 0, 0)
            btn.TextSize = 16
            btn.TextStrokeTransparency = 1
            btn.TextTransparency = 1

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = btn

            btn.MouseButton1Click:Connect(function()
                if buttonInfo.Callback then
                    task.spawn(buttonInfo.Callback)
                end
                if buttonInfo.ClosesUI then
                    TweenService:Create(Dismiss, TweenInfo.new(0.3), {
                        BackgroundTransparency = 1,
                        Position = Dismiss.Position + UDim2.new(0.1, 0, 0, 20)
                    }):Play()
                    for _, v in pairs(Dismiss:GetDescendants()) do
                        if v:IsA("TextLabel") or v:IsA("TextButton") then
                            TweenService:Create(v, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
                        end
                    end
                    task.wait(0.3)
                    Dismiss:Destroy()
                end
            end)

            table.insert(buttons, btn)
        end

        Dismiss.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(Dismiss, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 262, 0, 132),
            BackgroundTransparency = 0.3
        }):Play()

        TweenService:Create(TextLabel, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
        TweenService:Create(TextLabel_2, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
        for _, btn in pairs(buttons) do
            TweenService:Create(btn, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
        end

        if not NeverExpire then
            task.delay(Length, function()
                if not Dismiss or not Dismiss.Parent then return end
                for _, v in pairs(Dismiss:GetDescendants()) do
                    if v:IsA("TextLabel") or v:IsA("TextButton") then
                        TweenService:Create(v, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
                    end
                end
                TweenService:Create(Dismiss, TweenInfo.new(0.3), {
                    BackgroundTransparency = 1,
                    Position = Dismiss.Position + UDim2.new(0.1, 0, 0, 20)
                }):Play()
                task.wait(0.3)
                Dismiss:Destroy()
            end)
        end
    end

    return {
        CreateNotification = CreateNotification
    }
end
