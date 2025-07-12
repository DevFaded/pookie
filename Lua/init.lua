getgenv().identifyexecutor = function()
    return "ParadiseWRD"
end

getgenv().getexecutorname = function()
    return "ParadiseWRD"
end

getgenv().getcallingscript = function()
    local info = debug.getinfo(3, "f") 
    if not info or not info.func then return nil end
    local func = info.func
    for i = 1, 10 do
        local name, value = debug.getupvalue(func, i)
        if name == "script" and typeof(value) == "Instance" and 
           (value:IsA("Script") or value:IsA("LocalScript") or value:IsA("ModuleScript")) then
            return value
        end
    end
    return nil
end

getgenv().compareinstances = function(object1, object2)
    if not (typeof(object1) == "Instance" and typeof(object2) == "Instance") then
        return false
    end
    return object1:GetDebugId() == object2:GetDebugId()
end

getgenv().firetouchtransmitter = function(part1, part2)
    firetouchinterest(part1, part2, 0)
    task.wait(0.05)
    firetouchinterest(part1, part2, 1)
end

getgenv().isluaclosure = function(fn)
    if typeof(fn) ~= "function" then return false end
    local info = debug.getinfo(fn)
    return info and info.what == "Lua"
end

getgenv().base64encode = function(d)
    return ((d:gsub(".", function(x)
        local r, n = "", x:byte()
        for i = 7, 0, -1 do
            r = r .. (math.floor(n / 2^i) % 2 == 1 and "1" or "0")
        end
        return r
    end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
        if #x < 6 then return "" end
        return ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"):sub(tonumber(x, 2)+1, tonumber(x, 2)+1)
    end) .. ({ "", "==", "=" })[#d % 3 + 1])
end

getgenv().base64decode = function(d)
    local bin = d:gsub("[^A-Za-z0-9+/]", ""):gsub(".", function(x)
        local i = ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"):find(x) - 1
        local r = ""
        for j = 5, 0, -1 do
            r = r .. (math.floor(i / 2^j) % 2 == 1 and "1" or "0")
        end
        return r
    end)
    local bytes = {}
    for i = 1, #bin - (#bin % 8), 8 do
        local chunk = bin:sub(i, i+7)
        table.insert(bytes, string.char(tonumber(chunk, 2)))
    end
    return table.concat(bytes)
end
