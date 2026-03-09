Local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🌌 Universal Hitbox Size",
   LoadingTitle = "Loading players...",
   LoadingSubtitle = "Loading color..",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false,
})

-- Variáveis de Controle
_G.HitboxSize = 10
_G.HitboxTransparency = 0.7
_G.HitboxColor = Color3.fromRGB(255, 0, 0)
_G.HitboxEnabled = false
_G.TargetPlayer = "Todos"

local lp = game:GetService("Players").LocalPlayer
local runService = game:GetService("RunService")

-- Função para listar players
local function getPlayers()
    local pList = {"Todos"}
    for _, v in pairs(game:GetService("Players"):GetPlayers()) do
        if v ~= lp then table.insert(pList, v.Name) end
    end
    return pList
end

-- LÓGICA EXATA DO INFINITY YIELD (Copiada do Source)
runService.RenderStepped:Connect(function()
    if _G.HitboxEnabled then
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = player.Character.HumanoidRootPart
                
                if _G.TargetPlayer == "Todos" or player.Name == _G.TargetPlayer then
                    -- Aplica exatamente as propriedades que o IY usa
                    hrp.Size = Vector3.new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize)
                    hrp.Transparency = _G.HitboxTransparency
                    hrp.Color = _G.HitboxColor
                    hrp.Material = Enum.Material.Neon -- Para brilhar igual no IY
                    hrp.CanCollide = false
                    
                    -- Remove as bordas/detalhes para ficar um quadrado sólido perfeito
                    if hrp:FindFirstChildOfClass("SpecialMesh") then
                        hrp:FindFirstChildOfClass("SpecialMesh"):Destroy()
                    end
                else
                    -- Reseta players que não são o alvo
                    hrp.Size = Vector3.new(2, 2, 2)
                    hrp.Transparency = 1
                end
            end
        end
    end
end)

-- INTERFACE
local Tab = Window:CreateTab("Hitbox Settings", 4483362458)

Tab:CreateSection("Controle de Tamanho (IY Style)")

Tab:CreateToggle({
   Name = "Ativar Hitbox",
   CurrentValue = false,
   Callback = function(Value)
       _G.HitboxEnabled = Value
       if not Value then
           for _, p in pairs(game:GetService("Players"):GetPlayers()) do
               if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                   p.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 2)
                   p.Character.HumanoidRootPart.Transparency = 1
               end
           end
       end
   end,
})

Tab:CreateInput({
   Name = "Tamanho da Hitbox",
   PlaceholderText = "Digite o valor (Ex: 25)",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       local n = tonumber(Text)
       if n then _G.HitboxSize = n end
   end,
})

Tab:CreateSection("Seleção de Player")

local PlayerDrop = Tab:CreateDropdown({
   Name = "Alvo Específico",
   Options = getPlayers(),
   CurrentOption = {"Todos"},
   Callback = function(Option)
       _G.TargetPlayer = Option[1]
   end,
})

Tab:CreateButton({
   Name = "🔄 Atualizar Players",
   Callback = function()
       PlayerDrop:Refresh(getPlayers())
   end,
})

Tab:CreateSection("Personalização Visual")

Tab:CreateColorPicker({
    Name = "Cor do Quadrado",
    Color = _G.HitboxColor,
    Callback = function(Value)
        _G.HitboxColor = Value
    end,
})

Tab:CreateSlider({
   Name = "Transparência do Quadrado",
   Range = {0, 1},
   Increment = 0.1,
   Suffix = "Alpha",
   CurrentValue = 0.7,
   Callback = function(Value)
       _G.HitboxTransparency = Value
   end,
})

Rayfield:Notify({
    Title = "Lógica IY Aplicada",
    Content = "O quadrado agora segue o padrão exato do Infinity Yield.",
    Duration = 5
})
