local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local GuiService = game:GetService("GuiService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer

local isAutoClicking = false
local isAutoBossActive = false
local isAutoEggActive = false
local targetCPS = 30
local selectedBossName = "Bully"
local selectedEggName = "Basic Egg"

local bossList = {
    "Bully", "Teacher", "Gym Rat", "Mafia Boss", "Champion",
    "Noob", "Trainer", "Rogue", "Master", "Undead Sparta",
    "Desk Agent", "Fiery Guide", "Dark Banker", "Magma Troll", "Evil Overseer",
    "Orinthian", "Spaceboy", "Demon Slayer", "Cyber Cat", "Ud'zal",
    "Rocket Rider", "Missile Maven", "Lair Guardian", "Nova Nomad", "Space Dog",
    "Barbarian", "Hazmat", "Enforcer", "Bulk", "Mutant King",
    "Primal", "Dino", "Archeologist", "Tribe Leader", "Mammoth",
    "Scrap Trader", "Cyber Cop", "Cyber Assassin", "Ripper Doc", "Rogue Ai",
    "Coco Nut", "Fat Pirate", "Mermaid King", "Friendly Shark", "Kraken Boss",
    "Snow Ops", "Mountain Skier", "Frostington", "Frostfang", "Gladiator",
    "Sorcerer", "Cyclops Chris", "Leviathan", "Fungi Crusher", "Brute Hunter",
    "Masked Hacker", "Glitched Hacker", "Hacked TV", "Matrix Defender", "Corrupt Guest",
    "Touchdown Tim", "Steel Striker", "Playbook Pete", "Rapunz Andhawk", "Manager Mike",
    "White Mage", "Rust Golem", "Light Ember", "Light Bringer", "Rifted Warrior",
    "Pure Minion", "Angelic Warrior", "Dark Brute", "Empyrean", "Overseer",
    "Ghost Blade", "Rookie Orc", "Hunter Orc", "Demon Orc", "Elder Orc", "Wealthy Orc",
    "Evil Minion", "Bandit Cash", "Miner Mike", "Cave Clint", "Mr Lizard", "Unlucky Miner",
    "Guardian Knight", "Princess Phoebe", "Goblin", "King Kieran", "Shiny Knight",
    "Evil Ruby", "Peasant Tens", "Soul Knight", "Castle Reaper", "Doga King", "Flaming Reaper",
    "Frys Mech", "Void Shield", "Ruby Mech", "Demon Mech", "Void Mech",
    "Noob Mermaid", "Tide Spirit", "Bubble Blower", "Coral Beast", "Sea Emperor",
    "Ninja", "Kimono", "Samurai", "Blue Ninja", "Grand Master",
    "Space Termite", "Astronaut", "Space Cadet", "Alien", "Planet Ruler",
    "Cauldron Brewer", "Black Cat", "Apprentice Wizard", "Wizard Cat", "Expert Wizard",
    "Anubis", "Thoth", "Pharaoh", "King Tut", "Pyramid Keeper",
    "Bandit", "Cowboy", "Conductor", "Sheriff", "Mayor",
    "Ghost Reaper", "Cyber Oni", "Sinister Kitsune", "Gold Champion", "Temple Guardian",
    "Bastet", "Sakura Fighter", "Jungle Jack", "Moss Reaper", "Bone Tyrant", "Apex Warlord", "Peel Bandit",
    "Soldier Daniel", "Sgt Ryan", "Military Mike", "Lockdown Luke", "Major Pane",
    "Cpl Smith", "Sky Hawk", "Sgt Stone", "Night Op", "Air Sovereign"
}
local bossIndex = 1

local eggList = {
    "Basic Egg", "Wooden Egg", "Stone Egg", "Obsidian Egg", "Magma Egg",
    "Space Egg", "Alien Egg", "Cyber Egg", "Robot Egg", "Dino Egg",
    "Fossil Egg", "Pirate Egg", "Shark Egg", "Snow Egg", "Gladiator Egg",
    "Hacker Egg", "Matrix Egg", "Football Egg", "Light Egg", "Orc Egg",
    "Cave Egg", "Knight Egg", "Castle Egg", "Mech Egg", "Mermaid Egg",
    "Ninja Egg", "Wizard Egg", "Pharaoh Egg", "Western Egg", "Samurai Egg",
    "Jungle Egg", "Military Egg", "Army Egg"
}
local eggIndex = 1

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DeltaUltimateArmWrestleHub"
screenGui.ResetOnSpawn = false

pcall(function()
    if syn and syn.protect_gui then
        syn.protect_gui(screenGui)
        screenGui.Parent = CoreGui
    elseif gethui then
        screenGui.Parent = gethui()
    else
        screenGui.Parent = CoreGui
    end
end)
if not screenGui.Parent then
    screenGui.Parent = player:WaitForChild("PlayerGui")
end

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 320, 0, 410)
mainFrame.Position = UDim2.new(0.5, -160, 0.2, -205)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 14)
uiCorner.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 45)
titleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
titleLabel.Text = "⚡ Delta Ultimate Hub"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 13
titleLabel.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 14)
titleCorner.Parent = titleLabel

local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 38, 0, 38)
minimizeButton.Position = UDim2.new(1, -42, 0, 3.5)
minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 18
minimizeButton.Parent = mainFrame

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 8)
minCorner.Parent = minimizeButton

local miniIcon = Instance.new("TextButton")
miniIcon.Name = "MiniIcon"
miniIcon.Size = UDim2.new(0, 55, 0, 55)
miniIcon.Position = UDim2.new(0.8, 0, 0.15, 0)
miniIcon.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
miniIcon.Text = "⚡"
miniIcon.TextSize = 24
miniIcon.Active = true
miniIcon.Draggable = true
miniIcon.Visible = false
miniIcon.Parent = screenGui

local miniCorner = Instance.new("UICorner")
miniCorner.CornerRadius = UDim.new(1, 0)
miniCorner.Parent = miniIcon

local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(0.92, 0, 0, 40)
tabContainer.Position = UDim2.new(0.04, 0, 0.12, 0)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = mainFrame

local function createTabButton(name, posX)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.23, 0, 1, 0)
    btn.Position = UDim2.new(posX, 0, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.Parent = tabContainer
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    return btn
end

local tabClick = createTabButton("Click", 0)
local tabBoss  = createTabButton("Boss", 0.25)
local tabEgg   = createTabButton("Egg", 0.50)
local tabOpt   = createTabButton("Opt", 0.75)

local function createContainer()
    local c = Instance.new("Frame")
    c.Size = UDim2.new(0.92, 0, 0.63, 0)
    c.Position = UDim2.new(0.04, 0, 0.28, 0)
    c.BackgroundTransparency = 1
    c.Visible = false
    c.Parent = mainFrame
    return c
end

local pageClick = createContainer()
local pageBoss  = createContainer()
local pageEgg   = createContainer()
local pageOpt   = createContainer()

pageClick.Visible = true

local function switchTab(activePage, activeBtn)
    pageClick.Visible = (pageClick == activePage)
    pageBoss.Visible = (pageBoss == activePage)
    pageEgg.Visible = (pageEgg == activePage)
    pageOpt.Visible = (pageOpt == activePage)
    
    tabClick.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    tabBoss.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    tabEgg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    tabOpt.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    
    activeBtn.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
end

tabClick.MouseButton1Click:Connect(function() switchTab(pageClick, tabClick) end)
tabBoss.MouseButton1Click:Connect(function() switchTab(pageBoss, tabBoss) end)
tabEgg.MouseButton1Click:Connect(function() switchTab(pageEgg, tabEgg) end)
tabOpt.MouseButton1Click:Connect(function() switchTab(pageOpt, tabOpt) end)
tabClick.BackgroundColor3 = Color3.fromRGB(0, 122, 255)

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(1, 0, 0, 50)
toggleButton.Position = UDim2.new(0, 0, 0.05, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
toggleButton.Text = "СТАТУС КЛІКЕРА: ВИМКНЕНО"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 13
toggleButton.Parent = pageClick

local tCorner = Instance.new("UICorner")
tCorner.CornerRadius = UDim.new(0, 10)
tCorner.Parent = toggleButton

local cpsLabel = Instance.new("TextLabel")
cpsLabel.Size = UDim2.new(0.5, 0, 0, 40)
cpsLabel.Position = UDim2.new(0, 0, 0.4, 0)
cpsLabel.BackgroundTransparency = 1
cpsLabel.Text = "Швидкість CPS:"
cpsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
cpsLabel.Font = Enum.Font.Gotham
cpsLabel.TextSize = 14
cpsLabel.TextXAlignment = Enum.TextXAlignment.Left
cpsLabel.Parent = pageClick

local cpsInput = Instance.new("TextBox")
cpsInput.Size = UDim2.new(0.45, 0, 0, 40)
cpsInput.Position = UDim2.new(0.55, 0, 0.4, 0)
cpsInput.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
cpsInput.Text = tostring(targetCPS)
cpsInput.TextColor3 = Color3.fromRGB(255, 255, 255)
cpsInput.Font = Enum.Font.GothamBold
cpsInput.TextSize = 14
cpsInput.Parent = pageClick

local cInputCorner = Instance.new("UICorner")
cInputCorner.CornerRadius = UDim.new(0, 8)
cInputCorner.Parent = cpsInput

local clickInfo = Instance.new("TextLabel")
clickInfo.Size = UDim2.new(1, 0, 0, 45)
clickInfo.Position = UDim2.new(0, 0, 0.68, 0)
clickInfo.BackgroundTransparency = 1
clickInfo.Text = "🎯 Поставте зелене коло на потрібну кнопку"
clickInfo.TextColor3 = Color3.fromRGB(255, 200, 100)
clickInfo.Font = Enum.Font.Gotham
clickInfo.TextSize = 12
clickInfo.TextWrapped = true
clickInfo.Parent = pageClick

local bossInfo = Instance.new("TextLabel")
bossInfo.Size = UDim2.new(1, 0, 0, 35)
bossInfo.Position = UDim2.new(0, 0, 0, 0)
bossInfo.BackgroundTransparency = 1
bossInfo.Text = "Виберіть боса:"
bossInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
bossInfo.Font = Enum.Font.GothamBold
bossInfo.TextSize = 13
bossInfo.Parent = pageBoss

local bossDropdownBtn = Instance.new("TextButton")
bossDropdownBtn.Size = UDim2.new(1, 0, 0, 50)
bossDropdownBtn.Position = UDim2.new(0, 0, 0.2, 0)
bossDropdownBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
bossDropdownBtn.Text = "Бос: Bully"
bossDropdownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
bossDropdownBtn.Font = Enum.Font.GothamBold
bossDropdownBtn.TextSize = 13
bossDropdownBtn.Parent = pageBoss

local bCorner = Instance.new("UICorner")
bCorner.CornerRadius = UDim.new(0, 10)
bCorner.Parent = bossDropdownBtn

bossDropdownBtn.MouseButton1Click:Connect(function()
    bossIndex = bossIndex + 1
    if bossIndex > #bossList then bossIndex = 1 end
    selectedBossName = bossList[bossIndex]
    bossDropdownBtn.Text = "Бос: " .. selectedBossName
end)

local bossToggleButton = Instance.new("TextButton")
bossToggleButton.Size = UDim2.new(1, 0, 0, 50)
bossToggleButton.Position = UDim2.new(0, 0, 0.55, 0)
bossToggleButton.BackgroundColor3 = Color3.fromRGB(230, 126, 34)
bossToggleButton.Text = "⚔️ АВТО-БОС: ВИМКНЕНО"
bossToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
bossToggleButton.Font = Enum.Font.GothamBold
bossToggleButton.TextSize = 13
bossToggleButton.Parent = pageBoss

local btCorner = Instance.new("UICorner")
btCorner.CornerRadius = UDim.new(0, 10)
btCorner.Parent = bossToggleButton

local eggInfo = Instance.new("TextLabel")
eggInfo.Size = UDim2.new(1, 0, 0, 35)
eggInfo.Position = UDim2.new(0, 0, 0, 0)
eggInfo.BackgroundTransparency = 1
eggInfo.Text = "Виберіть яйце:"
eggInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
eggInfo.Font = Enum.Font.GothamBold
eggInfo.TextSize = 13
eggInfo.Parent = pageEgg

local eggDropdownBtn = Instance.new("TextButton")
eggDropdownBtn.Size = UDim2.new(1, 0, 0, 50)
eggDropdownBtn.Position = UDim2.new(0, 0, 0.2, 0)
eggDropdownBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
eggDropdownBtn.Text = "Яйце: Basic Egg"
eggDropdownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
eggDropdownBtn.Font = Enum.Font.GothamBold
eggDropdownBtn.TextSize = 13
eggDropdownBtn.Parent = pageEgg

local egCorner = Instance.new("UICorner")
egCorner.CornerRadius = UDim.new(0, 10)
egCorner.Parent = eggDropdownBtn

eggDropdownBtn.MouseButton1Click:Connect(function()
    eggIndex = eggIndex + 1
    if eggIndex > #eggList then eggIndex = 1 end
    selectedEggName = eggList[eggIndex]
    eggDropdownBtn.Text = "Яйце: " .. selectedEggName
end)

local eggToggleButton = Instance.new("TextButton")
eggToggleButton.Size = UDim2.new(1, 0, 0, 50)
eggToggleButton.Position = UDim2.new(0, 0, 0.55, 0)
eggToggleButton.BackgroundColor3 = Color3.fromRGB(120, 60, 220)
eggToggleButton.Text = "🥚 АВТО-ЯЙЦЯ: ВИМКНЕНО"
eggToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
eggToggleButton.Font = Enum.Font.GothamBold
eggToggleButton.TextSize = 13
eggToggleButton.Parent = pageEgg

local eCorner = Instance.new("UICorner")
eCorner.CornerRadius = UDim.new(0, 10)
eCorner.Parent = eggToggleButton

local optButton = Instance.new("TextButton")
optButton.Size = UDim2.new(1, 0, 0, 50)
optButton.Position = UDim2.new(0, 0, 0.1, 0)
optButton.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
optButton.Text = "📉 Знизити графіку (FPS Boost)"
optButton.TextColor3 = Color3.fromRGB(255, 255, 255)
optButton.Font = Enum.Font.GothamBold
optButton.TextSize = 13
optButton.Parent = pageOpt

local oCorner = Instance.new("UICorner")
oCorner.CornerRadius = UDim.new(0, 10)
oCorner.Parent = optButton

local optDesc = Instance.new("TextLabel")
optDesc.Size = UDim2.new(1, 0, 0, 60)
optDesc.Position = UDim2.new(0, 0, 0.45, 0)
optDesc.BackgroundTransparency = 1
optDesc.Text = "Зменшує навантаження на телефон."
optDesc.TextColor3 = Color3.fromRGB(180, 180, 190)
optDesc.Font = Enum.Font.Gotham
optDesc.TextSize = 12
optDesc.TextWrapped = true
optDesc.Parent = pageOpt

local targetCircle = Instance.new("TextButton")
targetCircle.Name = "TargetCircle"
targetCircle.Size = UDim2.new(0, 50, 0, 50)
targetCircle.Position = UDim2.new(0.6, -25, 0.45, 0)
targetCircle.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
targetCircle.BackgroundTransparency = 0.3
targetCircle.Text = "🎯"
targetCircle.TextSize = 20
targetCircle.Active = true
targetCircle.Draggable = true
targetCircle.Parent = screenGui

local circleCorner = Instance.new("UICorner")
circleCorner.CornerRadius = UDim.new(1, 0)
circleCorner.Parent = targetCircle

minimizeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    miniIcon.Visible = true
end)

miniIcon.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    miniIcon.Visible = false
end)

toggleButton.MouseButton1Click:Connect(function()
    isAutoClicking = not isAutoClicking
    if isAutoClicking then
        toggleButton.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
        toggleButton.Text = "СТАТУС КЛІКЕРА: ПРАЦЮЄ"
        targetCircle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    else
        toggleButton.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
        toggleButton.Text = "СТАТУС КЛІКЕРА: ВИМКНЕНО"
        targetCircle.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
    end
end)

bossToggleButton.MouseButton1Click:Connect(function()
    isAutoBossActive = not isAutoBossActive
    if isAutoBossActive then
        bossToggleButton.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
        bossToggleButton.Text = "⚔️ АВТО-БОС: ПРАЦЮЄ"
    else
        bossToggleButton.BackgroundColor3 = Color3.fromRGB(230, 126, 34)
        bossToggleButton.Text = "⚔️ АВТО-БОС: ВИМКНЕНО"
    end
end)

eggToggleButton.MouseButton1Click:Connect(function()
    isAutoEggActive = not isAutoEggActive
    if isAutoEggActive then
        eggToggleButton.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
        eggToggleButton.Text = "🥚 АВТО-ЯЙЦЯ: ПРАЦЮЄ"
    else
        eggToggleButton.BackgroundColor3 = Color3.fromRGB(120, 60, 220)
        eggToggleButton.Text = "🥚 АВТО-ЯЙЦЯ: ВИМКНЕНО"
    end
end)

optButton.MouseButton1Click:Connect(function()
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        Lighting.GlobalShadows = false
        Lighting.Brightness = 1
    end)
    optButton.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
    optButton.Text = "✅ Графіка оптимізована!"
    task.wait(2)
    optButton.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
    optButton.Text = "📉 Знизити графіку (FPS Boost)"
end)

cpsInput.FocusLost:Connect(function()
    local num = tonumber(cpsInput.Text)
    if num and num > 0 and num <= 60 then
        targetCPS = num
    else
        targetCPS = 30
        cpsInput.Text = tostring(targetCPS)
    end
end)

local function clickAt(btn)
    local ok, err = pcall(function()
        local inset = GuiService:GetGuiInset()
        local pos = btn.AbsolutePosition + btn.AbsoluteSize / 2 + inset
        VirtualInputManager:SendMouseButtonEvent(pos.X, pos.Y, 0, true, game, 0)
        VirtualInputManager:SendMouseButtonEvent(pos.X, pos.Y, 0, false, game, 0)
    end)
    if not ok then
        warn("Помилка клікера:", err)
    end
end

local function holdKeyE(duration)
    pcall(function()
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
        task.wait(duration)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
    end)
end

local function scanAndFightBossWiki()
    local ok, err = pcall(function()
        local targetFound = false
        local searchName = selectedBossName:lower()

        for _, obj in ipairs(Workspace:GetDescendants()) do
            local objName = obj.Name:lower()
            if objName:find(searchName, 1, true) then
                local part = nil
                if obj:IsA("Model") then
                    part = obj.PrimaryPart or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")
                elseif obj:IsA("BasePart") then
                    part = obj
                end

                if part and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 3, 0)
                    targetFound = true
                    break
                end
            end
        end

        if targetFound then
            task.wait(0.2)
            holdKeyE(1.0)
        end
    end)
    if not ok then warn("Помилка Авто-Боса:", err) end
end

local function scanAndOpenEgg()
    local ok, err = pcall(function()
        local targetFound = false
        local searchName = selectedEggName:lower():gsub("egg", ""):gsub("%s+", "")

        for _, obj in ipairs(Workspace:GetDescendants()) do
            local objName = obj.Name:lower()
            if objName:find("egg", 1, true) and (objName:find(searchName, 1, true) or objName:find("basic", 1, true)) then
                local part = nil
                if obj:IsA("Model") then
                    part = obj.PrimaryPart or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")
                elseif obj:IsA("BasePart") then
                    part = obj
                end

                if part and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 3, 0)
                    targetFound = true
                    break
                end
            end
        end

        if targetFound then
            task.wait(0.2)
            holdKeyE(0.4)
        end
    end)
    if not ok then warn("Помилка Авто-Яйця:", err) end
end

local accumulatedTime = 0
local scannerTimer = 0

RunService.Heartbeat:Connect(function(dt)
    if isAutoClicking then
        accumulatedTime = accumulatedTime + dt
        local interval = 1 / targetCPS
        while accumulatedTime >= interval do
            accumulat
            accumulatedTime = accumulatedTime - interval
            clickAt(targetCircle)
        end
    else
        accumulatedTime = 0
    end

    scannerTimer = scannerTimer + dt
    if scannerTimer >= 1 then
        scannerTimer = 0
        if isAutoBossActive then
            task.spawn(scanAndFightBossWiki)
        end
        if isAutoEggActive then
            task.spawn(scanAndOpenEgg)
        end
    end
end)
