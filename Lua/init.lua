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
