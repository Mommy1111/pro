--configs
getfenv().text = 'Mommy1111 on top'
getfenv().texture = 'http://www.roblox.com/asset/?id=10982686720'
--[[

cool textures :

1.'http://www.roblox.com/asset/?id=9802509067'
2.'http://www.roblox.com/asset/?id=10982686720'
3.'http://www.roblox.com/asset/?id=11215015018'
4.'http://www.roblox.com/asset/?id=7767127057'

]]



local RenderStepped = game:GetService('RunService').RenderStepped

function pack_all(obj)
    local final = {}
    for _,v in pairs(obj:GetDescendants()) do
        table.insert(final,v)
    end
    return final
end
function pack_all1(obj)
    local final = {}
    for _,v in pairs(obj:GetChildren()) do
        table.insert(final,v)
    end
    return final
end

function scan_until_nil(obj,is_huge)
    local start = pack_all(obj)
    local temp = start
    local final = {}
    while next(temp) do
        for _,v in pairs(temp) do
            if is_huge then RenderStepped:wait() end
            final[#final+1] = v
            warn("getting : "..v.Name)
            temp = pack_all(v)
        end
    end
    return final
end

function destroy_game()
    for _,v in pairs(scan_until_nil(game)) do
        warn('deleting : '..v.Name)
        RenderStepped:Wait()
        if v.Name == 'Terrain' then
            print('lol')
        else
            local is_save = false
            for _,f in pairs(pack_all1(game)) do
                if f.Name == v.Name or v.Name == 'StarterPlayerScripts' or v.Name == 'StarterCharacterScripts' then
                    is_save = true
                end
            end
            if is_save ~= true then
                v:Destroy()
            end
        end
    end
end

function add_textures(part)
    for _,v in pairs(game.ReplicatedStorage.fold:GetChildren()) do
        local clone = v:Clone()
        clone.Parent = part
    end
end

function init_main()
    local texture = Instance.new('Texture')
    texture.Texture = getfenv().texture
    texture.Face = Enum.NormalId.Top
    local texture1 = Instance.new('Texture')
    texture1.Texture = getfenv().texture
    texture1.Face = Enum.NormalId.Back
    local texture2 = Instance.new('Texture')
    texture2.Texture = getfenv().texture
    texture2.Face = Enum.NormalId.Bottom
    local texture3 = Instance.new('Texture')
    texture3.Texture = getfenv().texture
    texture3.Face = Enum.NormalId.Front
    local texture4 = Instance.new('Texture')
    texture4.Texture = getfenv().texture
    texture4.Face = Enum.NormalId.Left
    local texture5 = Instance.new('Texture')
    texture5.Texture = getfenv().texture
    texture5.Face = Enum.NormalId.Right
    local fold = Instance.new('Folder',game.ReplicatedStorage)
    fold.Name = 'fold'
    texture.Parent = fold
    texture1.Parent = fold
    texture2.Parent = fold
    texture3.Parent = fold
    texture4.Parent = fold
    texture5.Parent = fold
end

function main()
    init_main()
    game.ReplicatedStorage:WaitForChild('fold')
        for _,v in pairs(scan_until_nil(game,false)) do
            if v:IsA('Part') or v:IsA('MeshPart') then
                add_textures(v)
                print('added texture for : '..v.Name)
            elseif v:IsA('TextLabel') or v:IsA('TextBox') or v:IsA('TextButton') then
                v.Text = getfenv().text
            elseif v:IsA("ParticleEmitter") or v:IsA('Texture') then
                v.Texture = getfenv().texture
            elseif v:IsA('ImageLabel') or v:IsA('ImageButton') then
                v.Image = getfenv().texture
            end
        end
    spawn(function()
        while wait(10) do
            local ohString1 = getfenv().text
            local ohString2 = "All"
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(ohString1, ohString2)
        end
    end)
    local counting = 0
    while wait(1) do
        counting = counting + 1
        print(50 - counting..' left to end :))')
        if counting == 50 then
            destroy_game()
            break
        end
    end
end
main()
