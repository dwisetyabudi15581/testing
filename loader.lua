-- UNIVERSAL LOADER
local url = "https://raw.githubusercontent.com/dwisetyabudi15581/testing/main/script.lua"

local function GetHttp()
    local funcs = {
        function() return game:HttpGet(url) end,
        function() return game:HttpGetAsync(url) end,
        function() return http_request({Url=url, Method="GET"}).Body end,
        function() return request({Url=url, Method="GET"}).Body end,
        function() return http.get(url) end,
    }
    for _, fn in ipairs(funcs) do
        local ok, r = pcall(fn)
        if ok and r and r ~= "" then return r end
    end
    return nil
end

local code = GetHttp()
if code then
    loadstring(code)()
else
    warn("HTTP gagal!")
end
