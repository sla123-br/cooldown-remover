local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local nomesComuns = {
    "Cooldown", "WaitTime", "Debounce", "Delay", "Time", "ReloadTime", "AttackCooldown",
    "Wait", "CD", "Rate", "FireRate", "Spam", "Rest", "Tir",
    "Espera", "Tempo", "Recarga", "Atraso", "Demora", "Pausa", "TempoEspera", 
    "TempoRecarga", "CdAtaque", "Carregamento", "Tiro", "Intervalo"
}

local function removerCooldown(tool)
    if not tool:IsA("Tool") then return end

    for _, child in ipairs(tool:GetDescendants()) do
        if child:IsA("NumberValue") or child:IsA("IntValue") then
            for _, nome in ipairs(nomesComuns) do
                if string.find(string.lower(child.Name), string.lower(nome)) then
                    child.Value = 0
                end
            end
        end
    end
end

local function verificarInventario()
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if backpack then
        for _, item in ipairs(backpack:GetChildren()) do
            removerCooldown(item)
        end
    end

    local character = LocalPlayer.Character
    if character then
        for _, item in ipairs(character:GetChildren()) do
            if item:IsA("Tool") then
                removerCooldown(item)
            end
        end
    end
end

verificarInventario()

LocalPlayer.CharacterAdded:Connect(function(character)
    character.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            removerCooldown(child)
        end
    end)
end)

local backpack = LocalPlayer:FindFirstChild("Backpack")
if backpack then
    backpack.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            removerCooldown(child)
        end
    end)
end
