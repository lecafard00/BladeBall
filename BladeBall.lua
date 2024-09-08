-- Script Roblox basique pour Blade Ball (éducation uniquement)
-- Ce script permettrait d'automatiser certaines actions, comme esquiver des attaques.

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Fonction pour esquiver les attaques
local function dodgeAttack()
    local dodgeDistance = 50 -- Distance d'esquive
    local dodgeDirection = Vector3.new(math.random(-1,1), 0, math.random(-1,1)).Unit -- Choisir une direction aléatoire
    local newPosition = rootPart.Position + dodgeDirection * dodgeDistance

    humanoid:MoveTo(newPosition)
end

-- Automation des attaques
local function autoAttack()
    local blade = character:FindFirstChild("Blade") -- Rechercher l'arme Blade
    if blade then
        -- Rechercher le joueur le plus proche
        local nearestEnemy = nil
        local shortestDistance = math.huge
        
        for _, enemy in pairs(game.Players:GetPlayers()) do
            if enemy ~= player and enemy.Character and enemy.Character:FindFirstChild("HumanoidRootPart") then
                local enemyDistance = (enemy.Character.HumanoidRootPart.Position - rootPart.Position).magnitude
                if enemyDistance < shortestDistance then
                    shortestDistance = enemyDistance
                    nearestEnemy = enemy
                end
            end
        end

        if nearestEnemy and shortestDistance < 100 then -- Si un ennemi est à moins de 100 studs
            -- Attaquer cet ennemi
            humanoid:MoveTo(nearestEnemy.Character.HumanoidRootPart.Position)
            -- Simuler l'attaque (cette partie peut varier selon la logique du jeu)
            blade:Activate()
        end
    end
end

-- Exécuter ces fonctions en continu
while true do
    dodgeAttack() -- Esquive régulièrement
    autoAttack() -- Attaque automatiquement les ennemis proches
    wait(2) -- Attendre 2 secondes avant la prochaine esquive/attaque
end
