-- ⚙️ PENGATURAN & VARIABEL
_G.StopAll = false
_G.AutoFish = false
_G.AutoShake = true
_G.AlwaysPerfect = true
_G.FrozenBar = true
_G.LockPosition = true
_G.AntiAFK = true
_G.CastDelay = 0.5
_G.ReelDelay = 2.5
_G.HideShakeUI = false

-- Pengaturan Autos
_G.AutoSellAll = false
_G.SellAllInterval = 5

-- Pergerakan
_G.WalkSpeedEnabled = false
_G.WalkSpeed = 16
_G.JumpPowerEnabled = false
_G.JumpPower = 50
_G.Noclip = false
_G.DashEnabled = true
_G.DashSpeed = 100
_G.FlyEnabled = true
_G.FlySpeed = 50
_G.IsFlying = false
_G.FlyInertia = true
_G.BoostEnabled = false

-- ESP & Mobile
_G.ESPEnabled = false
_G.MobileFlyUp = false

-- Lokasi Kustom
_G.CustomName = ""
_G.CustomX = 0
_G.CustomY = 135
_G.CustomZ = 0
_G.SearchQuery = ""
_G.ManagerSearch = ""

-- Pengaturan Auto Totem
_G.AutoTotem = false
_G.DayTotemSelect = "Sundial Totem"
_G.NightTotemSelect = "Aurora Totem"

-- Pengaturan Auto Potion
_G.AutoPotion = false
_G.SelectedPotion = nil
_G.PotionDelayMinutes = 10
_G.PotionRepeatCount = 999
_G.PotionTimer = 0

-- Status Internal
_G.ProcessingTotem = false

-- Nama File
local FileName = "Fisch_Locations.json"

-- Variabel state (bukan _G) - memindahkan currentSpot ke _G
local currentFlyVelocity = Vector3.new(0, 0, 0)
_G.currentSpot = nil
local keysDown = {}
local lastSpacePress = 0

-- ============================================
-- SERVICES MODULE - Mengambil Services dari Aslinya
-- ============================================

local Services = {}

Services.HttpService = game:GetService("HttpService")
Services.UserInputService = game:GetService("UserInputService")
Services.RunService = game:GetService("RunService")
Services.Debris = game:GetService("Debris")
Services.Players = game:GetService("Players")
Services.VirtualInputManager = game:GetService("VirtualInputManager")
Services.CoreGui = game:GetService("CoreGui")
Services.ReplicatedStorage = game:GetService("ReplicatedStorage")
Services.VirtualUser = game:GetService("VirtualUser")
Services.LocalPlayer = Services.Players.LocalPlayer
Services.Lighting = game:GetService("Lighting")
Services.TeleportService = game:GetService("TeleportService")

-- Ukuran Layar & Deteksi Platform
Services.ScreenSize = workspace.CurrentCamera.ViewportSize
Services.IsMobile = table.find({Enum.Platform.Android, Enum.Platform.IOS}, Services.UserInputService:GetPlatform())

-- Kalkulasi Ukuran Window
if Services.IsMobile or Services.ScreenSize.X < 700 then
    local targetWidth = math.min(Services.ScreenSize.X * 0.85, 600)
    local targetHeight = math.min(Services.ScreenSize.Y * 0.70, 400)
    Services.WindowSize = UDim2.fromOffset(targetWidth, targetHeight)
    Services.TabsWidth = 120
else
    Services.WindowSize = UDim2.fromOffset(580, 460)
    Services.TabsWidth = 160
end

-- ============================================
-- DATA MODULE - Data Locations, Rods, Totems, Potions (Aslinya)
-- ============================================

local Data = {}

-- 📍 TABEL DATA
Data.DefaultLocations = {
    ["Moosewood (Spawn)"] = {x=380, y=135, z=220},
    ["Roslit Bay"] = {x=-1485, y=132, z=720},
    ["Terrapin Island"] = {x=-16, y=135, z=1540},
    ["Snowcap Island"] = {x=2610, y=135, z=2435},
    ["Sunstone Island"] = {x=-930, y=132, z=-1125},
    ["Statue of Sovereignty"] = {x=40, y=135, z=-1020},
    ["Mushgrove Swamp"] = {x=2440, y=132, z=-700},
    ["Keepers Altar"] = {x=1300, y=-225, z=-380},
    ["Desolate Deep"] = {x=-1650, y=-210, z=2840},
    ["Archeological Site"] = {x=4150, y=135, z=245},
    ["Vertigo (Entrance)"] = {x=-110, y=-510, z=1050},
    ["The Depths"] = {x=990, y=-710, z=1250},
    ["(Secret) Event Zone"] = {x=20654, y=140, z=-18005},
    ["Enchant"] = {x=1309,y=-806,z=-103},
    ["Coral Bastion"] = {x=2523,y=-1097,z=858}
}

Data.RodList = {
    {Name = "Training Rod", Price = 300}, {Name = "Plastic Rod", Price = 750},
    {Name = "Carbon Rod", Price = 2000}, {Name = "Stone Rod", Price = 2000},
    {Name = "Long Rod", Price = 3000}, {Name = "Fast Rod", Price = 4000},
    {Name = "Lucky Rod", Price = 4500}, {Name = "Steady Rod", Price = 7000},
    {Name = "Firefly Rod", Price = 9500}, {Name = "Fortune Rod", Price = 11000},
    {Name = "Rapid Rod", Price = 12000}, {Name = "Frog Rod", Price = 12000},
    {Name = "Magnet Rod", Price = 15000}, {Name = "Brine-Infused Rod", Price = 15000},
    {Name = "Merchant Rod", Price = 20000}, {Name = "Reinforced Rod", Price = 20000},
    {Name = "Arctic Rod", Price = 25000}, {Name = "Coral Rod", Price = 30000},
    {Name = "Crystalized Rod", Price = 35000}, {Name = "Avalanche Rod", Price = 35000},
    {Name = "Firework Rod", Price = 35000}, {Name = "Wildflower Rod", Price = 40000},
    {Name = "Depthseeker Rod", Price = 40000}, {Name = "Scurvy Rod", Price = 40000},
    {Name = "Boreal Rod", Price = 42000}, {Name = "Cinder Block Rod", Price = 50000},
    {Name = "The Boom Ball", Price = 50000}, {Name = "Verdant Shear Rod", Price = 50000},
    {Name = "Phoenix Rod", Price = 50000}, {Name = "Treasure Rod", Price = 50000},
    {Name = "Midas Rod", Price = 55000}, {Name = "Ice Warpers Rod", Price = 65000},
    {Name = "Blazebringer Rod", Price = 70000}, {Name = "Aurora Rod", Price = 70000},
    {Name = "Paper Fan Rod", Price = 70000}, {Name = "Carrot Rod", Price = 75000},
    {Name = "Meteor Totem", Price = 75000}, {Name = "Champions Rod", Price = 90000},
    {Name = "Mythical Rod", Price = 90000}, {Name = "Azure Of Lagoon", Price = 100000},
    {Name = "Kings Rod", Price = 100000}, {Name = "Fallen Rod", Price = 175000},
    {Name = "Scarlet Spincaster Rod", Price = 180000}, {Name = "Destiny Rod", Price = 190000},
    {Name = "Free Spirit Rod", Price = 200000}, {Name = "Volcanic Rod", Price = 250000},
    {Name = "Rainbow Cluster Rod", Price = 250000}, {Name = "Leviathan's Fang Rod", Price = 350000},
    {Name = "Wicked Fang Rod", Price = 400000}, {Name = "Tempest Rod", Price = 500000},
    {Name = "Summit Rod", Price = 500000}, {Name = "Poseidon Rod", Price = 700000},
    {Name = "Great Dreamer Rod", Price = 700000}, {Name = "Tidemourner Head", Price = 750000},
    {Name = "Challenger's Rod", Price = 75000}, {Name = "Rod Of The Depths", Price = 750000},
    {Name = "Cerulean Fang Rod", Price = 800000}, {Name = "Zeus Rod", Price = 850000},
    {Name = "Abyssal Specter Rod", Price = 850000}, {Name = "Kraken Rod", Price = 950000},
    {Name = "Luminescent Oath", Price = 1000000}, {Name = "Rod Of The Zenith", Price = 1500000},
    {Name = "Frostbane Rod", Price = 1500000}, {Name = "Heaven's Rod", Price = 1750000},
    {Name = "Eidolon Rod", Price = 2000000}, {Name = "Great Rod of Oscar", Price = 2500000},
    {Name = "Maelstrom", Price = 3250000}, {Name = "Cryolash", Price = 3500000},
    {Name = "Ethereal Prism Rod", Price = 3500000}, {Name = "Ruinous Oath", Price = 5000000},
    {Name = "Sanguine Spire", Price = 10000000}, {Name = "Thalassar's Ruin", Price = 14500000},
    {Name = "Original No-Life Rod", Price = 1},
}

Data.TotemData = {
    {Name = "Tempest Totem", Price = 2000},
    {Name = "Windset Totem", Price = 2000},
    {Name = "Sundial Totem", Price = 2000},
    {Name = "Smokescreen Totem", Price = 2000},
    {Name = "Clearcast Totem", Price = 2000},
    {Name = "Meteor Totem", Price = 75000},
    {Name = "Blue Moon Totem", Price = 75000},
    {Name = "Eclipse Totem", Price = 75000},
    {Name = "Blizzard Totem", Price = 75000},
    {Name = "Avalanche Totem", Price = 75000},
    {Name = "Aurora Totem", Price = 500000}
}

Data.TotemList = {}
for _, v in ipairs(Data.TotemData) do table.insert(Data.TotemList, v.Name) end

Data.PotionList = {
    "Luck Potion", "Lure Speed Potion", "All Season Potion", 
    "Glitched Potion", "Abyssal Tonic", "Ghost Elixir", 
    "Fortune Potion", "Hasty Potion", "Sea Traveler Note"
}

-- ============================================
-- UTILS MODULE - Fungsi Pembantu
-- ============================================

local Utils = {}

-- Operasi File
function Utils.LoadCustomLocations()
    if isfile and isfile(FileName) then
        local success, result = pcall(function() return Services.HttpService:JSONDecode(readfile(FileName)) end)
        if success then return result end
    end
    return {}
end

function Utils.SaveCustomLocations(data)
    if writefile then writefile(FileName, Services.HttpService:JSONEncode(data)) end
end

-- Item & Uang
function Utils.hasItem(itemName)
    return (Services.LocalPlayer.Backpack:FindFirstChild(itemName) or (Services.LocalPlayer.Character and Services.LocalPlayer.Character:FindFirstChild(itemName))) ~= nil
end

function Utils.getMoney()
    local ls = Services.LocalPlayer:FindFirstChild("leaderstats")
    local coin = ls and ls:FindFirstChild("C$") or ls:FindFirstChild("Cash")
    return coin and coin.Value or 0
end

-- Fungsi Remote
function Utils.FindSellAllRemote()
    local events = Services.ReplicatedStorage:FindFirstChild("events")
    if events then
        return events:FindFirstChild("SellAll") or events:FindFirstChild("sellall")
    end
    return nil
end

function Utils.FindSellHandRemote()
    local targetPath = "packages/Net/RF/Merchant/Sell"
    local parts = string.split(targetPath, "/")
    local current = Services.ReplicatedStorage
    for _, part in ipairs(parts) do
        if current:FindFirstChild(part) then
             current = current[part]
        else
            return nil
        end
    end
    if current and current:IsA("RemoteFunction") then
        return current
    end
    return nil
end

function Utils.GetPurchaseRemote()
    local events = Services.ReplicatedStorage:FindFirstChild("events")
    if events then
        return events:FindFirstChild("purchase")
    end
    return nil
end

function Utils.FindRemote(name)
    local target = Services.ReplicatedStorage:FindFirstChild("packages")
    if target and target:FindFirstChild("Net") then
        local re = target.Net:FindFirstChild("RE/"..name)
        if re then return re end
    end
    return nil
end

-- Pembantu Auto Fish
function Utils.CleanStack()
    local pg = Services.LocalPlayer.PlayerGui
    if pg:FindFirstChild("reel") then pg.reel:Destroy() end
    if pg:FindFirstChild("shakeui") then pg.shakeui:Destroy() end
end

function Utils.ForceEquipRod()
    local char = Services.LocalPlayer.Character
    if not char then return nil end
    local tool = char:FindFirstChildWhichIsA("Tool")
    if tool and tool.Name:lower():find("rod") then return tool end
    local backpack = Services.LocalPlayer.Backpack
    local rod = nil
    for _, v in pairs(backpack:GetChildren()) do
        if v:IsA("Tool") and v.Name:lower():find("rod") then rod = v; break end
    end
    if rod then
        char.Humanoid:EquipTool(rod); task.wait(0.2); return char:FindFirstChildWhichIsA("Tool")
    else
        Services.VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.T, false, game); task.wait(0.3); return char:FindFirstChildWhichIsA("Tool")
    end
end

function Utils.IsUIActive()
    local pg = Services.LocalPlayer.PlayerGui
    local hasShake = pg:FindFirstChild("shakeui") and pg.shakeui.Enabled
    local hasReel = pg:FindFirstChild("reel") and pg.reel.Enabled
    return hasShake or hasReel
end

-- Deteksi Shake (dari script asli)
function Utils.FastShake(obj)
    if not _G.AutoShake then return end

    if obj.Name == "shake" and obj:IsA("RemoteEvent") then
        local parentUI = obj.Parent
        if parentUI and parentUI:IsA("GuiObject") then
            if _G.HideShakeUI then
                parentUI.Visible = false
            else
                parentUI.Visible = true
            end
        end

        obj:FireServer()
        task.delay(0.1, function()
            obj:FireServer()
        end)
    end
end

-- Fungsi Format
function Utils.FormatTime(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = math.floor(seconds % 60)
    return string.format("%02d:%02d:%02d", hours, minutes, secs)
end

function Utils.FormatGameTime(clockTime)
    local hours = math.floor(clockTime)
    local minutes = math.floor((clockTime - hours) * 60)
    return string.format("%02d:%02d", hours, minutes)
end

-- ============================================
-- AUTO FISH MODULE - Sistem Mancing Otomatis (Aslinya)
-- ============================================

local AutoFish = {}

function AutoFish.Start()
    local finishRemote = Utils.FindRemote("Reel/Finish")
    
    task.spawn(function()
        while true do
            task.wait(0.1)
            
            if not _G.StopAll and _G.AutoFish then
                local char = Services.LocalPlayer.Character
                if not char then continue end
                
                -- Cek alat
                local currentTool = char:FindFirstChildWhichIsA("Tool")
                if currentTool and currentTool.Name:lower():find("rod") then
                    if not Utils.IsUIActive() then
                        char.Humanoid:UnequipTools(); task.wait(0.1)
                    end
                end
                
                local rod = Utils.ForceEquipRod()
                if rod and rod:FindFirstChild("events") then
                    local castRemote = rod.events:FindFirstChild("castAsync")
                    if castRemote then
                        -- 1. Lempar kail
                        local castSuccess = pcall(function() castRemote:InvokeServer(100, 1, false) end)
                        if not castSuccess then warn("Cast gagal, mencoba lagi..."); continue end
                        
                        local fishBited = false
                        local startTime = tick()
                        local lastActiveTime = tick()
                        
                        local maxTotalWait = 30
                        local noActivityTimeout = 3.5
                        
                        while _G.AutoFish and not _G.StopAll do
                            local currentTime = tick()
                            
                            if Utils.IsUIActive() then
                                lastActiveTime = currentTime
                            end
                            
                            if char.Humanoid.MoveDirection.Magnitude > 0 then
                                lastActiveTime = currentTime
                            end

                            if Services.LocalPlayer.PlayerGui:FindFirstChild("reel") then 
                                fishBited = true 
                                break 
                            end
                            
                            -- Kondisi selesai: kail lepas dari tangan
                            if not char:FindFirstChild(rod.Name) then break end
                            
                            -- Sistem anti bug (Smart Timeout)
                            if currentTime - lastActiveTime > noActivityTimeout then break end
                            if currentTime - startTime > maxTotalWait then break end
                            
                            task.wait(0.05)
                        end
                        
                        -- 2. Jika ikan sudah datang, tarik
                        if fishBited then
                            task.wait(_G.ReelDelay)
                            if finishRemote then
                                pcall(function() finishRemote:FireServer({ ["e"] = 100, ["p"] = _G.AlwaysPerfect, ["l"] = {} }) end)
                                _G.AddLog("🎣 Ikan Tertangkap!", Color3.fromRGB(0, 255, 255))
                            end
                        end
                        
                        task.wait(_G.CastDelay)
                        Utils.CleanStack()
                        if char:FindFirstChild("Humanoid") then char.Humanoid:UnequipTools() end
                    end
                end
            end
        end
    end)
end

function AutoFish.SetupShakeDetection()
    Services.LocalPlayer.PlayerGui.DescendantAdded:Connect(Utils.FastShake)
    for _, v in pairs(Services.LocalPlayer.PlayerGui:GetDescendants()) do
        Utils.FastShake(v)
    end
end

-- ============================================
-- AUTO POTION MODULE - Timer Auto Potion (Aslinya)
-- ============================================

local AutoPotion = {}

function AutoPotion.Start()
    task.spawn(function()
        while true do
            task.wait(1)
            
            if _G.AutoPotion and not _G.StopAll and _G.PotionRepeatCount > 0 then
                if _G.PotionTimer <= 0 then
                    local potionName = _G.SelectedPotion
                    
                    -- Cek apakah ada di inventaris
                    local hasItem = (Services.LocalPlayer.Backpack:FindFirstChild(potionName) or 
                                    (Services.LocalPlayer.Character and Services.LocalPlayer.Character:FindFirstChild(potionName))) ~= nil
                    
                    if hasItem then
                        -- 1. Hentikan mancing (Hard Stop)
                        local wasFishing = _G.AutoFish
                        if wasFishing then
                            _G.AutoFish = false
                            task.wait(2)
                        end

                        local char = Services.LocalPlayer.Character
                        local hum = char and char:FindFirstChild("Humanoid")
                        
                        if char and hum and hum.Health > 0 then
                            -- 2. Kosongkan tangan
                            for i = 1, 5 do
                                if char:FindFirstChildWhichIsA("Tool") then
                                    hum:UnequipTools()
                                    task.wait(0.2)
                                else
                                    break
                                end
                            end
                            
                            -- 3. Coba pegang dan minum ramuan
                            local potionTool = Services.LocalPlayer.Backpack:FindFirstChild(potionName) or char:FindFirstChild(potionName)
                            
                            if potionTool then
                                hum:EquipTool(potionTool)
                                task.wait(0.8)
                                
                                local heldItem = char:FindFirstChildWhichIsA("Tool")
                                if heldItem and heldItem.Name == potionName then
                                    -- Klik untuk minum
                                    Services.VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                                    task.wait(0.2)
                                    Services.VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                                    
                                    task.wait(2.5)
                                    hum:UnequipTools()
                                    
                                    _G.PotionRepeatCount = _G.PotionRepeatCount - 1
                                    _G.PotionTimer = _G.PotionDelayMinutes * 60
                                else
                                    hum:UnequipTools()
                                end
                            end
                        end
                        
                        -- 4. Kembali mancing
                        if wasFishing then
                            task.wait(1)
                            _G.AutoFish = true
                            
                            local rod = Services.LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool")
                            if not rod then 
                                for _, v in pairs(Services.LocalPlayer.Backpack:GetChildren()) do
                                    if v:IsA("Tool") and v.Name:find("Rod") then rod = v; break end
                                end
                            end
                            if rod then hum:EquipTool(rod) end
                        end
                    else
                        task.wait(5)
                    end
                else
                    _G.PotionTimer = _G.PotionTimer - 1
                end
            end
        end
    end)
end

-- ============================================
-- AUTO SELL MODULE - Auto Sell All (Aslinya)
-- ============================================

local AutoSell = {}

function AutoSell.Start()
    task.spawn(function()
        while true do
            if _G.AutoSellAll and not _G.StopAll then
                local remote = Utils.FindSellAllRemote()
                if remote then
                    pcall(function() remote:InvokeServer() end)
                end
                task.wait(_G.SellAllInterval or 5)
            else
                task.wait(1)
            end
        end
    end)
end

-- ============================================
-- AUTO TOTEM MODULE - Smart Auto Totem (Aslinya)
-- ============================================

local AutoTotem = {}

function AutoTotem.Start()
    local currentPeriodStatus = nil 
    local hasUsedTotem = false 
    local hasFixedEclipse = false 
    local lastGameTime = -1       
    local lastRealTime = tick()
    
    -- Variabel anti konflik
    _G.ProcessingTotem = false

    local function UseTotemItem(name, reason)
        if not Utils.hasItem(name) then return false end
        
        local char = Services.LocalPlayer.Character
        local hum = char and char:FindFirstChild("Humanoid")
        if not hum or hum.Health <= 0 then return false end

        -- 1. Nyatakan status sedang bekerja
        _G.ProcessingTotem = true
        
        -- 2. Perintahkan berhenti mancing secara paksa
        local wasFishing = _G.AutoFish
        if wasFishing then
            _G.AutoFish = false
            
            -- Bersihkan kail dari tangan
            local attempts = 0
            repeat
                hum:UnequipTools()
                task.wait(0.2)
                attempts = attempts + 1
            until not char:FindFirstChildWhichIsA("Tool") or attempts > 10
            
            task.wait(0.5)
        end

        local success = false
        local totem = Services.LocalPlayer.Backpack:FindFirstChild(name)
        if not totem then totem = char:FindFirstChild(name) end

        if totem then
            -- 3. Coba pegang Totem
            hum:EquipTool(totem)
            task.wait(1) 
            
            -- 4. Cek detik terakhir apakah benar-benar memegang Totem
            local heldItem = char:FindFirstChildWhichIsA("Tool")
            
            if heldItem and heldItem.Name == name then
                -- Sudah pegang yang benar -> tekan untuk digunakan
                Services.VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                task.wait(0.2)
                Services.VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                
                task.wait(2.5)
                hum:UnequipTools()
                success = true
            else
                -- Pegang yang salah
                success = false
            end
        end

        -- 5. Kembalikan status, dan kembali mancing
        _G.ProcessingTotem = false
        
        if wasFishing then
            task.wait(0.5)
            _G.AutoFish = true
            
            -- Bantu pegang kail kembali
            local rod = Services.LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool")
            if not rod then 
                for _, v in pairs(Services.LocalPlayer.Backpack:GetChildren()) do
                    if v:IsA("Tool") and v.Name:find("Rod") then rod = v; break end
                end
            end
            if rod then hum:EquipTool(rod) end
        end
        
        return success
    end

    task.spawn(function()
        while true do
            task.wait(1)
            
            if _G.AutoTotem and not _G.StopAll then
                local Lighting = game:GetService("Lighting")
                local currentTime = Lighting.ClockTime
                
                -- Cek waktu macet (Eclipse Fix)
                if currentTime ~= lastGameTime then
                    lastGameTime = currentTime
                    lastRealTime = tick()
                end
                local timeFrozen = tick() - lastRealTime

                -- [Kasus 1] Perbaiki bug Eclipse
                if currentTime >= 2.0 and currentTime <= 2.3 and timeFrozen > 10 then 
                    if not hasFixedEclipse then
                        if UseTotemItem(_G.DayTotemSelect, "Fix Eclipse") then
                            hasFixedEclipse = true
                            lastRealTime = tick()
                            task.wait(10)
                            currentPeriodStatus = nil 
                            hasUsedTotem = false      
                        end
                    end
                else
                    hasFixedEclipse = false
                end
                
                -- [Kasus 2] Perubahan waktu normal
                if not hasFixedEclipse then
                    local newPeriod = (currentTime >= 6.55 and currentTime < 18.05) and "Day" or "Night"
                    
                    if newPeriod ~= currentPeriodStatus then
                        currentPeriodStatus = newPeriod
                        hasUsedTotem = false 
                    end

                    if not hasUsedTotem then
                        local targetTotem = (currentPeriodStatus == "Day") and _G.DayTotemSelect or _G.NightTotemSelect
                        
                        if targetTotem and targetTotem ~= "" then
                            local result = UseTotemItem(targetTotem, "Change Time")
                            if result then
                                hasUsedTotem = true
                            end
                        end
                    end
                end
            else
                currentPeriodStatus = nil
                hasUsedTotem = false
            end
        end
    end)
end

-- ============================================
-- CHARACTER MODULE - ESP, Fly, Noclip, Dash (Aslinya)
-- ============================================

local Character = {}

-- State dari Config
-- currentSpot menggunakan _G.currentSpot secara langsung

-- Penampung ESP
local ESPHolder = Instance.new("Folder", Services.CoreGui)
ESPHolder.Name = "FischESPHolder"

function Character.Start()
    -- Anti AFK
    Services.LocalPlayer.Idled:Connect(function()
        if _G.AntiAFK then
            Services.VirtualUser:CaptureController()
            Services.VirtualUser:ClickButton2(Vector2.new())
        end
    end)

    -- Penanganan Input
    Services.UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        keysDown[input.KeyCode] = true
        
        if input.KeyCode == Enum.KeyCode.Q then 
            if _G.DashEnabled and not _G.StopAll then
                local char = Services.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
                    local hrp = char.HumanoidRootPart
                    local moveDir = char.Humanoid.MoveDirection
                    if moveDir.Magnitude == 0 then moveDir = hrp.CFrame.LookVector end
                    local bv = Instance.new("BodyVelocity")
                    bv.Name = "DashVelocity"
                    bv.Velocity = moveDir * _G.DashSpeed
                    bv.MaxForce = Vector3.new(1e5, 0, 1e5)
                    bv.P = 5000
                    bv.Parent = hrp
                    Services.Debris:AddItem(bv, 0.25)
                end
            end
        end
        
        if input.KeyCode == Enum.KeyCode.LeftShift then
            _G.BoostEnabled = not _G.BoostEnabled
        end
        
        if input.KeyCode == Enum.KeyCode.Space and _G.FlyEnabled and not _G.StopAll then
            if (tick() - lastSpacePress) < 0.3 then
                _G.IsFlying = not _G.IsFlying
                currentFlyVelocity = Vector3.new(0, 0, 0)
                if not _G.IsFlying and Services.LocalPlayer.Character and Services.LocalPlayer.Character:FindFirstChild("Humanoid") then
                    Services.LocalPlayer.Character.Humanoid.PlatformStand = false
                end
            end
            lastSpacePress = tick()
        end
    end)
    
    Services.UserInputService.InputEnded:Connect(function(input)
        keysDown[input.KeyCode] = nil
    end)

    -- Loop Utama RenderStepped
    Services.RunService.RenderStepped:Connect(function()
        -- ESP
        if _G.ESPEnabled then
            for _, player in pairs(Services.Players:GetPlayers()) do
                if player ~= Services.LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                    local head = player.Character.Head
                    local espBox = ESPHolder:FindFirstChild(player.Name)
                    if not espBox then
                        espBox = Instance.new("BillboardGui", ESPHolder)
                        espBox.Name = player.Name
                        espBox.Size = UDim2.new(0, 100, 0, 50)
                        espBox.StudsOffset = Vector3.new(0, 2, 0)
                        espBox.AlwaysOnTop = true
                        local nl = Instance.new("TextLabel", espBox)
                        nl.Name = "NameLabel"
                        nl.Size = UDim2.new(1,0,1,0)
                        nl.BackgroundTransparency = 1
                        nl.TextColor3 = Color3.white
                        nl.TextStrokeTransparency = 0
                        nl.TextSize = 14
                        nl.Font = Enum.Font.SourceSansBold
                        local dl = Instance.new("TextLabel", espBox)
                        dl.Name = "DistLabel"
                        dl.Size = UDim2.new(1,0,0.5,0)
                        dl.Position = UDim2.new(0,0,0.8,0)
                        dl.BackgroundTransparency = 1
                        dl.TextColor3 = Color3.new(0.8,0.8,0.8)
                        dl.TextStrokeTransparency = 0
                        dl.TextSize = 12
                        dl.Font = Enum.Font.SourceSans
                    end
                    if espBox.Adornee ~= head then espBox.Adornee = head end
                    local myRoot = Services.LocalPlayer.Character and Services.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local dist = myRoot and (myRoot.Position - head.Position).Magnitude or 0
                    espBox.NameLabel.Text = player.DisplayName .. " (@" .. player.Name .. ")"
                    espBox.DistLabel.Text = math.floor(dist) .. " m"
                else
                    if ESPHolder:FindFirstChild(player.Name) then ESPHolder[player.Name]:Destroy() end
                end
            end
        elseif #ESPHolder:GetChildren() > 0 then
            ESPHolder:ClearAllChildren()
        end

        if _G.StopAll then return end
        
        local char = Services.LocalPlayer.Character
        if not char then return end
        
        local hrp, hum = char:FindFirstChild("HumanoidRootPart"), char:FindFirstChild("Humanoid")
        
        -- Noclip
        if _G.Noclip then
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
        
        -- Fisika Terbang
        if _G.IsFlying and hrp and hum then
            hum.PlatformStand = true
            hum.AutoRotate = false
            local bv = hrp:FindFirstChild("FlyVelocity") or Instance.new("BodyVelocity", hrp)
            bv.Name = "FlyVelocity"
            bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            local bg = hrp:FindFirstChild("FlyGyro") or Instance.new("BodyGyro", hrp)
            bg.Name = "FlyGyro"
            bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            local moveDir = hum.MoveDirection
            local cam = workspace.CurrentCamera
            if moveDir.Magnitude > 0 then
                local lookY = cam.CFrame.LookVector.Y
                moveDir = Vector3.new(moveDir.X, moveDir.Y + (lookY * 2), moveDir.Z).Unit
            end
            if keysDown[Enum.KeyCode.Space] or _G.MobileFlyUp then
                moveDir = moveDir + Vector3.new(0, 1, 0)
            end
            local speed = _G.FlySpeed * (_G.BoostEnabled and 2.5 or 1.0)
            if moveDir.Magnitude > 0 then
                currentFlyVelocity = currentFlyVelocity:Lerp(moveDir.Unit * speed, 0.2)
                bg.CFrame = bg.CFrame:Lerp(CFrame.lookAt(hrp.Position, hrp.Position + currentFlyVelocity) * CFrame.Angles(math.rad(-90), 0, 0), 0.2)
            else
                currentFlyVelocity = _G.FlyInertia and currentFlyVelocity:Lerp(Vector3.zero, 0.05) or Vector3.zero
                local forward = cam.CFrame.LookVector
                bg.CFrame = bg.CFrame:Lerp(CFrame.lookAt(hrp.Position, hrp.Position + Vector3.new(forward.X, 0, forward.Z)), 0.1)
            end
            bv.Velocity = currentFlyVelocity
        else
            if hrp and hrp:FindFirstChild("FlyVelocity") then hrp.FlyVelocity:Destroy() end
            if hrp and hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
            if hum then hum.PlatformStand = false; hum.AutoRotate = true end
        end
        
        -- Kunci Posisi untuk Auto Fish
        if _G.AutoFish and _G.LockPosition and _G.currentSpot and not _G.IsFlying and hrp then
            hrp.CFrame = _G.currentSpot
            hrp.Velocity = Vector3.zero
        end
        
        -- WalkSpeed & JumpPower
        if hum and not _G.IsFlying then
            if _G.WalkSpeedEnabled then hum.WalkSpeed = _G.WalkSpeed end
            if _G.JumpPowerEnabled then hum.UseJumpPower = true; hum.JumpPower = _G.JumpPower end
        end
        
        -- Frozen Bar
        if _G.AutoFish and _G.FrozenBar then
            local bar = Services.LocalPlayer.PlayerGui:FindFirstChild("reel") and Services.LocalPlayer.PlayerGui.reel:FindFirstChild("bar")
            if bar and bar:FindFirstChild("playerbar") then
                bar.playerbar.Size = UDim2.new(1,0,1,0)
                bar.playerbar.Position = UDim2.new(0,0,0,0)
                bar.playerbar.AnchorPoint = Vector2.new(0,0)
                bar.playerbar.BackgroundColor3 = Color3.new(1,1,1)
            end
        end
    end)
end

-- ============================================
-- LOG UI MODULE - Sistem Log
-- ============================================

local LogUI = {}

-- Elemen UI
local LogGui, LogFrame, LogScroll, UIList

function LogUI.Create()
    -- [[ 📜 PENYIAPAN SISTEM LOG ]] --
    LogGui = Instance.new("ScreenGui")
    LogGui.Name = "FischLogGui"
    LogGui.Parent = game:GetService("CoreGui")
    LogGui.Enabled = false
    LogGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    LogFrame = Instance.new("Frame")
    LogFrame.Name = "MainFrame"
    LogFrame.Parent = LogGui
    LogFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    LogFrame.BorderColor3 = Color3.fromRGB(60, 60, 60)
    LogFrame.BorderSizePixel = 1
    LogFrame.Position = UDim2.new(0.75, 0, 0.65, 0)
    LogFrame.Size = UDim2.new(0, 300, 0, 200)
    LogFrame.Active = true
    LogFrame.Draggable = true

    -- Judul (Title Bar)
    local LogTitle = Instance.new("TextLabel")
    LogTitle.Parent = LogFrame
    LogTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    LogTitle.Size = UDim2.new(1, 0, 0, 25)
    LogTitle.Font = Enum.Font.GothamBold
    LogTitle.Text = "  📜 Log Script"
    LogTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    LogTitle.TextSize = 14
    LogTitle.TextXAlignment = Enum.TextXAlignment.Left

    -- Area tampilan pesan (Scrolling Frame)
    LogScroll = Instance.new("ScrollingFrame")
    LogScroll.Parent = LogFrame
    LogScroll.BackgroundTransparency = 1
    LogScroll.Position = UDim2.new(0, 5, 0, 30)
    LogScroll.Size = UDim2.new(1, -10, 1, -35)
    LogScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    LogScroll.ScrollBarThickness = 4

    UIList = Instance.new("UIListLayout")
    UIList.Parent = LogScroll
    UIList.SortOrder = Enum.SortOrder.LayoutOrder
    UIList.Padding = UDim.new(0, 4)
    
    -- Log Percobaan
    LogUI.AddLog("Sistem diinisialisasi...", Color3.fromRGB(100, 255, 100))
end

function LogUI.AddLog(text, color)
    if not LogScroll then return end
    
    local timestamp = os.date("%H:%M:%S")
    local label = Instance.new("TextLabel")
    label.Parent = LogScroll
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 0, 18)
    label.Font = Enum.Font.SourceSans
    label.Text = string.format("[%s] %s", timestamp, text)
    label.TextColor3 = color or Color3.fromRGB(200, 200, 200)
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextWrapped = false
    
    -- Auto Scroll
    LogScroll.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y)
    LogScroll.CanvasPosition = Vector2.new(0, UIList.AbsoluteContentSize.Y)
    
    -- Hapus log lama jika terlalu banyak
    if #LogScroll:GetChildren() > 100 then
        LogScroll:GetChildren()[2]:Destroy()
    end
end

-- Tetapkan ke _G sesuai aslinya
_G.AddLog = LogUI.AddLog

function LogUI.SetVisible(enabled)
    if LogGui then
        LogGui.Enabled = enabled
    end
end

function LogUI.ClearLogs()
    if not LogScroll then return end
    for _, child in pairs(LogScroll:GetChildren()) do
        if child:IsA("TextLabel") then child:Destroy() end
    end
    LogScroll.CanvasSize = UDim2.new(0,0,0,0)
    LogUI.AddLog("Log dihapus.", Color3.fromRGB(255, 255, 0))
end

-- ============================================
-- INFO UI MODULE - Panel Info Server
-- ============================================

local InfoUI = {}

-- Elemen UI (Global dalam modul)
local InfoGui, InfoFrame, RealTimeLabel, GameTimeLabel, UptimeLabel

function InfoUI.Create()
    -- [[ ℹ️ PENYIAPAN PANEL INFO SERVER ]] --
    InfoGui = Instance.new("ScreenGui")
    InfoGui.Name = "FischInfoGui"
    InfoGui.Parent = game:GetService("CoreGui")
    InfoGui.Enabled = true
    InfoGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Kerangka Utama (Main Frame)
    InfoFrame = Instance.new("Frame")
    InfoFrame.Name = "MainFrame"
    InfoFrame.Parent = InfoGui
    InfoFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    InfoFrame.BorderColor3 = Color3.fromRGB(60, 60, 60)
    InfoFrame.BorderSizePixel = 1
    InfoFrame.Position = UDim2.new(0.02, 0, 0.25, 0)
    InfoFrame.Size = UDim2.new(0, 250, 0, 120)
    InfoFrame.Active = true
    InfoFrame.Draggable = true

    -- Judul (Title Bar)
    local InfoTitle = Instance.new("TextLabel")
    InfoTitle.Parent = InfoFrame
    InfoTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    InfoTitle.Size = UDim2.new(1, 0, 0, 25)
    InfoTitle.Font = Enum.Font.GothamBold
    InfoTitle.Text = "  📊 Info Server"
    InfoTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    InfoTitle.TextSize = 14
    InfoTitle.TextXAlignment = Enum.TextXAlignment.Left

    -- Tombol lipat (Minimize Button)
    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Parent = InfoFrame
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    MinimizeBtn.BackgroundTransparency = 1
    MinimizeBtn.Position = UDim2.new(1, -30, 0, 0)
    MinimizeBtn.Size = UDim2.new(0, 30, 0, 25)
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.Text = "-"
    MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.TextSize = 18

    -- Area Konten (Content)
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Parent = InfoFrame
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Position = UDim2.new(0, 10, 0, 30)
    ContentFrame.Size = UDim2.new(1, -20, 1, -35)

    -- Buat TextLabel untuk menampilkan berbagai nilai
    local function CreateInfoLabel(order, defaultText)
        local lbl = Instance.new("TextLabel")
        lbl.Parent = ContentFrame
        lbl.BackgroundTransparency = 1
        lbl.Position = UDim2.new(0, 0, 0, (order - 1) * 25)
        lbl.Size = UDim2.new(1, 0, 0, 25)
        lbl.Font = Enum.Font.SourceSansSemibold
        lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
        lbl.TextSize = 16
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Text = defaultText
        return lbl
    end

    RealTimeLabel = CreateInfoLabel(1, "🕒 Waktu Nyata: ...")
    GameTimeLabel = CreateInfoLabel(2, "☀️ Waktu Game: ...")
    UptimeLabel = CreateInfoLabel(3, "⏳ Uptime: ...")

    -- [[ Sistem Lipat (Minimizing Logic) ]] --
    local isMinimized = false
    MinimizeBtn.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            InfoFrame:TweenSize(UDim2.new(0, 250, 0, 25), "Out", "Quad", 0.3, true)
            ContentFrame.Visible = false
            MinimizeBtn.Text = "+"
        else
            InfoFrame:TweenSize(UDim2.new(0, 250, 0, 120), "Out", "Quad", 0.3, true)
            ContentFrame.Visible = true
            MinimizeBtn.Text = "-"
        end
    end)
end

function InfoUI.SetVisible(enabled)
    if InfoGui then
        InfoGui.Enabled = enabled
    end
end

function InfoUI.Update(formatTimeFunc, formatGameTimeFunc)
    if not InfoGui or not InfoGui.Enabled then return end
    
    local statusTime = os.date("%H:%M:%S")
    local clockTime = game:GetService("Lighting").ClockTime
    local timeState = (clockTime >= 6 and clockTime < 18) and "Siang ☀️" or "Malam 🌙"
    local gameTimeStr = formatGameTimeFunc(clockTime) .. " " .. timeState
    local serverTime = workspace.DistributedGameTime
    local uptimeStr = formatTimeFunc(serverTime)
    
    RealTimeLabel.Text = "🕒 Waktu Nyata:  " .. statusTime
    GameTimeLabel.Text = "🗓️ Waktu Game: " .. gameTimeStr
    UptimeLabel.Text = "⏳ Waktu Online:    " .. uptimeStr
    
    if timeState == "Siang ☀️" then
        GameTimeLabel.TextColor3 = Color3.fromRGB(255, 220, 100)
    else
        GameTimeLabel.TextColor3 = Color3.fromRGB(100, 150, 255)
    end
end

-- ============================================
-- FLY UI MODULE - Panel Kontrol Terbang
-- ============================================

local FlyUI = {}

-- Elemen UI
local FlyGui, FlyFrame, ToggleFlyBtn, BoostFlyBtn

function FlyUI.Create()
    -- [[ ✈️ PANEL KONTROL TERBANG (MOBILE) ]] --
    FlyGui = Instance.new("ScreenGui")
    FlyGui.Name = "FischFlyGui"
    FlyGui.Parent = game:GetService("CoreGui")
    FlyGui.Enabled = false
    FlyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Kerangka Utama
    FlyFrame = Instance.new("Frame")
    FlyFrame.Name = "FlyMainFrame"
    FlyFrame.Parent = FlyGui
    FlyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    FlyFrame.BorderColor3 = Color3.fromRGB(60, 60, 60)
    FlyFrame.BorderSizePixel = 1
    FlyFrame.Position = UDim2.new(0.8, 0, 0.25, 0)
    FlyFrame.Size = UDim2.new(0, 150, 0, 180)
    FlyFrame.Active = true
    FlyFrame.Draggable = true

    -- Judul
    local FlyTitle = Instance.new("TextLabel")
    FlyTitle.Parent = FlyFrame
    FlyTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    FlyTitle.Size = UDim2.new(1, 0, 0, 25)
    FlyTitle.Font = Enum.Font.GothamBold
    FlyTitle.Text = "  ✈️ Kontrol Terbang"
    FlyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    FlyTitle.TextSize = 14
    FlyTitle.TextXAlignment = Enum.TextXAlignment.Left

    -- Tombol lipat
    local FlyMinimizeBtn = Instance.new("TextButton")
    FlyMinimizeBtn.Parent = FlyFrame
    FlyMinimizeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    FlyMinimizeBtn.BackgroundTransparency = 1
    FlyMinimizeBtn.Position = UDim2.new(1, -30, 0, 0)
    FlyMinimizeBtn.Size = UDim2.new(0, 30, 0, 25)
    FlyMinimizeBtn.Font = Enum.Font.GothamBold
    FlyMinimizeBtn.Text = "-"
    FlyMinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    FlyMinimizeBtn.TextSize = 18

    -- Area konten
    local FlyContent = Instance.new("Frame")
    FlyContent.Parent = FlyFrame
    FlyContent.BackgroundTransparency = 1
    FlyContent.Position = UDim2.new(0, 10, 0, 35)
    FlyContent.Size = UDim2.new(1, -20, 1, -45)

    -- 1. Tombol On/Off (Toggle Utama)
    ToggleFlyBtn = Instance.new("TextButton")
    ToggleFlyBtn.Name = "ToggleFlyBtn"
    ToggleFlyBtn.Parent = FlyContent
    ToggleFlyBtn.Size = UDim2.new(1, 0, 0, 50)
    ToggleFlyBtn.Position = UDim2.new(0, 0, 0, 0)
    ToggleFlyBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    ToggleFlyBtn.Font = Enum.Font.GothamBold
    ToggleFlyBtn.Text = "MATI"
    ToggleFlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleFlyBtn.TextSize = 24
    Instance.new("UICorner", ToggleFlyBtn).CornerRadius = UDim.new(0, 8)

    -- 2. Tombol Speed Boost
    BoostFlyBtn = Instance.new("TextButton")
    BoostFlyBtn.Name = "BoostFlyBtn"
    BoostFlyBtn.Parent = FlyContent
    BoostFlyBtn.Size = UDim2.new(1, 0, 0, 40)
    BoostFlyBtn.Position = UDim2.new(0, 0, 0, 60)
    BoostFlyBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    BoostFlyBtn.Font = Enum.Font.GothamBold
    BoostFlyBtn.Text = "⚡ Kecepatan: Normal"
    BoostFlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    BoostFlyBtn.TextSize = 16
    Instance.new("UICorner", BoostFlyBtn).CornerRadius = UDim.new(0, 8)

    -- Logika: Tombol On/Off
    ToggleFlyBtn.MouseButton1Click:Connect(function()
        _G.IsFlying = not _G.IsFlying
        
        if _G.IsFlying then
            ToggleFlyBtn.Text = "HIDUP"
            ToggleFlyBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        else
            ToggleFlyBtn.Text = "MATI"
            ToggleFlyBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            
            local char = Services.LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then 
                char.Humanoid.PlatformStand = false 
            end
        end
    end)

    -- Logika: Tombol Boost
    BoostFlyBtn.MouseButton1Click:Connect(function()
        _G.BoostEnabled = not _G.BoostEnabled
        
        if _G.BoostEnabled then
            BoostFlyBtn.Text = "⚡ Kecepatan: CEPAT!"
            BoostFlyBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
            BoostFlyBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        else
            BoostFlyBtn.Text = "⚡ Kecepatan: Normal"
            BoostFlyBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            BoostFlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end)

    -- Logika: Perkecil/Perbesar jendela
    local isFlyMinimized = false
    FlyMinimizeBtn.MouseButton1Click:Connect(function()
        isFlyMinimized = not isFlyMinimized
        if isFlyMinimized then
            FlyFrame:TweenSize(UDim2.new(0, 150, 0, 25), "Out", "Quad", 0.3, true)
            FlyContent.Visible = false
            FlyMinimizeBtn.Text = "+"
        else
            FlyFrame:TweenSize(UDim2.new(0, 150, 0, 180), "Out", "Quad", 0.3, true)
            FlyContent.Visible = true
            FlyMinimizeBtn.Text = "-"
        end
    end)

    -- Loop Auto Sync
    task.spawn(function()
        while true do
            task.wait(0.2)
            if FlyGui.Enabled then
                -- Sync tombol terbang
                if _G.IsFlying and ToggleFlyBtn.Text ~= "HIDUP" then
                    ToggleFlyBtn.Text = "HIDUP"
                    ToggleFlyBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
                elseif not _G.IsFlying and ToggleFlyBtn.Text ~= "MATI" then
                    ToggleFlyBtn.Text = "MATI"
                    ToggleFlyBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
                end

                -- Sync tombol Boost
                if _G.BoostEnabled and BoostFlyBtn.Text ~= "⚡ Kecepatan: CEPAT!" then
                    BoostFlyBtn.Text = "⚡ Kecepatan: CEPAT!"
                    BoostFlyBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
                    BoostFlyBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                elseif not _G.BoostEnabled and BoostFlyBtn.Text ~= "⚡ Kecepatan: Normal" then
                    BoostFlyBtn.Text = "⚡ Kecepatan: Normal"
                    BoostFlyBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                    BoostFlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
            end
        end
    end)
end

function FlyUI.SetVisible(enabled)
    if FlyGui then
        FlyGui.Enabled = enabled
    end
end

-- ============================================
-- MAIN UI MODULE - Fluent UI dan Tabs
-- ============================================

local MainUI = {}

-- Referensi Global
MainUI.Window = nil
MainUI.Tabs = nil
MainUI.Options = nil
MainUI.Fluent = nil
MainUI.SaveManager = nil
MainUI.InterfaceManager = nil

function MainUI.Create()
    -- Muat Fluent
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    end)

    if not success or not result then
        warn("[Error Script]: Gagal memuat Fluent UI! Periksa koneksi internet Anda.")
        return nil
    end

    local Fluent = result
    MainUI.Fluent = Fluent
    
    local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
    local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
    MainUI.SaveManager = SaveManager
    MainUI.InterfaceManager = InterfaceManager

    -- 🖼️ PENYIAPAN UI
    local Window = Fluent:CreateWindow({
        Title = "TESTING | versi 1",
        SubTitle = "FISCH",
        TabWidth = Services.TabsWidth,
        Size = Services.WindowSize,
        Acrylic = false,
        Theme = "Amethyst",
        MinimizeKey = Enum.KeyCode.LeftControl
    })
    MainUI.Window = Window

    -- Buat Tabs
    local Tabs = {
        Home = Window:AddTab({ Title = "Home", Icon = "home" }),
        Main = Window:AddTab({ Title = "Auto Fish", Icon = "component" }),
        Autos = Window:AddTab({ Title = "Autos", Icon = "repeat" }),
        Character = Window:AddTab({ Title = "Character", Icon = "user" }),
        Teleport = Window:AddTab({ Title = "Teleport", Icon = "map" }),
        Shop = Window:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
        Visuals = Window:AddTab({ Title = "Visuals", Icon = "eye" }),
        Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
        ServerInfo = Window:AddTab({ Title = "Server Info", Icon = "info" })
    }
    MainUI.Tabs = Tabs
    MainUI.Options = Fluent.Options

    return {
        Fluent = Fluent,
        Window = Window,
        Tabs = Tabs,
        Options = Fluent.Options,
        SaveManager = SaveManager,
        InterfaceManager = InterfaceManager
    }
end

function MainUI.CreateMobileUI()
    local CoreGui = Services.CoreGui
    local VirtualInputManager = Services.VirtualInputManager

    if CoreGui:FindFirstChild("FischMobileUI") then CoreGui.FischMobileUI:Destroy() end
    
    local ScreenGui = Instance.new("ScreenGui", CoreGui)
    ScreenGui.Name = "FischMobileUI"
    
    local MenuBtn = Instance.new("ImageButton", ScreenGui)
    MenuBtn.Name = "MenuToggle"
    MenuBtn.BackgroundColor3 = Color3.new(0,0,0)
    MenuBtn.BackgroundTransparency = 0.5
    MenuBtn.AnchorPoint = Vector2.new(0.5, 0)
    MenuBtn.Position = UDim2.new(0.5, -25, 0.05, 0)
    MenuBtn.Size = UDim2.fromOffset(50, 50)
    MenuBtn.Size = UDim2.fromOffset(50, 50)
    MenuBtn.Image = "rbxassetid://100142831144115"
    MenuBtn.Draggable = true
    Instance.new("UICorner", MenuBtn).CornerRadius = UDim.new(1,0)
    Instance.new("UIStroke", MenuBtn).Color = Color3.new(1,1,1)
    
    MenuBtn.MouseButton1Click:Connect(function()
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
        task.wait(0.05)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
    end)
end

-- ============================================
-- TAB SETUP MODULE - Pengaturan Tabs dan Elemen UI
-- ============================================

local TabSetup = {}

function TabSetup.SetupAllTabs(UI, Data, Utils)
    local Tabs = UI.Tabs
    local Options = UI.Options
    local Fluent = UI.Fluent

    -- 🏠 HOME
    Tabs.Home:AddToggle("StopAll", {Title = "HENTIKAN SEMUA AKSI", Default = false }):OnChanged(function()
        _G.StopAll = Options.StopAll.Value
        if _G.StopAll then
            _G.IsFlying = false
            local char = Services.LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                 char.Humanoid.PlatformStand = false; char.Humanoid.AutoRotate = true 
            end
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                for _, v in pairs({"FlyVelocity", "FlyGyro"}) do
                     if char.HumanoidRootPart:FindFirstChild(v) then char.HumanoidRootPart[v]:Destroy() end
                end
            end
        end
    end)

    -- 🎣 MAIN (Auto Fish)
    local ToggleAutoFish = Tabs.Main:AddToggle("AutoFish", {Title = "Aktifkan Auto Fish", Default = false })
    ToggleAutoFish:OnChanged(function()
        _G.AutoFish = Options.AutoFish.Value
        if _G.AutoFish and Services.LocalPlayer.Character and Services.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            _G.currentSpot = Services.LocalPlayer.Character.HumanoidRootPart.CFrame
        else
            _G.currentSpot = nil
        end
    end)
    Tabs.Main:AddToggle("AutoShake", {Title = "Auto Shake", Default = true }):OnChanged(function() _G.AutoShake = Options.AutoShake.Value end)
    Tabs.Main:AddToggle("LockPosition", {Title = "Kunci Posisi", Default = true }):OnChanged(function() _G.LockPosition = Options.LockPosition.Value end)

    -- 🤖 AUTOS
    local Autos = Tabs.Autos
    Autos:AddParagraph({ Title = "Jual Item", Content = "Auto jual atau jual di tangan." })

    local ToggleSellAll = Autos:AddToggle("AutoSellAll", {Title = "Auto Jual Semua", Default = false })
    ToggleSellAll:OnChanged(function() _G.AutoSellAll = Options.AutoSellAll.Value end)
    Autos:AddSlider("SellAllInterval", {Title = "Interval Jual (detik)", Default = 5, Min = 1, Max = 60, Rounding = 1, Callback = function(V) _G.SellAllInterval = V end})

    Autos:AddButton({Title = "Jual di Tangan", Callback = function()
        local remote = game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("Sell")
        if remote then
            local success, res = pcall(function() return remote:InvokeServer() end)
            if success then 
                LogUI.AddLog("💰 Item Terjual", Color3.fromRGB(100, 255, 100)) 
                Fluent:Notify({Title="Jual Tangan", Content="Sukses! Hasil: " .. tostring(res), Duration=3}) 
            else 
                warn("Error Jual Tangan:", res) 
            end
        else
            Fluent:Notify({Title="Error", Content="Remote Jual Tidak Ditemukan!", Duration=3})
        end
    end})

    Autos:AddParagraph({ Title = "---", Content = "" })

    -- Smart Auto Totem
    Autos:AddParagraph({ Title = "Smart Auto Totem", Content = "Sistem deteksi waktu Server secara Real-time\nAkan berjalan saat pergantian waktu (pagi/malam)" })

    _G.AutoTotem = false
    _G.DayTotemSelect = "Sundial Totem"
    _G.NightTotemSelect = "Aurora Totem"

    Autos:AddToggle("EnableAutoTotem", {Title = "Aktifkan Smart Auto Totem", Default = false }):OnChanged(function(Value) _G.AutoTotem = Value end)

    Autos:AddDropdown("DayTotemDrop", {
        Title = "☀️ Totem saat masuk pagi (06:30)", 
        Values = Data.TotemList, 
        Multi = false, 
        Default = "Sundial Totem",
    }):OnChanged(function(Value) _G.DayTotemSelect = Value end)

    Autos:AddDropdown("NightTotemDrop", {
        Title = "🌙 Totem saat masuk malam (18:00)", 
        Values = Data.TotemList, 
        Multi = false, 
        Default = "Aurora Totem",
    }):OnChanged(function(Value) _G.NightTotemSelect = Value end)

    -- Auto Potion
    Autos:AddParagraph({ Title = "Auto Potion (Timer)", Content = "Sistem minum ramuan dengan timer loop (satuan: menit)" })

    _G.AutoPotion = false
    _G.SelectedPotion = Data.PotionList[1]
    _G.PotionDelayMinutes = 10
    _G.PotionRepeatCount = 999
    _G.PotionTimer = 0

    Autos:AddToggle("EnableAutoPotion", {Title = "Aktifkan Auto Potion", Default = false }):OnChanged(function(Value)
        _G.AutoPotion = Value
        if Value then _G.PotionTimer = 0 end
    end)

    Autos:AddDropdown("PotionSelect", {
        Title = "Pilih Potion",
        Values = Data.PotionList,
        Multi = false,
        Default = 1,
    }):OnChanged(function(Value) _G.SelectedPotion = Value end)

    Autos:AddInput("PotionTimeInput", {
        Title = "Durasi buff (menit)",
        Default = "16",
        Numeric = true,
        Callback = function(Value) _G.PotionDelayMinutes = tonumber(Value) or 16 end
    })

    Autos:AddInput("PotionCountInput", {
        Title = "Jumlah pengulangan",
        Default = "999",
        Numeric = true,
        Callback = function(Value) _G.PotionRepeatCount = tonumber(Value) or 999 end
    })

    -- 🏃 CHARACTER
    Tabs.Character:AddToggle("ESPEnabled", {Title = "Aktifkan Player ESP", Default = false }):OnChanged(function() 
        _G.ESPEnabled = Options.ESPEnabled.Value 
    end)
    Tabs.Character:AddToggle("WalkSpeedEnabled", {Title = "Aktifkan Walk Speed", Default = false }):OnChanged(function() _G.WalkSpeedEnabled = Options.WalkSpeedEnabled.Value end)
    Tabs.Character:AddInput("WalkSpeedVal", {Title = "Nilai Kecepatan", Default = "16", Numeric = true, Callback = function(V) _G.WalkSpeed = tonumber(V) or 16 end})
    Tabs.Character:AddToggle("JumpPowerEnabled", {Title = "Aktifkan Jump Power", Default = false }):OnChanged(function() _G.JumpPowerEnabled = Options.JumpPowerEnabled.Value end)
    Tabs.Character:AddInput("JumpPowerVal", {Title = "Nilai Lompat", Default = "50", Numeric = true, Callback = function(V) _G.JumpPower = tonumber(V) or 50 end})
    Tabs.Character:AddToggle("Noclip", {Title = "Noclip", Default = false }):OnChanged(function() _G.Noclip = Options.Noclip.Value end)
    Tabs.Character:AddToggle("DashEnabled", {Title = "Aktifkan Dash", Default = true }):OnChanged(function() _G.DashEnabled = Options.DashEnabled.Value end)
    Tabs.Character:AddSlider("DashSpeed", {Title = "Kecepatan Dash", Default = 100, Min = 50, Max = 300, Rounding = 0, Callback = function(V) _G.DashSpeed = V end})
    Tabs.Character:AddToggle("FlyEnabled", {Title = "Aktifkan Fly", Default = true }):OnChanged(function() _G.FlyEnabled = Options.FlyEnabled.Value end)
    Tabs.Character:AddToggle("FlyInertia", {Title = "Inersia Terbang", Default = true }):OnChanged(function() _G.FlyInertia = Options.FlyInertia.Value end)
    Tabs.Character:AddSlider("FlySpeed", {Title = "Kecepatan Terbang", Default = 75, Min = 10, Max = 300, Rounding = 0, Callback = function(V) _G.FlySpeed = V end})
    
    Tabs.Character:AddParagraph({ Title = "Dukungan Mobile", Content = "Alat untuk perangkat mobile" })

    Tabs.Character:AddToggle("ShowFlyPanel", {Title = "Tampilkan Panel Fly (Mobile)", Default = false }):OnChanged(function(Value)
        FlyUI.SetVisible(Value)
    end)

    -- 🗺️ TELEPORT
    local DropdownManager, DropdownWarp
    local function RefreshAllDropdowns()
        local saved = Utils.LoadCustomLocations()
        local managerList, warpList = {}, {}
        local mQuery, wQuery = _G.ManagerSearch:lower(), _G.SearchQuery:lower()
        for name, _ in pairs(saved) do
            if mQuery == "" or name:lower():find(mQuery) then table.insert(managerList, name) end
            if wQuery == "" or name:lower():find(wQuery) then table.insert(warpList, name) end
        end
        for name, _ in pairs(Data.DefaultLocations) do
            if wQuery == "" or name:lower():find(wQuery) then table.insert(warpList, name) end
        end
        table.sort(managerList); table.sort(warpList)
        if DropdownManager then DropdownManager:SetValues(managerList) end
        if DropdownWarp then DropdownWarp:SetValues(warpList) end
    end

    Tabs.Teleport:AddButton({Title = "🔄 Refresh Daftar", Callback = function() RefreshAllDropdowns(); Fluent:Notify({Title="Teleport", Content="Diperbarui!", Duration=1}) end})
    Tabs.Teleport:AddInput("ManagerSearch", {Title = "🔍 Cari Tersimpan", Default = "", Callback = function(V) _G.ManagerSearch = V; RefreshAllDropdowns() end})
    
    DropdownManager = Tabs.Teleport:AddDropdown("ManagerSelect", {Title = "📂 Pilih Tersimpan", Values = {}, Multi = false, Default = nil})
    DropdownManager:OnChanged(function(Value)
        local saved = Utils.LoadCustomLocations()
        if Value and saved[Value] then
            _G.CustomName = Value
            _G.CustomX, _G.CustomY, _G.CustomZ = saved[Value].x, saved[Value].y, saved[Value].z
            if Options.LocName then Options.LocName:SetValue(Value) end
            if Options.InputX then Options.InputX:SetValue(tostring(_G.CustomX)) end
            if Options.InputY then Options.InputY:SetValue(tostring(_G.CustomY)) end
            if Options.InputZ then Options.InputZ:SetValue(tostring(_G.CustomZ)) end
        end
    end)
    
    Tabs.Teleport:AddInput("LocName", {Title = "Nama", Default = "", Callback = function(V) _G.CustomName = V end})
    Tabs.Teleport:AddInput("InputX", {Title = "X", Default = "0", Numeric = true, Callback = function(V) _G.CustomX = tonumber(V) or 0 end})
    Tabs.Teleport:AddInput("InputY", {Title = "Y", Default = "135", Numeric = true, Callback = function(V) _G.CustomY = tonumber(V) or 135 end})
    Tabs.Teleport:AddInput("InputZ", {Title = "Z", Default = "0", Numeric = true, Callback = function(V) _G.CustomZ = tonumber(V) or 0 end})
    
    Tabs.Teleport:AddButton({Title = "📍 Ambil Posisi", Callback = function()
        local char = Services.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local pos = char.HumanoidRootPart.Position
            _G.CustomX, _G.CustomY, _G.CustomZ = math.floor(pos.X), math.floor(pos.Y), math.floor(pos.Z)
            if Options.InputX then Options.InputX:SetValue(tostring(_G.CustomX)) end
            if Options.InputY then Options.InputY:SetValue(tostring(_G.CustomY)) end
            if Options.InputZ then Options.InputZ:SetValue(tostring(_G.CustomZ)) end
        end
    end})
    
    Tabs.Teleport:AddButton({Title = "💾 Simpan", Callback = function()
        if _G.CustomName == "" then return end
        local saved = Utils.LoadCustomLocations()
        saved[_G.CustomName] = {x = tonumber(_G.CustomX), y = tonumber(_G.CustomY), z = tonumber(_G.CustomZ)}
        Utils.SaveCustomLocations(saved); RefreshAllDropdowns()
    end})
    
    Tabs.Teleport:AddButton({Title = "🚀 Warp ke XYZ", Callback = function()
        if _G.StopAll then return end
        local char = Services.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local tp = CFrame.new(tonumber(_G.CustomX) or 0, tonumber(_G.CustomY) or 135, tonumber(_G.CustomZ) or 0)
            char.HumanoidRootPart.CFrame = tp
        end
    end})
    
    Tabs.Teleport:AddInput("SearchLoc", {Title = "🔍 Cari Warp", Default = "", Callback = function(V) _G.SearchQuery = V; RefreshAllDropdowns() end})
    
    DropdownWarp = Tabs.Teleport:AddDropdown("IslandWarp", {Title = "📂 Pilih Tujuan", Values = {}, Multi = false, Default = nil})
    DropdownWarp:OnChanged(function(Value)
        if _G.StopAll or not Value then return end
        local target, saved = Data.DefaultLocations[Value], Utils.LoadCustomLocations()
        if not target and saved[Value] then target = saved[Value] end
        if target then
            local char = Services.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local tp = CFrame.new(target.x, target.y, target.z)
                char.HumanoidRootPart.CFrame = tp
            end
        end
    end)

    -- Teleport Pemain
    Tabs.Teleport:AddParagraph({ Title = "-----------------", Content = "" })
    Tabs.Teleport:AddParagraph({ Title = "Teleport Pemain", Content = "Warp ke pemain lain di server" })

    local PlayerDropdown = Tabs.Teleport:AddDropdown("PlayerSelect", {
        Title = "Pilih Pemain (Select Player)",
        Values = {},
        Multi = false,
        Default = nil,
    })

    local function RefreshPlayerList()
        local pList = {}
        for _, p in pairs(Services.Players:GetPlayers()) do
            if p ~= Services.LocalPlayer then
                table.insert(pList, p.Name)
            end
        end
        table.sort(pList)
        PlayerDropdown:SetValues(pList)
    end

    Tabs.Teleport:AddButton({
        Title = "🔄 Refresh Daftar Pemain",
        Description = "Tekan untuk refresh daftar nama",
        Callback = function()
            RefreshPlayerList()
            Fluent:Notify({Title = "Sistem", Content = "Daftar Pemain Diperbarui!", Duration = 1})
        end
    })

    Tabs.Teleport:AddButton({
        Title = "🚀 Warp ke Pemain",
        Description = "Warp ke pemain yang dipilih",
        Callback = function()
            local targetName = Options.PlayerSelect.Value
            if not targetName then return end
            
            local targetPlayer = Services.Players:FindFirstChild(targetName)
            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local char = Services.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 0)
                    Fluent:Notify({Title = "Teleport", Content = "Warp ke: " .. targetName, Duration = 2})
                end
            else
                Fluent:Notify({Title = "Error", Content = "Tidak dapat menemukan pemain, atau dia sedang mati", Duration = 3})
            end
        end
    })

    task.delay(1, function() RefreshPlayerList() end)

    -- 🛒 SHOP
    local RodNames = {}
    for _, v in ipairs(Data.RodList) do table.insert(RodNames, v.Name) end
    Tabs.Shop:AddDropdown("SelectedRod", {Title = "Pilih Rod", Values = RodNames, Multi = false, Default = 1})
    Tabs.Shop:AddButton({Title = "Beli Rod", Callback = function() 
        local remote = Utils.GetPurchaseRemote()
        if remote then
            remote:FireServer(Options.SelectedRod.Value, "Rod", nil, 1) 
        else
            Fluent:Notify({Title = "Error", Content = "Remote pembelian tidak ditemukan", Duration = 3})
        end
    end})

    Tabs.Shop:AddDropdown("SelectedTotem", {Title = "Pilih Totem", Values = Data.TotemList, Multi = false, Default = 1})
    Tabs.Shop:AddInput("TotemAmount", {Title = "Jumlah", Default = "1", Numeric = true})
    Tabs.Shop:AddButton({Title = "Beli Totem", Callback = function()
        local selectedName = Options.SelectedTotem.Value
        local amount = math.clamp(tonumber(Options.TotemAmount.Value) or 1, 1, 50)
        
        local pricePerItem = 0
        for _, v in ipairs(Data.TotemData) do
            if v.Name == selectedName then pricePerItem = v.Price; break end
        end
        
        local totalPrice = pricePerItem * amount
        local currentMoney = Utils.getMoney()
        
        if currentMoney >= totalPrice then
            local remote = Utils.GetPurchaseRemote()
            if remote then
                remote:FireServer(selectedName, "Item", nil, amount)
                Fluent:Notify({Title = "Sukses", Content = "Membeli " .. amount .. " " .. selectedName, Duration = 3})
            else
                Fluent:Notify({Title = "Error", Content = "Remote pembelian tidak ditemukan", Duration = 3})
            end
        else
            Fluent:Notify({Title = "Gagal", Content = "Uang tidak cukup! Butuh: " .. totalPrice, Duration = 5})
        end
    end})

    -- 👁️ VISUALS
    local Visuals = Tabs.Visuals
    Visuals:AddParagraph({ Title = "Visibilitas UI", Content = "Pengaturan tampilan/sembunyikan tombol" })
    Visuals:AddToggle("HideShakeUI", {Title = "Sembunyikan UI Shake (Mode Siluman)", Default = false }):OnChanged(function() 
        _G.HideShakeUI = Options.HideShakeUI.Value 
    end)

    -- ⚙️ SETTINGS
    Tabs.Settings:AddToggle("AntiAFK", {Title = "Aktifkan Anti AFK", Default = true }):OnChanged(function() _G.AntiAFK = Options.AntiAFK.Value end)
    Tabs.Settings:AddToggle("AlwaysPerfect", {Title = "Selalu Tangkapan Sempurna", Default = true }):OnChanged(function() _G.AlwaysPerfect = Options.AlwaysPerfect.Value end)
    Tabs.Settings:AddToggle("FrozenBar", {Title = "Bar Beku (Visual)", Default = true }):OnChanged(function() _G.FrozenBar = Options.FrozenBar.Value end)
    Tabs.Settings:AddSlider("ReelDelay", {Title = "Delay Setelah Gigit", Default = 2.5, Min = 0.0, Max = 10.0, Rounding = 1, Callback = function(V) _G.ReelDelay = V end})
    Tabs.Settings:AddSlider("CastDelay", {Title = "Cooldown Setelah Tangkap", Default = 0.5, Min = 0.1, Max = 2.0, Rounding = 1, Callback = function(V) _G.CastDelay = V end})
    Tabs.Settings:AddButton({Title = "🔄 Rejoin Server", Callback = function() Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Services.LocalPlayer) end})
    Tabs.Settings:AddButton({Title = "⏩ Server Hop", Callback = function() Services.TeleportService:Teleport(game.PlaceId, Services.LocalPlayer) end})
    
    Tabs.Settings:AddParagraph({ Title = "Panel Log", Content = "Jendela tampilan status operasi" })
    Tabs.Settings:AddToggle("ShowLogPanel", {Title = "Tampilkan Panel Log", Default = false }):OnChanged(function(Value)
        LogUI.SetVisible(Value)
    end)
    Tabs.Settings:AddButton({Title = "Hapus Log", Callback = function() LogUI.ClearLogs() end})

    -- Performa & FPS
    Tabs.Settings:AddParagraph({ Title = "-----------------", Content = "" })
    Tabs.Settings:AddParagraph({ Title = "Performa & FPS", Content = "Alat bantu mengurangi lag dan mengurangi beban perangkat" })

    Tabs.Settings:AddButton({
        Title = "📉 Hapus Tekstur & Efek",
        Description = "Ubah gambar menjadi polos + hapus efek (FPS Boost)",
        Callback = function()
            local terrain = workspace:FindFirstChildOfClass("Terrain")
            if terrain then
                terrain.WaterWaveSize = 0
                terrain.WaterWaveSpeed = 0
                terrain.WaterReflectance = 0
                terrain.WaterTransparency = 0
            end

            local lighting = game:GetService("Lighting")
            lighting.GlobalShadows = false
            lighting.FogEnd = 9e9
            lighting.Brightness = 2
            
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and not v:IsA("MeshPart") then
                    v.Material = Enum.Material.SmoothPlastic
                    v.Reflectance = 0
                elseif v:IsA("Decal") or v:IsA("Texture") then
                    v:Destroy()
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
                    v.Enabled = false
                end
            end
            
            Fluent:Notify({Title = "FPS Boost", Content = "Tekstur & Efek Dihapus!", Duration = 3})
        end
    })

    Tabs.Settings:AddToggle("FullBright", {Title = "☀️ Full Bright (Tanpa Kabut)", Default = false }):OnChanged(function(Value)
        if Value then
            game:GetService("Lighting").Brightness = 2
            game:GetService("Lighting").ClockTime = 14
            game:GetService("Lighting").FogEnd = 100000
            game:GetService("Lighting").GlobalShadows = false
            game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        end
    end)

    Tabs.Settings:AddToggle("SuperLowMode", {Title = "⚫ Nonaktifkan Render 3D (Super AFK)", Default = false }):OnChanged(function(Value)
        Services.RunService:Set3dRenderingEnabled(not Value)
        if Value then
            Fluent:Notify({Title = "Mode AFK", Content = "Tampilan 3D dimatikan (hemat GPU)", Duration = 3})
        else
            Fluent:Notify({Title = "Mode AFK", Content = "Kembali ke mode normal", Duration = 3})
        end
    end)

    Tabs.Settings:AddInput("FPSCap", {
        Title = "🔒 Batas FPS Maksimum",
        Default = "60",
        Numeric = true,
        Callback = function(Value)
            setfpscap(tonumber(Value) or 60)
        end
    })

    -- ℹ️ TAB INFO SERVER
    local InfoTab = Tabs.ServerInfo

    InfoTab:AddToggle("ShowInfoPanel", {Title = "Tampilkan Panel Info Overlay", Default = true }):OnChanged(function(Value)
        InfoUI.SetVisible(Value)
    end)

    InfoTab:AddParagraph({ Title = "---", Content = "" })

    local RealTimePara = InfoTab:AddParagraph({ Title = "🕒 Waktu Nyata (Real Time)", Content = "Memuat..." })
    local GameTimePara = InfoTab:AddParagraph({ Title = "☀️ Waktu Game (Game Time)", Content = "Memuat..." })
    local UptimePara = InfoTab:AddParagraph({ Title = "⏳ Server Sudah Berjalan (Server Uptime)", Content = "Memuat..." })

    -- Loop Update
    task.spawn(function()
        while true do
            -- Waktu Nyata
            local statusTime = os.date("%H:%M:%S")
            
            -- Waktu Game
            local clockTime = game:GetService("Lighting").ClockTime
            local timeState = (clockTime >= 6 and clockTime < 18) and "Siang ☀️" or "Malam 🌙"
            local gameTimeStr = Utils.FormatGameTime(clockTime) .. " " .. timeState

            -- Uptime Server
            local serverTime = workspace.DistributedGameTime
            local uptimeStr = Utils.FormatTime(serverTime)

            -- Update Paragraph
            if RealTimePara then RealTimePara:SetDesc(statusTime) end
            if GameTimePara then GameTimePara:SetDesc(gameTimeStr) end
            if UptimePara then UptimePara:SetDesc(uptimeStr) end

            -- Update Info UI
            InfoUI.Update(Utils.FormatTime, Utils.FormatGameTime)

            task.wait(1)
        end
    end)

    -- Penyiapan SaveManager
    UI.SaveManager:SetLibrary(Fluent)
    UI.InterfaceManager:SetLibrary(Fluent)
    UI.SaveManager:IgnoreThemeSettings()
    UI.InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    UI.Window:SelectTab(1)
    UI.SaveManager:LoadAutoloadConfig()
    
    RefreshAllDropdowns()
end

-- ============================================
-- MAIN EXECUTION - Menjalankan Semua Modul
-- ============================================

local function Main()
    -- Buat UI
    LogUI.Create()
    InfoUI.Create()
    FlyUI.Create()
    
    local UI = MainUI.Create()
    if not UI then return end
    
    if Services.IsMobile then
        MainUI.CreateMobileUI()
    end
    
    -- Setup Tabs
    TabSetup.SetupAllTabs(UI, Data, Utils)
    
    -- Jalankan Modul
    AutoFish.SetupShakeDetection()
    AutoFish.Start()
    AutoPotion.Start()
    AutoSell.Start()
    AutoTotem.Start()
    Character.Start()
    
    -- Log Startup
    _G.AddLog("✅ TESTING berhasil dimuat!", Color3.fromRGB(0, 255, 100))
    UI.Fluent:Notify({Title = "TESTING", Content = "Script berhasil dimuat!", Duration = 5})
end

-- Jalankan Main
Main()
