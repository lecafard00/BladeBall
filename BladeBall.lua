-- Création du menu (GUI)
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local dodgeButton = Instance.new("TextButton")

-- Configuration du ScreenGui
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Configuration du Frame (menu)
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Parent = screenGui

-- Configuration du bouton d'activation d'esquive automatique
dodgeButton.Size = UDim2.new(1, 0, 1, 0)
dodgeButton.Position = UDim2.new(0, 0, 0, 0)
dodgeButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
dodgeButton.Text = "Activer Esquive Auto"
dodgeButton.Parent = frame

-- Variables pour l'état de l'esquive automatique
local dodgeEnabled = false
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Fonction d'esquive automatique
local function dodgeAttack()
    if dodgeEnabled then
        local dodgeDistance = 50 -- Distance d'esquive
        local dodgeDirection = Vector3.new(math.random(-1,1), 0, math.random(-1,1)).Unit -- Direction aléatoire
        local newPosition = rootPart.Position + dodgeDirection * dodgeDistance
        humanoid:MoveTo(newPosition)
    end
end

-- Activer/Désactiver l'esquive automatique en appuyant sur le bouton
dodgeButton.MouseButton1Click:Connect(function()
    dodgeEnabled = not dodgeEnabled
    if dodgeEnabled then
        dodgeButton.Text = "Désactiver Esquive Auto"
        dodgeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0) -- Changer la couleur en rouge pour indiquer que c'est activé
    else
        dodgeButton.Text = "Activer Esquive Auto"
        dodgeButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0) -- Retour à la couleur verte
    end
end)

-- Boucle pour exécuter l'esquive automatique
while true do
    if dodgeEnabled then
        dodgeAttack() -- Esquive si activé
    end
    wait(2) -- Esquive toutes les 2 secondes
end
