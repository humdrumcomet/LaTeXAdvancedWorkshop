local function f(x,y,z)
    local sigma = 3
    local rho =26.5
    local beta = 1
    return {sigma*(y-x), -x*z + rho*x - y, x*y - beta*z}
end



local function print_lorAttrWithEulerMethod(h, npoints, option)
    local x0 = 0.0
    local y0 = 1.0
    local z0 = 0.0

    local z = z0 + (math.random()-0.5)/2
    local y = y0 + (math.random()-0.5)/2
    local x = x0 + (math.random()-0.5)/2
    if option~=[[]] then
        tex.sprint("\\addplot3["..option.."] coordinates{")
    else
        tex.sprint("\\addplot3 coordinates{")
    end
    
    for i=1, 100 do
        local m = f(x,y,z)
        x = x + h *m[1]
        y = y + h *m[2]
        z = z + h *m[3]
    end
    for i=1, npoints do
        local m = f(x,y,z)
        x = x + h *m[1]
        y = y + h *m[2]
        z = z + h *m[3]
        tex.sprint("("..x..","..y..","..z..")")
    end
    tex.sprint("};")
    --return {x, y, z}
end
return { LorenzAttractor = print_lorAttrWithEulerMethod }
