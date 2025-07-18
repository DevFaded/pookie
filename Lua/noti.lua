return {
	CreateNotification = function(Options)
		local TweenService = game:GetService("TweenService")

		local NotifUI = Instance.new("ScreenGui")
		NotifUI.Name = "NotifUI"
		NotifUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
		NotifUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

		local Holder = Instance.new("Frame")
		Holder.Name = "Holder"
		Holder.Parent = NotifUI
		Holder.AnchorPoint = Vector2.new(0.5, 0)
		Holder.Position = UDim2.new(0.5, 0, 0.1, 0)
		Holder.BackgroundTransparency = 1
		Holder.Size = UDim2.new(0, 280, 0, 150)

		local Notification = Instance.new("Frame")
		Notification.Name = "Notification"
		Notification.Parent = Holder
		Notification.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		Notification.Size = UDim2.new(1, 0, 1, 0)
		Notification.AnchorPoint = Vector2.new(0.5, 0)
		Notification.Position = UDim2.new(0.5, 0, 0, 0)
		Notification.BackgroundTransparency = 1
		Notification.ClipsDescendants = true
		Notification.AutoButtonColor = false
		Notification.BorderSizePixel = 0
		Notification.UICorner = Instance.new("UICorner", Notification)
		Notification.UICorner.CornerRadius = UDim.new(0, 10)

		local Title = Instance.new("TextLabel")
		Title.Parent = Notification
		Title.BackgroundTransparency = 1
		Title.Position = UDim2.new(0, 12, 0, 12)
		Title.Size = UDim2.new(1, -24, 0, 26)
		Title.Font = Enum.Font.GothamBold
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title.TextSize = 18
		Title.TextXAlignment = Enum.TextXAlignment.Left
		Title.Text = Options.Title or "Notification Title"

		local Content = Instance.new("TextLabel")
		Content.Parent = Notification
		Content.BackgroundTransparency = 1
		Content.Position = UDim2.new(0, 12, 0, 42)
		Content.Size = UDim2.new(1, -24, 0, 70)
		Content.Font = Enum.Font.Gotham
		Content.TextColor3 = Color3.fromRGB(220, 220, 220)
		Content.TextSize = 14
		Content.TextWrapped = true
		Content.TextXAlignment = Enum.TextXAlignment.Left
		Content.TextYAlignment = Enum.TextYAlignment.Top
		Content.Text = Options.Content or "Notification content here."

		local ButtonsFrame = Instance.new("Frame")
		ButtonsFrame.Parent = Notification
		ButtonsFrame.BackgroundTransparency = 1
		ButtonsFrame.Position = UDim2.new(0, 12, 1, -44)
		ButtonsFrame.Size = UDim2.new(1, -24, 0, 32)

		-- Layout buttons horizontally with spacing
		local UIListLayout = Instance.new("UIListLayout")
		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 10)
		UIListLayout.Parent = ButtonsFrame

		-- Helper: default buttons if none provided
		local Buttons = Options.Buttons
		if not Buttons or #Buttons == 0 then
			Buttons = {
				{
					Title = "Dismiss",
					ClosesUI = true,
					Callback = function() end,
				}
			}
		end

		-- Create buttons
		for i, btnData in ipairs(Buttons) do
			local btn = Instance.new("TextButton")
			btn.Parent = ButtonsFrame
			btn.AutoButtonColor = true
			btn.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
			btn.TextColor3 = Color3.fromRGB(15, 15, 15)
			btn.Font = Enum.Font.GothamSemibold
			btn.TextSize = 14
			btn.Text = btnData.Title or "Button"
			btn.Size = UDim2.new(0, 0, 1, 0) -- will resize by text later
			btn.ClipsDescendants = true
			btn.AnchorPoint = Vector2.new(0, 0)
			btn.BorderSizePixel = 0

			local UICorner = Instance.new("UICorner")
			UICorner.CornerRadius = UDim.new(0, 6)
			UICorner.Parent = btn

			-- Wait a frame to measure text size for autosize
			task.defer(function()
				local textSize = btn.TextBounds
				btn.Size = UDim2.new(0, textSize.X + 20, 1, 0) -- 20 px padding left+right
			end)

			btn.MouseButton1Click:Connect(function()
				if btnData.Callback then
					task.spawn(btnData.Callback)
				end
				if btnData.ClosesUI then
					-- Animate out and destroy
					TweenService:Create(Notification, TweenInfo.new(0.25), {
						BackgroundTransparency = 1,
						Position = Notification.Position + UDim2.new(0, 0, 0, 30),
					}):Play()

					for _, v in pairs(Notification:GetDescendants()) do
						if v:IsA("TextLabel") or v:IsA("TextButton") then
							TweenService:Create(v, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
						end
					end

					task.wait(0.3)
					NotifUI:Destroy()
				end
			end)
		end

		-- Show animation
		TweenService:Create(Notification, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			BackgroundTransparency = 0,
			Position = Notification.Position,
		}):Play()

		-- Fade text in
		for _, v in pairs(Notification:GetChildren()) do
			if v:IsA("TextLabel") or v:IsA("TextButton") then
				v.TextTransparency = 1
				TweenService:Create(v, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
			end
		end

		-- Auto close if needed
		if not Options.NeverExpire then
			task.delay(Options.Length or 5, function()
				if not Notification or not Notification.Parent then return end
				TweenService:Create(Notification, TweenInfo.new(0.25), {
					BackgroundTransparency = 1,
					Position = Notification.Position + UDim2.new(0, 0, 0, 30),
				}):Play()

				for _, v in pairs(Notification:GetDescendants()) do
					if v:IsA("TextLabel") or v:IsA("TextButton") then
						TweenService:Create(v, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
					end
				end

				task.wait(0.3)
				NotifUI:Destroy()
			end)
		end
	end
}
