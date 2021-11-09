local function f(x,y,z)
    local sigma = 3
    local rho =26.5
    local beta = 1
    return {sigma*(y-x), -x*z + rho*x - y, x*y - beta*z}
end

local function print_lorAttrWithEulerMethod(h, npoints, iter, var, option)
    
    if var == nil then 
        var = {} 
    --else
        --print("returning "..var[#var]["x"])
    end

    local x0 = 0.0
    local y0 = 1.0
    local z0 = 0.0

    if option~=[[]] then
        tex.sprint("\\addplot3["..option.."] coordinates{")
    else
        tex.sprint("\\addplot3 coordinates{")
    end
    
    local z = z0 + (math.random()-0.5)/2
    local y = y0 + (math.random()-0.5)/2
    local x = x0 + (math.random()-0.5)/2
    if iter<1 then
        for i=1, 100 do
            local m = f(x,y,z)
            x = x + h *m[1]
            y = y + h *m[2]
            z = z + h *m[3]
        end
    end

    npointsOrg = npoints
    npoints = iter*npoints+npoints
    for i=1, npoints do
        if npoint == npointsOrg or i>= npoints - npointsOrg then
            local m = f(x,y,z)
            x = x + h *m[1]
            y = y + h *m[2]
            z = z + h *m[3]
            var[i]={["x"]=x, ["y"]=y, ["z"]=z}
        else
            x = var[i]["x"]
            y = var[i]["y"]
            z = var[i]["z"]
        end
        --print(x)
        --print("cur "..var[i]["x"])
        tex.sprint("("..x..","..y..","..z..")")
    end
    tex.sprint("};")
    return var
end
return { LorenzAttractor = print_lorAttrWithEulerMethod }
