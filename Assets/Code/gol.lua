local function runGolRules(dimx, dimy, mat)
    for n=0,dimx do
        for m=0, dimy do
            if n == 0 then
                left = dimx
                right = n + 1
            elseif n == dimx then
                left = n-1
                right = 1

            else
                left = n-1
                right = n+1
            end
            if m == 0 then
                down = dimy
                up = m + 1
            elseif m == dimy then
                down = m-1
                up = 1

            else
                down = m-1
                up = m+1
            end
            --print(left, right, down, up)
            neighb = mat[left][m]+mat[left][up]+mat[left][down]+mat[n][up]+mat[n][down]+mat[right][up]+mat[right][down]+mat[right][m]
            if mat[n][m] == 1 and (neighb == 2 or neighb == 3) then
                mat[n][m] = 1
            elseif mat[n][m] == 0 and neighb == 3 then
                mat[n][m] = 1
            else
                mat[n][m] = 0
            end
        end
    end
    return mat
end

local function print_scatterPop(dimx, dimy, mat, option)
    if option == nil then 
        option = ""
    end
    if mat == nil then
        mat={}
        math.randomseed( os.time() )
        math.random()
        math.random()
        math.random()
        for n=0,dimx do
            mat[n] = {}
            for m=0, dimy do
                mat[n][m]=math.random(2)-1
                --print(n,m,mat[n][m])
            end
        end
    end
    if option~=[[]] then
        tex.print("\\addplot[matrix plot*, mesh/cols="..dimx..", point meta=explicit, "..option.."] table[meta=z]{")
    else
        tex.print("\\addplot[matrix plot*, mesh/cols="..dimx..", point meta=explicit] table[meta=z]{")
    end
    mat = runGolRules(dimx,dimy, mat)
    --print("startPrint")
    tex.print("x y z ")
    for n=0,dimx-1 do
        for m=0, dimy-1 do
                tex.print(n.." "..m.." "..mat[n][m])
                --print(n.." "..m.." "..mat[n][m])
                --print(n,m,mat[n][m])
        end
    end
    tex.sprint("};")
    return mat
end

local function print_popCount(count, mat, dimx, dimy, iter, option)
    if count == nil then
        count = {}
    end
    count[iter] = 0
    if option == nil then 
        option = ""
    end
    if option~=[[]] then
        tex.sprint("\\addplot["..option.."] coordinates{")
    else
        tex.sprint("\\addplot coordinates{")
    end
    mat = runGolRules(dimx,dimy, mat)
    --print("startPrint")
    if iter>0 then
        for n=0,iter-1 do
            tex.sprint("("..n..","..count[n]..")")
            print(n, count[n])
        end
    end
    for n=0,dimx do
        for m=0, dimy do
            if mat[n][m] == 1 then
                count[iter] = count[iter]+1
            end
        end
    end
    print(iter, count[iter])
    tex.sprint("("..iter..","..count[iter]..")")
    tex.sprint("};")
    return count
end

--var = print_scatterPop(50,50,var)
return { golRun = print_scatterPop, golTot = print_popCount}
