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

getgenv().isluaclosure = function(fn)
    if typeof(fn) ~= "function" then return false end
    local info = debug.getinfo(fn)
    return info and info.what == "Lua"
end

