return function()
	local NotifUI = Instance.new("ScreenGui")
	local Holder = Instance.new("ScrollingFrame")
	local Buttons = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local TextLabel_3 = Instance.new("TextLabel")
	local TextLabel_4 = Instance.new("TextLabel")
	local TextButton_2 = Instance.new("TextButton")
	local UICorner_4 = Instance.new("UICorner")
	local TextButton_3 = Instance.new("TextButton")
	local UICorner_5 = Instance.new("UICorner")
	local Sorter = Instance.new("UIListLayout")

	NotifUI.Name = "NotifUI"
	NotifUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	NotifUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Holder.Name = "Holder"
	Holder.Parent = NotifUI
	Holder.Active = true
	Holder.AnchorPoint = Vector2.new(1, 0)
	Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Holder.BackgroundTransparency = 1.000
	Holder.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Holder.BorderSizePixel = 0
	Holder.Position = UDim2.new(1, 0, 0.1, 0)
	Holder.Size = UDim2.new(0.25, 0, 1, 0)
	Holder.CanvasSize = UDim2.new(0, 0, 0, 0)

	Sorter.Name = "Sorter"
	Sorter.Parent = Holder
	Sorter.HorizontalAlignment = Enum.HorizontalAlignment.Center
	Sorter.SortOrder = Enum.SortOrder.LayoutOrder
	Sorter.VerticalAlignment = Enum.VerticalAlignment.Center
	Sorter.Padding = UDim.new(0, 15)

	local function SetDefault(v1, v2)
		v1 = v1 or {}
		local v3 = {}
		for i, v in next, v2 do
			v3[i] = v1[i] or v2[i]
		end
		return v3
	end

	local function CreateNotification(Options)
		local Default = {
			Buttons = {
				[1] = {
					Title = 'Dismiss',
					ClosesUI = true,
					Callback = function() end
				}
			},
			Title = 'Notification Title',
			Content = 'Placeholder notification content',
			Length = 5,
			NeverExpire = false
		}
		Options = SetDefault(Options, Default)

		local Dismiss = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local TextLabel = Instance.new("TextLabel")
		local TextLabel_2 = Instance.new("TextLabel")
		local TextButton = Instance.new("TextButton")
		local UICorner_2 = Instance.new("UICorner")
		local TweenService = game:GetService("TweenService")

		Dismiss.Name = "Notification"
		Dismiss.Parent = Holder
		Dismiss.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		Dismiss.BackgroundTransparency = 1
		Dismiss.BorderColor3 = Color3.fromRGB(27, 42, 53)
		Dismiss.Size = UDim2.new(0, 262, 0, 132)
		Dismiss.Position = UDim2.new(0, 0, 0, 0)
		Dismiss.Visible = true

		UICorner.Parent = Dismiss

		TextLabel.Parent = Dismiss
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.BorderColor3 = Color3.fromRGB(27, 42, 53)
		TextLabel.Position = UDim2.new(0.057, 0, 0.053, 0)
		TextLabel.Size = UDim2.new(0, 194, 0, 29)
		TextLabel.Font = Enum.Font.GothamMedium
		TextLabel.Text = Options.Title
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.TextSize = 16.000
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel.TextTransparency = 1

		TextLabel_2.Parent = Dismiss
		TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel_2.BackgroundTransparency = 1.000
		TextLabel_2.BorderColor3 = Color3.fromRGB(27, 42, 53)
		TextLabel_2.Position = UDim2.new(0.057, 0, 0.303, 0)
		TextLabel_2.Size = UDim2.new(0, 233, 0, 52)
		TextLabel_2.Font = Enum.Font.Gotham
		TextLabel_2.Text = Options.Content
		TextLabel_2.TextColor3 = Color3.fromRGB(234, 234, 234)
		TextLabel_2.TextSize = 14.000
		TextLabel_2.TextWrapped = true
		TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel_2.TextYAlignment = Enum.TextYAlignment.Top
		TextLabel_2.TextTransparency = 1

		if Options.Buttons[1] then
			TextButton.Parent = Dismiss
			TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextButton.BorderColor3 = Color3.fromRGB(27, 42, 53)
			TextButton.Position = UDim2.new(0.057, 0, 0.697, 0)
			TextButton.Size = UDim2.new(0, 233, 0, 29)
			TextButton.Font = Enum.Font.GothamMedium
			TextButton.Text = Options.Buttons[1].Title or "Dismiss"
			TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			TextButton.TextSize = 16.000
			TextButton.TextStrokeColor3 = Color3.fromRGB(31, 33, 35)
			TextButton.TextTransparency = 1
			UICorner_2.CornerRadius = UDim.new(0, 6)
			UICorner_2.Parent = TextButton
			TextButton.MouseButton1Click:Connect(function()
				if Options.Buttons[1].Callback then
					task.spawn(Options.Buttons[1].Callback)
				end
				if Options.Buttons[1].ClosesUI then
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
		end

		Dismiss.Size = UDim2.new(0, 0, 0, 0)
		TweenService:Create(Dismiss, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 262, 0, 132),
			BackgroundTransparency = 0.3
		}):Play()

		TweenService:Create(TextLabel, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
		TweenService:Create(TextLabel_2, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
		if TextButton then
			TweenService:Create(TextButton, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
		end

		if not Options.NeverExpire then
			task.delay(Options.Length, function()
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

	return CreateNotification
end
