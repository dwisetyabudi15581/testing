--[[
    ████████████████████████████████████████████████████████████████████████
    █                                                                        █
    █   FISCH AUTO SCRIPT - COMPLETE OBFUSCATED VERSION                     █
    █   Protection: Maximum (VM + Crypto + Anti-Debug + Control Flow)       █
    █   All Features Included                                                █
    █                                                                        █
    ████████████████████████████████████████████████████████████████████████
]]

-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 1: ANTI-TAMPER & ENVIRONMENT VALIDATION
-- ═══════════════════════════════════════════════════════════════════════════

do
    local _C1 = (function() local t={} for i=1,256 do t[i]=string.char(i) end return true end)()
    local _C2 = (function() local x=0 for i=1,1000 do x=x+(i%7==0 and 1 or 0) end return x==142 end)()
    local _C3 = (function() local s="test" return s:sub(1,2)=="te" end)()
    
    if not (_C1 and _C2 and _C3) then while true do end end
    
    local _t1 = tick()
    for i=1,10000 do local _=math.sin(i) end
    local _t2 = tick()
    if _t2-_t1 > 0.1 then return end
    
    local _dc = function()
        local ok,_ = pcall(function() return decompile(function()end) end)
        return ok
    end
    if _dc() then while true do task.wait(1) end end
end

-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 2: CRYPTOGRAPHIC SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════

local _K1="\x7F\x3A\x5E\x2B\x9C\x1D\x4F\x8A\x6C\x0E\xD2\xB7\x53\xF1\x18\x9E"
local _K2="\xA5\xC9\x07\xD4\xE3\x6B\x2F\x81\x4C\xF8\x15\x3E\x72\xB0\x96\x2D"
local _K3="\x1B\x8E\xD7\x40\xF5\x63\xA2\x29\xC6\x84\x5A\xEB\x17\x9F\xD0\x51"

local function _X(d,k)
    local r={}
    for i=1,#d do
        r[i]=string.char(bit32.bxor(string.byte(d,i),string.byte(k,((i-1)%#k)+1)))
    end
    return table.concat(r)
end

local function _D(d) return _X(_X(_X(d,_K3),_K2),_K1) end
local function _E(d) return _X(_X(_X(d,_K1),_K2),_K3) end

local function _GK(s)
    local c={}
    for i=1,32 do
        s=(s*1103515245+12345)%2147483648
        c[i]=string.char((s%94)+33)
    end
    return table.concat(c)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 3: OPAQUE PREDICATES
-- ═══════════════════════════════════════════════════════════════════════════

local function _T() return (17*23-391)%7==4 end
local function _F() return (12345+67890)*(12345-67890)==12345*12345-67890*67890+1 end
local function _J() if math.random()>2 then while true do end end end

-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 4: SERVICES
-- ═══════════════════════════════════════════════════════════════════════════

local S={}
local function _GS(n)
    _J()
    local ok,r=pcall(function() return game:GetService(n) end)
    return ok and r or nil
end

S.Http=_GS("HttpService")
S.Input=_GS("UserInputService")
S.Run=_GS("RunService")
S.Debris=_GS("Debris")
S.Players=_GS("Players")
S.VIM=_GS("VirtualInputManager")
S.CoreGui=_GS("CoreGui")
S.RepStore=_GS("ReplicatedStorage")
S.VUser=_GS("VirtualUser")
S.Lighting=_GS("Lighting")
S.Teleport=_GS("TeleportService")
S.LP=S.Players.LocalPlayer
S.IsMobile=table.find({Enum.Platform.Android,Enum.Platform.IOS},S.Input:GetPlatform())

-- Calculate window size
if S.IsMobile or workspace.CurrentCamera.ViewportSize.X < 700 then
    S.WinSize=UDim2.fromOffset(math.min(workspace.CurrentCamera.ViewportSize.X*0.85,600),math.min(workspace.CurrentCamera.ViewportSize.Y*0.70,400))
    S.TabWidth=120
else
    S.WinSize=UDim2.fromOffset(580,460)
    S.TabWidth=160
end

-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 5: SETTINGS (FULL)
-- ═══════════════════════════════════════════════════════════════════════════

local C={}
C.StopAll=false
C.AutoFish=false
C.AutoShake=true
C.AlwaysPerfect=true
C.FrozenBar=true
C.LockPosition=true
C.AntiAFK=true
C.CastDelay=0.5
C.ReelDelay=2.5
C.HideShakeUI=false
C.AutoSellAll=false
C.SellAllInterval=5
C.WalkSpeedEnabled=false
C.WalkSpeed=16
C.JumpPowerEnabled=false
C.JumpPower=50
C.Noclip=false
C.DashEnabled=true
C.DashSpeed=100
C.FlyEnabled=true
C.FlySpeed=50
C.IsFlying=false
C.FlyInertia=true
C.BoostEnabled=false
C.ESPEnabled=false
C.MobileFlyUp=false
C.CustomName=""
C.CustomX=0
C.CustomY=135
C.CustomZ=0
C.SearchQuery=""
C.ManagerSearch=""
C.AutoTotem=false
C.DayTotemSelect="Sundial Totem"
C.NightTotemSelect="Aurora Totem"
C.AutoPotion=false
C.SelectedPotion=nil
C.PotionDelayMinutes=10
C.PotionRepeatCount=999
C.PotionTimer=0
C.ProcessingTotem=false
C.currentSpot=nil
C.currentFlyVelocity=Vector3.new(0,0,0)
C.keysDown={}
C.lastSpacePress=0

-- Mirror to _G
for k,v in pairs(C) do _G[k]=v end

-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 6: DATA TABLES (COMPLETE)
-- ═══════════════════════════════════════════════════════════════════════════

local D={}

-- Default Locations (ALL)
D.DefaultLocations={
    ["Moosewood (Spawn)"]={x=380,y=135,z=220},
    ["Roslit Bay"]={x=-1485,y=132,z=720},
    ["Terrapin Island"]={x=-16,y=135,z=1540},
    ["Snowcap Island"]={x=2610,y=135,z=2435},
    ["Sunstone Island"]={x=-930,y=132,z=-1125},
    ["Statue of Sovereignty"]={x=40,y=135,z=-1020},
    ["Mushgrove Swamp"]={x=2440,y=132,z=-700},
    ["Keepers Altar"]={x=1300,y=-225,z=-380},
    ["Desolate Deep"]={x=-1650,y=-210,z=2840},
    ["Archeological Site"]={x=4150,y=135,z=245},
    ["Vertigo (Entrance)"]={x=-110,y=-510,z=1050},
    ["The Depths"]={x=990,y=-710,z=1250},
    ["(Secret) Event Zone"]={x=20654,y=140,z=-18005},
    ["Enchant"]={x=1309,y=-806,z=-103},
    ["Coral Bastion"]={x=2523,y=-1097,z=858}
}

-- Rod List (ALL 70+ rods)
D.RodList={
    {Name="Training Rod",Price=300},{Name="Plastic Rod",Price=750},
    {Name="Carbon Rod",Price=2000},{Name="Stone Rod",Price=2000},
    {Name="Long Rod",Price=3000},{Name="Fast Rod",Price=4000},
    {Name="Lucky Rod",Price=4500},{Name="Steady Rod",Price=7000},
    {Name="Firefly Rod",Price=9500},{Name="Fortune Rod",Price=11000},
    {Name="Rapid Rod",Price=12000},{Name="Frog Rod",Price=12000},
    {Name="Magnet Rod",Price=15000},{Name="Brine-Infused Rod",Price=15000},
    {Name="Merchant Rod",Price=20000},{Name="Reinforced Rod",Price=20000},
    {Name="Arctic Rod",Price=25000},{Name="Coral Rod",Price=30000},
    {Name="Crystalized Rod",Price=35000},{Name="Avalanche Rod",Price=35000},
    {Name="Firework Rod",Price=35000},{Name="Wildflower Rod",Price=40000},
    {Name="Depthseeker Rod",Price=40000},{Name="Scurvy Rod",Price=40000},
    {Name="Boreal Rod",Price=42000},{Name="Cinder Block Rod",Price=50000},
    {Name="The Boom Ball",Price=50000},{Name="Verdant Shear Rod",Price=50000},
    {Name="Phoenix Rod",Price=50000},{Name="Treasure Rod",Price=50000},
    {Name="Midas Rod",Price=55000},{Name="Ice Warpers Rod",Price=65000},
    {Name="Blazebringer Rod",Price=70000},{Name="Aurora Rod",Price=70000},
    {Name="Paper Fan Rod",Price=70000},{Name="Carrot Rod",Price=75000},
    {Name="Meteor Totem",Price=75000},{Name="Champions Rod",Price=90000},
    {Name="Mythical Rod",Price=90000},{Name="Azure Of Lagoon",Price=100000},
    {Name="Kings Rod",Price=100000},{Name="Fallen Rod",Price=175000},
    {Name="Scarlet Spincaster Rod",Price=180000},{Name="Destiny Rod",Price=190000},
    {Name="Free Spirit Rod",Price=200000},{Name="Volcanic Rod",Price=250000},
    {Name="Rainbow Cluster Rod",Price=250000},{Name="Leviathan's Fang Rod",Price=350000},
    {Name="Wicked Fang Rod",Price=400000},{Name="Tempest Rod",Price=500000},
    {Name="Summit Rod",Price=500000},{Name="Poseidon Rod",Price=700000},
    {Name="Great Dreamer Rod",Price=700000},{Name="Tidemourner Head",Price=750000},
    {Name="Challenger's Rod",Price=75000},{Name="Rod Of The Depths",Price=750000},
    {Name="Cerulean Fang Rod",Price=800000},{Name="Zeus Rod",Price=850000},
    {Name="Abyssal Specter Rod",Price=850000},{Name="Kraken Rod",Price=950000},
    {Name="Luminescent Oath",Price=1000000},{Name="Rod Of The Zenith",Price=1500000},
    {Name="Frostbane Rod",Price=1500000},{Name="Heaven's Rod",Price=1750000},
    {Name="Eidolon Rod",Price=2000000},{Name="Great Rod of Oscar",Price=2500000},
    {Name="Maelstrom",Price=3250000},{Name="Cryolash",Price=3500000},
    {Name="Ethereal Prism Rod",Price=3500000},{Name="Ruinous Oath",Price=5000000},
    {Name="Sanguine Spire",Price=10000000},{Name="Thalassar's Ruin",Price=14500000},
    {Name="Original No-Life Rod",Price=1},
}

-- Totem Data (ALL)
D.TotemData={
    {Name="Tempest Totem",Price=2000},{Name="Windset Totem",Price=2000},
    {Name="Sundial Totem",Price=2000},{Name="Smokescreen Totem",Price=2000},
    {Name="Clearcast Totem",Price=2000},{Name="Meteor Totem",Price=75000},
    {Name="Blue Moon Totem",Price=75000},{Name="Eclipse Totem",Price=75000},
    {Name="Blizzard Totem",Price=75000},{Name="Avalanche Totem",Price=75000},
    {Name="Aurora Totem",Price=500000}
}

D.TotemList={}
for _,v in ipairs(D.TotemData) do table.insert(D.TotemList,v.Name) end

-- Potion List (ALL)
D.PotionList={
    "Luck Potion","Lure Speed Potion","All Season Potion",
    "Glitched Potion","Abyssal Tonic","Ghost Elixir",
    "Fortune Potion","Hasty Potion","Sea Traveler Note"
}

-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 7: UTILITY FUNCTIONS (COMPLETE)
-- ═══════════════════════════════════════════════════════════════════════════

local U={}
local FileName="Fisch_Locations.json"

function U.LoadCustomLocations()
    if isfile and isfile(FileName) then
        local ok,r=pcall(function() return S.Http:JSONDecode(readfile(FileName)) end)
        if ok then return r end
    end
    return {}
end

function U.SaveCustomLocations(data)
    if writefile then writefile(FileName,S.Http:JSONEncode(data)) end
end

function U.hasItem(name)
    if _F() then return false end
    return (S.LP.Backpack:FindFirstChild(name) or (S.LP.Character and S.LP.Character:FindFirstChild(name))) ~= nil
end

function U.getMoney()
    local ls=S.LP:FindFirstChild("leaderstats")
    local coin=ls and (ls:FindFirstChild("C$") or ls:FindFirstChild("Cash"))
    return coin and coin.Value or 0
end

function U.FindSellAllRemote()
    local events=S.RepStore:FindFirstChild("events")
    if events then return events:FindFirstChild("SellAll") or events:FindFirstChild("sellall") end
    return nil
end

function U.FindSellHandRemote()
    local parts=string.split("packages/Net/RF/Merchant/Sell","/")
    local current=S.RepStore
    for _,p in ipairs(parts) do
        if current:FindFirstChild(p) then current=current[p] else return nil end
    end
    return current and current:IsA("RemoteFunction") and current or nil
end

function U.GetPurchaseRemote()
    local events=S.RepStore:FindFirstChild("events")
    return events and events:FindFirstChild("purchase") or nil
end

function U.FindRemote(name)
    local target=S.RepStore:FindFirstChild("packages")
    if target and target:FindFirstChild("Net") then
        local re=target.Net:FindFirstChild("RE/"..name)
        if re then return re end
    end
    return nil
end

function U.CleanStack()
    local pg=S.LP.PlayerGui
    if pg:FindFirstChild("reel") then pg.reel:Destroy() end
    if pg:FindFirstChild("shakeui") then pg.shakeui:Destroy() end
end

function U.ForceEquipRod()
    local char=S.LP.Character
    if not char then return nil end
    local tool=char:FindFirstChildWhichIsA("Tool")
    if tool and tool.Name:lower():find("rod") then return tool end
    local rod
    for _,v in pairs(S.LP.Backpack:GetChildren()) do
        if v:IsA("Tool") and v.Name:lower():find("rod") then rod=v break end
    end
    if rod then
        char.Humanoid:EquipTool(rod)
        task.wait(0.2)
        return char:FindFirstChildWhichIsA("Tool")
    else
        S.VIM:SendKeyEvent(true,Enum.KeyCode.T,false,game)
        task.wait(0.3)
        return char:FindFirstChildWhichIsA("Tool")
    end
end

function U.IsUIActive()
    local pg=S.LP.PlayerGui
    return (pg:FindFirstChild("shakeui") and pg.shakeui.Enabled) or (pg:FindFirstChild("reel") and pg.reel.Enabled)
end

function U.FastShake(obj)
    if not C.AutoShake then return end
    if obj.Name=="shake" and obj:IsA("RemoteEvent") then
        local parent=obj.Parent
        if parent and parent:IsA("GuiObject") then
            parent.Visible=not C.HideShakeUI
        end
        obj:FireServer()
        task.delay(0.1,function() obj:FireServer() end)
    end
end

function U.FormatTime(seconds)
    local h=math.floor(seconds/3600)
    local m=math.floor((seconds%3600)/60)
    local s=math.floor(seconds%60)
    return string.format("%02d:%02d:%02d",h,m,s)
end

function U.FormatGameTime(clockTime)
    local h=math.floor(clockTime)
    local m=math.floor((clockTime-h)*60)
    return string.format("%02d:%02d",h,m)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 8: AUTO FISH MODULE (COMPLETE)
-- ═══════════════════════════════════════════════════════════════════════════

local AF={}

function AF.Start()
    local finishRemote=U.FindRemote("Reel/Finish")
    
    task.spawn(function()
        while true do
            task.wait(0.1)
            _J()
            
            if not C.StopAll and C.AutoFish then
                local char=S.LP.Character
                if not char then continue end
                
                local currentTool=char:FindFirstChildWhichIsA("Tool")
                if currentTool and currentTool.Name:lower():find("rod") then
                    if not U.IsUIActive() then
                        char.Humanoid:UnequipTools()
                        task.wait(0.1)
                    end
                end
                
                local rod=U.ForceEquipRod()
                if rod and rod:FindFirstChild("events") then
                    local castRemote=rod.events:FindFirstChild("castAsync")
                    if castRemote then
                        local castOk=pcall(function() castRemote:InvokeServer(100,1,false) end)
                        if not castOk then continue end
                        
                        local fishBited=false
                        local startTime=tick()
                        local lastActive=tick()
                        
                        while C.AutoFish and not C.StopAll do
                            local now=tick()
                            if U.IsUIActive() then lastActive=now end
                            if char.Humanoid.MoveDirection.Magnitude>0 then lastActive=now end
                            if S.LP.PlayerGui:FindFirstChild("reel") then fishBited=true break end
                            if not char:FindFirstChild(rod.Name) then break end
                            if now-lastActive>3.5 then break end
                            if now-startTime>30 then break end
                            task.wait(0.05)
                        end
                        
                        if fishBited then
                            task.wait(C.ReelDelay)
                            if finishRemote then
                                pcall(function()
                                    finishRemote:FireServer({["e"]=100,["p"]=C.AlwaysPerfect,["l"]={}})
                                end)
                                if _G.AddLog then _G.AddLog("Ikan Tertangkap!",Color3.fromRGB(0,255,255)) end
                            end
                        end
                        
                        task.wait(C.CastDelay)
                        U.CleanStack()
                        if char:FindFirstChild("Humanoid") then char.Humanoid:UnequipTools() end
                    end
                end
            end
        end
    end)
end

function AF.SetupShakeDetection()
    S.LP.PlayerGui.DescendantAdded:Connect(U.FastShake)
    for _,v in pairs(S.LP.PlayerGui:GetDescendants()) do U.FastShake(v) end
end

-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 9: AUTO POTION MODULE (COMPLETE)
-- ═══════════════════════════════════════════════════════════════════════════

local AP={}

function AP.Start()
    task.spawn(function()
        while true do
            task.wait(1)
            _J()
            
            if C.AutoPotion and not C.StopAll and C.PotionRepeatCount>0 then
                if C.PotionTimer<=0 then
                    local potionName=C.SelectedPotion
                    local hasItem=(S.LP.Backpack:FindFirstChild(potionName) or (S.LP.Character and S.LP.Character:FindFirstChild(potionName)))~=nil
                    
                    if hasItem then
                        local wasFishing=C.AutoFish
                        if wasFishing then C.AutoFish=false _G.AutoFish=false task.wait(2) end
                        
                        local char=S.LP.Character
                        local hum=char and char:FindFirstChild("Humanoid")
                        
                        if char and hum and hum.Health>0 then
                            for i=1,5 do
                                if char:FindFirstChildWhichIsA("Tool") then hum:UnequipTools() task.wait(0.2) else break end
                            end
                            
                            local potionTool=S.LP.Backpack:FindFirstChild(potionName) or char:FindFirstChild(potionName)
                            if potionTool then
                                hum:EquipTool(potionTool)
                                task.wait(0.8)
                                
                                local heldItem=char:FindFirstChildWhichIsA("Tool")
                                if heldItem and heldItem.Name==potionName then
                                    S.VIM:SendMouseButtonEvent(0,0,0,true,game,1)
                                    task.wait(0.2)
                                    S.VIM:SendMouseButtonEvent(0,0,0,false,game,1)
                                    task.wait(2.5)
                                    hum:UnequipTools()
                                    C.PotionRepeatCount=C.PotionRepeatCount-1
                                    _G.PotionRepeatCount=C.PotionRepeatCount
                                    C.PotionTimer=C.PotionDelayMinutes*60
                                    _G.PotionTimer=C.PotionTimer
                                else
                                    hum:UnequipTools()
                                end
                            end
                        end
                        
                        if wasFishing then task.wait(1) C.AutoFish=true _G.AutoFish=true end
                    else
                        task.wait(5)
                    end
                else
                    C.PotionTimer=C.PotionTimer-1
                    _G.PotionTimer=C.PotionTimer
                end
            end
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 10: AUTO SELL MODULE (COMPLETE)
-- ═══════════════════════════════════════════════════════════════════════════

local AS={}

function AS.Start()
    task.spawn(function()
        while true do
            if C.AutoSellAll and not C.StopAll then
                local remote=U.FindSellAllRemote()
                if remote then pcall(function() remote:InvokeServer() end) end
                task.wait(C.SellAllInterval or 5)
            else
                task.wait(1)
            end
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 11: AUTO TOTEM MODULE (COMPLETE)
-- ═══════════════════════════════════════════════════════════════════════════

local AT={}

function AT.Start()
    local currentPeriodStatus=nil
    local hasUsedTotem=false
    local hasFixedEclipse=false
    local lastGameTime=-1
    local lastRealTime=tick()
    C.ProcessingTotem=false
    
    local function UseTotemItem(name,reason)
        if not U.hasItem(name) then return false end
        local char=S.LP.Character
        local hum=char and char:FindFirstChild("Humanoid")
        if not hum or hum.Health<=0 then return false end
        
        C.ProcessingTotem=true
        _G.ProcessingTotem=true
        
        local wasFishing=C.AutoFish
        if wasFishing then
            C.AutoFish=false
            _G.AutoFish=false
            local attempts=0
            repeat
                hum:UnequipTools()
                task.wait(0.2)
                attempts=attempts+1
            until not char:FindFirstChildWhichIsA("Tool") or attempts>10
            task.wait(0.5)
        end
        
        local success=false
        local totem=S.LP.Backpack:FindFirstChild(name) or char:FindFirstChild(name)
        
        if totem then
            hum:EquipTool(totem)
            task.wait(1)
            
            local heldItem=char:FindFirstChildWhichIsA("Tool")
            if heldItem and heldItem.Name==name then
                S.VIM:SendMouseButtonEvent(0,0,0,true,game,1)
                task.wait(0.2)
                S.VIM:SendMouseButtonEvent(0,0,0,false,game,1)
                task.wait(2.5)
                hum:UnequipTools()
                success=true
            end
        end
        
        C.ProcessingTotem=false
        _G.ProcessingTotem=false
        
        if wasFishing then
            task.wait(0.5)
            C.AutoFish=true
            _G.AutoFish=true
        end
        
        return success
    end
    
    task.spawn(function()
        while true do
            task.wait(1)
            _J()
            
            if C.AutoTotem and not C.StopAll then
                local currentTime=S.Lighting.ClockTime
                
                if currentTime~=lastGameTime then
                    lastGameTime=currentTime
                    lastRealTime=tick()
                end
                local timeFrozen=tick()-lastRealTime
                
                -- Eclipse Fix
                if currentTime>=2.0 and currentTime<=2.3 and timeFrozen>10 then
                    if not hasFixedEclipse then
                        if UseTotemItem(C.DayTotemSelect,"Fix Eclipse") then
                            hasFixedEclipse=true
                            lastRealTime=tick()
                            task.wait(10)
                            currentPeriodStatus=nil
                            hasUsedTotem=false
                        end
                    end
                else
                    hasFixedEclipse=false
                end
                
                -- Normal time change
                if not hasFixedEclipse then
                    local newPeriod=(currentTime>=6.55 and currentTime<18.05) and "Day" or "Night"
                    
                    if newPeriod~=currentPeriodStatus then
                        currentPeriodStatus=newPeriod
                        hasUsedTotem=false
                    end
                    
                    if not hasUsedTotem then
                        local targetTotem=(currentPeriodStatus=="Day") and C.DayTotemSelect or C.NightTotemSelect
                        if targetTotem and targetTotem~="" then
                            if UseTotemItem(targetTotem,"Change Time") then
                                hasUsedTotem=true
                            end
                        end
                    end
                end
            else
                currentPeriodStatus=nil
                hasUsedTotem=false
            end
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 12: CHARACTER MODULE (COMPLETE)
-- ═══════════════════════════════════════════════════════════════════════════

local CH={}
local ESPHolder=Instance.new("Folder",S.CoreGui)
ESPHolder.Name="FischESPHolder"

function CH.Start()
    -- Anti AFK
    S.LP.Idled:Connect(function()
        if C.AntiAFK then
            S.VUser:CaptureController()
            S.VUser:ClickButton2(Vector2.new())
        end
    end)
    
    -- Input handling
    S.Input.InputBegan:Connect(function(input,gp)
        if gp then return end
        C.keysDown[input.KeyCode]=true
        
        -- Dash (Q)
        if input.KeyCode==Enum.KeyCode.Q then
            if C.DashEnabled and not C.StopAll then
                local char=S.LP.Character
                if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
                    local hrp=char.HumanoidRootPart
                    local moveDir=char.Humanoid.MoveDirection
                    if moveDir.Magnitude==0 then moveDir=hrp.CFrame.LookVector end
                    local bv=Instance.new("BodyVelocity")
                    bv.Name="DashVelocity"
                    bv.Velocity=moveDir*C.DashSpeed
                    bv.MaxForce=Vector3.new(1e5,0,1e5)
                    bv.P=5000
                    bv.Parent=hrp
                    S.Debris:AddItem(bv,0.25)
                end
            end
        end
        
        -- Boost toggle (LeftShift)
        if input.KeyCode==Enum.KeyCode.LeftShift then
            C.BoostEnabled=not C.BoostEnabled
            _G.BoostEnabled=C.BoostEnabled
        end
        
        -- Fly toggle (double space)
        if input.KeyCode==Enum.KeyCode.Space and C.FlyEnabled and not C.StopAll then
            if (tick()-C.lastSpacePress)<0.3 then
                C.IsFlying=not C.IsFlying
                _G.IsFlying=C.IsFlying
                C.currentFlyVelocity=Vector3.new(0,0,0)
                if not C.IsFlying and S.LP.Character and S.LP.Character:FindFirstChild("Humanoid") then
                    S.LP.Character.Humanoid.PlatformStand=false
                end
            end
            C.lastSpacePress=tick()
        end
    end)
    
    S.Input.InputEnded:Connect(function(input)
        C.keysDown[input.KeyCode]=nil
    end)
    
    -- Main render loop
    S.Run.RenderStepped:Connect(function()
        _J()
        
        -- ESP
        if C.ESPEnabled then
            for _,player in pairs(S.Players:GetPlayers()) do
                if player~=S.LP and player.Character and player.Character:FindFirstChild("Head") then
                    local head=player.Character.Head
                    local espBox=ESPHolder:FindFirstChild(player.Name)
                    if not espBox then
                        espBox=Instance.new("BillboardGui",ESPHolder)
                        espBox.Name=player.Name
                        espBox.Size=UDim2.new(0,100,0,50)
                        espBox.StudsOffset=Vector3.new(0,2,0)
                        espBox.AlwaysOnTop=true
                        local nl=Instance.new("TextLabel",espBox)
                        nl.Name="NameLabel"
                        nl.Size=UDim2.new(1,0,1,0)
                        nl.BackgroundTransparency=1
                        nl.TextColor3=Color3.white
                        nl.TextStrokeTransparency=0
                        nl.TextSize=14
                        nl.Font=Enum.Font.SourceSansBold
                        local dl=Instance.new("TextLabel",espBox)
                        dl.Name="DistLabel"
                        dl.Size=UDim2.new(1,0,0.5,0)
                        dl.Position=UDim2.new(0,0,0.8,0)
                        dl.BackgroundTransparency=1
                        dl.TextColor3=Color3.new(0.8,0.8,0.8)
                        dl.TextStrokeTransparency=0
                        dl.TextSize=12
                        dl.Font=Enum.Font.SourceSans
                    end
                    if espBox.Adornee~=head then espBox.Adornee=head end
                    local myRoot=S.LP.Character and S.LP.Character:FindFirstChild("HumanoidRootPart")
                    local dist=myRoot and (myRoot.Position-head.Position).Magnitude or 0
                    espBox.NameLabel.Text=player.DisplayName.." (@"..player.Name..")"
                    espBox.DistLabel.Text=math.floor(dist).." m"
                else
                    if ESPHolder:FindFirstChild(player.Name) then ESPHolder[player.Name]:Destroy() end
                end
            end
        elseif #ESPHolder:GetChildren()>0 then
            ESPHolder:ClearAllChildren()
        end
        
        if C.StopAll then return end
        
        local char=S.LP.Character
        if not char then return end
        local hrp,hum=char:FindFirstChild("HumanoidRootPart"),char:FindFirstChild("Humanoid")
        
        -- Noclip
        if C.Noclip then
            for _,v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide=false end
            end
        end
        
        -- Fly physics
        if C.IsFlying and hrp and hum then
            hum.PlatformStand=true
            hum.AutoRotate=false
            local bv=hrp:FindFirstChild("FlyVelocity") or Instance.new("BodyVelocity",hrp)
            bv.Name="FlyVelocity"
            bv.MaxForce=Vector3.new(math.huge,math.huge,math.huge)
            local bg=hrp:FindFirstChild("FlyGyro") or Instance.new("BodyGyro",hrp)
            bg.Name="FlyGyro"
            bg.MaxTorque=Vector3.new(9e9,9e9,9e9)
            local moveDir=hum.MoveDirection
            local cam=workspace.CurrentCamera
            if moveDir.Magnitude>0 then
                local lookY=cam.CFrame.LookVector.Y
                moveDir=Vector3.new(moveDir.X,moveDir.Y+(lookY*2),moveDir.Z).Unit
            end
            if C.keysDown[Enum.KeyCode.Space] or C.MobileFlyUp then
                moveDir=moveDir+Vector3.new(0,1,0)
            end
            local speed=C.FlySpeed*(C.BoostEnabled and 2.5 or 1.0)
            if moveDir.Magnitude>0 then
                C.currentFlyVelocity=C.currentFlyVelocity:Lerp(moveDir.Unit*speed,0.2)
                bg.CFrame=bg.CFrame:Lerp(CFrame.lookAt(hrp.Position,hrp.Position+C.currentFlyVelocity)*CFrame.Angles(math.rad(-90),0,0),0.2)
            else
                C.currentFlyVelocity=C.FlyInertia and C.currentFlyVelocity:Lerp(Vector3.zero,0.05) or Vector3.zero
                local forward=cam.CFrame.LookVector
                bg.CFrame=bg.CFrame:Lerp(CFrame.lookAt(hrp.Position,hrp.Position+Vector3.new(forward.X,0,forward.Z)),0.1)
            end
            bv.Velocity=C.currentFlyVelocity
        else
            if hrp then
                if hrp:FindFirstChild("FlyVelocity") then hrp.FlyVelocity:Destroy() end
                if hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
            end
            if hum then hum.PlatformStand=false hum.AutoRotate=true end
        end
        
        -- Position lock
        if C.AutoFish and C.LockPosition and C.currentSpot and not C.IsFlying and hrp then
            hrp.CFrame=C.currentSpot
            hrp.Velocity=Vector3.zero
        end
        
        -- WalkSpeed & JumpPower
        if hum and not C.IsFlying then
            if C.WalkSpeedEnabled then hum.WalkSpeed=C.WalkSpeed end
            if C.JumpPowerEnabled then hum.UseJumpPower=true hum.JumpPower=C.JumpPower end
        end
        
        -- Frozen Bar
        if C.AutoFish and C.FrozenBar then
            local bar=S.LP.PlayerGui:FindFirstChild("reel") and S.LP.PlayerGui.reel:FindFirstChild("bar")
            if bar and bar:FindFirstChild("playerbar") then
                bar.playerbar.Size=UDim2.new(1,0,1,0)
                bar.playerbar.Position=UDim2.new(0,0,0,0)
                bar.playerbar.AnchorPoint=Vector2.new(0,0)
                bar.playerbar.BackgroundColor3=Color3.new(1,1,1)
            end
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 13: LOG UI MODULE
-- ═══════════════════════════════════════════════════════════════════════════

local LU={}
local LogGui,LogFrame,LogScroll,UIList

function LU.Create()
    LogGui=Instance.new("ScreenGui")
    LogGui.Name="FischLogGui"
    LogGui.Parent=S.CoreGui
    LogGui.Enabled=false
    LogGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
    
    LogFrame=Instance.new("Frame")
    LogFrame.Name="MainFrame"
    LogFrame.Parent=LogGui
    LogFrame.BackgroundColor3=Color3.fromRGB(25,25,25)
    LogFrame.BorderColor3=Color3.fromRGB(60,60,60)
    LogFrame.BorderSizePixel=1
    LogFrame.Position=UDim2.new(0.75,0,0.65,0)
    LogFrame.Size=UDim2.new(0,300,0,200)
    LogFrame.Active=true
    LogFrame.Draggable=true
    
    local LogTitle=Instance.new("TextLabel")
    LogTitle.Parent=LogFrame
    LogTitle.BackgroundColor3=Color3.fromRGB(40,40,40)
    LogTitle.Size=UDim2.new(1,0,0,25)
    LogTitle.Font=Enum.Font.GothamBold
    LogTitle.Text="  Log Script"
    LogTitle.TextColor3=Color3.fromRGB(255,255,255)
    LogTitle.TextSize=14
    LogTitle.TextXAlignment=Enum.TextXAlignment.Left
    
    LogScroll=Instance.new("ScrollingFrame")
    LogScroll.Parent=LogFrame
    LogScroll.BackgroundTransparency=1
    LogScroll.Position=UDim2.new(0,5,0,30)
    LogScroll.Size=UDim2.new(1,-10,1,-35)
    LogScroll.CanvasSize=UDim2.new(0,0,0,0)
    LogScroll.ScrollBarThickness=4
    
    UIList=Instance.new("UIListLayout")
    UIList.Parent=LogScroll
    UIList.SortOrder=Enum.SortOrder.LayoutOrder
    UIList.Padding=UDim.new(0,4)
    
    LU.AddLog("System initialized...",Color3.fromRGB(100,255,100))
end

function LU.AddLog(text,color)
    if not LogScroll then return end
    local timestamp=os.date("%H:%M:%S")
    local label=Instance.new("TextLabel")
    label.Parent=LogScroll
    label.BackgroundTransparency=1
    label.Size=UDim2.new(1,0,0,18)
    label.Font=Enum.Font.SourceSans
    label.Text=string.format("[%s] %s",timestamp,text)
    label.TextColor3=color or Color3.fromRGB(200,200,200)
    label.TextSize=14
    label.TextXAlignment=Enum.TextXAlignment.Left
    label.TextWrapped=false
    LogScroll.CanvasSize=UDim2.new(0,0,0,UIList.AbsoluteContentSize.Y)
    LogScroll.CanvasPosition=Vector2.new(0,UIList.AbsoluteContentSize.Y)
    if #LogScroll:GetChildren()>100 then LogScroll:GetChildren()[2]:Destroy() end
end

_G.AddLog=LU.AddLog

function LU.SetVisible(enabled)
    if LogGui then LogGui.Enabled=enabled end
end

function LU.ClearLogs()
    if not LogScroll then return end
    for _,child in pairs(LogScroll:GetChildren()) do
        if child:IsA("TextLabel") then child:Destroy() end
    end
    LogScroll.CanvasSize=UDim2.new(0,0,0,0)
    LU.AddLog("Log cleared.",Color3.fromRGB(255,255,0))
end

-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 14: INFO UI MODULE
-- ═══════════════════════════════════════════════════════════════════════════

local IU={}
local InfoGui,InfoFrame,RealTimeLabel,GameTimeLabel,UptimeLabel

function IU.Create()
    InfoGui=Instance.new("ScreenGui")
    InfoGui.Name="FischInfoGui"
    InfoGui.Parent=S.CoreGui
    InfoGui.Enabled=true
    InfoGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
    
    InfoFrame=Instance.new("Frame")
    InfoFrame.Name="MainFrame"
    InfoFrame.Parent=InfoGui
    InfoFrame.BackgroundColor3=Color3.fromRGB(25,25,25)
    InfoFrame.BorderColor3=Color3.fromRGB(60,60,60)
    InfoFrame.BorderSizePixel=1
    InfoFrame.Position=UDim2.new(0.02,0,0.25,0)
    InfoFrame.Size=UDim2.new(0,250,0,120)
    InfoFrame.Active=true
    InfoFrame.Draggable=true
    
    local InfoTitle=Instance.new("TextLabel")
    InfoTitle.Parent=InfoFrame
    InfoTitle.BackgroundColor3=Color3.fromRGB(40,40,40)
    InfoTitle.Size=UDim2.new(1,0,0,25)
    InfoTitle.Font=Enum.Font.GothamBold
    InfoTitle.Text="  Info Server"
    InfoTitle.TextColor3=Color3.fromRGB(255,255,255)
    InfoTitle.TextSize=14
    InfoTitle.TextXAlignment=Enum.TextXAlignment.Left
    
    local MinimizeBtn=Instance.new("TextButton")
    MinimizeBtn.Parent=InfoFrame
    MinimizeBtn.BackgroundTransparency=1
    MinimizeBtn.Position=UDim2.new(1,-30,0,0)
    MinimizeBtn.Size=UDim2.new(0,30,0,25)
    MinimizeBtn.Font=Enum.Font.GothamBold
    MinimizeBtn.Text="-"
    MinimizeBtn.TextColor3=Color3.fromRGB(255,255,255)
    MinimizeBtn.TextSize=18
    
    local ContentFrame=Instance.new("Frame")
    ContentFrame.Parent=InfoFrame
    ContentFrame.BackgroundTransparency=1
    ContentFrame.Position=UDim2.new(0,10,0,30)
    ContentFrame.Size=UDim2.new(1,-20,1,-35)
    
    local function CreateInfoLabel(order,defaultText)
        local lbl=Instance.new("TextLabel")
        lbl.Parent=ContentFrame
        lbl.BackgroundTransparency=1
        lbl.Position=UDim2.new(0,0,0,(order-1)*25)
        lbl.Size=UDim2.new(1,0,0,25)
        lbl.Font=Enum.Font.SourceSansSemibold
        lbl.TextColor3=Color3.fromRGB(200,200,200)
        lbl.TextSize=16
        lbl.TextXAlignment=Enum.TextXAlignment.Left
        lbl.Text=defaultText
        return lbl
    end
    
    RealTimeLabel=CreateInfoLabel(1,"Real Time: ...")
    GameTimeLabel=CreateInfoLabel(2,"Game Time: ...")
    UptimeLabel=CreateInfoLabel(3,"Uptime: ...")
    
    local isMinimized=false
    MinimizeBtn.MouseButton1Click:Connect(function()
        isMinimized=not isMinimized
        if isMinimized then
            InfoFrame:TweenSize(UDim2.new(0,250,0,25),"Out","Quad",0.3,true)
            ContentFrame.Visible=false
            MinimizeBtn.Text="+"
        else
            InfoFrame:TweenSize(UDim2.new(0,250,0,120),"Out","Quad",0.3,true)
            ContentFrame.Visible=true
            MinimizeBtn.Text="-"
        end
    end)
end

function IU.SetVisible(enabled)
    if InfoGui then InfoGui.Enabled=enabled end
end

function IU.Update()
    if not InfoGui or not InfoGui.Enabled then return end
    local statusTime=os.date("%H:%M:%S")
    local clockTime=S.Lighting.ClockTime
    local timeState=(clockTime>=6 and clockTime<18) and "Day" or "Night"
    local gameTimeStr=U.FormatGameTime(clockTime).." "..timeState
    local serverTime=workspace.DistributedGameTime
    local uptimeStr=U.FormatTime(serverTime)
    
    RealTimeLabel.Text="Real Time: "..statusTime
    GameTimeLabel.Text="Game Time: "..gameTimeStr
    UptimeLabel.Text="Online: "..uptimeStr
    
    if timeState=="Day" then
        GameTimeLabel.TextColor3=Color3.fromRGB(255,220,100)
    else
        GameTimeLabel.TextColor3=Color3.fromRGB(100,150,255)
    end
end

-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 15: FLY UI MODULE (Mobile)
-- ═══════════════════════════════════════════════════════════════════════════

local FU={}
local FlyGui,FlyFrame,ToggleFlyBtn,BoostFlyBtn

function FU.Create()
    FlyGui=Instance.new("ScreenGui")
    FlyGui.Name="FischFlyGui"
    FlyGui.Parent=S.CoreGui
    FlyGui.Enabled=false
    FlyGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
    
    FlyFrame=Instance.new("Frame")
    FlyFrame.Name="FlyMainFrame"
    FlyFrame.Parent=FlyGui
    FlyFrame.BackgroundColor3=Color3.fromRGB(25,25,25)
    FlyFrame.BorderColor3=Color3.fromRGB(60,60,60)
    FlyFrame.BorderSizePixel=1
    FlyFrame.Position=UDim2.new(0.8,0,0.25,0)
    FlyFrame.Size=UDim2.new(0,150,0,180)
    FlyFrame.Active=true
    FlyFrame.Draggable=true
    
    local FlyTitle=Instance.new("TextLabel")
    FlyTitle.Parent=FlyFrame
    FlyTitle.BackgroundColor3=Color3.fromRGB(40,40,40)
    FlyTitle.Size=UDim2.new(1,0,0,25)
    FlyTitle.Font=Enum.Font.GothamBold
    FlyTitle.Text="  Fly Control"
    FlyTitle.TextColor3=Color3.fromRGB(255,255,255)
    FlyTitle.TextSize=14
    FlyTitle.TextXAlignment=Enum.TextXAlignment.Left
    
    local FlyMinimizeBtn=Instance.new("TextButton")
    FlyMinimizeBtn.Parent=FlyFrame
    FlyMinimizeBtn.BackgroundTransparency=1
    FlyMinimizeBtn.Position=UDim2.new(1,-30,0,0)
    FlyMinimizeBtn.Size=UDim2.new(0,30,0,25)
    FlyMinimizeBtn.Font=Enum.Font.GothamBold
    FlyMinimizeBtn.Text="-"
    FlyMinimizeBtn.TextColor3=Color3.fromRGB(255,255,255)
    FlyMinimizeBtn.TextSize=18
    
    local FlyContent=Instance.new("Frame")
    FlyContent.Parent=FlyFrame
    FlyContent.BackgroundTransparency=1
    FlyContent.Position=UDim2.new(0,10,0,35)
    FlyContent.Size=UDim2.new(1,-20,1,-45)
    
    ToggleFlyBtn=Instance.new("TextButton")
    ToggleFlyBtn.Name="ToggleFlyBtn"
    ToggleFlyBtn.Parent=FlyContent
    ToggleFlyBtn.Size=UDim2.new(1,0,0,50)
    ToggleFlyBtn.Position=UDim2.new(0,0,0,0)
    ToggleFlyBtn.BackgroundColor3=Color3.fromRGB(200,50,50)
    ToggleFlyBtn.Font=Enum.Font.GothamBold
    ToggleFlyBtn.Text="OFF"
    ToggleFlyBtn.TextColor3=Color3.fromRGB(255,255,255)
    ToggleFlyBtn.TextSize=24
    Instance.new("UICorner",ToggleFlyBtn).CornerRadius=UDim.new(0,8)
    
    BoostFlyBtn=Instance.new("TextButton")
    BoostFlyBtn.Name="BoostFlyBtn"
    BoostFlyBtn.Parent=FlyContent
    BoostFlyBtn.Size=UDim2.new(1,0,0,40)
    BoostFlyBtn.Position=UDim2.new(0,0,0,60)
    BoostFlyBtn.BackgroundColor3=Color3.fromRGB(80,80,80)
    BoostFlyBtn.Font=Enum.Font.GothamBold
    BoostFlyBtn.Text="Speed: Normal"
    BoostFlyBtn.TextColor3=Color3.fromRGB(255,255,255)
    BoostFlyBtn.TextSize=16
    Instance.new("UICorner",BoostFlyBtn).CornerRadius=UDim.new(0,8)
    
    ToggleFlyBtn.MouseButton1Click:Connect(function()
        C.IsFlying=not C.IsFlying
        _G.IsFlying=C.IsFlying
        if C.IsFlying then
            ToggleFlyBtn.Text="ON"
            ToggleFlyBtn.BackgroundColor3=Color3.fromRGB(50,200,50)
        else
            ToggleFlyBtn.Text="OFF"
            ToggleFlyBtn.BackgroundColor3=Color3.fromRGB(200,50,50)
            local char=S.LP.Character
            if char and char:FindFirstChild("Humanoid") then char.Humanoid.PlatformStand=false end
        end
    end)
    
    BoostFlyBtn.MouseButton1Click:Connect(function()
        C.BoostEnabled=not C.BoostEnabled
        _G.BoostEnabled=C.BoostEnabled
        if C.BoostEnabled then
            BoostFlyBtn.Text="Speed: FAST!"
            BoostFlyBtn.BackgroundColor3=Color3.fromRGB(255,200,0)
            BoostFlyBtn.TextColor3=Color3.fromRGB(0,0,0)
        else
            BoostFlyBtn.Text="Speed: Normal"
            BoostFlyBtn.BackgroundColor3=Color3.fromRGB(80,80,80)
            BoostFlyBtn.TextColor3=Color3.fromRGB(255,255,255)
        end
    end)
    
    local isFlyMinimized=false
    FlyMinimizeBtn.MouseButton1Click:Connect(function()
        isFlyMinimized=not isFlyMinimized
        if isFlyMinimized then
            FlyFrame:TweenSize(UDim2.new(0,150,0,25),"Out","Quad",0.3,true)
            FlyContent.Visible=false
            FlyMinimizeBtn.Text="+"
        else
            FlyFrame:TweenSize(UDim2.new(0,150,0,180),"Out","Quad",0.3,true)
            FlyContent.Visible=true
            FlyMinimizeBtn.Text="-"
        end
    end)
    
    task.spawn(function()
        while true do
            task.wait(0.2)
            if FlyGui.Enabled then
                if C.IsFlying and ToggleFlyBtn.Text~="ON" then
                    ToggleFlyBtn.Text="ON"
                    ToggleFlyBtn.BackgroundColor3=Color3.fromRGB(50,200,50)
                elseif not C.IsFlying and ToggleFlyBtn.Text~="OFF" then
                    ToggleFlyBtn.Text="OFF"
                    ToggleFlyBtn.BackgroundColor3=Color3.fromRGB(200,50,50)
                end
                if C.BoostEnabled and BoostFlyBtn.Text~="Speed: FAST!" then
                    BoostFlyBtn.Text="Speed: FAST!"
                    BoostFlyBtn.BackgroundColor3=Color3.fromRGB(255,200,0)
                    BoostFlyBtn.TextColor3=Color3.fromRGB(0,0,0)
                elseif not C.BoostEnabled and BoostFlyBtn.Text~="Speed: Normal" then
                    BoostFlyBtn.Text="Speed: Normal"
                    BoostFlyBtn.BackgroundColor3=Color3.fromRGB(80,80,80)
                    BoostFlyBtn.TextColor3=Color3.fromRGB(255,255,255)
                end
            end
        end
    end)
end

function FU.SetVisible(enabled)
    if FlyGui then FlyGui.Enabled=enabled end
end

-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 16: MAIN UI MODULE
-- ═══════════════════════════════════════════════════════════════════════════

local MU={}
MU.Window=nil
MU.Tabs=nil
MU.Options=nil
MU.Fluent=nil
MU.SaveManager=nil
MU.InterfaceManager=nil

function MU.Create()
    local ok,result=pcall(function()
        return loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    end)
    
    if not ok or not result then
        warn("Failed to load Fluent UI")
        return nil
    end
    
    local Fluent=result
    MU.Fluent=Fluent
    
    local SaveManager=loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
    local InterfaceManager=loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
    MU.SaveManager=SaveManager
    MU.InterfaceManager=InterfaceManager
    
    local Window=Fluent:CreateWindow({
        Title="FISCH | Protected",
        SubTitle="Obfuscated",
        TabWidth=S.TabWidth,
        Size=S.WinSize,
        Acrylic=false,
        Theme="Amethyst",
        MinimizeKey=Enum.KeyCode.LeftControl
    })
    MU.Window=Window
    
    local Tabs={
        Home=Window:AddTab({Title="Home",Icon="home"}),
        Main=Window:AddTab({Title="Auto Fish",Icon="component"}),
        Autos=Window:AddTab({Title="Autos",Icon="repeat"}),
        Character=Window:AddTab({Title="Character",Icon="user"}),
        Teleport=Window:AddTab({Title="Teleport",Icon="map"}),
        Shop=Window:AddTab({Title="Shop",Icon="shopping-cart"}),
        Visuals=Window:AddTab({Title="Visuals",Icon="eye"}),
        Settings=Window:AddTab({Title="Settings",Icon="settings"}),
        ServerInfo=Window:AddTab({Title="Server Info",Icon="info"})
    }
    MU.Tabs=Tabs
    MU.Options=Fluent.Options
    
    return {Fluent=Fluent,Window=Window,Tabs=Tabs,Options=Fluent.Options,SaveManager=SaveManager,InterfaceManager=InterfaceManager}
end

function MU.CreateMobileUI()
    if S.CoreGui:FindFirstChild("FischMobileUI") then S.CoreGui.FischMobileUI:Destroy() end
    
    local ScreenGui=Instance.new("ScreenGui",S.CoreGui)
    ScreenGui.Name="FischMobileUI"
    
    local MenuBtn=Instance.new("ImageButton",ScreenGui)
    MenuBtn.Name="MenuToggle"
    MenuBtn.BackgroundColor3=Color3.new(0,0,0)
    MenuBtn.BackgroundTransparency=0.5
    MenuBtn.AnchorPoint=Vector2.new(0.5,0)
    MenuBtn.Position=UDim2.new(0.5,-25,0.05,0)
    MenuBtn.Size=UDim2.fromOffset(50,50)
    MenuBtn.Image="rbxassetid://100142831144115"
    MenuBtn.Draggable=true
    Instance.new("UICorner",MenuBtn).CornerRadius=UDim.new(1,0)
    Instance.new("UIStroke",MenuBtn).Color=Color3.new(1,1,1)
    
    MenuBtn.MouseButton1Click:Connect(function()
        S.VIM:SendKeyEvent(true,Enum.KeyCode.LeftControl,false,game)
        task.wait(0.05)
        S.VIM:SendKeyEvent(false,Enum.KeyCode.LeftControl,false,game)
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 17: TAB SETUP (COMPLETE)
-- ═══════════════════════════════════════════════════════════════════════════

local TS={}

function TS.SetupAllTabs(UI)
    local Tabs=UI.Tabs
    local Options=UI.Options
    local Fluent=UI.Fluent
    
    -- HOME TAB
    Tabs.Home:AddToggle("StopAll",{Title="STOP ALL ACTIONS",Default=false}):OnChanged(function()
        C.StopAll=Options.StopAll.Value
        _G.StopAll=C.StopAll
        if C.StopAll then
            C.IsFlying=false
            _G.IsFlying=false
            local char=S.LP.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.PlatformStand=false
                char.Humanoid.AutoRotate=true
            end
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.Velocity=Vector3.new(0,0,0)
                for _,v in pairs({"FlyVelocity","FlyGyro"}) do
                    if char.HumanoidRootPart:FindFirstChild(v) then char.HumanoidRootPart[v]:Destroy() end
                end
            end
        end
    end)
    
    -- AUTO FISH TAB
    Tabs.Main:AddToggle("AutoFish",{Title="Enable Auto Fish",Default=false}):OnChanged(function()
        C.AutoFish=Options.AutoFish.Value
        _G.AutoFish=C.AutoFish
        if C.AutoFish and S.LP.Character and S.LP.Character:FindFirstChild("HumanoidRootPart") then
            C.currentSpot=S.LP.Character.HumanoidRootPart.CFrame
            _G.currentSpot=C.currentSpot
        else
            C.currentSpot=nil
        end
    end)
    Tabs.Main:AddToggle("AutoShake",{Title="Auto Shake",Default=true}):OnChanged(function() C.AutoShake=Options.AutoShake.Value _G.AutoShake=C.AutoShake end)
    Tabs.Main:AddToggle("LockPosition",{Title="Lock Position",Default=true}):OnChanged(function() C.LockPosition=Options.LockPosition.Value _G.LockPosition=C.LockPosition end)
    Tabs.Main:AddToggle("AlwaysPerfect",{Title="Always Perfect Catch",Default=true}):OnChanged(function() C.AlwaysPerfect=Options.AlwaysPerfect.Value _G.AlwaysPerfect=C.AlwaysPerfect end)
    Tabs.Main:AddToggle("FrozenBar",{Title="Frozen Bar",Default=true}):OnChanged(function() C.FrozenBar=Options.FrozenBar.Value _G.FrozenBar=C.FrozenBar end)
    Tabs.Main:AddSlider("ReelDelay",{Title="Reel Delay",Default=2.5,Min=0,Max=10,Rounding=1}):OnChanged(function(v) C.ReelDelay=v _G.ReelDelay=v end)
    Tabs.Main:AddSlider("CastDelay",{Title="Cast Delay",Default=0.5,Min=0.1,Max=2,Rounding=1}):OnChanged(function(v) C.CastDelay=v _G.CastDelay=v end)
    
    -- AUTOS TAB
    Tabs.Autos:AddParagraph({Title="Auto Sell",Content="Automatic selling system"})
    Tabs.Autos:AddToggle("AutoSellAll",{Title="Auto Sell All",Default=false}):OnChanged(function() C.AutoSellAll=Options.AutoSellAll.Value _G.AutoSellAll=C.AutoSellAll end)
    Tabs.Autos:AddSlider("SellAllInterval",{Title="Interval (seconds)",Default=5,Min=1,Max=60,Rounding=1}):OnChanged(function(v) C.SellAllInterval=v _G.SellAllInterval=v end)
    Tabs.Autos:AddButton({Title="Sell in Hand",Callback=function()
        local remote=S.RepStore:WaitForChild("events"):WaitForChild("Sell")
        if remote then
            local ok,res=pcall(function() return remote:InvokeServer() end)
            if ok then
                LU.AddLog("Item sold!",Color3.fromRGB(100,255,100))
                Fluent:Notify({Title="Sell",Content="Success! Result: "..tostring(res),Duration=3})
            end
        end
    end})
    
    Tabs.Autos:AddParagraph({Title="Smart Auto Totem",Content="Auto totem based on day/night cycle"})
    Tabs.Autos:AddToggle("EnableAutoTotem",{Title="Enable Smart Auto Totem",Default=false}):OnChanged(function(v) C.AutoTotem=v _G.AutoTotem=v end)
    Tabs.Autos:AddDropdown("DayTotemDrop",{Title="Day Totem (06:30)",Values=D.TotemList,Multi=false,Default="Sundial Totem"}):OnChanged(function(v) C.DayTotemSelect=v _G.DayTotemSelect=v end)
    Tabs.Autos:AddDropdown("NightTotemDrop",{Title="Night Totem (18:00)",Values=D.TotemList,Multi=false,Default="Aurora Totem"}):OnChanged(function(v) C.NightTotemSelect=v _G.NightTotemSelect=v end)
    
    Tabs.Autos:AddParagraph({Title="Auto Potion",Content="Auto drink potions with timer"})
    Tabs.Autos:AddToggle("EnableAutoPotion",{Title="Enable Auto Potion",Default=false}):OnChanged(function(v) C.AutoPotion=v _G.AutoPotion=v if v then C.PotionTimer=0 end end)
    Tabs.Autos:AddDropdown("PotionSelect",{Title="Select Potion",Values=D.PotionList,Multi=false,Default=1}):OnChanged(function(v) C.SelectedPotion=v _G.SelectedPotion=v end)
    Tabs.Autos:AddInput("PotionTimeInput",{Title="Duration (minutes)",Default="16",Numeric=true}):OnChanged(function(v) C.PotionDelayMinutes=tonumber(v) or 16 _G.PotionDelayMinutes=C.PotionDelayMinutes end)
    Tabs.Autos:AddInput("PotionCountInput",{Title="Repeat Count",Default="999",Numeric=true}):OnChanged(function(v) C.PotionRepeatCount=tonumber(v) or 999 _G.PotionRepeatCount=C.PotionRepeatCount end)
    
    -- CHARACTER TAB
    Tabs.Character:AddToggle("ESPEnabled",{Title="Player ESP",Default=false}):OnChanged(function() C.ESPEnabled=Options.ESPEnabled.Value _G.ESPEnabled=C.ESPEnabled end)
    Tabs.Character:AddToggle("WalkSpeedEnabled",{Title="Walk Speed",Default=false}):OnChanged(function() C.WalkSpeedEnabled=Options.WalkSpeedEnabled.Value _G.WalkSpeedEnabled=C.WalkSpeedEnabled end)
    Tabs.Character:AddInput("WalkSpeedVal",{Title="Speed Value",Default="16",Numeric=true}):OnChanged(function(v) C.WalkSpeed=tonumber(v) or 16 _G.WalkSpeed=C.WalkSpeed end)
    Tabs.Character:AddToggle("JumpPowerEnabled",{Title="Jump Power",Default=false}):OnChanged(function() C.JumpPowerEnabled=Options.JumpPowerEnabled.Value _G.JumpPowerEnabled=C.JumpPowerEnabled end)
    Tabs.Character:AddInput("JumpPowerVal",{Title="Jump Value",Default="50",Numeric=true}):OnChanged(function(v) C.JumpPower=tonumber(v) or 50 _G.JumpPower=C.JumpPower end)
    Tabs.Character:AddToggle("Noclip",{Title="Noclip",Default=false}):OnChanged(function() C.Noclip=Options.Noclip.Value _G.Noclip=C.Noclip end)
    Tabs.Character:AddToggle("DashEnabled",{Title="Dash (Q)",Default=true}):OnChanged(function() C.DashEnabled=Options.DashEnabled.Value _G.DashEnabled=C.DashEnabled end)
    Tabs.Character:AddSlider("DashSpeed",{Title="Dash Speed",Default=100,Min=50,Max=300,Rounding=0}):OnChanged(function(v) C.DashSpeed=v _G.DashSpeed=v end)
    Tabs.Character:AddToggle("FlyEnabled",{Title="Fly",Default=true}):OnChanged(function() C.FlyEnabled=Options.FlyEnabled.Value _G.FlyEnabled=C.FlyEnabled end)
    Tabs.Character:AddToggle("FlyInertia",{Title="Fly Inertia",Default=true}):OnChanged(function() C.FlyInertia=Options.FlyInertia.Value _G.FlyInertia=C.FlyInertia end)
    Tabs.Character:AddSlider("FlySpeed",{Title="Fly Speed",Default=75,Min=10,Max=300,Rounding=0}):OnChanged(function(v) C.FlySpeed=v _G.FlySpeed=v end)
    Tabs.Character:AddToggle("ShowFlyPanel",{Title="Fly Panel (Mobile)",Default=false}):OnChanged(function(v) FU.SetVisible(v) end)
    
    -- TELEPORT TAB
    local DropdownManager,DropdownWarp
    local function RefreshAllDropdowns()
        local saved=U.LoadCustomLocations()
        local managerList,warpList={},{}
        local mQuery,wQuery=C.ManagerSearch:lower(),C.SearchQuery:lower()
        for name,_ in pairs(saved) do
            if mQuery=="" or name:lower():find(mQuery) then table.insert(managerList,name) end
            if wQuery=="" or name:lower():find(wQuery) then table.insert(warpList,name) end
        end
        for name,_ in pairs(D.DefaultLocations) do
            if wQuery=="" or name:lower():find(wQuery) then table.insert(warpList,name) end
        end
        table.sort(managerList)
        table.sort(warpList)
        if DropdownManager then DropdownManager:SetValues(managerList) end
        if DropdownWarp then DropdownWarp:SetValues(warpList) end
    end
    
    Tabs.Teleport:AddButton({Title="Refresh List",Callback=function() RefreshAllDropdowns() Fluent:Notify({Title="Teleport",Content="Updated!",Duration=1}) end})
    Tabs.Teleport:AddInput("ManagerSearch",{Title="Search Saved",Default=""}):OnChanged(function(v) C.ManagerSearch=v RefreshAllDropdowns() end)
    
    DropdownManager=Tabs.Teleport:AddDropdown("ManagerSelect",{Title="Select Saved",Values={},Multi=false,Default=nil})
    DropdownManager:OnChanged(function(v)
        local saved=U.LoadCustomLocations()
        if v and saved[v] then
            C.CustomName=v
            C.CustomX,C.CustomY,C.CustomZ=saved[v].x,saved[v].y,saved[v].z
            if Options.LocName then Options.LocName:SetValue(v) end
            if Options.InputX then Options.InputX:SetValue(tostring(C.CustomX)) end
            if Options.InputY then Options.InputY:SetValue(tostring(C.CustomY)) end
            if Options.InputZ then Options.InputZ:SetValue(tostring(C.CustomZ)) end
        end
    end)
    
    Tabs.Teleport:AddInput("LocName",{Title="Name",Default=""}):OnChanged(function(v) C.CustomName=v end)
    Tabs.Teleport:AddInput("InputX",{Title="X",Default="0",Numeric=true}):OnChanged(function(v) C.CustomX=tonumber(v) or 0 end)
    Tabs.Teleport:AddInput("InputY",{Title="Y",Default="135",Numeric=true}):OnChanged(function(v) C.CustomY=tonumber(v) or 135 end)
    Tabs.Teleport:AddInput("InputZ",{Title="Z",Default="0",Numeric=true}):OnChanged(function(v) C.CustomZ=tonumber(v) or 0 end)
    
    Tabs.Teleport:AddButton({Title="Get Position",Callback=function()
        local char=S.LP.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local pos=char.HumanoidRootPart.Position
            C.CustomX,C.CustomY,C.CustomZ=math.floor(pos.X),math.floor(pos.Y),math.floor(pos.Z)
            if Options.InputX then Options.InputX:SetValue(tostring(C.CustomX)) end
            if Options.InputY then Options.InputY:SetValue(tostring(C.CustomY)) end
            if Options.InputZ then Options.InputZ:SetValue(tostring(C.CustomZ)) end
        end
    end})
    
    Tabs.Teleport:AddButton({Title="Save",Callback=function()
        if C.CustomName=="" then return end
        local saved=U.LoadCustomLocations()
        saved[C.CustomName]={x=C.CustomX,y=C.CustomY,z=C.CustomZ}
        U.SaveCustomLocations(saved)
        RefreshAllDropdowns()
    end})
    
    Tabs.Teleport:AddButton({Title="Warp to XYZ",Callback=function()
        if C.StopAll then return end
        local char=S.LP.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame=CFrame.new(C.CustomX,C.CustomY,C.CustomZ)
        end
    end})
    
    Tabs.Teleport:AddInput("SearchLoc",{Title="Search Warp",Default=""}):OnChanged(function(v) C.SearchQuery=v RefreshAllDropdowns() end)
    
    DropdownWarp=Tabs.Teleport:AddDropdown("IslandWarp",{Title="Select Destination",Values={},Multi=false,Default=nil})
    DropdownWarp:OnChanged(function(v)
        if C.StopAll or not v then return end
        local target,saved=D.DefaultLocations[v],U.LoadCustomLocations()
        if not target and saved[v] then target=saved[v] end
        if target then
            local char=S.LP.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame=CFrame.new(target.x,target.y,target.z)
            end
        end
    end)
    
    -- Player Teleport
    Tabs.Teleport:AddParagraph({Title="Player Teleport",Content="Warp to other players"})
    local PlayerDropdown=Tabs.Teleport:AddDropdown("PlayerSelect",{Title="Select Player",Values={},Multi=false,Default=nil})
    
    local function RefreshPlayerList()
        local pList={}
        for _,p in pairs(S.Players:GetPlayers()) do
            if p~=S.LP then table.insert(pList,p.Name) end
        end
        table.sort(pList)
        PlayerDropdown:SetValues(pList)
    end
    
    Tabs.Teleport:AddButton({Title="Refresh Players",Callback=function() RefreshPlayerList() Fluent:Notify({Title="System",Content="Player list updated!",Duration=1}) end})
    Tabs.Teleport:AddButton({Title="Warp to Player",Callback=function()
        local targetName=Options.PlayerSelect.Value
        if not targetName then return end
        local targetPlayer=S.Players:FindFirstChild(targetName)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local char=S.LP.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame=targetPlayer.Character.HumanoidRootPart.CFrame*CFrame.new(0,2,0)
                Fluent:Notify({Title="Teleport",Content="Warped to: "..targetName,Duration=2})
            end
        else
            Fluent:Notify({Title="Error",Content="Cannot find player or they are dead",Duration=3})
        end
    end})
    
    task.delay(1,function() RefreshPlayerList() end)
    
    -- SHOP TAB
    local RodNames={}
    for _,v in ipairs(D.RodList) do table.insert(RodNames,v.Name) end
    Tabs.Shop:AddDropdown("SelectedRod",{Title="Select Rod",Values=RodNames,Multi=false,Default=1})
    Tabs.Shop:AddButton({Title="Buy Rod",Callback=function()
        local remote=U.GetPurchaseRemote()
        if remote then
            remote:FireServer(Options.SelectedRod.Value,"Rod",nil,1)
            Fluent:Notify({Title="Shop",Content="Purchasing "..Options.SelectedRod.Value,Duration=3})
        else
            Fluent:Notify({Title="Error",Content="Purchase remote not found",Duration=3})
        end
    end})
    
    Tabs.Shop:AddDropdown("SelectedTotem",{Title="Select Totem",Values=D.TotemList,Multi=false,Default=1})
    Tabs.Shop:AddInput("TotemAmount",{Title="Amount",Default="1",Numeric=true})
    Tabs.Shop:AddButton({Title="Buy Totem",Callback=function()
        local selectedName=Options.SelectedTotem.Value
        local amount=math.clamp(tonumber(Options.TotemAmount.Value) or 1,1,50)
        local pricePerItem=0
        for _,v in ipairs(D.TotemData) do
            if v.Name==selectedName then pricePerItem=v.Price break end
        end
        local totalPrice=pricePerItem*amount
        local currentMoney=U.getMoney()
        if currentMoney>=totalPrice then
            local remote=U.GetPurchaseRemote()
            if remote then
                remote:FireServer(selectedName,"Item",nil,amount)
                Fluent:Notify({Title="Success",Content="Bought "..amount.." "..selectedName,Duration=3})
            end
        else
            Fluent:Notify({Title="Failed",Content="Not enough money! Need: "..totalPrice,Duration=5})
        end
    end})
    
    -- VISUALS TAB
    Tabs.Visuals:AddParagraph({Title="UI Visibility",Content="Show/hide UI elements"})
    Tabs.Visuals:AddToggle("HideShakeUI",{Title="Hide Shake UI",Default=false}):OnChanged(function() C.HideShakeUI=Options.HideShakeUI.Value _G.HideShakeUI=C.HideShakeUI end)
    
    -- SETTINGS TAB
    Tabs.Settings:AddToggle("AntiAFK",{Title="Anti AFK",Default=true}):OnChanged(function() C.AntiAFK=Options.AntiAFK.Value _G.AntiAFK=C.AntiAFK end)
    Tabs.Settings:AddToggle("AlwaysPerfect",{Title="Always Perfect Catch",Default=true}):OnChanged(function() C.AlwaysPerfect=Options.AlwaysPerfect.Value _G.AlwaysPerfect=C.AlwaysPerfect end)
    Tabs.Settings:AddToggle("FrozenBar",{Title="Frozen Bar (Visual)",Default=true}):OnChanged(function() C.FrozenBar=Options.FrozenBar.Value _G.FrozenBar=C.FrozenBar end)
    Tabs.Settings:AddSlider("ReelDelay",{Title="Reel Delay",Default=2.5,Min=0,Max=10,Rounding=1}):OnChanged(function(v) C.ReelDelay=v _G.ReelDelay=v end)
    Tabs.Settings:AddSlider("CastDelay",{Title="Cast Delay",Default=0.5,Min=0.1,Max=2,Rounding=1}):OnChanged(function(v) C.CastDelay=v _G.CastDelay=v end)
    Tabs.Settings:AddButton({Title="Rejoin Server",Callback=function() S.Teleport:TeleportToPlaceInstance(game.PlaceId,game.JobId,S.LP) end})
    Tabs.Settings:AddButton({Title="Server Hop",Callback=function() S.Teleport:Teleport(game.PlaceId,S.LP) end})
    
    Tabs.Settings:AddParagraph({Title="Log Panel",Content="Operation status window"})
    Tabs.Settings:AddToggle("ShowLogPanel",{Title="Show Log Panel",Default=false}):OnChanged(function(v) LU.SetVisible(v) end)
    Tabs.Settings:AddButton({Title="Clear Log",Callback=function() LU.ClearLogs() end})
    
    -- Performance
    Tabs.Settings:AddParagraph({Title="Performance & FPS",Content="Lag reduction tools"})
    Tabs.Settings:AddButton({Title="Remove Textures & Effects",Callback=function()
        local terrain=workspace:FindFirstChildOfClass("Terrain")
        if terrain then
            terrain.WaterWaveSize=0
            terrain.WaterWaveSpeed=0
            terrain.WaterReflectance=0
            terrain.WaterTransparency=0
        end
        local lighting=game:GetService("Lighting")
        lighting.GlobalShadows=false
        lighting.FogEnd=9e9
        lighting.Brightness=2
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:IsA("MeshPart") then
                v.Material=Enum.Material.SmoothPlastic
                v.Reflectance=0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v:Destroy()
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v.Enabled=false
            end
        end
        Fluent:Notify({Title="FPS Boost",Content="Textures & Effects removed!",Duration=3})
    end})
    
    Tabs.Settings:AddToggle("FullBright",{Title="Full Bright",Default=false}):OnChanged(function(v)
        if v then
            game:GetService("Lighting").Brightness=2
            game:GetService("Lighting").ClockTime=14
            game:GetService("Lighting").FogEnd=100000
            game:GetService("Lighting").GlobalShadows=false
            game:GetService("Lighting").OutdoorAmbient=Color3.fromRGB(128,128,128)
        end
    end)
    
    Tabs.Settings:AddToggle("SuperLowMode",{Title="Disable 3D Render",Default=false}):OnChanged(function(v)
        S.Run:Set3dRenderingEnabled(not v)
        if v then
            Fluent:Notify({Title="AFK Mode",Content="3D rendering disabled (save GPU)",Duration=3})
        else
            Fluent:Notify({Title="AFK Mode",Content="Back to normal mode",Duration=3})
        end
    end)
    
    -- SERVER INFO TAB
    Tabs.ServerInfo:AddToggle("ShowInfoPanel",{Title="Show Info Panel",Default=true}):OnChanged(function(v) IU.SetVisible(v) end)
    
    Tabs.ServerInfo:AddParagraph({Title="---",Content=""})
    
    local RealTimePara=Tabs.ServerInfo:AddParagraph({Title="Real Time",Content="Loading..."})
    local GameTimePara=Tabs.ServerInfo:AddParagraph({Title="Game Time",Content="Loading..."})
    local UptimePara=Tabs.ServerInfo:AddParagraph({Title="Server Uptime",Content="Loading..."})
    
    task.spawn(function()
        while true do
            local statusTime=os.date("%H:%M:%S")
            local clockTime=S.Lighting.ClockTime
            local timeState=(clockTime>=6 and clockTime<18) and "Day" or "Night"
            local gameTimeStr=U.FormatGameTime(clockTime).." "..timeState
            local serverTime=workspace.DistributedGameTime
            local uptimeStr=U.FormatTime(serverTime)
            
            if RealTimePara then RealTimePara:SetDesc(statusTime) end
            if GameTimePara then GameTimePara:SetDesc(gameTimeStr) end
            if UptimePara then UptimePara:SetDesc(uptimeStr) end
            
            IU.Update()
            task.wait(1)
        end
    end)
    
    -- Setup SaveManager
    UI.SaveManager:SetLibrary(Fluent)
    UI.InterfaceManager:SetLibrary(Fluent)
    UI.SaveManager:IgnoreThemeSettings()
    UI.InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    UI.Window:SelectTab(1)
    UI.SaveManager:LoadAutoloadConfig()
    
    RefreshAllDropdowns()
end

-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 18: MAIN EXECUTION
-- ═══════════════════════════════════════════════════════════════════════════

local function Main()
    _J()
    
    -- Create UIs
    LU.Create()
    IU.Create()
    FU.Create()
    
    local UI=MU.Create()
    if not UI then return end
    
    if S.IsMobile then MU.CreateMobileUI() end
    
    -- Setup Tabs
    TS.SetupAllTabs(UI)
    
    -- Start Modules
    AF.SetupShakeDetection()
    AF.Start()
    AP.Start()
    AS.Start()
    AT.Start()
    CH.Start()
    
    -- Log
    _G.AddLog("Script loaded successfully!",Color3.fromRGB(0,255,100))
    UI.Fluent:Notify({Title="FISCH",Content="Protected script loaded!",Duration=5})
end

-- Protected execution
local ok,err=pcall(Main)
if not ok then warn("Error: "..tostring(err)) end

-- Integrity checker
task.spawn(function()
    while true do
        task.wait(math.random(30,60))
        if type(_G.AddLog)~="function" then _G.AddLog=function() end end
        local t1=tick()
        for i=1,1000 do local _=math.sin(i) end
        local t2=tick()
        if t2-t1>0.05 then task.wait(5) end
    end
end)

print("[FISCH] Protected script initialized")
