-- Load UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/valinciaeunha/valincia-ui-rblx/refs/heads/main/Library.lua"))()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

-- Variables
local speedValue = 16
local jumpPowerValue = 50
local infJumpActive = false
local infJumpConn = nil
local autoRebirthActive = false
local autoBuySpeedActive = false
local autoFarmTeleportActive = false
local autoUpgradeRemoteActive = false
local celestialHunterActive = false
local celestialWatcherConn = nil
local secretHunterActive = false
local secretWatcherConn = nil
local godlyHunterActive = false
local godlyWatcherConn = nil

-- Helper Functions
local function holdE(seconds)
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(seconds)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end

local function getHomePlot()
    local plotName = LocalPlayer:GetAttribute("Plot")
    if plotName then
        return workspace.GameFolder.Plots:FindFirstChild(plotName)
    end
    return nil
end

local function doRebirth()
    pcall(function()
        ReplicatedStorage.Events.Rebirth:InvokeServer("Rebirth")
    end)
end

-- Create Window
local Window = Library:CreateWindow({
    Title = "SurviveLava For Brainrots | Indonesia",
    Footer = "By Faresv2 | Valincia UI",
    Size = UDim2.new(0, 580, 0, 450),
    Center = true,
    AutoShow = true,
    ToggleKeybind = Enum.KeyCode.RightControl
})

-- Tab: Utama
local TabUtama = Window:AddTab("Utama")

-- Group: VIP & Gerakan
local GroupVIP = TabUtama:AddGroupbox("VIP & Pengaturan")
local GroupGerakan = TabUtama:AddGroupbox("Gerakan Karakter")

-- Free VIP Toggle
GroupVIP:AddToggle("FreeVIP", {
    Text = "Gratis VIP",
    Default = false,
    Callback = function(state)
        if state then
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "VIPDoors" or v.Name == "VIPDoor" then
                    pcall(function()
                        v:Destroy()
                    end)
                end
            end
        end
    end
})

-- Infinite Jump Toggle
GroupGerakan:AddToggle("InfiniteJump", {
    Text = "Lompat Tak Terbatas",
    Default = false,
    Callback = function(state)
        infJumpActive = state
        if infJumpActive then
            infJumpConn = UserInputService.JumpRequest:Connect(function()
                if infJumpActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                    LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        elseif infJumpConn then
            infJumpConn:Disconnect()
            infJumpConn = nil
        end
    end
})

-- Jump Power Toggle
GroupGerakan:AddToggle("JumpPowerToggle", {
    Text = "Aktifkan Kekuatan Lompat",
    Default = false,
    Callback = function(state)
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if state then
                humanoid.JumpPower = jumpPowerValue
            else
                humanoid.JumpPower = 50
            end
        end
    end
})

-- Jump Power Slider
GroupGerakan:AddSlider("JumpPower", {
    Text = "Kekuatan Lompat",
    Min = 50,
    Max = 1000,
    Default = 50,
    Suffix = " JP",
    Callback = function(val)
        jumpPowerValue = val
    end
})

-- Walk Speed Toggle
GroupGerakan:AddToggle("WalkSpeedToggle", {
    Text = "Aktifkan Kecepatan Jalan",
    Default = false,
    Callback = function(state)
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if state then
                humanoid.WalkSpeed = speedValue
            else
                humanoid.WalkSpeed = 16
            end
        end
    end
})

-- Walk Speed Slider
GroupGerakan:AddSlider("WalkSpeed", {
    Text = "Kecepatan Jalan",
    Min = 16,
    Max = 1000,
    Default = 16,
    Suffix = " WS",
    Callback = function(val)
        speedValue = val
    end
})

-- Tab: Basis
local TabBasis = Window:AddTab("Basis")

-- Group: Manajemen Basis
local GroupBasis = TabBasis:AddGroupbox("Manajemen Basis")

-- Back to Base Button
GroupBasis:AddButton({
    Text = "Kembali ke Basis Saya",
    Callback = function()
        local myPlot = getHomePlot()
        if myPlot and LocalPlayer.Character then
            LocalPlayer.Character:PivotTo(myPlot:GetPivot() * CFrame.new(0, 4, -10) * CFrame.fromOrientation(0, math.pi, 0))
        end
    end
})

-- Upgrade Base Button
GroupBasis:AddButton({
    Text = "Tingkatkan Basis",
    Callback = function()
        ReplicatedStorage.Events.Upgrade:InvokeServer()
    end
})

-- Auto Collect Toggle
GroupBasis:AddToggle("AutoCollect", {
    Text = "Kumpulkan Otomatis",
    Default = false,
    Callback = function(state)
        autoFarmTeleportActive = state
        if autoFarmTeleportActive then
            task.spawn(function()
                while autoFarmTeleportActive do
                    local myPlot = getHomePlot()
                    if myPlot then
                        for i = 1, 30 do
                            if not autoFarmTeleportActive then break end
                            local place = myPlot.Places:FindFirstChild(tostring(i))
                            if place and place:FindFirstChild("Claim") then
                                local claimPart = place.Claim
                                local rootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                if rootPart then
                                    rootPart.CFrame = claimPart.CFrame * CFrame.new(0, 5, 0)
                                    task.wait(0.3)
                                end
                            end
                        end
                    end
                    task.wait(1)
                end
            end)
        end
    end
})

-- Auto Upgrade Toggle
GroupBasis:AddToggle("AutoUpgrade", {
    Text = "Tingkatkan Otomatis",
    Default = false,
    Callback = function(state)
        autoUpgradeRemoteActive = state
        if autoUpgradeRemoteActive then
            task.spawn(function()
                while autoUpgradeRemoteActive do
                    for i = 1, 30 do
                        if not autoUpgradeRemoteActive then break end
                        ReplicatedStorage.Events.Upgrade:InvokeServer(i)
                        task.wait(0.1)
                    end
                    task.wait(1)
                end
            end)
        end
    end
})

-- Auto Rebirth Toggle
GroupBasis:AddToggle("AutoRebirth", {
    Text = "Rebirth Otomatis",
    Default = false,
    Callback = function(state)
        autoRebirthActive = state
        if autoRebirthActive then
            task.spawn(function()
                while autoRebirthActive do
                    doRebirth()
                    task.wait(0.5)
                end
            end)
        end
    end
})

-- Auto Buy Speed Toggle
GroupBasis:AddToggle("AutoBuySpeed", {
    Text = "Beli Kecepatan Otomatis",
    Default = false,
    Callback = function(state)
        autoBuySpeedActive = state
        if autoBuySpeedActive then
            task.spawn(function()
                while autoBuySpeedActive do
                    pcall(function()
                        ReplicatedStorage.Events.Speed:InvokeServer("Speed", 10)
                    end)
                    task.wait(0.5)
                end
            end)
        end
    end
})

-- Tab: Auto Get
local TabAutoGet = Window:AddTab("Auto Ambil")

-- Group: Celestial
local GroupCelestial = TabAutoGet:AddGroupbox("Celestial")

-- TP to Celestial Button
GroupCelestial:AddButton({
    Text = "Teleport ke Celestial",
    Callback = function()
        local celestialFolder = workspace.GameFolder.Brainrots:FindFirstChild("Celestial")
        if celestialFolder and #celestialFolder:GetChildren() > 0 then
            local obj = celestialFolder:GetChildren()[1]
            local root = obj:FindFirstChildWhichIsA("BasePart") or obj.PrimaryPart
            if root and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = root.CFrame * CFrame.new(0, 5, 0)
            end
        end
    end
})

-- Auto Get Celestial Toggle
GroupCelestial:AddToggle("AutoGetCelestial", {
    Text = "Ambil Celestial Otomatis",
    Default = false,
    Callback = function(state)
        celestialHunterActive = state
        if celestialHunterActive then
            local celestialFolder = workspace.GameFolder.Brainrots:FindFirstChild("Celestial")
            if not celestialFolder then return end

            local function hunt(celestial)
                if not celestialHunterActive or not celestial.Parent then return end

                local rootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not rootPart then return end

                local originalCFrame = rootPart.CFrame
                local targetPart = celestial:FindFirstChildWhichIsA("BasePart") or celestial.PrimaryPart
                if not targetPart then return end

                rootPart.CFrame = targetPart.CFrame * CFrame.new(0, 5, 0)
                task.wait(0.1)

                local prompt = celestial:FindFirstChildWhichIsA("ProximityPrompt", true)
                if prompt then
                    holdE(prompt.HoldDuration or 1.5)
                end

                for i = 1, 20 do
                    if not celestial.Parent then break end
                    task.wait(0.1)
                end

                task.wait(0.2)
                rootPart.CFrame = originalCFrame
            end

            celestialWatcherConn = celestialFolder.ChildAdded:Connect(hunt)

            for _, celestial in ipairs(celestialFolder:GetChildren()) do
                task.spawn(hunt, celestial)
            end

        elseif celestialWatcherConn then
            celestialWatcherConn:Disconnect()
            celestialWatcherConn = nil
        end
    end
})

-- Group: Secret
local GroupSecret = TabAutoGet:AddGroupbox("Secret")

-- TP to Secret Button
GroupSecret:AddButton({
    Text = "Teleport ke Secret",
    Callback = function()
        local secretFolder = workspace.GameFolder.Brainrots:FindFirstChild("Secret")
        if secretFolder and #secretFolder:GetChildren() > 0 then
            local obj = secretFolder:GetChildren()[1]
            local root = obj:FindFirstChildWhichIsA("BasePart") or obj.PrimaryPart
            if root and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = root.CFrame * CFrame.new(0, 5, 0)
            end
        end
    end
})

-- Auto Get Secret Toggle
GroupSecret:AddToggle("AutoGetSecret", {
    Text = "Ambil Secret Otomatis",
    Default = false,
    Callback = function(state)
        secretHunterActive = state
        if secretHunterActive then
            local secretFolder = workspace.GameFolder.Brainrots:FindFirstChild("Secret")
            if not secretFolder then return end

            local function hunt(secret)
                if not secretHunterActive or not secret.Parent then return end

                local rootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not rootPart then return end

                local originalCFrame = rootPart.CFrame
                local targetPart = secret:FindFirstChildWhichIsA("BasePart") or secret.PrimaryPart
                if not targetPart then return end

                rootPart.CFrame = targetPart.CFrame * CFrame.new(0, 5, 0)
                task.wait(0.1)

                local prompt = secret:FindFirstChildWhichIsA("ProximityPrompt", true)
                if prompt then
                    holdE(prompt.HoldDuration or 1.5)
                end

                task.wait(0.2)
                rootPart.CFrame = originalCFrame
            end

            secretWatcherConn = secretFolder.ChildAdded:Connect(hunt)

            for _, secret in ipairs(secretFolder:GetChildren()) do
                task.spawn(hunt, secret)
            end

        elseif secretWatcherConn then
            secretWatcherConn:Disconnect()
            secretWatcherConn = nil
        end
    end
})

-- Group: Godly
local GroupGodly = TabAutoGet:AddGroupbox("Godly")

-- TP to Godly Button
GroupGodly:AddButton({
    Text = "Teleport ke Godly",
    Callback = function()
        local godlyFolder = workspace.GameFolder.Brainrots:FindFirstChild("Godly")
        if godlyFolder and #godlyFolder:GetChildren() > 0 then
            local obj = godlyFolder:GetChildren()[1]
            local root = obj:FindFirstChildWhichIsA("BasePart") or obj.PrimaryPart
            if root and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = root.CFrame * CFrame.new(0, 5, 0)
            end
        end
    end
})

-- Auto Get Godly Toggle
GroupGodly:AddToggle("AutoGetGodly", {
    Text = "Ambil Godly Otomatis",
    Default = false,
    Callback = function(state)
        godlyHunterActive = state
        if godlyHunterActive then
            local godlyFolder = workspace.GameFolder.Brainrots:FindFirstChild("Godly")
            if not godlyFolder then return end

            local function hunt(godly)
                if not godlyHunterActive or not godly.Parent then return end

                local rootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not rootPart then return end

                local originalCFrame = rootPart.CFrame
                local targetPart = godly:FindFirstChildWhichIsA("BasePart") or godly.PrimaryPart
                if not targetPart then return end

                rootPart.CFrame = targetPart.CFrame * CFrame.new(0, 5, 0)
                task.wait(0.1)

                local prompt = godly:FindFirstChildWhichIsA("ProximityPrompt", true)
                if prompt then
                    holdE(prompt.HoldDuration or 1.5)
                end

                for i = 1, 20 do
                    if not godly.Parent then break end
                    task.wait(0.1)
                end

                task.wait(0.2)
                rootPart.CFrame = originalCFrame
            end

            godlyWatcherConn = godlyFolder.ChildAdded:Connect(hunt)

            for _, godly in ipairs(godlyFolder:GetChildren()) do
                task.spawn(hunt, godly)
            end

        elseif godlyWatcherConn then
            godlyWatcherConn:Disconnect()
            godlyWatcherConn = nil
        end
    end
})

-- Tab: Info
local TabInfo = Window:AddTab("Info")
local GroupInfo = TabInfo:AddGroupbox("Informasi Script")

GroupInfo:AddLabel("pornhub")
GroupInfo:AddLabel("-------------------")
GroupInfo:AddLabel("Tekan Right Ctrl untuk toggle UI")
GroupInfo:AddLabel("-------------------")
GroupInfo:AddLabel("Catatan:")
GroupInfo:AddLabel("Fitur gerakan (kecepatan & lompat)")
GroupInfo:AddLabel("tidak mempengaruhi pengumpulan")
GroupInfo:AddLabel("Brainrots atau Rebirth.")
GroupInfo:AddLabel("Jika kecepatan tidak berfungsi,")
GroupInfo:AddLabel("coba on/off ulang.")

Library:Notify({ Text = "Script Berhasil Dimuat!", Duration = 3 })
