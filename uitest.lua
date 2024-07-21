lib = {}
if isfolder("FileSystemUI") then
print("TRUE")
else
makefolder("FileSystemUI")
end
if isfolder("FileSystemUI/".._G.Name) then
print("TRUE")
else
makefolder("FileSystemUI/".._G.Name)
end
local function Run(Code: string)
    local Thread = {}
    Thread.Thread = coroutine.create(loadstring(Code))
    
    function Thread:Run()
        coroutine.resume(Thread.Thread)
    end
    function Thread:Suspend()
        coroutine.yield(Thread.Thread)
    end
    function Thread:Terminate()
        print(Thread.Thread, "terminated!")
        coroutine.close(Thread.Thread)
    end
    return Thread
end




local FileExplorer = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local SideBar = Instance.new("Frame")
local SideBarSeparator = Instance.new("Frame")
local Scrolling = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local Top = Instance.new("Frame")
local TopSeparator = Instance.new("Frame")
local TopImage = Instance.new("ImageLabel")
local TopText = Instance.new("TextLabel")


FileExplorer.Name = "FileExplorer"
FileExplorer.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
FileExplorer.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Parent = FileExplorer
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BackgroundTransparency = 1.000
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.181303114, 0, 0.187050357, 0)
MainFrame.Size = UDim2.new(0, 679, 0, 459)

SideBar.Name = "SideBar"
SideBar.Parent = MainFrame
SideBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SideBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
SideBar.BorderSizePixel = 0
SideBar.Position = UDim2.new(0.00109863281, 0, 0.121652506, 0)
SideBar.Size = UDim2.new(0, 169, 0, 402)

SideBarSeparator.Name = "SideBarSeparator"
SideBarSeparator.Parent = SideBar
SideBarSeparator.BackgroundColor3 = Color3.fromRGB(125, 125, 125)
SideBarSeparator.BackgroundTransparency = 0.700
SideBarSeparator.BorderColor3 = Color3.fromRGB(0, 0, 0)
SideBarSeparator.BorderSizePixel = 0
SideBarSeparator.Position = UDim2.new(0.99000001, 0, -0.00400000019, 0)
SideBarSeparator.Size = UDim2.new(0, 1, 0, 402)

Scrolling.Name = "Scrolling"
Scrolling.Parent = SideBar
Scrolling.Active = true
Scrolling.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Scrolling.BackgroundTransparency = 1.000
Scrolling.BorderColor3 = Color3.fromRGB(0, 0, 0)
Scrolling.BorderSizePixel = 0
Scrolling.Size = UDim2.new(0, 169, 0, 402)

UIListLayout.Parent = Scrolling
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

Top.Name = "Top"
Top.Parent = MainFrame
Top.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
Top.BorderSizePixel = 0
Top.Position = UDim2.new(0.00109863281, 0, -0.00639974885, 0)
Top.Size = UDim2.new(0, 678, 0, 59)

TopSeparator.Name = "TopSeparator"
TopSeparator.Parent = Top
TopSeparator.BackgroundColor3 = Color3.fromRGB(125, 125, 125)
TopSeparator.BackgroundTransparency = 0.700
TopSeparator.BorderColor3 = Color3.fromRGB(0, 0, 0)
TopSeparator.BorderSizePixel = 0
TopSeparator.Position = UDim2.new(-0.000643479812, 0, 0.979020774, 0)
TopSeparator.Size = UDim2.new(0, 678, 0, 1)

TopImage.Name = "TopImage"
TopImage.Parent = Top
TopImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TopImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
TopImage.BorderSizePixel = 0
TopImage.Size = UDim2.new(0, 115, 0, 25)
TopImage.Image = "rbxassetid://18585334328"

TopText.Name = "TopText"
TopText.Parent = Top
TopText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TopText.BorderColor3 = Color3.fromRGB(0, 0, 0)
TopText.BorderSizePixel = 0
TopText.Position = UDim2.new(0, 0, 0.423729599, 0)
TopText.Size = UDim2.new(0, 203, 0, 32)
TopText.Font = Enum.Font.SourceSans
TopText.Text = "        File      Home      Share      View"
TopText.TextColor3 = Color3.fromRGB(159, 159, 159)
TopText.TextSize = 14.000
TopText.TextXAlignment = Enum.TextXAlignment.Left



local UIS = game:GetService('UserInputService')
local frame = MainFrame
local dragToggle = nil
local dragSpeed = 0.25
local dragStart = nil
local startPos = nil

local function updateInput(input)
	local delta = input.Position - dragStart
	local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
		startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	game:GetService('TweenService'):Create(frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
end

frame.InputBegan:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
		dragToggle = true
		dragStart = input.Position
		startPos = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragToggle = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		if dragToggle then
			updateInput(input)
		end
	end
end)


local fc = {}
local cvf = nil
local showfirst=false

local function lib.NewFolder(Name)
    if isfolder("FileSystemUI/".._G.Name.."/"..Name) then
     print("TRUE")
    else
       makefolder("FileSystemUI/".._G.Name.."/"..Name)
    end 
	local FileHolder = Instance.new("Frame")
	local Frame = Instance.new("Frame")
	local TextLabel = Instance.new("TextLabel")
	local ImageLabel = Instance.new("ImageLabel")
	local TextButton = Instance.new("TextButton")
	local uilist	= Instance.new("UIListLayout")

	--Properties:

	Frame.Parent = Scrolling
	Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.new(0, 0, 0.0472636819, 0)
	Frame.Size = UDim2.new(0, 167, 0, 19)

	TextLabel.Parent = Frame
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Position = UDim2.new(0.118343197, 0, 0, 0)
	TextLabel.Size = UDim2.new(0, 149, 0, 19)
	TextLabel.Font = Enum.Font.SourceSans
	TextLabel.Text = Name
	TextLabel.TextColor3 = Color3.fromRGB(126, 126, 126)
	TextLabel.TextSize = 13.000
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left

	ImageLabel.Parent = Frame
	ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ImageLabel.BorderSizePixel = 0
	ImageLabel.Size = UDim2.new(0, 20, 0, 20)
	ImageLabel.Image = "rbxassetid://18585578338"

	TextButton.Parent = Frame
	TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextButton.BackgroundTransparency = 1.000
	TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextButton.BorderSizePixel = 0
	TextButton.Size = UDim2.new(0, 169, 0, 19)
	TextButton.Font = Enum.Font.SourceSans
	TextButton.Text = ""
	TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	TextButton.TextSize = 14.000


	FileHolder.Name = Name .. "FileHolderFrame"
	FileHolder.Parent = MainFrame
	FileHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	FileHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
	FileHolder.BorderSizePixel = 0
	FileHolder.Position = UDim2.new(0.249048427, 0, 0.121652506, 0)
	FileHolder.Size = UDim2.new(0, 509, 0, 402)
	if showfirst==false then
		FileHolder.Visible = true
		showfirst=true
	else	
		FileHolder.Visible = false

	end
	uilist.Parent=FileHolder
	fc[Name] = FileHolder

	local function onFolderClick()
		if cvf then
			cvf.Visible = false
		end
		FileHolder.Visible = true
		cvf = FileHolder
	end

	TextButton.MouseButton1Click:Connect(onFolderClick)
end

local function lib.NewLuaFile(Name, folderName,cb)
	local FolderFrame = fc[folderName]
	if not FolderFrame then
		warn("Folder not found: " .. folderName)
		return
	end
    if isfile("FileSystemUI/".._G.Name.."/"..folderName.."/"..Name) then
     print("TRUE")
     local rd = readfile("FileSystemUI/".._G.Name.."/"..folderName.."/"..Name)
     if rd ~= cb then
                writefile("FileSystemUI/".._G.Name.."/"..folderName.."/"..Name,cb)
     end    
    else
       writefile("FileSystemUI/".._G.Name.."/"..folderName.."/"..Name,cb)
    end 
	local NewLuaFile = Instance.new("Frame")
	local TextLabel = Instance.new("TextLabel")
	local ImageLabel = Instance.new("ImageLabel")
	local TextButton = Instance.new("TextButton")

	--Properties:

	NewLuaFile.Name = "NewLuaFile"
	NewLuaFile.Parent = FolderFrame
	NewLuaFile.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	NewLuaFile.BorderColor3 = Color3.fromRGB(0, 0, 0)
	NewLuaFile.BorderSizePixel = 0
	NewLuaFile.Size = UDim2.new(0, 169, 0, 19)

	TextLabel.Parent = NewLuaFile
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Position = UDim2.new(0.118343197, 0, 0, 0)
	TextLabel.Size = UDim2.new(0, 149, 0, 19)
	TextLabel.Font = Enum.Font.SourceSans
	TextLabel.Text = Name
	TextLabel.TextColor3 = Color3.fromRGB(126, 126, 126)
	TextLabel.TextSize = 13.000
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left

	ImageLabel.Parent = NewLuaFile
	ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ImageLabel.BorderSizePixel = 0
	ImageLabel.Size = UDim2.new(0, 20, 0, 20)
	ImageLabel.Image = "http://www.roblox.com/asset/?id=11529272805"

	TextButton.Parent = NewLuaFile
	TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextButton.BackgroundTransparency = 1.000
	TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextButton.BorderSizePixel = 0
	TextButton.Size = UDim2.new(0, 236, 0, 19)
	TextButton.Font = Enum.Font.SourceSans
	TextButton.Text = ""
	TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	TextButton.TextSize = 14.000

	TextButton.MouseButton1Click:Connect(function()
        local rd = readfile("FileSystemUI/".._G.Name.."/"..folderName.."/"..Name)
        local NewThread = Run(rd)
        NewThread:Run()
    end)

end

local function lib.ShowImg(Name,folderName)
	local IMG = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local ImageLabel = Instance.new("ImageLabel")
	local Frame_2 = Instance.new("Frame")
	local TextButton = Instance.new("TextButton")

	--Properties:

	IMG.Name = "IMG"
	IMG.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	IMG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Frame.Parent = IMG
	Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.new(0.200378075, 0, 0.116987176, 0)
	Frame.Size = UDim2.new(0, 403, 0, 444)

	ImageLabel.Parent = Frame
	ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ImageLabel.BorderSizePixel = 0
	ImageLabel.Position = UDim2.new(0, 0, 0.0810810775, 0)
	ImageLabel.Size = UDim2.new(0, 403, 0, 408)
	ImageLabel.Image = getcustomasset("FileSystemUI/".._G.Name.."/"..folderName.."/"..Name)
	
	Frame_2.Parent = Frame
	Frame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame_2.BorderSizePixel = 0
	Frame_2.Position = UDim2.new(-0.000614440767, 0, 0, 0)
	Frame_2.Size = UDim2.new(0, 403, 0, 34)

	TextButton.Parent = Frame_2
	TextButton.BackgroundColor3 = Color3.fromRGB(218, 218, 218)
	TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextButton.BorderSizePixel = 0
	TextButton.Position = UDim2.new(0.895781636, 0, 0, 0)
	TextButton.Size = UDim2.new(0, 42, 0, 36)
	TextButton.Font = Enum.Font.SourceSans
	TextButton.Text = "X"
	TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	TextButton.TextSize = 30.000
	TextButton.MouseButton1Click:Connect(function()
		IMG:Destroy()
	end)

	local function FAPT_fake_script() 
		local script = Instance.new('LocalScript', Frame)


		local UIS = game:GetService('UserInputService')
		local frame = script.Parent
		local dragToggle = nil
		local dragSpeed = 0.25
		local dragStart = nil
		local startPos = nil

		local function updateInput(input)
			local delta = input.Position - dragStart
			local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			game:GetService('TweenService'):Create(frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
		end

		frame.InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
				dragToggle = true
				dragStart = input.Position
				startPos = frame.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragToggle = false
					end
				end)
			end
		end)

		UIS.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				if dragToggle then
					updateInput(input)
				end
			end
		end)
	end
	coroutine.wrap(FAPT_fake_script)()

	
end
local function playaudio(audio)
	local ad = Instance.new("Sound")
	ad.Parent = game.Players.LocalPlayer.PlayerGui
	ad.SoundId = audio
	ad:Play()
	return ad
end

local function ShowAudio(Name,folderName)

	local Audio = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local Frame_2 = Instance.new("Frame")
	local TextButton = Instance.new("TextButton")
	local PausePlay = Instance.new("TextButton")

	--Properties:

	Audio.Name = "Audio"
	Audio.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	Audio.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Frame.Parent = Audio
	Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.new(0.359468967, 0, 0.116987176, 0)
	Frame.Size = UDim2.new(0, 235, 0, 74)

	Frame_2.Parent = Frame
	Frame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame_2.BorderSizePixel = 0
	Frame_2.Size = UDim2.new(0, 233, 0, 25)

	TextButton.Parent = Frame_2
	TextButton.BackgroundColor3 = Color3.fromRGB(218, 218, 218)
	TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextButton.BorderSizePixel = 0
	TextButton.Position = UDim2.new(0.872264922, 0, 0, 0)
	TextButton.Size = UDim2.new(0, 31, 0, 27)
	TextButton.Font = Enum.Font.SourceSans
	TextButton.Text = "X"
	TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	TextButton.TextSize = 30.000

	PausePlay.Name = "Pause/Play"
	PausePlay.Parent = Frame
	PausePlay.BackgroundColor3 = Color3.fromRGB(218, 218, 218)
	PausePlay.BorderColor3 = Color3.fromRGB(0, 0, 0)
	PausePlay.BorderSizePixel = 0
	PausePlay.Position = UDim2.new(0, 0, 0.476947695, 0)
	PausePlay.Size = UDim2.new(0, 235, 0, 27)
	PausePlay.Font = Enum.Font.SourceSans
	PausePlay.Text = "Pause"
	PausePlay.TextColor3 = Color3.fromRGB(0, 0, 0)
	PausePlay.TextSize = 30.000
	local playing=true
	local ad = playaudio(getcustomasset("FileSystemUI/".._G.Name.."/"..folderName.."/"..Name))

	TextButton.MouseButton1Click:Connect(function()
		ad:Destroy()
		Audio:Destroy()
	end)

	local function KIEFJT_fake_script()
		local script = Instance.new('LocalScript', Frame)



		local UIS = game:GetService('UserInputService')
		local frame = script.Parent
		local dragToggle = nil
		local dragSpeed = 0.25
		local dragStart = nil
		local startPos = nil

		local function updateInput(input)
			local delta = input.Position - dragStart
			local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			game:GetService('TweenService'):Create(frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
		end

		frame.InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
				dragToggle = true
				dragStart = input.Position
				startPos = frame.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragToggle = false
					end
				end)
			end
		end)

		UIS.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				if dragToggle then
					updateInput(input)
				end
			end
		end)
	end
	coroutine.wrap(KIEFJT_fake_script)()
	PausePlay.MouseButton1Click:Connect(function()
		if playing==true then
			ad:Pause()
			PausePlay.Text="Play"
			playing=false
		else 
			ad:Resume()	
			PausePlay.Text="Pause"

			playing=true
		end
	end)
	
end


local function lib.NewImgFile(Name, folderName,Img)
    print(Img)
	local FolderFrame = fc[folderName]
	if not FolderFrame then
		warn("Folder not found: " .. folderName)
		return
	end
    if isfile("FileSystemUI/".._G.Name.."/"..folderName.."/"..Name) then
        print("TRUE")
    else
    	local CONTENT = game:HttpGet(Img)

       writefile("FileSystemUI/".._G.Name.."/"..folderName.."/"..Name,CONTENT)
    end 
	local NewLuaFile = Instance.new("Frame")
	local TextLabel = Instance.new("TextLabel")
	local ImageLabel = Instance.new("ImageLabel")
	local TextButton = Instance.new("TextButton")


	NewLuaFile.Name = "NewImgFile"
	NewLuaFile.Parent = FolderFrame
	NewLuaFile.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	NewLuaFile.BorderColor3 = Color3.fromRGB(0, 0, 0)
	NewLuaFile.BorderSizePixel = 0
	NewLuaFile.Size = UDim2.new(0, 169, 0, 19)

	TextLabel.Parent = NewLuaFile
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Position = UDim2.new(0.118343197, 0, 0, 0)
	TextLabel.Size = UDim2.new(0, 149, 0, 19)
	TextLabel.Font = Enum.Font.SourceSans
	TextLabel.Text = Name
	TextLabel.TextColor3 = Color3.fromRGB(126, 126, 126)
	TextLabel.TextSize = 13.000
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left

	ImageLabel.Parent = NewLuaFile
	ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ImageLabel.BorderSizePixel = 0
	ImageLabel.Size = UDim2.new(0, 20, 0, 20)
	ImageLabel.Image = getcustomasset("FileSystemUI/".._G.Name.."/"..folderName.."/"..Name)

	TextButton.Parent = NewLuaFile
	TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextButton.BackgroundTransparency = 1.000
	TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextButton.BorderSizePixel = 0
	TextButton.Size = UDim2.new(0, 236, 0, 19)
	TextButton.Font = Enum.Font.SourceSans
	TextButton.Text = ""
	TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	TextButton.TextSize = 14.000

	TextButton.MouseButton1Click:Connect(function()

		ShowImg(Name,folderName)
	end)

end
local function lib.NewAudioFile(Name, folderName,audio)
    print(audio)
	local FolderFrame = fc[folderName]
	if not FolderFrame then
		warn("Folder not found: " .. folderName)
		return
	end
    if isfile("FileSystemUI/".._G.Name.."/"..folderName.."/"..Name) then
        print("TRUE")
    else
    	local CONTENT = game:HttpGet(audio)

       writefile("FileSystemUI/".._G.Name.."/"..folderName.."/"..Name,CONTENT)
    end 	
	local NewLuaFile = Instance.new("Frame")
	local TextLabel = Instance.new("TextLabel")
	local ImageLabel = Instance.new("ImageLabel")
	local TextButton = Instance.new("TextButton")


	NewLuaFile.Name = "NewAudioFile"
	NewLuaFile.Parent = FolderFrame
	NewLuaFile.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	NewLuaFile.BorderColor3 = Color3.fromRGB(0, 0, 0)
	NewLuaFile.BorderSizePixel = 0
	NewLuaFile.Size = UDim2.new(0, 169, 0, 19)

	TextLabel.Parent = NewLuaFile
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Position = UDim2.new(0.118343197, 0, 0, 0)
	TextLabel.Size = UDim2.new(0, 149, 0, 19)
	TextLabel.Font = Enum.Font.SourceSans
	TextLabel.Text = Name
	TextLabel.TextColor3 = Color3.fromRGB(126, 126, 126)
	TextLabel.TextSize = 13.000
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left

	ImageLabel.Parent = NewLuaFile
	ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ImageLabel.BorderSizePixel = 0
	ImageLabel.Size = UDim2.new(0, 20, 0, 20)
	ImageLabel.Image = "http://www.roblox.com/asset/?id=14597263890"

	TextButton.Parent = NewLuaFile
	TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextButton.BackgroundTransparency = 1.000
	TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextButton.BorderSizePixel = 0
	TextButton.Size = UDim2.new(0, 236, 0, 19)
	TextButton.Font = Enum.Font.SourceSans
	TextButton.Text = ""
	TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	TextButton.TextSize = 14.000

	TextButton.MouseButton1Click:Connect(function()
		ShowAudio(Name,folderName)
	end)

end
return lib
