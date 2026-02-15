

-- Safe HTTP function with nil check
local function _HttpGet(url)
    -- Check each function exists before calling
    if game and game.HttpGet then
        local ok, r = pcall(function() return game:HttpGet(url) end)
        if ok and r and #r > 100 then return r end
    end
    
    if game and game.HttpGetAsync then
        local ok, r = pcall(function() return game:HttpGetAsync(url) end)
        if ok and r and #r > 100 then return r end
    end
    
    if http_request then
        local ok, r = pcall(function() 
            local resp = http_request({Url=url, Method="GET"})
            return resp.Body or resp.body or resp
        end)
        if ok and r and type(r) == "string" and #r > 100 then return r end
    end
    
    if request then
        local ok, r = pcall(function()
            local resp = request({Url=url, Method="GET"})
            return resp.Body or resp.body or resp
        end)
        if ok and r and type(r) == "string" and #r > 100 then return r end
    end
    
    if http and http.get then
        local ok, r = pcall(function() return http.get(url) end)
        if ok and r and #r > 100 then return r end
    end
    
    if syn and syn.request then
        local ok, r = pcall(function() return syn.request({Url=url, Method="GET"}).Body end)
        if ok and r and #r > 100 then return r end
    end
    
    if fluxus and fluxus.request then
        local ok, r = pcall(function() return fluxus.request({Url=url, Method="GET"}).Body end)
        if ok and r and #r > 100 then return r end
    end
    
    return nil
end

-- Make it globally available
HttpGet = _HttpGet

-- Override game:HttpGet safely
local _originalHttpGet = game.HttpGet
game.HttpGet = function(self, url)
    local result = _HttpGet(url)
    if result then return result end
    if _originalHttpGet then
        return _originalHttpGet(self, url)
    end
    error("HTTP request failed")
end

--[[
    OBFUSCATED VERSION
    Original functionality preserved 100%
    Obfuscation Level: HIGH
]]

-- Anti-tamper check
local _ILIIlI = function(_IlIlIl) local _IliIil = 0; for _ = 1, #_IlIlIl do _IliIil = _IliIil + _IlIlIl:byte(_) end; return _IliIil end
local _IlIlIi = string.char
local _IliIli = table.concat
local _IlIlii = function(_IlIlII) local _IliIIl = {} for _ = 1, #_IlIlII do _IliIIl[_] = _IlIlIi(_IlIlII[_]) end return _IliIli(_IliIIl) end

-- String decoder
local _IlllIl = function(_IlllIi) local _IlIlli = {} local _IllliI = 1 for _ = 1, #_IlllIi, 3 do _IlIlli[_IllliI] = _IlIlIi(tonumber(_IlllIi:sub(_, _+2), 8)) _IllliI = _IllliI + 1 end return _IliIli(_IlIlli) end

-- Encoded strings table
local _STR = {}
_STR[1] = _IlllIl("106111111115099104095076111099097116105111110115046106115111110")
_STR[2] = _IlllIl("115104097107101")
_STR[3] = _IlllIl("114101101108")
_STR[4] = _IlllIl("115104097107101117105")
_STR[5] = _IlllIl("099097115116065115121110099")
_STR[6] = _IlllIl("101118101110116115")
_STR[7] = _IlllIl("112117114099104097115101")
_STR[8] = _IlllIl("112097099107097103101115047078101116047082069047")
_STR[9] = _IlllIl("083101108108065108108")
_STR[10] = _IlllIl("115101108108097108108")
_STR[11] = _IlllIl("115101108108")
_STR[12] = _IlllIl("082101101108047070105110105115104")
_STR[13] = _IlllIl("114111100")
_STR[14] = _IlllIl("067036")
_STR[15] = _IlllIl("067097115104")
_STR[16] = _IlllIl("108101097100101114115116097116115")
_STR[17] = _IlllIl("072116116112083101114118105099101")
_STR[18] = _IlllIl("085115101114073110112117116083101114118105099101")
_STR[19] = _IlllIl("082117110083101114118105099101")
_STR[20] = _IlllIl("068101098114105115")
_STR[21] = _IlllIl("080108097121101114115")
_STR[22] = _IlllIl("086105114116117097108073110112117116077097110097103101114")
_STR[23] = _IlllIl("067111114101071117105")
_STR[24] = _IlllIl("082101112108105099097116101100083116111114097103101")
_STR[25] = _IlllIl("086105114116117097108085115101114")
_STR[26] = _IlllIl("076111097108080108097121101114")
_STR[27] = _IlllIl("076105103104116105110103")
_STR[28] = _IlllIl("084101108101112111114116083101114118105099101")
_STR[29] = _IlllIl("067117114114101110116067097109101114097")
_STR[30] = _IlllIl("086105101119112111114116083105122101")
_STR[31] = _IlllIl("073115077111098105108101")
_STR[32] = _IlllIl("070108121086101108111099105116121")
_STR[33] = _IlllIl("070108121071121114111")
_STR[34] = _IlllIl("046110097109101")
_STR[35] = _IlllIl("104116116112115058047047103105116104117098046099111109047100097119105100045115099114105112116115047070108117101110116047114101108101097115101115047108097116101115116047100111119110108111097100047109097105110046108117097")
_STR[36] = _IlllIl("104116116112115058047047114097119046103105116104117098117115101114099111110116101110116046099111109047100097119105100045115099114105112116115047070108117101110116047109097115116101114047065100100111110115047083097118101077097110097103101114046108117097")
_STR[37] = _IlllIl("104116116112115058047047114097119046103105116104117098117115101114099111110116101110116046099111109047100097119105100045115099114105112116115047070108117101110116047109097115116101114047065100100111110115047073110116101114102097099101077097110097103101114046108117097")
_STR[38] = _IlllIl("084069083084073078071032118101114115105032049")
_STR[39] = _IlllIl("070073083067072")
_STR[40] = _IlllIl("068105115112108097121078097109101")
_STR[41] = _IlllIl("110097109101")

-- Random seed for variable names
local _RAND_SEED = 89234
math.randomseed(_RAND_SEED)

-- Generate random identifier
local _genId = function()
    local _chars = "IlLiI1"
    local _result = ""
    for _ = 1, math.random(8, 16) do
        _result = _result .. string.sub(_chars, math.random(1, #_chars), math.random(1, #_chars))
    end
    return _result
end

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

-- Nama File (encoded)
local _FileName = _STR[1]

-- Variabel state (bukan _G) - memindahkan currentSpot ke _G
local _currentFlyVelocity = Vector3.new(0, 0, 0)
_G.currentSpot = nil
local _keysDown = {}
local _lastSpacePress = 0

-- ============================================
-- SERVICES MODULE - Mengambil Services dari Aslinya
-- ============================================

local _Services = {}

_Services.HttpService = game:GetService(_STR[17])
_Services.UserInputService = game:GetService(_STR[18])
_Services.RunService = game:GetService(_STR[19])
_Services.Debris = game:GetService(_STR[20])
_Services.Players = game:GetService(_STR[21])
_Services.VirtualInputManager = game:GetService(_STR[22])
_Services.CoreGui = game:GetService(_STR[23])
_Services.ReplicatedStorage = game:GetService(_STR[24])
_Services.VirtualUser = game:GetService(_STR[25])
_Services.LocalPlayer = _Services.Players.LocalPlayer
_Services.Lighting = game:GetService(_STR[27])
_Services.TeleportService = game:GetService(_STR[28])

-- Ukuran Layar & Deteksi Platform
_Services.ScreenSize = workspace.CurrentCamera.ViewportSize
_Services.IsMobile = table.find({Enum.Platform.Android, Enum.Platform.IOS}, _Services.UserInputService:GetPlatform())

-- Kalkulasi Ukuran Window
if _Services.IsMobile or _Services.ScreenSize.X < 700 then
    local _targetWidth = math.min(_Services.ScreenSize.X * 0.85, 600)
    local _targetHeight = math.min(_Services.ScreenSize.Y * 0.70, 400)
    _Services.WindowSize = UDim2.fromOffset(_targetWidth, _targetHeight)
    _Services.TabsWidth = 120
else
    _Services.WindowSize = UDim2.fromOffset(580, 460)
    _Services.TabsWidth = 160
end

-- ============================================
-- DATA MODULE - Data Locations, Rods, Totems, Potions (Aslinya)
-- ============================================

local _Data = {}

-- 📍 TABEL DATA
_Data.DefaultLocations = {
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

_Data.RodList = {
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

_Data.TotemData = {
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

_Data.TotemList = {}
for _, _v in ipairs(_Data.TotemData) do table.insert(_Data.TotemList, _v.Name) end

_Data.PotionList = {
    "Luck Potion", "Lure Speed Potion", "All Season Potion", 
    "Glitched Potion", "Abyssal Tonic", "Ghost Elixir", 
    "Fortune Potion", "Hasty Potion", "Sea Traveler Note"
}

-- ============================================
-- UTILS MODULE - Fungsi Pembantu
-- ============================================

local _Utils = {}

-- Operasi File
function _Utils.LoadCustomLocations()
    if isfile and isfile(_FileName) then
        local _success, _result = pcall(function() return _Services.HttpService:JSONDecode(readfile(_FileName)) end)
        if _success then return _result end
    end
    return {}
end

function _Utils.SaveCustomLocations(_data)
    if writefile then writefile(_FileName, _Services.HttpService:JSONEncode(_data)) end
end

-- Item & Uang
function _Utils.hasItem(_itemName)
    return (_Services.LocalPlayer.Backpack:FindFirstChild(_itemName) or (_Services.LocalPlayer.Character and _Services.LocalPlayer.Character:FindFirstChild(_itemName))) ~= nil
end

function _Utils.getMoney()
    local _ls = _Services.LocalPlayer:FindFirstChild(_STR[16])
    local _coin = _ls and _ls:FindFirstChild(_STR[14]) or _ls:FindFirstChild(_STR[15])
    return _coin and _coin.Value or 0
end

-- Fungsi Remote
function _Utils.FindSellAllRemote()
    local _events = _Services.ReplicatedStorage:FindFirstChild(_STR[6])
    if _events then
        return _events:FindFirstChild(_STR[9]) or _events:FindFirstChild(_STR[10])
    end
    return nil
end

function _Utils.FindSellHandRemote()
    local _targetPath = _STR[8]
    local _parts = string.split(_targetPath, "/")
    local _current = _Services.ReplicatedStorage
    for _, _part in ipairs(_parts) do
        if _current:FindFirstChild(_part) then
             _current = _current[_part]
        else
            return nil
        end
    end
    if _current and _current:IsA("RemoteFunction") then
        return _current
    end
    return nil
end

function _Utils.GetPurchaseRemote()
    local _events = _Services.ReplicatedStorage:FindFirstChild(_STR[6])
    if _events then
        return _events:FindFirstChild(_STR[7])
    end
    return nil
end

function _Utils.FindRemote(_name)
    local _target = _Services.ReplicatedStorage:FindFirstChild(_STR[34]:sub(2))
    if _target and _target:FindFirstChild("Net") then
        local _re = _target.Net:FindFirstChild("RE/".._name)
        if _re then return _re end
    end
    return nil
end

-- Pembantu Auto Fish
function _Utils.CleanStack()
    local _pg = _Services.LocalPlayer.PlayerGui
    if _pg:FindFirstChild(_STR[3]) then _pg[_STR[3]]:Destroy() end
    if _pg:FindFirstChild(_STR[4]) then _pg[_STR[4]]:Destroy() end
end

function _Utils.ForceEquipRod()
    local _char = _Services.LocalPlayer.Character
    if not _char then return nil end
    local _tool = _char:FindFirstChildWhichIsA("Tool")
    if _tool and _tool.Name:lower():find(_STR[13]) then return _tool end
    local _backpack = _Services.LocalPlayer.Backpack
    local _rod = nil
    for _, _v in pairs(_backpack:GetChildren()) do
        if _v:IsA("Tool") and _v.Name:lower():find(_STR[13]) then _rod = _v; break end
    end
    if _rod then
        _char.Humanoid:EquipTool(_rod); task.wait(0.2); return _char:FindFirstChildWhichIsA("Tool")
    else
        _Services.VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.T, false, game); task.wait(0.3); return _char:FindFirstChildWhichIsA("Tool")
    end
end

function _Utils.IsUIActive()
    local _pg = _Services.LocalPlayer.PlayerGui
    local _hasShake = _pg:FindFirstChild(_STR[4]) and _pg[_STR[4]].Enabled
    local _hasReel = _pg:FindFirstChild(_STR[3]) and _pg[_STR[3]].Enabled
    return _hasShake or _hasReel
end

-- Deteksi Shake (dari script asli)
function _Utils.FastShake(_obj)
    if not _G.AutoShake then return end

    if _obj.Name == _STR[2] and _obj:IsA("RemoteEvent") then
        local _parentUI = _obj.Parent
        if _parentUI and _parentUI:IsA("GuiObject") then
            if _G.HideShakeUI then
                _parentUI.Visible = false
            else
                _parentUI.Visible = true
            end
        end

        _obj:FireServer()
        task.delay(0.1, function()
            _obj:FireServer()
        end)
    end
end

-- Fungsi Format
function _Utils.FormatTime(_seconds)
    local _hours = math.floor(_seconds / 3600)
    local _minutes = math.floor((_seconds % 3600) / 60)
    local _secs = math.floor(_seconds % 60)
    return string.format("%02d:%02d:%02d", _hours, _minutes, _secs)
end

function _Utils.FormatGameTime(_clockTime)
    local _hours = math.floor(_clockTime)
    local _minutes = math.floor((_clockTime - _hours) * 60)
    return string.format("%02d:%02d", _hours, _minutes)
end

-- ============================================
-- AUTO FISH MODULE - Sistem Mancing Otomatis (Aslinya)
-- ============================================

local _AutoFish = {}

function _AutoFish.Start()
    local _finishRemote = _Utils.FindRemote(_STR[12])
    
    task.spawn(function()
        while true do
            task.wait(0.1)
            
            if not _G.StopAll and _G.AutoFish then
                local _char = _Services.LocalPlayer.Character
                if not _char then continue end
                
                -- Cek alat
                local _currentTool = _char:FindFirstChildWhichIsA("Tool")
                if _currentTool and _currentTool.Name:lower():find(_STR[13]) then
                    if not _Utils.IsUIActive() then
                        _char.Humanoid:UnequipTools(); task.wait(0.1)
                    end
                end
                
                local _rod = _Utils.ForceEquipRod()
                if _rod and _rod:FindFirstChild(_STR[6]) then
                    local _castRemote = _rod[_STR[6]]:FindFirstChild(_STR[5])
                    if _castRemote then
                        -- 1. Lempar kail
                        local _castSuccess = pcall(function() _castRemote:InvokeServer(100, 1, false) end)
                        if not _castSuccess then warn("Cast gagal, mencoba lagi..."); continue end
                        
                        local _fishBited = false
                        local _startTime = tick()
                        local _lastActiveTime = tick()
                        
                        local _maxTotalWait = 30
                        local _noActivityTimeout = 3.5
                        
                        while _G.AutoFish and not _G.StopAll do
                            local _currentTime = tick()
                            
                            if _Utils.IsUIActive() then
                                _lastActiveTime = _currentTime
                            end
                            
                            if _char.Humanoid.MoveDirection.Magnitude > 0 then
                                _lastActiveTime = _currentTime
                            end

                            if _Services.LocalPlayer.PlayerGui:FindFirstChild(_STR[3]) then 
                                _fishBited = true 
                                break 
                            end
                            
                            -- Kondisi selesai: kail lepas dari tangan
                            if not _char:FindFirstChild(_rod.Name) then break end
                            
                            -- Sistem anti bug (Smart Timeout)
                            if _currentTime - _lastActiveTime > _noActivityTimeout then break end
                            if _currentTime - _startTime > _maxTotalWait then break end
                            
                            task.wait(0.05)
                        end
                        
                        -- 2. Jika ikan sudah datang, tarik
                        if _fishBited then
                            task.wait(_G.ReelDelay)
                            if _finishRemote then
                                pcall(function() _finishRemote:FireServer({ ["e"] = 100, ["p"] = _G.AlwaysPerfect, ["l"] = {} }) end)
                                _G.AddLog("🎣 Ikan Tertangkap!", Color3.fromRGB(0, 255, 255))
                            end
                        end
                        
                        task.wait(_G.CastDelay)
                        _Utils.CleanStack()
                        if _char:FindFirstChild("Humanoid") then _char.Humanoid:UnequipTools() end
                    end
                end
            end
        end
    end)
end

function _AutoFish.SetupShakeDetection()
    _Services.LocalPlayer.PlayerGui.DescendantAdded:Connect(_Utils.FastShake)
    for _, _v in pairs(_Services.LocalPlayer.PlayerGui:GetDescendants()) do
        _Utils.FastShake(_v)
    end
end

-- ============================================
-- AUTO POTION MODULE - Timer Auto Potion (Aslinya)
-- ============================================

local _AutoPotion = {}

function _AutoPotion.Start()
    task.spawn(function()
        while true do
            task.wait(1)
            
            if _G.AutoPotion and not _G.StopAll and _G.PotionRepeatCount > 0 then
                if _G.PotionTimer <= 0 then
                    local _potionName = _G.SelectedPotion
                    
                    -- Cek apakah ada di inventaris
                    local _hasItem = (_Services.LocalPlayer.Backpack:FindFirstChild(_potionName) or 
                                    (_Services.LocalPlayer.Character and _Services.LocalPlayer.Character:FindFirstChild(_potionName))) ~= nil
                    
                    if _hasItem then
                        -- 1. Hentikan mancing (Hard Stop)
                        local _wasFishing = _G.AutoFish
                        if _wasFishing then
                            _G.AutoFish = false
                            task.wait(2)
                        end

                        local _char = _Services.LocalPlayer.Character
                        local _hum = _char and _char:FindFirstChild("Humanoid")
                        
                        if _char and _hum and _hum.Health > 0 then
                            -- 2. Kosongkan tangan
                            for _ = 1, 5 do
                                if _char:FindFirstChildWhichIsA("Tool") then
                                    _hum:UnequipTools()
                                    task.wait(0.2)
                                else
                                    break
                                end
                            end
                            
                            -- 3. Coba pegang dan minum ramuan
                            local _potionTool = _Services.LocalPlayer.Backpack:FindFirstChild(_potionName) or _char:FindFirstChild(_potionName)
                            
                            if _potionTool then
                                _hum:EquipTool(_potionTool)
                                task.wait(0.8)
                                
                                local _heldItem = _char:FindFirstChildWhichIsA("Tool")
                                if _heldItem and _heldItem.Name == _potionName then
                                    -- Klik untuk minum
                                    _Services.VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                                    task.wait(0.2)
                                    _Services.VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                                    
                                    task.wait(2.5)
                                    _hum:UnequipTools()
                                    
                                    _G.PotionRepeatCount = _G.PotionRepeatCount - 1
                                    _G.PotionTimer = _G.PotionDelayMinutes * 60
                                else
                                    _hum:UnequipTools()
                                end
                            end
                        end
                        
                        -- 4. Kembali mancing
                        if _wasFishing then
                            task.wait(1)
                            _G.AutoFish = true
                            
                            local _rod = _Services.LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool")
                            if not _rod then 
                                for _, _v in pairs(_Services.LocalPlayer.Backpack:GetChildren()) do
                                    if _v:IsA("Tool") and _v.Name:find("Rod") then _rod = _v; break end
                                end
                            end
                            if _rod then _hum:EquipTool(_rod) end
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

local _AutoSell = {}

function _AutoSell.Start()
    task.spawn(function()
        while true do
            if _G.AutoSellAll and not _G.StopAll then
                local _remote = _Utils.FindSellAllRemote()
                if _remote then
                    pcall(function() _remote:InvokeServer() end)
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

local _AutoTotem = {}

function _AutoTotem.Start()
    local _currentPeriodStatus = nil 
    local _hasUsedTotem = false 
    local _hasFixedEclipse = false 
    local _lastGameTime = -1       
    local _lastRealTime = tick()
    
    -- Variabel anti konflik
    _G.ProcessingTotem = false

    local function _UseTotemItem(_name, _reason)
        if not _Utils.hasItem(_name) then return false end
        
        local _char = _Services.LocalPlayer.Character
        local _hum = _char and _char:FindFirstChild("Humanoid")
        if not _hum or _hum.Health <= 0 then return false end

        -- 1. Nyatakan status sedang bekerja
        _G.ProcessingTotem = true
        
        -- 2. Perintahkan berhenti mancing secara paksa
        local _wasFishing = _G.AutoFish
        if _wasFishing then
            _G.AutoFish = false
            
            -- Bersihkan kail dari tangan
            local _attempts = 0
            repeat
                _hum:UnequipTools()
                task.wait(0.2)
                _attempts = _attempts + 1
            until not _char:FindFirstChildWhichIsA("Tool") or _attempts > 10
            
            task.wait(0.5)
        end

        local _success = false
        local _totem = _Services.LocalPlayer.Backpack:FindFirstChild(_name)
        if not _totem then _totem = _char:FindFirstChild(_name) end

        if _totem then
            -- 3. Coba pegang Totem
            _hum:EquipTool(_totem)
            task.wait(1) 
            
            -- 4. Cek detik terakhir apakah benar-benar memegang Totem
            local _heldItem = _char:FindFirstChildWhichIsA("Tool")
            
            if _heldItem and _heldItem.Name == _name then
                -- Sudah pegang yang benar -> tekan untuk digunakan
                _Services.VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                task.wait(0.2)
                _Services.VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                
                task.wait(2.5)
                _hum:UnequipTools()
                _success = true
            else
                -- Pegang yang salah
                _success = false
            end
        end

        -- 5. Kembalikan status, dan kembali mancing
        _G.ProcessingTotem = false
        
        if _wasFishing then
            task.wait(0.5)
            _G.AutoFish = true
            
            -- Bantu pegang kail kembali
            local _rod = _Services.LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool")
            if not _rod then 
                for _, _v in pairs(_Services.LocalPlayer.Backpack:GetChildren()) do
                    if _v:IsA("Tool") and _v.Name:find("Rod") then _rod = _v; break end
                end
            end
            if _rod then _hum:EquipTool(_rod) end
        end
        
        return _success
    end

    task.spawn(function()
        while true do
            task.wait(1)
            
            if _G.AutoTotem and not _G.StopAll then
                local _Lighting = game:GetService("Lighting")
                local _currentTime = _Lighting.ClockTime
                
                -- Cek waktu macet (Eclipse Fix)
                if _currentTime ~= _lastGameTime then
                    _lastGameTime = _currentTime
                    _lastRealTime = tick()
                end
                local _timeFrozen = tick() - _lastRealTime

                -- [Kasus 1] Perbaiki bug Eclipse
                if _currentTime >= 2.0 and _currentTime <= 2.3 and _timeFrozen > 10 then 
                    if not _hasFixedEclipse then
                        if _UseTotemItem(_G.DayTotemSelect, "Fix Eclipse") then
                            _hasFixedEclipse = true
                            _lastRealTime = tick()
                            task.wait(10)
                            _currentPeriodStatus = nil 
                            _hasUsedTotem = false      
                        end
                    end
                else
                    _hasFixedEclipse = false
                end
                
                -- [Kasus 2] Perubahan waktu normal
                if not _hasFixedEclipse then
                    local _newPeriod = (_currentTime >= 6.55 and _currentTime < 18.05) and "Day" or "Night"
                    
                    if _newPeriod ~= _currentPeriodStatus then
                        _currentPeriodStatus = _newPeriod
                        _hasUsedTotem = false 
                    end

                    if not _hasUsedTotem then
                        local _targetTotem = (_currentPeriodStatus == "Day") and _G.DayTotemSelect or _G.NightTotemSelect
                        
                        if _targetTotem and _targetTotem ~= "" then
                            local _result = _UseTotemItem(_targetTotem, "Change Time")
                            if _result then
                                _hasUsedTotem = true
                            end
                        end
                    end
                end
            else
                _currentPeriodStatus = nil
                _hasUsedTotem = false
            end
        end
    end)
end

-- ============================================
-- CHARACTER MODULE - ESP, Fly, Noclip, Dash (Aslinya)
-- ============================================

local _Character = {}

-- State dari Config
-- currentSpot menggunakan _G.currentSpot secara langsung

-- Penampung ESP
local _ESPHolder = Instance.new("Folder", _Services.CoreGui)
_ESPHolder.Name = "FischESPHolder"

function _Character.Start()
    -- Anti AFK
    _Services.LocalPlayer.Idled:Connect(function()
        if _G.AntiAFK then
            _Services.VirtualUser:CaptureController()
            _Services.VirtualUser:ClickButton2(Vector2.new())
        end
    end)

    -- Penanganan Input
    _Services.UserInputService.InputBegan:Connect(function(_input, _gp)
        if _gp then return end
        _keysDown[_input.KeyCode] = true
        
        if _input.KeyCode == Enum.KeyCode.Q then 
            if _G.DashEnabled and not _G.StopAll then
                local _char = _Services.LocalPlayer.Character
                if _char and _char:FindFirstChild("HumanoidRootPart") and _char:FindFirstChild("Humanoid") then
                    local _hrp = _char.HumanoidRootPart
                    local _moveDir = _char.Humanoid.MoveDirection
                    if _moveDir.Magnitude == 0 then _moveDir = _hrp.CFrame.LookVector end
                    local _bv = Instance.new("BodyVelocity")
                    _bv.Name = "DashVelocity"
                    _bv.Velocity = _moveDir * _G.DashSpeed
                    _bv.MaxForce = Vector3.new(1e5, 0, 1e5)
                    _bv.P = 5000
                    _bv.Parent = _hrp
                    _Services.Debris:AddItem(_bv, 0.25)
                end
            end
        end
        
        if _input.KeyCode == Enum.KeyCode.LeftShift then
            _G.BoostEnabled = not _G.BoostEnabled
        end
        
        if _input.KeyCode == Enum.KeyCode.Space and _G.FlyEnabled and not _G.StopAll then
            if (tick() - _lastSpacePress) < 0.3 then
                _G.IsFlying = not _G.IsFlying
                _currentFlyVelocity = Vector3.new(0, 0, 0)
                if not _G.IsFlying and _Services.LocalPlayer.Character and _Services.LocalPlayer.Character:FindFirstChild("Humanoid") then
                    _Services.LocalPlayer.Character.Humanoid.PlatformStand = false
                end
            end
            _lastSpacePress = tick()
        end
    end)
    
    _Services.UserInputService.InputEnded:Connect(function(_input)
        _keysDown[_input.KeyCode] = nil
    end)

    -- Loop Utama RenderStepped
    _Services.RunService.RenderStepped:Connect(function()
        -- ESP
        if _G.ESPEnabled then
            for _, _player in pairs(_Services.Players:GetPlayers()) do
                if _player ~= _Services.LocalPlayer and _player.Character and _player.Character:FindFirstChild("Head") then
                    local _head = _player.Character.Head
                    local _espBox = _ESPHolder:FindFirstChild(_player.Name)
                    if not _espBox then
                        _espBox = Instance.new("BillboardGui", _ESPHolder)
                        _espBox.Name = _player.Name
                        _espBox.Size = UDim2.new(0, 100, 0, 50)
                        _espBox.StudsOffset = Vector3.new(0, 2, 0)
                        _espBox.AlwaysOnTop = true
                        local _nl = Instance.new("TextLabel", _espBox)
                        _nl.Name = "NameLabel"
                        _nl.Size = UDim2.new(1,0,1,0)
                        _nl.BackgroundTransparency = 1
                        _nl.TextColor3 = Color3.white
                        _nl.TextStrokeTransparency = 0
                        _nl.TextSize = 14
                        _nl.Font = Enum.Font.SourceSansBold
                        local _dl = Instance.new("TextLabel", _espBox)
                        _dl.Name = "DistLabel"
                        _dl.Size = UDim2.new(1,0,0.5,0)
                        _dl.Position = UDim2.new(0,0,0.8,0)
                        _dl.BackgroundTransparency = 1
                        _dl.TextColor3 = Color3.new(0.8,0.8,0.8)
                        _dl.TextStrokeTransparency = 0
                        _dl.TextSize = 12
                        _dl.Font = Enum.Font.SourceSans
                    end
                    if _espBox.Adornee ~= _head then _espBox.Adornee = _head end
                    local _myRoot = _Services.LocalPlayer.Character and _Services.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local _dist = _myRoot and (_myRoot.Position - _head.Position).Magnitude or 0
                    _espBox.NameLabel.Text = _player.DisplayName .. " (@" .. _player.Name .. ")"
                    _espBox.DistLabel.Text = math.floor(_dist) .. " m"
                else
                    if _ESPHolder:FindFirstChild(_player.Name) then _ESPHolder[_player.Name]:Destroy() end
                end
            end
        elseif #_ESPHolder:GetChildren() > 0 then
            _ESPHolder:ClearAllChildren()
        end

        if _G.StopAll then return end
        
        local _char = _Services.LocalPlayer.Character
        if not _char then return end
        
        local _hrp, _hum = _char:FindFirstChild("HumanoidRootPart"), _char:FindFirstChild("Humanoid")
        
        -- Noclip
        if _G.Noclip then
            for _, _v in pairs(_char:GetDescendants()) do
                if _v:IsA("BasePart") then
                    _v.CanCollide = false
                end
            end
        end
        
        -- Fisika Terbang
        if _G.IsFlying and _hrp and _hum then
            _hum.PlatformStand = true
            _hum.AutoRotate = false
            local _bv = _hrp:FindFirstChild(_STR[32]) or Instance.new("BodyVelocity", _hrp)
            _bv.Name = _STR[32]
            _bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            local _bg = _hrp:FindFirstChild(_STR[33]) or Instance.new("BodyGyro", _hrp)
            _bg.Name = _STR[33]
            _bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            local _moveDir = _hum.MoveDirection
            local _cam = workspace.CurrentCamera
            if _moveDir.Magnitude > 0 then
                local _lookY = _cam.CFrame.LookVector.Y
                _moveDir = Vector3.new(_moveDir.X, _moveDir.Y + (_lookY * 2), _moveDir.Z).Unit
            end
            if _keysDown[Enum.KeyCode.Space] or _G.MobileFlyUp then
                _moveDir = _moveDir + Vector3.new(0, 1, 0)
            end
            local _speed = _G.FlySpeed * (_G.BoostEnabled and 2.5 or 1.0)
            if _moveDir.Magnitude > 0 then
                _currentFlyVelocity = _currentFlyVelocity:Lerp(_moveDir.Unit * _speed, 0.2)
                _bg.CFrame = _bg.CFrame:Lerp(CFrame.lookAt(_hrp.Position, _hrp.Position + _currentFlyVelocity) * CFrame.Angles(math.rad(-90), 0, 0), 0.2)
            else
                _currentFlyVelocity = _G.FlyInertia and _currentFlyVelocity:Lerp(Vector3.zero, 0.05) or Vector3.zero
                local _forward = _cam.CFrame.LookVector
                _bg.CFrame = _bg.CFrame:Lerp(CFrame.lookAt(_hrp.Position, _hrp.Position + Vector3.new(_forward.X, 0, _forward.Z)), 0.1)
            end
            _bv.Velocity = _currentFlyVelocity
        else
            if _hrp and _hrp:FindFirstChild(_STR[32]) then _hrp[_STR[32]]:Destroy() end
            if _hrp and _hrp:FindFirstChild(_STR[33]) then _hrp[_STR[33]]:Destroy() end
            if _hum then _hum.PlatformStand = false; _hum.AutoRotate = true end
        end
        
        -- Kunci Posisi untuk Auto Fish
        if _G.AutoFish and _G.LockPosition and _G.currentSpot and not _G.IsFlying and _hrp then
            _hrp.CFrame = _G.currentSpot
            _hrp.Velocity = Vector3.zero
        end
        
        -- WalkSpeed & JumpPower
        if _hum and not _G.IsFlying then
            if _G.WalkSpeedEnabled then _hum.WalkSpeed = _G.WalkSpeed end
            if _G.JumpPowerEnabled then _hum.UseJumpPower = true; _hum.JumpPower = _G.JumpPower end
        end
        
        -- Frozen Bar
        if _G.AutoFish and _G.FrozenBar then
            local _bar = _Services.LocalPlayer.PlayerGui:FindFirstChild(_STR[3]) and _Services.LocalPlayer.PlayerGui[_STR[3]]:FindFirstChild("bar")
            if _bar and _bar:FindFirstChild("playerbar") then
                _bar.playerbar.Size = UDim2.new(1,0,1,0)
                _bar.playerbar.Position = UDim2.new(0,0,0,0)
                _bar.playerbar.AnchorPoint = Vector2.new(0,0)
                _bar.playerbar.BackgroundColor3 = Color3.new(1,1,1)
            end
        end
    end)
end

-- ============================================
-- LOG UI MODULE - Sistem Log
-- ============================================

local _LogUI = {}

-- Elemen UI
local _LogGui, _LogFrame, _LogScroll, _UIList

function _LogUI.Create()
    -- [[ 📜 PENYIAPAN SISTEM LOG ]] --
    _LogGui = Instance.new("ScreenGui")
    _LogGui.Name = "FischLogGui"
    _LogGui.Parent = game:GetService("CoreGui")
    _LogGui.Enabled = false
    _LogGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    _LogFrame = Instance.new("Frame")
    _LogFrame.Name = "MainFrame"
    _LogFrame.Parent = _LogGui
    _LogFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    _LogFrame.BorderColor3 = Color3.fromRGB(60, 60, 60)
    _LogFrame.BorderSizePixel = 1
    _LogFrame.Position = UDim2.new(0.75, 0, 0.65, 0)
    _LogFrame.Size = UDim2.new(0, 300, 0, 200)
    _LogFrame.Active = true
    _LogFrame.Draggable = true

    -- Judul (Title Bar)
    local _LogTitle = Instance.new("TextLabel")
    _LogTitle.Parent = _LogFrame
    _LogTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    _LogTitle.Size = UDim2.new(1, 0, 0, 25)
    _LogTitle.Font = Enum.Font.GothamBold
    _LogTitle.Text = "  📜 Log Script"
    _LogTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    _LogTitle.TextSize = 14
    _LogTitle.TextXAlignment = Enum.TextXAlignment.Left

    -- Area tampilan pesan (Scrolling Frame)
    _LogScroll = Instance.new("ScrollingFrame")
    _LogScroll.Parent = _LogFrame
    _LogScroll.BackgroundTransparency = 1
    _LogScroll.Position = UDim2.new(0, 5, 0, 30)
    _LogScroll.Size = UDim2.new(1, -10, 1, -35)
    _LogScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    _LogScroll.ScrollBarThickness = 4

    _UIList = Instance.new("UIListLayout")
    _UIList.Parent = _LogScroll
    _UIList.SortOrder = Enum.SortOrder.LayoutOrder
    _UIList.Padding = UDim.new(0, 4)
    
    -- Log Percobaan
    _LogUI.AddLog("Sistem diinisialisasi...", Color3.fromRGB(100, 255, 100))
end

function _LogUI.AddLog(_text, _color)
    if not _LogScroll then return end
    
    local _timestamp = os.date("%H:%M:%S")
    local _label = Instance.new("TextLabel")
    _label.Parent = _LogScroll
    _label.BackgroundTransparency = 1
    _label.Size = UDim2.new(1, 0, 0, 18)
    _label.Font = Enum.Font.SourceSans
    _label.Text = string.format("[%s] %s", _timestamp, _text)
    _label.TextColor3 = _color or Color3.fromRGB(200, 200, 200)
    _label.TextSize = 14
    _label.TextXAlignment = Enum.TextXAlignment.Left
    _label.TextWrapped = false
    
    -- Auto Scroll
    _LogScroll.CanvasSize = UDim2.new(0, 0, 0, _UIList.AbsoluteContentSize.Y)
    _LogScroll.CanvasPosition = Vector2.new(0, _UIList.AbsoluteContentSize.Y)
    
    -- Hapus log lama jika terlalu banyak
    if #_LogScroll:GetChildren() > 100 then
        _LogScroll:GetChildren()[2]:Destroy()
    end
end

-- Tetapkan ke _G sesuai aslinya
_G.AddLog = _LogUI.AddLog

function _LogUI.SetVisible(_enabled)
    if _LogGui then
        _LogGui.Enabled = _enabled
    end
end

function _LogUI.ClearLogs()
    if not _LogScroll then return end
    for _, _child in pairs(_LogScroll:GetChildren()) do
        if _child:IsA("TextLabel") then _child:Destroy() end
    end
    _LogScroll.CanvasSize = UDim2.new(0,0,0,0)
    _LogUI.AddLog("Log dihapus.", Color3.fromRGB(255, 255, 0))
end

-- ============================================
-- INFO UI MODULE - Panel Info Server
-- ============================================

local _InfoUI = {}

-- Elemen UI (Global dalam modul)
local _InfoGui, _InfoFrame, _RealTimeLabel, _GameTimeLabel, _UptimeLabel

function _InfoUI.Create()
    -- [[ ℹ️ PENYIAPAN PANEL INFO SERVER ]] --
    _InfoGui = Instance.new("ScreenGui")
    _InfoGui.Name = "FischInfoGui"
    _InfoGui.Parent = game:GetService("CoreGui")
    _InfoGui.Enabled = true
    _InfoGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Kerangka Utama (Main Frame)
    _InfoFrame = Instance.new("Frame")
    _InfoFrame.Name = "MainFrame"
    _InfoFrame.Parent = _InfoGui
    _InfoFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    _InfoFrame.BorderColor3 = Color3.fromRGB(60, 60, 60)
    _InfoFrame.BorderSizePixel = 1
    _InfoFrame.Position = UDim2.new(0.02, 0, 0.25, 0)
    _InfoFrame.Size = UDim2.new(0, 250, 0, 120)
    _InfoFrame.Active = true
    _InfoFrame.Draggable = true

    -- Judul (Title Bar)
    local _InfoTitle = Instance.new("TextLabel")
    _InfoTitle.Parent = _InfoFrame
    _InfoTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    _InfoTitle.Size = UDim2.new(1, 0, 0, 25)
    _InfoTitle.Font = Enum.Font.GothamBold
    _InfoTitle.Text = "  📊 Info Server"
    _InfoTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    _InfoTitle.TextSize = 14
    _InfoTitle.TextXAlignment = Enum.TextXAlignment.Left

    -- Tombol lipat (Minimize Button)
    local _MinimizeBtn = Instance.new("TextButton")
    _MinimizeBtn.Parent = _InfoFrame
    _MinimizeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    _MinimizeBtn.BackgroundTransparency = 1
    _MinimizeBtn.Position = UDim2.new(1, -30, 0, 0)
    _MinimizeBtn.Size = UDim2.new(0, 30, 0, 25)
    _MinimizeBtn.Font = Enum.Font.GothamBold
    _MinimizeBtn.Text = "-"
    _MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    _MinimizeBtn.TextSize = 18

    -- Area Konten (Content)
    local _ContentFrame = Instance.new("Frame")
    _ContentFrame.Parent = _InfoFrame
    _ContentFrame.BackgroundTransparency = 1
    _ContentFrame.Position = UDim2.new(0, 10, 0, 30)
    _ContentFrame.Size = UDim2.new(1, -20, 1, -35)

    -- Buat TextLabel untuk menampilkan berbagai nilai
    local function _CreateInfoLabel(_order, _defaultText)
        local _lbl = Instance.new("TextLabel")
        _lbl.Parent = _ContentFrame
        _lbl.BackgroundTransparency = 1
        _lbl.Position = UDim2.new(0, 0, 0, (_order - 1) * 25)
        _lbl.Size = UDim2.new(1, 0, 0, 25)
        _lbl.Font = Enum.Font.SourceSansSemibold
        _lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
        _lbl.TextSize = 16
        _lbl.TextXAlignment = Enum.TextXAlignment.Left
        _lbl.Text = _defaultText
        return _lbl
    end

    _RealTimeLabel = _CreateInfoLabel(1, "🕒 Waktu Nyata: ...")
    _GameTimeLabel = _CreateInfoLabel(2, "☀️ Waktu Game: ...")
    _UptimeLabel = _CreateInfoLabel(3, "⏳ Uptime: ...")

    -- [[ Sistem Lipat (Minimizing Logic) ]] --
    local _isMinimized = false
    _MinimizeBtn.MouseButton1Click:Connect(function()
        _isMinimized = not _isMinimized
        if _isMinimized then
            _InfoFrame:TweenSize(UDim2.new(0, 250, 0, 25), "Out", "Quad", 0.3, true)
            _ContentFrame.Visible = false
            _MinimizeBtn.Text = "+"
        else
            _InfoFrame:TweenSize(UDim2.new(0, 250, 0, 120), "Out", "Quad", 0.3, true)
            _ContentFrame.Visible = true
            _MinimizeBtn.Text = "-"
        end
    end)
end

function _InfoUI.SetVisible(_enabled)
    if _InfoGui then
        _InfoGui.Enabled = _enabled
    end
end

function _InfoUI.Update(_formatTimeFunc, _formatGameTimeFunc)
    if not _InfoGui or not _InfoGui.Enabled then return end
    
    local _statusTime = os.date("%H:%M:%S")
    local _clockTime = game:GetService("Lighting").ClockTime
    local _timeState = (_clockTime >= 6 and _clockTime < 18) and "Siang ☀️" or "Malam 🌙"
    local _gameTimeStr = _formatGameTimeFunc(_clockTime) .. " " .. _timeState
    local _serverTime = workspace.DistributedGameTime
    local _uptimeStr = _formatTimeFunc(_serverTime)
    
    _RealTimeLabel.Text = "🕒 Waktu Nyata:  " .. _statusTime
    _GameTimeLabel.Text = "🗓️ Waktu Game: " .. _gameTimeStr
    _UptimeLabel.Text = "⏳ Waktu Online:    " .. _uptimeStr
    
    if _timeState == "Siang ☀️" then
        _GameTimeLabel.TextColor3 = Color3.fromRGB(255, 220, 100)
    else
        _GameTimeLabel.TextColor3 = Color3.fromRGB(100, 150, 255)
    end
end

-- ============================================
-- FLY UI MODULE - Panel Kontrol Terbang
-- ============================================

local _FlyUI = {}

-- Elemen UI
local _FlyGui, _FlyFrame, _ToggleFlyBtn, _BoostFlyBtn

function _FlyUI.Create()
    -- [[ ✈️ PANEL KONTROL TERBANG (MOBILE) ]] --
    _FlyGui = Instance.new("ScreenGui")
    _FlyGui.Name = "FischFlyGui"
    _FlyGui.Parent = game:GetService("CoreGui")
    _FlyGui.Enabled = false
    _FlyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Kerangka Utama
    _FlyFrame = Instance.new("Frame")
    _FlyFrame.Name = "FlyMainFrame"
    _FlyFrame.Parent = _FlyGui
    _FlyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    _FlyFrame.BorderColor3 = Color3.fromRGB(60, 60, 60)
    _FlyFrame.BorderSizePixel = 1
    _FlyFrame.Position = UDim2.new(0.8, 0, 0.25, 0)
    _FlyFrame.Size = UDim2.new(0, 150, 0, 180)
    _FlyFrame.Active = true
    _FlyFrame.Draggable = true

    -- Judul
    local _FlyTitle = Instance.new("TextLabel")
    _FlyTitle.Parent = _FlyFrame
    _FlyTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    _FlyTitle.Size = UDim2.new(1, 0, 0, 25)
    _FlyTitle.Font = Enum.Font.GothamBold
    _FlyTitle.Text = "  ✈️ Kontrol Terbang"
    _FlyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    _FlyTitle.TextSize = 14
    _FlyTitle.TextXAlignment = Enum.TextXAlignment.Left

    -- Tombol lipat
    local _FlyMinimizeBtn = Instance.new("TextButton")
    _FlyMinimizeBtn.Parent = _FlyFrame
    _FlyMinimizeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    _FlyMinimizeBtn.BackgroundTransparency = 1
    _FlyMinimizeBtn.Position = UDim2.new(1, -30, 0, 0)
    _FlyMinimizeBtn.Size = UDim2.new(0, 30, 0, 25)
    _FlyMinimizeBtn.Font = Enum.Font.GothamBold
    _FlyMinimizeBtn.Text = "-"
    _FlyMinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    _FlyMinimizeBtn.TextSize = 18

    -- Area konten
    local _FlyContent = Instance.new("Frame")
    _FlyContent.Parent = _FlyFrame
    _FlyContent.BackgroundTransparency = 1
    _FlyContent.Position = UDim2.new(0, 10, 0, 35)
    _FlyContent.Size = UDim2.new(1, -20, 1, -45)

    -- 1. Tombol On/Off (Toggle Utama)
    _ToggleFlyBtn = Instance.new("TextButton")
    _ToggleFlyBtn.Name = "ToggleFlyBtn"
    _ToggleFlyBtn.Parent = _FlyContent
    _ToggleFlyBtn.Size = UDim2.new(1, 0, 0, 50)
    _ToggleFlyBtn.Position = UDim2.new(0, 0, 0, 0)
    _ToggleFlyBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    _ToggleFlyBtn.Font = Enum.Font.GothamBold
    _ToggleFlyBtn.Text = "MATI"
    _ToggleFlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    _ToggleFlyBtn.TextSize = 24
    Instance.new("UICorner", _ToggleFlyBtn).CornerRadius = UDim.new(0, 8)

    -- 2. Tombol Speed Boost
    _BoostFlyBtn = Instance.new("TextButton")
    _BoostFlyBtn.Name = "BoostFlyBtn"
    _BoostFlyBtn.Parent = _FlyContent
    _BoostFlyBtn.Size = UDim2.new(1, 0, 0, 40)
    _BoostFlyBtn.Position = UDim2.new(0, 0, 0, 60)
    _BoostFlyBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    _BoostFlyBtn.Font = Enum.Font.GothamBold
    _BoostFlyBtn.Text = "⚡ Kecepatan: Normal"
    _BoostFlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    _BoostFlyBtn.TextSize = 16
    Instance.new("UICorner", _BoostFlyBtn).CornerRadius = UDim.new(0, 8)

    -- Logika: Tombol On/Off
    _ToggleFlyBtn.MouseButton1Click:Connect(function()
        _G.IsFlying = not _G.IsFlying
        
        if _G.IsFlying then
            _ToggleFlyBtn.Text = "HIDUP"
            _ToggleFlyBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        else
            _ToggleFlyBtn.Text = "MATI"
            _ToggleFlyBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            
            local _char = _Services.LocalPlayer.Character
            if _char and _char:FindFirstChild("Humanoid") then 
                _char.Humanoid.PlatformStand = false 
            end
        end
    end)

    -- Logika: Tombol Boost
    _BoostFlyBtn.MouseButton1Click:Connect(function()
        _G.BoostEnabled = not _G.BoostEnabled
        
        if _G.BoostEnabled then
            _BoostFlyBtn.Text = "⚡ Kecepatan: CEPAT!"
            _BoostFlyBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
            _BoostFlyBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        else
            _BoostFlyBtn.Text = "⚡ Kecepatan: Normal"
            _BoostFlyBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            _BoostFlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end)

    -- Logika: Perkecil/Perbesar jendela
    local _isFlyMinimized = false
    _FlyMinimizeBtn.MouseButton1Click:Connect(function()
        _isFlyMinimized = not _isFlyMinimized
        if _isFlyMinimized then
            _FlyFrame:TweenSize(UDim2.new(0, 150, 0, 25), "Out", "Quad", 0.3, true)
            _FlyContent.Visible = false
            _FlyMinimizeBtn.Text = "+"
        else
            _FlyFrame:TweenSize(UDim2.new(0, 150, 0, 180), "Out", "Quad", 0.3, true)
            _FlyContent.Visible = true
            _FlyMinimizeBtn.Text = "-"
        end
    end)

    -- Loop Auto Sync
    task.spawn(function()
        while true do
            task.wait(0.2)
            if _FlyGui.Enabled then
                -- Sync tombol terbang
                if _G.IsFlying and _ToggleFlyBtn.Text ~= "HIDUP" then
                    _ToggleFlyBtn.Text = "HIDUP"
                    _ToggleFlyBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
                elseif not _G.IsFlying and _ToggleFlyBtn.Text ~= "MATI" then
                    _ToggleFlyBtn.Text = "MATI"
                    _ToggleFlyBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
                end

                -- Sync tombol Boost
                if _G.BoostEnabled and _BoostFlyBtn.Text ~= "⚡ Kecepatan: CEPAT!" then
                    _BoostFlyBtn.Text = "⚡ Kecepatan: CEPAT!"
                    _BoostFlyBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
                    _BoostFlyBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                elseif not _G.BoostEnabled and _BoostFlyBtn.Text ~= "⚡ Kecepatan: Normal" then
                    _BoostFlyBtn.Text = "⚡ Kecepatan: Normal"
                    _BoostFlyBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                    _BoostFlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
            end
        end
    end)
end

function _FlyUI.SetVisible(_enabled)
    if _FlyGui then
        _FlyGui.Enabled = _enabled
    end
end

-- ============================================
-- MAIN UI MODULE - Fluent UI dan Tabs
-- ============================================

local _MainUI = {}

-- Referensi Global
_MainUI.Window = nil
_MainUI.Tabs = nil
_MainUI.Options = nil
_MainUI.Fluent = nil
_MainUI.SaveManager = nil
_MainUI.InterfaceManager = nil

function _MainUI.Create()
    -- Muat Fluent
    local _success, _result = pcall(function()
        return loadstring(game:HttpGet(_STR[35]))()
    end)

    if not _success or not _result then
        warn("[Error Script]: Gagal memuat Fluent UI! Periksa koneksi internet Anda.")
        return nil
    end

    local _Fluent = _result
    _MainUI.Fluent = _Fluent
    
    local _SaveManager = loadstring(game:HttpGet(_STR[36]))()
    local _InterfaceManager = loadstring(game:HttpGet(_STR[37]))()
    _MainUI.SaveManager = _SaveManager
    _MainUI.InterfaceManager = _InterfaceManager

    -- 🖼️ PENYIAPAN UI
    local _Window = _Fluent:CreateWindow({
        Title = _STR[38],
        SubTitle = _STR[39],
        TabWidth = _Services.TabsWidth,
        Size = _Services.WindowSize,
        Acrylic = false,
        Theme = "Amethyst",
        MinimizeKey = Enum.KeyCode.LeftControl
    })
    _MainUI.Window = _Window

    -- Buat Tabs
    local _Tabs = {
        Home = _Window:AddTab({ Title = "Home", Icon = "home" }),
        Main = _Window:AddTab({ Title = "Auto Fish", Icon = "component" }),
        Autos = _Window:AddTab({ Title = "Autos", Icon = "repeat" }),
        Character = _Window:AddTab({ Title = "Character", Icon = "user" }),
        Teleport = _Window:AddTab({ Title = "Teleport", Icon = "map" }),
        Shop = _Window:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
        Visuals = _Window:AddTab({ Title = "Visuals", Icon = "eye" }),
        Settings = _Window:AddTab({ Title = "Settings", Icon = "settings" }),
        ServerInfo = _Window:AddTab({ Title = "Server Info", Icon = "info" })
    }
    _MainUI.Tabs = _Tabs
    _MainUI.Options = _Fluent.Options

    return {
        Fluent = _Fluent,
        Window = _Window,
        Tabs = _Tabs,
        Options = _Fluent.Options,
        SaveManager = _SaveManager,
        InterfaceManager = _InterfaceManager
    }
end

function _MainUI.CreateMobileUI()
    local _CoreGui = _Services.CoreGui
    local _VirtualInputManager = _Services.VirtualInputManager

    if _CoreGui:FindFirstChild("FischMobileUI") then _CoreGui.FischMobileUI:Destroy() end
    
    local _ScreenGui = Instance.new("ScreenGui", _CoreGui)
    _ScreenGui.Name = "FischMobileUI"
    
    local _MenuBtn = Instance.new("ImageButton", _ScreenGui)
    _MenuBtn.Name = "MenuToggle"
    _MenuBtn.BackgroundColor3 = Color3.new(0,0,0)
    _MenuBtn.BackgroundTransparency = 0.5
    _MenuBtn.AnchorPoint = Vector2.new(0.5, 0)
    _MenuBtn.Position = UDim2.new(0.5, -25, 0.05, 0)
    _MenuBtn.Size = UDim2.fromOffset(50, 50)
    _MenuBtn.Size = UDim2.fromOffset(50, 50)
    _MenuBtn.Image = "rbxassetid://100142831144115"
    _MenuBtn.Draggable = true
    Instance.new("UICorner", _MenuBtn).CornerRadius = UDim.new(1,0)
    Instance.new("UIStroke", _MenuBtn).Color = Color3.new(1,1,1)
    
    _MenuBtn.MouseButton1Click:Connect(function()
        _VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
        task.wait(0.05)
        _VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
    end)
end

-- ============================================
-- TAB SETUP MODULE - Pengaturan Tabs dan Elemen UI
-- ============================================

local _TabSetup = {}

function _TabSetup.SetupAllTabs(_UI, _Data, _Utils)
    local _Tabs = _UI.Tabs
    local _Options = _UI.Options
    local _Fluent = _UI.Fluent

    -- 🏠 HOME
    _Tabs.Home:AddToggle("StopAll", {Title = "HENTIKAN SEMUA AKSI", Default = false }):OnChanged(function()
        _G.StopAll = _Options.StopAll.Value
        if _G.StopAll then
            _G.IsFlying = false
            local _char = _Services.LocalPlayer.Character
            if _char and _char:FindFirstChild("Humanoid") then
                 _char.Humanoid.PlatformStand = false; _char.Humanoid.AutoRotate = true 
            end
            if _char and _char:FindFirstChild("HumanoidRootPart") then
                _char.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                for _, _v in pairs({_STR[32], _STR[33]}) do
                     if _char.HumanoidRootPart:FindFirstChild(_v) then _char.HumanoidRootPart[_v]:Destroy() end
                end
            end
        end
    end)

    -- 🎣 MAIN (Auto Fish)
    local _ToggleAutoFish = _Tabs.Main:AddToggle("AutoFish", {Title = "Aktifkan Auto Fish", Default = false })
    _ToggleAutoFish:OnChanged(function()
        _G.AutoFish = _Options.AutoFish.Value
        if _G.AutoFish and _Services.LocalPlayer.Character and _Services.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            _G.currentSpot = _Services.LocalPlayer.Character.HumanoidRootPart.CFrame
        else
            _G.currentSpot = nil
        end
    end)
    _Tabs.Main:AddToggle("AutoShake", {Title = "Auto Shake", Default = true }):OnChanged(function() _G.AutoShake = _Options.AutoShake.Value end)
    _Tabs.Main:AddToggle("LockPosition", {Title = "Kunci Posisi", Default = true }):OnChanged(function() _G.LockPosition = _Options.LockPosition.Value end)

    -- 🤖 AUTOS
    local _Autos = _Tabs.Autos
    _Autos:AddParagraph({ Title = "Jual Item", Content = "Auto jual atau jual di tangan." })

    local _ToggleSellAll = _Autos:AddToggle("AutoSellAll", {Title = "Auto Jual Semua", Default = false })
    _ToggleSellAll:OnChanged(function() _G.AutoSellAll = _Options.AutoSellAll.Value end)
    _Autos:AddSlider("SellAllInterval", {Title = "Interval Jual (detik)", Default = 5, Min = 1, Max = 60, Rounding = 1, Callback = function(_V) _G.SellAllInterval = _V end})

    _Autos:AddButton({Title = "Jual di Tangan", Callback = function()
        local _remote = game:GetService("ReplicatedStorage"):WaitForChild(_STR[6]):WaitForChild(_STR[11])
        if _remote then
            local _success, _res = pcall(function() return _remote:InvokeServer() end)
            if _success then 
                _LogUI.AddLog("💰 Item Terjual", Color3.fromRGB(100, 255, 100)) 
                _Fluent:Notify({Title="Jual Tangan", Content="Sukses! Hasil: " .. tostring(_res), Duration=3}) 
            else 
                warn("Error Jual Tangan:", _res) 
            end
        else
            _Fluent:Notify({Title="Error", Content="Remote Jual Tidak Ditemukan!", Duration=3})
        end
    end})

    _Autos:AddParagraph({ Title = "---", Content = "" })

    -- Smart Auto Totem
    _Autos:AddParagraph({ Title = "Smart Auto Totem", Content = "Sistem deteksi waktu Server secara Real-time\nAkan berjalan saat pergantian waktu (pagi/malam)" })

    _G.AutoTotem = false
    _G.DayTotemSelect = "Sundial Totem"
    _G.NightTotemSelect = "Aurora Totem"

    _Autos:AddToggle("EnableAutoTotem", {Title = "Aktifkan Smart Auto Totem", Default = false }):OnChanged(function(_Value) _G.AutoTotem = _Value end)

    _Autos:AddDropdown("DayTotemDrop", {
        Title = "☀️ Totem saat masuk pagi (06:30)", 
        Values = _Data.TotemList, 
        Multi = false, 
        Default = "Sundial Totem",
    }):OnChanged(function(_Value) _G.DayTotemSelect = _Value end)

    _Autos:AddDropdown("NightTotemDrop", {
        Title = "🌙 Totem saat masuk malam (18:00)", 
        Values = _Data.TotemList, 
        Multi = false, 
        Default = "Aurora Totem",
    }):OnChanged(function(_Value) _G.NightTotemSelect = _Value end)

    -- Auto Potion
    _Autos:AddParagraph({ Title = "Auto Potion (Timer)", Content = "Sistem minum ramuan dengan timer loop (satuan: menit)" })

    _G.AutoPotion = false
    _G.SelectedPotion = _Data.PotionList[1]
    _G.PotionDelayMinutes = 10
    _G.PotionRepeatCount = 999
    _G.PotionTimer = 0

    _Autos:AddToggle("EnableAutoPotion", {Title = "Aktifkan Auto Potion", Default = false }):OnChanged(function(_Value)
        _G.AutoPotion = _Value
        if _Value then _G.PotionTimer = 0 end
    end)

    _Autos:AddDropdown("PotionSelect", {
        Title = "Pilih Potion",
        Values = _Data.PotionList,
        Multi = false,
        Default = 1,
    }):OnChanged(function(_Value) _G.SelectedPotion = _Value end)

    _Autos:AddInput("PotionTimeInput", {
        Title = "Durasi buff (menit)",
        Default = "16",
        Numeric = true,
        Callback = function(_Value) _G.PotionDelayMinutes = tonumber(_Value) or 16 end
    })

    _Autos:AddInput("PotionCountInput", {
        Title = "Jumlah pengulangan",
        Default = "999",
        Numeric = true,
        Callback = function(_Value) _G.PotionRepeatCount = tonumber(_Value) or 999 end
    })

    -- 🏃 CHARACTER
    _Tabs.Character:AddToggle("ESPEnabled", {Title = "Aktifkan Player ESP", Default = false }):OnChanged(function() 
        _G.ESPEnabled = _Options.ESPEnabled.Value 
    end)
    _Tabs.Character:AddToggle("WalkSpeedEnabled", {Title = "Aktifkan Walk Speed", Default = false }):OnChanged(function() _G.WalkSpeedEnabled = _Options.WalkSpeedEnabled.Value end)
    _Tabs.Character:AddInput("WalkSpeedVal", {Title = "Nilai Kecepatan", Default = "16", Numeric = true, Callback = function(_V) _G.WalkSpeed = tonumber(_V) or 16 end})
    _Tabs.Character:AddToggle("JumpPowerEnabled", {Title = "Aktifkan Jump Power", Default = false }):OnChanged(function() _G.JumpPowerEnabled = _Options.JumpPowerEnabled.Value end)
    _Tabs.Character:AddInput("JumpPowerVal", {Title = "Nilai Lompat", Default = "50", Numeric = true, Callback = function(_V) _G.JumpPower = tonumber(_V) or 50 end})
    _Tabs.Character:AddToggle("Noclip", {Title = "Noclip", Default = false }):OnChanged(function() _G.Noclip = _Options.Noclip.Value end)
    _Tabs.Character:AddToggle("DashEnabled", {Title = "Aktifkan Dash", Default = true }):OnChanged(function() _G.DashEnabled = _Options.DashEnabled.Value end)
    _Tabs.Character:AddSlider("DashSpeed", {Title = "Kecepatan Dash", Default = 100, Min = 50, Max = 300, Rounding = 0, Callback = function(_V) _G.DashSpeed = _V end})
    _Tabs.Character:AddToggle("FlyEnabled", {Title = "Aktifkan Fly", Default = true }):OnChanged(function() _G.FlyEnabled = _Options.FlyEnabled.Value end)
    _Tabs.Character:AddToggle("FlyInertia", {Title = "Inersia Terbang", Default = true }):OnChanged(function() _G.FlyInertia = _Options.FlyInertia.Value end)
    _Tabs.Character:AddSlider("FlySpeed", {Title = "Kecepatan Terbang", Default = 75, Min = 10, Max = 300, Rounding = 0, Callback = function(_V) _G.FlySpeed = _V end})
    
    _Tabs.Character:AddParagraph({ Title = "Dukungan Mobile", Content = "Alat untuk perangkat mobile" })

    _Tabs.Character:AddToggle("ShowFlyPanel", {Title = "Tampilkan Panel Fly (Mobile)", Default = false }):OnChanged(function(_Value)
        _FlyUI.SetVisible(_Value)
    end)

    -- 🗺️ TELEPORT
    local _DropdownManager, _DropdownWarp
    local function _RefreshAllDropdowns()
        local _saved = _Utils.LoadCustomLocations()
        local _managerList, _warpList = {}, {}
        local _mQuery, _wQuery = _G.ManagerSearch:lower(), _G.SearchQuery:lower()
        for _name, _ in pairs(_saved) do
            if _mQuery == "" or _name:lower():find(_mQuery) then table.insert(_managerList, _name) end
            if _wQuery == "" or _name:lower():find(_wQuery) then table.insert(_warpList, _name) end
        end
        for _name, _ in pairs(_Data.DefaultLocations) do
            if _wQuery == "" or _name:lower():find(_wQuery) then table.insert(_warpList, _name) end
        end
        table.sort(_managerList); table.sort(_warpList)
        if _DropdownManager then _DropdownManager:SetValues(_managerList) end
        if _DropdownWarp then _DropdownWarp:SetValues(_warpList) end
    end

    _Tabs.Teleport:AddButton({Title = "🔄 Refresh Daftar", Callback = function() _RefreshAllDropdowns(); _Fluent:Notify({Title="Teleport", Content="Diperbarui!", Duration=1}) end})
    _Tabs.Teleport:AddInput("ManagerSearch", {Title = "🔍 Cari Tersimpan", Default = "", Callback = function(_V) _G.ManagerSearch = _V; _RefreshAllDropdowns() end})
    
    _DropdownManager = _Tabs.Teleport:AddDropdown("ManagerSelect", {Title = "📂 Pilih Tersimpan", Values = {}, Multi = false, Default = nil})
    _DropdownManager:OnChanged(function(_Value)
        local _saved = _Utils.LoadCustomLocations()
        if _Value and _saved[_Value] then
            _G.CustomName = _Value
            _G.CustomX, _G.CustomY, _G.CustomZ = _saved[_Value].x, _saved[_Value].y, _saved[_Value].z
            if _Options.LocName then _Options.LocName:SetValue(_Value) end
            if _Options.InputX then _Options.InputX:SetValue(tostring(_G.CustomX)) end
            if _Options.InputY then _Options.InputY:SetValue(tostring(_G.CustomY)) end
            if _Options.InputZ then _Options.InputZ:SetValue(tostring(_G.CustomZ)) end
        end
    end)
    
    _Tabs.Teleport:AddInput("LocName", {Title = "Nama", Default = "", Callback = function(_V) _G.CustomName = _V end})
    _Tabs.Teleport:AddInput("InputX", {Title = "X", Default = "0", Numeric = true, Callback = function(_V) _G.CustomX = tonumber(_V) or 0 end})
    _Tabs.Teleport:AddInput("InputY", {Title = "Y", Default = "135", Numeric = true, Callback = function(_V) _G.CustomY = tonumber(_V) or 135 end})
    _Tabs.Teleport:AddInput("InputZ", {Title = "Z", Default = "0", Numeric = true, Callback = function(_V) _G.CustomZ = tonumber(_V) or 0 end})
    
    _Tabs.Teleport:AddButton({Title = "📍 Ambil Posisi", Callback = function()
        local _char = _Services.LocalPlayer.Character
        if _char and _char:FindFirstChild("HumanoidRootPart") then
            local _pos = _char.HumanoidRootPart.Position
            _G.CustomX, _G.CustomY, _G.CustomZ = math.floor(_pos.X), math.floor(_pos.Y), math.floor(_pos.Z)
            if _Options.InputX then _Options.InputX:SetValue(tostring(_G.CustomX)) end
            if _Options.InputY then _Options.InputY:SetValue(tostring(_G.CustomY)) end
            if _Options.InputZ then _Options.InputZ:SetValue(tostring(_G.CustomZ)) end
        end
    end})
    
    _Tabs.Teleport:AddButton({Title = "💾 Simpan", Callback = function()
        if _G.CustomName == "" then return end
        local _saved = _Utils.LoadCustomLocations()
        _saved[_G.CustomName] = {x = tonumber(_G.CustomX), y = tonumber(_G.CustomY), z = tonumber(_G.CustomZ)}
        _Utils.SaveCustomLocations(_saved); _RefreshAllDropdowns()
    end})
    
    _Tabs.Teleport:AddButton({Title = "🚀 Warp ke XYZ", Callback = function()
        if _G.StopAll then return end
        local _char = _Services.LocalPlayer.Character
        if _char and _char:FindFirstChild("HumanoidRootPart") then
            local _tp = CFrame.new(tonumber(_G.CustomX) or 0, tonumber(_G.CustomY) or 135, tonumber(_G.CustomZ) or 0)
            _char.HumanoidRootPart.CFrame = _tp
        end
    end})
    
    _Tabs.Teleport:AddInput("SearchLoc", {Title = "🔍 Cari Warp", Default = "", Callback = function(_V) _G.SearchQuery = _V; _RefreshAllDropdowns() end})
    
    _DropdownWarp = _Tabs.Teleport:AddDropdown("IslandWarp", {Title = "📂 Pilih Tujuan", Values = {}, Multi = false, Default = nil})
    _DropdownWarp:OnChanged(function(_Value)
        if _G.StopAll or not _Value then return end
        local _target, _saved = _Data.DefaultLocations[_Value], _Utils.LoadCustomLocations()
        if not _target and _saved[_Value] then _target = _saved[_Value] end
        if _target then
            local _char = _Services.LocalPlayer.Character
            if _char and _char:FindFirstChild("HumanoidRootPart") then
                local _tp = CFrame.new(_target.x, _target.y, _target.z)
                _char.HumanoidRootPart.CFrame = _tp
            end
        end
    end)

    -- Teleport Pemain
    _Tabs.Teleport:AddParagraph({ Title = "-----------------", Content = "" })
    _Tabs.Teleport:AddParagraph({ Title = "Teleport Pemain", Content = "Warp ke pemain lain di server" })

    local _PlayerDropdown = _Tabs.Teleport:AddDropdown("PlayerSelect", {
        Title = "Pilih Pemain (Select Player)",
        Values = {},
        Multi = false,
        Default = nil,
    })

    local function _RefreshPlayerList()
        local _pList = {}
        for _, _p in pairs(_Services.Players:GetPlayers()) do
            if _p ~= _Services.LocalPlayer then
                table.insert(_pList, _p.Name)
            end
        end
        table.sort(_pList)
        _PlayerDropdown:SetValues(_pList)
    end

    _Tabs.Teleport:AddButton({
        Title = "🔄 Refresh Daftar Pemain",
        Description = "Tekan untuk refresh daftar nama",
        Callback = function()
            _RefreshPlayerList()
            _Fluent:Notify({Title = "Sistem", Content = "Daftar Pemain Diperbarui!", Duration = 1})
        end
    })

    _Tabs.Teleport:AddButton({
        Title = "🚀 Warp ke Pemain",
        Description = "Warp ke pemain yang dipilih",
        Callback = function()
            local _targetName = _Options.PlayerSelect.Value
            if not _targetName then return end
            
            local _targetPlayer = _Services.Players:FindFirstChild(_targetName)
            if _targetPlayer and _targetPlayer.Character and _targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local _char = _Services.LocalPlayer.Character
                if _char and _char:FindFirstChild("HumanoidRootPart") then
                    _char.HumanoidRootPart.CFrame = _targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 0)
                    _Fluent:Notify({Title = "Teleport", Content = "Warp ke: " .. _targetName, Duration = 2})
                end
            else
                _Fluent:Notify({Title = "Error", Content = "Tidak dapat menemukan pemain, atau dia sedang mati", Duration = 3})
            end
        end
    })

    task.delay(1, function() _RefreshPlayerList() end)

    -- 🛒 SHOP
    local _RodNames = {}
    for _, _v in ipairs(_Data.RodList) do table.insert(_RodNames, _v.Name) end
    _Tabs.Shop:AddDropdown("SelectedRod", {Title = "Pilih Rod", Values = _RodNames, Multi = false, Default = 1})
    _Tabs.Shop:AddButton({Title = "Beli Rod", Callback = function() 
        local _remote = _Utils.GetPurchaseRemote()
        if _remote then
            _remote:FireServer(_Options.SelectedRod.Value, "Rod", nil, 1) 
        else
            _Fluent:Notify({Title = "Error", Content = "Remote pembelian tidak ditemukan", Duration = 3})
        end
    end})

    _Tabs.Shop:AddDropdown("SelectedTotem", {Title = "Pilih Totem", Values = _Data.TotemList, Multi = false, Default = 1})
    _Tabs.Shop:AddInput("TotemAmount", {Title = "Jumlah", Default = "1", Numeric = true})
    _Tabs.Shop:AddButton({Title = "Beli Totem", Callback = function()
        local _selectedName = _Options.SelectedTotem.Value
        local _amount = math.clamp(tonumber(_Options.TotemAmount.Value) or 1, 1, 50)
        
        local _pricePerItem = 0
        for _, _v in ipairs(_Data.TotemData) do
            if _v.Name == _selectedName then _pricePerItem = _v.Price; break end
        end
        
        local _totalPrice = _pricePerItem * _amount
        local _currentMoney = _Utils.getMoney()
        
        if _currentMoney >= _totalPrice then
            local _remote = _Utils.GetPurchaseRemote()
            if _remote then
                _remote:FireServer(_selectedName, "Item", nil, _amount)
                _Fluent:Notify({Title = "Sukses", Content = "Membeli " .. _amount .. " " .. _selectedName, Duration = 3})
            else
                _Fluent:Notify({Title = "Error", Content = "Remote pembelian tidak ditemukan", Duration = 3})
            end
        else
            _Fluent:Notify({Title = "Gagal", Content = "Uang tidak cukup! Butuh: " .. _totalPrice, Duration = 5})
        end
    end})

    -- 👁️ VISUALS
    local _Visuals = _Tabs.Visuals
    _Visuals:AddParagraph({ Title = "Visibilitas UI", Content = "Pengaturan tampilan/sembunyikan tombol" })
    _Visuals:AddToggle("HideShakeUI", {Title = "Sembunyikan UI Shake (Mode Siluman)", Default = false }):OnChanged(function() 
        _G.HideShakeUI = _Options.HideShakeUI.Value 
    end)

    -- ⚙️ SETTINGS
    _Tabs.Settings:AddToggle("AntiAFK", {Title = "Aktifkan Anti AFK", Default = true }):OnChanged(function() _G.AntiAFK = _Options.AntiAFK.Value end)
    _Tabs.Settings:AddToggle("AlwaysPerfect", {Title = "Selalu Tangkapan Sempurna", Default = true }):OnChanged(function() _G.AlwaysPerfect = _Options.AlwaysPerfect.Value end)
    _Tabs.Settings:AddToggle("FrozenBar", {Title = "Bar Beku (Visual)", Default = true }):OnChanged(function() _G.FrozenBar = _Options.FrozenBar.Value end)
    _Tabs.Settings:AddSlider("ReelDelay", {Title = "Delay Setelah Gigit", Default = 2.5, Min = 0.0, Max = 10.0, Rounding = 1, Callback = function(_V) _G.ReelDelay = _V end})
    _Tabs.Settings:AddSlider("CastDelay", {Title = "Cooldown Setelah Tangkap", Default = 0.5, Min = 0.1, Max = 2.0, Rounding = 1, Callback = function(_V) _G.CastDelay = _V end})
    _Tabs.Settings:AddButton({Title = "🔄 Rejoin Server", Callback = function() _Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, _Services.LocalPlayer) end})
    _Tabs.Settings:AddButton({Title = "⏩ Server Hop", Callback = function() _Services.TeleportService:Teleport(game.PlaceId, _Services.LocalPlayer) end})
    
    _Tabs.Settings:AddParagraph({ Title = "Panel Log", Content = "Jendela tampilan status operasi" })
    _Tabs.Settings:AddToggle("ShowLogPanel", {Title = "Tampilkan Panel Log", Default = false }):OnChanged(function(_Value)
        _LogUI.SetVisible(_Value)
    end)
    _Tabs.Settings:AddButton({Title = "Hapus Log", Callback = function() _LogUI.ClearLogs() end})

    -- Performa & FPS
    _Tabs.Settings:AddParagraph({ Title = "-----------------", Content = "" })
    _Tabs.Settings:AddParagraph({ Title = "Performa & FPS", Content = "Alat bantu mengurangi lag dan mengurangi beban perangkat" })

    _Tabs.Settings:AddButton({
        Title = "📉 Hapus Tekstur & Efek",
        Description = "Ubah gambar menjadi polos + hapus efek (FPS Boost)",
        Callback = function()
            local _terrain = workspace:FindFirstChildOfClass("Terrain")
            if _terrain then
                _terrain.WaterWaveSize = 0
                _terrain.WaterWaveSpeed = 0
                _terrain.WaterReflectance = 0
                _terrain.WaterTransparency = 0
            end

            local _lighting = game:GetService("Lighting")
            _lighting.GlobalShadows = false
            _lighting.FogEnd = 9e9
            _lighting.Brightness = 2
            
            for _, _v in pairs(workspace:GetDescendants()) do
                if _v:IsA("BasePart") and not _v:IsA("MeshPart") then
                    _v.Material = Enum.Material.SmoothPlastic
                    _v.Reflectance = 0
                elseif _v:IsA("Decal") or _v:IsA("Texture") then
                    _v:Destroy()
                elseif _v:IsA("ParticleEmitter") or _v:IsA("Trail") or _v:IsA("Beam") or _v:IsA("Fire") or _v:IsA("Smoke") or _v:IsA("Sparkles") then
                    _v.Enabled = false
                end
            end
            
            _Fluent:Notify({Title = "FPS Boost", Content = "Tekstur & Efek Dihapus!", Duration = 3})
        end
    })

    _Tabs.Settings:AddToggle("FullBright", {Title = "☀️ Full Bright (Tanpa Kabut)", Default = false }):OnChanged(function(_Value)
        if _Value then
            game:GetService("Lighting").Brightness = 2
            game:GetService("Lighting").ClockTime = 14
            game:GetService("Lighting").FogEnd = 100000
            game:GetService("Lighting").GlobalShadows = false
            game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        end
    end)

    _Tabs.Settings:AddToggle("SuperLowMode", {Title = "⚫ Nonaktifkan Render 3D (Super AFK)", Default = false }):OnChanged(function(_Value)
        _Services.RunService:Set3dRenderingEnabled(not _Value)
        if _Value then
            _Fluent:Notify({Title = "Mode AFK", Content = "Tampilan 3D dimatikan (hemat GPU)", Duration = 3})
        else
            _Fluent:Notify({Title = "Mode AFK", Content = "Kembali ke mode normal", Duration = 3})
        end
    end)

    _Tabs.Settings:AddInput("FPSCap", {
        Title = "🔒 Batas FPS Maksimum",
        Default = "60",
        Numeric = true,
        Callback = function(_Value)
            setfpscap(tonumber(_Value) or 60)
        end
    })

    -- ℹ️ TAB INFO SERVER
    local _InfoTab = _Tabs.ServerInfo

    _InfoTab:AddToggle("ShowInfoPanel", {Title = "Tampilkan Panel Info Overlay", Default = true }):OnChanged(function(_Value)
        _InfoUI.SetVisible(_Value)
    end)

    _InfoTab:AddParagraph({ Title = "---", Content = "" })

    local _RealTimePara = _InfoTab:AddParagraph({ Title = "🕒 Waktu Nyata (Real Time)", Content = "Memuat..." })
    local _GameTimePara = _InfoTab:AddParagraph({ Title = "☀️ Waktu Game (Game Time)", Content = "Memuat..." })
    local _UptimePara = _InfoTab:AddParagraph({ Title = "⏳ Server Sudah Berjalan (Server Uptime)", Content = "Memuat..." })

    -- Loop Update
    task.spawn(function()
        while true do
            -- Waktu Nyata
            local _statusTime = os.date("%H:%M:%S")
            
            -- Waktu Game
            local _clockTime = game:GetService("Lighting").ClockTime
            local _timeState = (_clockTime >= 6 and _clockTime < 18) and "Siang ☀️" or "Malam 🌙"
            local _gameTimeStr = _Utils.FormatGameTime(_clockTime) .. " " .. _timeState

            -- Uptime Server
            local _serverTime = workspace.DistributedGameTime
            local _uptimeStr = _Utils.FormatTime(_serverTime)

            -- Update Paragraph
            if _RealTimePara then _RealTimePara:SetDesc(_statusTime) end
            if _GameTimePara then _GameTimePara:SetDesc(_gameTimeStr) end
            if _UptimePara then _UptimePara:SetDesc(_uptimeStr) end

            -- Update Info UI
            _InfoUI.Update(_Utils.FormatTime, _Utils.FormatGameTime)

            task.wait(1)
        end
    end)

    -- Penyiapan SaveManager
    _UI.SaveManager:SetLibrary(_Fluent)
    _UI.InterfaceManager:SetLibrary(_Fluent)
    _UI.SaveManager:IgnoreThemeSettings()
    _UI.InterfaceManager:BuildInterfaceSection(_Tabs.Settings)
    _UI.Window:SelectTab(1)
    _UI.SaveManager:LoadAutoloadConfig()
    
    _RefreshAllDropdowns()
end

-- ============================================
-- MAIN EXECUTION - Menjalankan Semua Modul
-- ============================================

local function _Main()
    -- Buat UI
    _LogUI.Create()
    _InfoUI.Create()
    _FlyUI.Create()
    
    local _UI = _MainUI.Create()
    if not _UI then return end
    
    if _Services.IsMobile then
        _MainUI.CreateMobileUI()
    end
    
    -- Setup Tabs
    _TabSetup.SetupAllTabs(_UI, _Data, _Utils)
    
    -- Jalankan Modul
    _AutoFish.SetupShakeDetection()
    _AutoFish.Start()
    _AutoPotion.Start()
    _AutoSell.Start()
    _AutoTotem.Start()
    _Character.Start()
    
    -- Log Startup
    _G.AddLog("✅ TESTING berhasil dimuat!", Color3.fromRGB(0, 255, 100))
    _UI.Fluent:Notify({Title = "TESTING", Content = "Script berhasil dimuat!", Duration = 5})
end

-- Jalankan Main
_Main()
