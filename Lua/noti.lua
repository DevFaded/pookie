return function()
	local TweenService = game:GetService("TweenService")

	local NotifUI = Instance.new("ScreenGui")
	NotifUI.Name = "NotifUI"
	NotifUI.ResetOnSpawn = false
	NotifUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	NotifUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local Holder = Instance.new("ScrollingFrame")
	Holder.Name = "Holder"
	Holder.Parent = NotifUI
	Holder.Active = true
	Holder.AnchorPoint = Vector2.new(1, 0)
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
		Dismiss.Name = "Notification"
		Dismiss.Parent = Holder
		Dismiss.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		Dismiss.BackgroundTransparency = 1
		Dismiss.BorderSizePixel = 0
		Dismiss.Size = UDim2.new(0, 262, 0, 132)
		Dismiss.Position = UDim2.new(0, 0, 0, 0)
		Dismiss.Visible = true

		local UICorner = Instance.new("UICorner", Dismiss)

		local TextLabel = Instance.new("TextLabel")
		TextLabel.Parent = Dismiss
		TextLabel.BackgroundTransparency = 1
		TextLabel.Position = UDim2.new(0.057, 0, 0.053, 0)
		TextLabel.Size = UDim2.new(0, 194, 0, 29)
		TextLabel.Font = Enum.Font.GothamMedium
		TextLabel.Text = Options.Title
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.TextSize = 16
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel.TextTransparency = 1

		local TextLabel_2 = Instance.new("TextLabel")
		TextLabel_2.Parent = Dismiss
		TextLabel_2.BackgroundTransparency = 1
		TextLabel_2.Position = UDim2.new(0.057, 0, 0.303, 0)
		TextLabel_2.Size = UDim2.new(0, 233, 0, 52)
		TextLabel_2.Font = Enum.Font.Gotham
		TextLabel_2.Text = Options.Content
		TextLabel_2.TextColor3 = Color3.fromRGB(234, 234, 234)
		TextLabel_2.TextSize = 14
		TextLabel_2.TextWrapped = true
		TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel_2.TextYAlignment = Enum.TextYAlignment.Top
		TextLabel_2.TextTransparency = 1

		local numButtons = #Options.Buttons
		local buttonWidth = math.floor((233 - (numButtons - 1) * 5) / numButtons)

		for i, btn in ipairs(Options.Buttons) do
			local TextButton = Instance.new("TextButton")
			TextButton.Parent = Dismiss
			TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextButton.Position = UDim2.new(0, 13 + (buttonWidth + 5) * (i - 1), 0.697, 0)
			TextButton.Size = UDim2.new(0, buttonWidth, 0, 29)
			TextButton.Font = Enum.Font.GothamMedium
			TextButton.Text = btn.Title or "Button"
			TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			TextButton.TextSize = 16
			TextButton.TextTransparency = 1

			local UICorner_2 = Instance.new("UICorner", TextButton)
			UICorner_2.CornerRadius = UDim.new(0, 6)

			TextButton.MouseButton1Click:Connect(function()
				if btn.Callback then
					task.spawn(btn.Callback)
				end
				if btn.ClosesUI then
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

			TweenService:Create(TextButton, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
		end

		Dismiss.Size = UDim2.new(0, 0, 0, 0)
		TweenService:Create(Dismiss, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 262, 0, 132),
			BackgroundTransparency = 0.3
		}):Play()

		TweenService:Create(TextLabel, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
		TweenService:Create(TextLabel_2, TweenInfo.new(0.4), {TextTransparency = 0}):Play()

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
