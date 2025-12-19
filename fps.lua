if not getgenv().FPSBoost then
    getgenv().FPSBoost = {}
end

if not getgenv().FPSBoost.Ignore then
    getgenv().FPSBoost.Ignore = {}
end

if not game:IsLoaded() then
    repeat
        task.wait()
    until game:IsLoaded()
end
if not getgenv().FPSBoost.Settings then
    getgenv().FPSBoost.Settings = {
        Players = {
            ["Ignore Me"] = true,
            ["Ignore Others"] = true,
            ["Ignore Tools"] = true
        },
        Meshes = {
            NoMesh = false,
            NoTexture = false,
            Destroy = false
        },
        Images = {
            Invisible = true,
            Destroy = false
        },
        Explosions = {
            Smaller = true,
            Invisible = false,
            Destroy = false
        },
        Particles = {
            Invisible = true,
            Destroy = false
        },
        TextLabels = {
            LowerQuality = false,
            Invisible = false,
            Destroy = false
        },
        MeshParts = {
            LowerQuality = true,
            Invisible = false,
            NoTexture = false,
            NoMesh = false,
            Destroy = false
        },
        Other = {
            ["FPS Cap"] = true,
            ["No Camera Effects"] = true,
            ["No Clothes"] = true,
            ["Low Water Graphics"] = true,
            ["No Shadows"] = true,
            ["Low Rendering"] = true,
            ["Low Quality Parts"] = true,
            ["Low Quality Models"] = true,
            ["Reset Materials"] = true,
            ["Lower Quality MeshParts"] = true,
            ClearNilInstances = false
        }
    }
end
local Players, Lighting, StarterGui, MaterialService = cloneref(game:GetService("Players")), cloneref(game:GetService("Lighting")), cloneref(game:GetService("StarterGui")), cloneref(game:GetService("MaterialService"))
local ME, CanBeEnabled = Players.LocalPlayer, {"ParticleEmitter", "Trail", "Smoke", "Fire", "Sparkles"}
local function PartOfCharacter(Inst)
    for i, v in pairs(Players:GetPlayers()) do
        if v ~= ME and v.Character and Inst:IsDescendantOf(v.Character) then
            return true
        end
    end
    return false
end
local function DescendantOfIgnore(Inst)
    for i, v in pairs(getgenv().FPSBoost.Ignore) do
        if Inst:IsDescendantOf(v) then
            return true
        end
    end
    return false
end
local function CheckIfBad(Inst)
    if not Inst:IsDescendantOf(Players) and (getgenv().FPSBoost.Settings.Players["Ignore Others"] and not PartOfCharacter(Inst) 
    or not getgenv().FPSBoost.Settings.Players["Ignore Others"]) and (getgenv().FPSBoost.Settings.Players["Ignore Me"] and ME.Character and not Inst:IsDescendantOf(ME.Character) 
    or not getgenv().FPSBoost.Settings.Players["Ignore Me"]) and (getgenv().FPSBoost.Settings.Players["Ignore Tools"] and not Inst:IsA("BackpackItem") and not Inst:FindFirstAncestorWhichIsA("BackpackItem") 
    or not getgenv().FPSBoost.Settings.Players["Ignore Tools"]) and (getgenv().FPSBoost.Ignore and not table.find(getgenv().FPSBoost.Ignore, Inst) and not DescendantOfIgnore(Inst) 
    or (not getgenv().FPSBoost.Ignore or type(getgenv().FPSBoost.Ignore) ~= "table" or #getgenv().FPSBoost.Ignore <= 0)) then
        if Inst:IsA("DataModelMesh") then
            if Inst:IsA("SpecialMesh") then
                if getgenv().FPSBoost.Settings.Meshes.NoMesh then
                    Inst.MeshId = ""
                end
                if getgenv().FPSBoost.Settings.Meshes.NoTexture then
                    Inst.TextureId = ""
                end
            end
            if getgenv().FPSBoost.Settings.Meshes.Destroy or getgenv().FPSBoost.Settings["No Meshes"] then
                Inst:Destroy()
            end
        elseif Inst:IsA("FaceInstance") then
            if getgenv().FPSBoost.Settings.Images.Invisible then
                Inst.Transparency = 1
                Inst.Shiny = 1
            end
            if getgenv().FPSBoost.Settings.Images.LowDetail then
                Inst.Shiny = 1
            end
            if getgenv().FPSBoost.Settings.Images.Destroy then
                Inst:Destroy()
            end
        elseif Inst:IsA("ShirtGraphic") then
            if getgenv().FPSBoost.Settings.Images.Invisible then
                Inst.Graphic = ""
            end
            if getgenv().FPSBoost.Settings.Images.Destroy then
                Inst:Destroy()
            end
        elseif table.find(CanBeEnabled, Inst.ClassName) then
            if getgenv().FPSBoost.Settings["Invisible Particles"] or getgenv().FPSBoost.Settings["No Particles"] or (getgenv().FPSBoost.Settings.Other and getgenv().FPSBoost.Settings.Other["Invisible Particles"]) or (getgenv().FPSBoost.Settings.Particles and getgenv().FPSBoost.Settings.Particles.Invisible) then
                Inst.Enabled = false
            end
            if (getgenv().FPSBoost.Settings.Other and getgenv().FPSBoost.Settings.Other["No Particles"]) or (getgenv().FPSBoost.Settings.Particles and getgenv().FPSBoost.Settings.Particles.Destroy) then
                Inst:Destroy()
            end
        elseif Inst:IsA("PostEffect") and (getgenv().FPSBoost.Settings["No Camera Effects"] or (getgenv().FPSBoost.Settings.Other and getgenv().FPSBoost.Settings.Other["No Camera Effects"])) then
            Inst.Enabled = false
        elseif Inst:IsA("Explosion") then
            if getgenv().FPSBoost.Settings["Smaller Explosions"] or (getgenv().FPSBoost.Settings.Other and getgenv().FPSBoost.Settings.Other["Smaller Explosions"]) or (getgenv().FPSBoost.Settings.Explosions and getgenv().FPSBoost.Settings.Explosions.Smaller) then
                Inst.BlastPressure = 1
                Inst.BlastRadius = 1
            end
            if getgenv().FPSBoost.Settings["Invisible Explosions"] or (getgenv().FPSBoost.Settings.Other and getgenv().FPSBoost.Settings.Other["Invisible Explosions"]) or (getgenv().FPSBoost.Settings.Explosions and getgenv().FPSBoost.Settings.Explosions.Invisible) then
                Inst.BlastPressure = 1
                Inst.BlastRadius = 1
                Inst.Visible = false
            end
            if getgenv().FPSBoost.Settings["No Explosions"] or (getgenv().FPSBoost.Settings.Other and getgenv().FPSBoost.Settings.Other["No Explosions"]) or (getgenv().FPSBoost.Settings.Explosions and getgenv().FPSBoost.Settings.Explosions.Destroy) then
                Inst:Destroy()
            end
        elseif Inst:IsA("Clothing") or Inst:IsA("SurfaceAppearance") or Inst:IsA("BaseWrap") then
            if getgenv().FPSBoost.Settings["No Clothes"] or (getgenv().FPSBoost.Settings.Other and getgenv().FPSBoost.Settings.Other["No Clothes"]) then
                Inst:Destroy()
            end
        elseif Inst:IsA("BasePart") and not Inst:IsA("MeshPart") then
            if getgenv().FPSBoost.Settings["Low Quality Parts"] or (getgenv().FPSBoost.Settings.Other and getgenv().FPSBoost.Settings.Other["Low Quality Parts"]) then
                Inst.Material = Enum.Material.Plastic
                Inst.Reflectance = 0
            end
        elseif Inst:IsA("TextLabel") and Inst:IsDescendantOf(workspace) then
            if getgenv().FPSBoost.Settings["Lower Quality TextLabels"] or (getgenv().FPSBoost.Settings.Other and getgenv().FPSBoost.Settings.Other["Lower Quality TextLabels"]) or (getgenv().FPSBoost.Settings.TextLabels and getgenv().FPSBoost.Settings.TextLabels.LowerQuality) then
                Inst.Font = Enum.Font.SourceSans
                Inst.TextScaled = false
                Inst.RichText = false
                Inst.TextSize = 14
            end
            if getgenv().FPSBoost.Settings["Invisible TextLabels"] or (getgenv().FPSBoost.Settings.Other and getgenv().FPSBoost.Settings.Other["Invisible TextLabels"]) or (getgenv().FPSBoost.Settings.TextLabels and getgenv().FPSBoost.Settings.TextLabels.Invisible) then
                Inst.Visible = false
            end
            if getgenv().FPSBoost.Settings["No TextLabels"] or (getgenv().FPSBoost.Settings.Other and getgenv().FPSBoost.Settings.Other["No TextLabels"]) or (getgenv().FPSBoost.Settings.TextLabels and getgenv().FPSBoost.Settings.TextLabels.Destroy) then
                Inst:Destroy()
            end
        elseif Inst:IsA("Model") then
            if getgenv().FPSBoost.Settings["Low Quality Models"] or (getgenv().FPSBoost.Settings.Other and getgenv().FPSBoost.Settings.Other["Low Quality Models"]) then
                Inst.LevelOfDetail = 1
            end
        elseif Inst:IsA("MeshPart") then
            if getgenv().FPSBoost.Settings["Low Quality MeshParts"] or (getgenv().FPSBoost.Settings.Other and getgenv().FPSBoost.Settings.Other["Low Quality MeshParts"]) or (getgenv().FPSBoost.Settings.MeshParts and getgenv().FPSBoost.Settings.MeshParts.LowerQuality) then
                Inst.RenderFidelity = 2
                Inst.Reflectance = 0
                Inst.Material = Enum.Material.Plastic
            end
            if getgenv().FPSBoost.Settings["Invisible MeshParts"] or (getgenv().FPSBoost.Settings.Other and getgenv().FPSBoost.Settings.Other["Invisible MeshParts"]) or (getgenv().FPSBoost.Settings.MeshParts and getgenv().FPSBoost.Settings.MeshParts.Invisible) then
                Inst.Transparency = 1
                Inst.RenderFidelity = 2
                Inst.Reflectance = 0
                Inst.Material = Enum.Material.Plastic
            end
            if getgenv().FPSBoost.Settings.MeshParts and getgenv().FPSBoost.Settings.MeshParts.NoTexture then
                Inst.TextureID = ""
            end
            if getgenv().FPSBoost.Settings.MeshParts and getgenv().FPSBoost.Settings.MeshParts.NoMesh then
                Inst.MeshId = ""
            end
            if getgenv().FPSBoost.Settings["No MeshParts"] or (getgenv().FPSBoost.Settings.Other and getgenv().FPSBoost.Settings.Other["No MeshParts"]) or (getgenv().FPSBoost.Settings.MeshParts and getgenv().FPSBoost.Settings.MeshParts.Destroy) then
                Inst:Destroy()
            end
        end
    end
end
coroutine.wrap(pcall)(function()
    if (getgenv().FPSBoost.Settings["Low Water Graphics"] or (getgenv().FPSBoost.Settings.Other and getgenv().FPSBoost.Settings.Other["Low Water Graphics"])) then
        local terrain = workspace:FindFirstChildOfClass("Terrain")
        if not terrain then
            repeat
                task.wait()
            until workspace:FindFirstChildOfClass("Terrain")
            terrain = workspace:FindFirstChildOfClass("Terrain")
        end
        terrain.WaterWaveSize = 0
        terrain.WaterWaveSpeed = 0
        terrain.WaterReflectance = 0
        terrain.WaterTransparency = 0
        if sethiddenproperty then
            sethiddenproperty(terrain, "Decoration", false)
        end
    end
end)
coroutine.wrap(pcall)(function()
    if getgenv().FPSBoost.Settings["No Shadows"] or (getgenv().FPSBoost.Settings.Other and getgenv().FPSBoost.Settings.Other["No Shadows"]) then
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.ShadowSoftness = 0
        if sethiddenproperty then
            sethiddenproperty(Lighting, "Technology", 2)
        end
    end
end)
coroutine.wrap(pcall)(function()
    if getgenv().FPSBoost.Settings["Low Rendering"] or (getgenv().FPSBoost.Settings.Other and getgenv().FPSBoost.Settings.Other["Low Rendering"]) then
        settings().Rendering.QualityLevel = 1
        settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
    end
end)
coroutine.wrap(pcall)(function()
    if getgenv().FPSBoost.Settings["Reset Materials"] or (getgenv().FPSBoost.Settings.Other and getgenv().FPSBoost.Settings.Other["Reset Materials"]) then
        for i, v in pairs(MaterialService:GetChildren()) do
            v:Destroy()
        end
        MaterialService.Use2022Materials = false
    end
end)
coroutine.wrap(pcall)(function()
    if getgenv().FPSBoost.Settings["FPS Cap"] or (getgenv().FPSBoost.Settings.Other and getgenv().FPSBoost.Settings.Other["FPS Cap"]) then
        if setfpscap then
            if type(getgenv().FPSBoost.Settings["FPS Cap"] or (getgenv().FPSBoost.Settings.Other and getgenv().FPSBoost.Settings.Other["FPS Cap"])) == "string" or type(getgenv().FPSBoost.Settings["FPS Cap"] or (getgenv().FPSBoost.Settings.Other and getgenv().FPSBoost.Settings.Other["FPS Cap"])) == "number" then
                setfpscap(tonumber(getgenv().FPSBoost.Settings["FPS Cap"] or (getgenv().FPSBoost.Settings.Other and getgenv().FPSBoost.Settings.Other["FPS Cap"])))
            elseif getgenv().FPSBoost.Settings["FPS Cap"] or (getgenv().FPSBoost.Settings.Other and getgenv().FPSBoost.Settings.Other["FPS Cap"]) == true then
                setfpscap(1e6)
            end
        end
    end
end)
coroutine.wrap(pcall)(function()
    if getgenv().FPSBoost.Settings.Other["ClearNilInstances"] then
        if getnilinstances then
            for _, v in pairs(getnilinstances()) do
                pcall(v.Destroy, v)
            end
        end
    end
end)
local Descendants = game:GetDescendants()
for i, v in pairs(Descendants) do
    CheckIfBad(v)
end
game.DescendantAdded:Connect(function(value)
    wait(getgenv().FPSBoost.LoadedWait or 1)
    CheckIfBad(value)
end)
