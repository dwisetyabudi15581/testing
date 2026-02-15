--[[
    ╔═══════════════════════════════════════════════════════════╗
    ║                    FISCH SCRIPT LOADER                     ║
    ║                                                            ║
    ║   Cara Pakai:                                              ║
    ║   1. Upload complete_obfuscated_fisch.lua ke GitHub        ║
    ║   2. Rename menjadi script.lua                             ║
    ║   3. Ganti URL di bawah dengan URL raw Anda                ║
    ║   4. Copy seluruh kode ini ke executor                     ║
    ╚═══════════════════════════════════════════════════════════╝
]]

-- ═══════════════════════════════════════════════════════════════
-- PASTE URL RAW GITHUB ANDA DI SINI
-- ═══════════════════════════════════════════════════════════════

local URL = "https://raw.githubusercontent.com/USERNAME/fisch-script/main/script.lua"

-- ═══════════════════════════════════════════════════════════════
-- JANGAN UBAH KODE DI BAWAH INI
-- ═══════════════════════════════════════════════════════════════

local function notify(title, text)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = 5
        })
    end)
end

notify("FISCH", "Loading script...")

local success, result = pcall(function()
    return game:HttpGet(URL)
end)

if not success or not result then
    notify("FISCH Error", "Failed to fetch script!")
    return
end

local execSuccess, execError = pcall(function()
    loadstring(result)()
end)

if execSuccess then
    notify("FISCH", "Script loaded!")
else
    notify("FISCH Error", tostring(execError))
end
