-- [[ ZOKO LOADER V2 - نظام التحقق المحسن ]] --

-- 1. رابط حالة السكربت (بدون أكواد مجمدة، يسحب من الـ main مباشرة)
local Status_URL = "https://raw.githubusercontent.com/Ray2133231/Zoko/main/a23.lua" 

-- 2. رابط الكود الأساسي 
local CoreScript_URL = "https://raw.githubusercontent.com/Ray2133231/Zoko2/main/main.lua"

local function LoadZoko()
    -- كاسر الكاش (عشان الإكستكيوتور ما يحفظ النسخة القديمة إذا طفيته أو شغلته)
    local CacheBuster = "?t=" .. tostring(tick())
    
    local success, status = pcall(function()
        return game:HttpGet(Status_URL .. CacheBuster)
    end)

    if success then
        -- نستخدم string.find مع string.upper عشان لو كتبت on أو ON يشتغل وما يدقق عالحروف
        if string.find(string.upper(status), "ON") then
            print("[Zoko] Status: ONLINE - Loading Engine...")
            
            -- سحب الكود الأساسي مع كاسر الكاش
            local coreSuccess, coreCode = pcall(function()
                return game:HttpGet(CoreScript_URL .. CacheBuster)
            end)
            
            if coreSuccess then
                -- تشغيل الكود الأساسي والتقاط أي أخطاء فيه
                local loadFunc, loadError = loadstring(coreCode)
                if loadFunc then
                    loadFunc()
                else
                    warn("❌ [Zoko] خطأ في الكود الأساسي:", loadError)
                    game.Players.LocalPlayer:Kick("❌ السكربت الأساسي فيه خطأ برمجي، افتح F9 للتفاصيل.")
                end
            else
                warn("❌ [Zoko] فشل في سحب الكود الأساسي.")
            end
        else
            -- إذا كان مكتوب OFF أو أي شيء ثاني
            game.Players.LocalPlayer:Kick("❌ السكربت متوقف حالياً من قبل المطور (Zoko) للصيانة أو التحديث.")
        end
    else
        game.Players.LocalPlayer:Kick("❌ فشل الاتصال بسيرفر التحقق. تأكد من اتصالك بالإنترنت.")
    end
end

LoadZoko()
