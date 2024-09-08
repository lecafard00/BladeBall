-- Charger Infinite Yield
loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()

-- Ajouter la commande Blade Ball avec esquive automatique
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
local dodgeKey = Enum.KeyCode.F  -- Touche pour esquiver (F)
local dodgeEnabled = false  -- Variable pour activer/désactiver l'esquive automatique

-- Fonction pour esquiver automatiquement
local function dodgeBall()
    local dodgeDistance = 50 -- Distance d'esquive
    local dodgeDirection = Vector3.new(math.random(-1,1), 0, math.random(-1,1)).Unit -- Direction aléatoire
    local newPosition = rootPart.Position + dodgeDirection * dodgeDistance
    humanoid:MoveTo(newPosition)
end

-- Fonction pour détecter les balles à proximité
local function detectBall()
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Part") and obj.Name == "Ball" then -- Vérifier que c'est une balle
            local distance = (obj.Position - rootPart.Position).Magnitude
            if distance < 30 then -- Si la balle est à moins de 30 studs
                dodgeBall() -- Esquiver
            end
        end
    end
end

-- Activer l'esquive avec la touche F
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == dodgeKey then
        dodgeEnabled = not dodgeEnabled
        if dodgeEnabled then
            print("Esquive automatique activée")
        else
            print("Esquive automatique désactivée")
        end
    end
end)

-- Boucle pour vérifier la position des balles en continu
while true do
    if dodgeEnabled then
        detectBall()
    end
    wait(0.1) -- Vérification toutes les 0.1 secondes
end
