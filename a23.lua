-- [[ ZOKO LOADER - نظام التحقق ]] --

-- 1. رابط حالة السكربت (حط رابط Pastebin Raw اللي مكتوب فيه ON أو OFF)
local Status_URL = "https://raw.githubusercontent.com/Ray2133231/Zoko/0d6a2a48e605c97d0676b9b48e376b917a348a79/a23.lua" 

-- 2. رابط الكود الأساسي (الملف الثاني - يفضل يكون مشفر وما تعطيه لأحد مباشرة)
local CoreScript_URL = "https://raw.githubusercontent.com/Ray2133231/Zoko2/refs/heads/main/main.lua"

local function LoadZoko()
    local success, status = pcall(function()
        return game:HttpGet(Status_URL)
    end)

    if success then
        if string.match(status, "ON") then
            -- إذا السكربت شغال، يتم استدعاء الكود الأساسي
            print("[Zoko] Status: ONLINE - Loading Engine...")
            loadstring(game:HttpGet(CoreScript_URL))()
        else
            -- إذا السكربت طافي
            game.Players.LocalPlayer:Kick("❌ السكربت متوقف حالياً من قبل المطور (Zoko) للصيانة أو التحديث.")
        end
    else
        game.Players.LocalPlayer:Kick("❌ فشل الاتصال بسيرفر التحقق. تأكد من اتصالك بالإنترنت.")
    end
end

LoadZoko()
