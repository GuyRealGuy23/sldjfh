-- the mighty dusttrust 6

--[[//
notes:
- use tele 1 on yourself to unstick from walls
- bone remote is just, boneremote:FireServer(character path) [the lockon value also works]
- the attackDialogue variable sets whether or not attacks have their own edgy dialogue to them lmao
\\]]


-- setup variables
local attackDialogue = false
local alternateSkin = false
local fdymode = false

-- script
local player = game.Players.LocalPlayer
local char;
player.CharacterAdded:Connect(function(x)
    char = x
end)
local phase = 1
local pass = getrenv()._G.Pass
local rep = game.ReplicatedStorage
local remotes = rep.Remotes
local rs = game:GetService('RunService')
local ts = game:GetService('TweenService')
local chatcon
local hb = rs.Heartbeat
local mouse = player:GetMouse()
local slashing = false
local purple = Color3.fromRGB(107,10,241)
local hp = 250
local maxhp = 250
local blockmeter = 150
local storage = {}
local bones = #storage
local mouse = player:GetMouse()
local UserInputService = game:GetService("UserInputService")
local lockToggle = false
local superarmor = true
local hurtanims = {}
local lmbDebounce = false
local NOS = false
local UsingSpeed = false
for i,v in pairs(game:GetService("ReplicatedStorage").Animations.HurtAnimations:GetChildren()) do
    table.insert(hurtanims, v.AnimationId)
end
local sGui = Instance.new('ScreenGui')
sGui.Parent = player.PlayerGui
sGui.Name = 'Screen'

wait = task.wait
spawn = task.spawn

function waitForSpawn(x)
    warn('good')
    player.CharacterAdded:Wait()
    local char = player.Character
    if x then
        task.spawn(function()
        local hb = char:WaitForChild('Head'):WaitForChild('HealthBar'):WaitForChild('Frame')
        local pn = hb.PName:Clone()
        hb.PName:Destroy()
        --hb:WaitForChild('StaminaBar'):Destroy()
        pn.Parent = hb
        end)
    end
    player.Character:WaitForChild('Humanoid').AnimationPlayed:Wait()
end

local function unbind()
task.delay(0.1, function ()
    for _, v in pairs(getgc()) do
        if type(v) == 'function' and string.find(debug.getinfo(v)['source'], 'LockOnScript') then
            local TargetKeycodes = {
                ['Enum.UserInputType.MouseButton3'] = true
            }

            for i2, v2 in pairs(debug.getconstants(v)) do
                if string.find(tostring(v2), 'Enum.UserInputType')and TargetKeycodes[tostring(v2)] then
                    debug.setconstant(v, i2, Enum)
                end
            end
        end
    end
end)
end

function fixHumanoid()
    task.spawn(function()
    game.ReplicatedStorage.Resources.LocalScripts.FixHumanoid:Clone().Parent = char
    task.wait(0.1)
    char:FindFirstChild('FixHumanoid'):Destroy()
    end)
end

function fixEffects()
    game.ReplicatedStorage.Resources.LocalScripts.FixEffects:Clone().Parent = char
end

function ca(tab)
    player = game.Players.LocalPlayer
    local ff
for _,v in pairs(player.Backpack.Main:GetChildren()) do
er = string.lower(v.Name)
if string.match(er,'moves') then
v.Animations.Idle.AnimationId = tab[1]
v.Animations.Walk.AnimationId = tab[2]
v.Animations.Run.AnimationId = tab[3]
v.Animations.Block.AnimationId = tab[4]
end
end

yea = player.Backpack.Main
yen  = yea.Name
for _,v in pairs(player.Backpack:GetChildren()) do
if v.Name == 'Main' then
v.Parent = player
main = v 
end
end
for _,v in pairs(main:GetDescendants()) do
if v.Name == 'Extra' then
extra = v
end
end
for _,v in pairs(player.PlayerGui.UI.Ui:GetChildren()) do
er = string.lower(v.Name)
if string.match(er,'move') then
v.Parent = extra
end
end
for _,v in pairs(player:GetDescendants()) do
if string.find(string.lower(v.Name),'indicator') and v.Name ~= 'Indicator' then
v.Parent = extra
indn = v.Name
end
end
exn = 0
for _,v in pairs(extra:GetChildren()) do
  if v.Name == indn then
  exn = exn + 1 
if exn > 1 then
  v:Destroy()
end
end 
end
main.Parent = player.Backpack
end

function createbone(val)
for i=1,val,1 do
spawn(function()
local bone = game.ReplicatedStorage.Effects.Bone2.Bone:Clone()
bone.Parent = char.Bones
bone.CFrame = target.HumanoidRootPart.CFrame
bone.Size = Vector3.new(1,3,0.8)
bone.Anchored = false
spawn(function()
local vel = Instance.new('BodyVelocity')
vel.Name = 'Client'
vel.Parent = bone
vel.MaxForce = Vector3.new(100000,100000,100000)
vel.P = 6000
vel.Velocity = Vector3.new(math.random(-10,10),math.random(40,50),math.random(-10,10))
wait(0.15)
vel:Destroy()
end)
local gy = Instance.new('BodyGyro')
gy.Parent = bone
gy.CFrame = CFrame.fromEulerAnglesXYZ(math.random(-1720,1720),math.random(-1720,1720),math.random(-1720,1720))
gy.D = 1550
gy.P = 10000
gy.MaxTorque = Vector3.new(100000,100000,100000)
wait(1)
bone:Destroy()
end)
end
end

function chat(text,col)
    local A_1 = 
    {
    	[1] = pass, 
    	[2] = "Chatted", 
    	[3] = text, 
    	[4] = Color3.fromRGB(255,255,255)
    }
    local Event = game:GetService("ReplicatedStorage").Remotes.Events
    Event:FireServer(A_1)
    hb:Wait()
    char.Head:WaitForChild('TextBar'):WaitForChild('TextLabel').TextColor3 = col
end

function effect(name,offset,color,s,rotation)
warn('effecto')
local effect = game:GetService("ReplicatedStorage").Effects[name]:Clone()
effect.Parent = char
warn('effector2')
--effect.CFrame = char.HumanoidRootPart.CFrame*CFrame.new(0,15,0)
for _,v in pairs(effect:GetDescendants()) do
spawn(function()
Angle = rotation
v.CFrame = target.HumanoidRootPart.CFrame*offset*Angle
end)
spawn(function()
v.Color = color
end)
spawn(function()
v.Size = v.Size*s
end)
end
end

if not isfile('Song1.mp3') then
local Content = syn.request({Url="https://cdn.discordapp.com/attachments/962934538848317543/962934627016798218/Homicidal_Lunacy.mp3", Method="GET"})
writefile('Song1.mp3', Content.Body)
end
if not isfile('Song2.mp3') then
local Content = syn.request({Url="https://cdn.discordapp.com/attachments/962934538848317543/962936555989782568/Maniacs_Revenge.mp3", Method="GET"})
writefile('Song2.mp3', Content.Body)
end
if not isfile('Song3.mp3') then
local Content = syn.request({Url="https://cdn.discordapp.com/attachments/962934538848317543/962936550113554442/The_Final_Showdown.mp3", Method="GET"})
writefile('Song3.mp3', Content.Body)
end
if not isfile('Song4.mp3') then
local Content = syn.request({Url="https://cdn.discordapp.com/attachments/962934538848317543/962936565280174160/Divine_Terror.mp3", Method="GET"})
writefile('Song4.mp3', Content.Body)
end
if not isfile('Song5.mp3') then
local Content = syn.request({Url="https://cdn.discordapp.com/attachments/962934538848317543/962936449114710086/Game_Over.mp3", Method="GET"})
writefile('Song5.mp3', Content.Body)
end

local mus = Instance.new('Folder')
mus.Parent = player
mus.Name = 'Music'
local song1 = Instance.new('Sound')
song1.Parent = mus
song1.SoundId = getsynasset('Song1.mp3')
song1.Volume = 1
song1.Looped = true

local song2 = Instance.new('Sound')
song2.Parent = mus
song2.SoundId = getsynasset('Song2.mp3')
song2.Volume = 1
song2.Looped = true

local song3 = Instance.new('Sound')
song3.Parent = mus
song3.SoundId = getsynasset('Song3.mp3')
song3.Volume = 1
song3.Looped = true

local song4 = Instance.new('Sound')
song4.Parent = mus
song4.SoundId = getsynasset('Song4.mp3')
song4.Volume = 1
song4.Looped = true

local song5 = Instance.new('Sound')
song5.Parent = mus
song5.SoundId = getsynasset('Song5.mp3')
song5.Volume = 1
song5.Looped = true

function stopMusic()
    song1:Stop()
    song2:Stop()
    song3:Stop()
    song4:Stop()
    song5:Stop()
end

local anims1 = {
    "rbxassetid://5028878836",
    "rbxassetid://4370512420",
    "rbxassetid://5657151699",
    "rbxassetid://4290685608"
}
if alternateSkin == true then
anims1[1] = 'rbxassetid://5079250270'
end
task.wait()

local anims1sw = {
    
}
local anims2 = {
    
}

player.PlayerData.DeathScene:Destroy()
warn('Ready to go!')
waitForSpawn(true)
player.PlayerScripts:WaitForChild('Music'):Destroy()
char.Dodge:Destroy()
char:WaitForChild('ForceField'):Destroy()
hb:Wait(0.2)

local A_1 = {
    [1] = getrenv()._G.Pass, 
    [2] = "Damage", 
    [3] = 'nan', 
    [4] = char
}

game.ReplicatedStorage.Remotes.Events:FireServer(A_1)

spawn(function()
    task.wait(1)
    game.Players:Chat(("So... here we are."))
    task.wait(5)
    game.Players:Chat(([[Standing face to face in an empty world,
with the same goal in mind.]]))
    task.wait(5.3)
    game.Players:Chat(([[Killing the person in front of us,
and everyone else we care about.]]))
    task.wait(5)
    game.Players:Chat(([[But who said you'll be the one
to succeed?]]))
    task.wait(4.5)
    game.Players:Chat(("Nobody."))
    task.wait(3.5)
    game.Players:Chat(([[And I'll make sure I'm the only one
who can fullfil that goal!]]))
end)

hb:Wait()
char.Humanoid.Health = 1
char.Humanoid:GetPropertyChangedSignal('Health'):Connect(function()
    hb:Wait()
    char.Humanoid.Health = 1
    fixHumanoid()
end)

slash = 'a'
wfc = game:GetService("Players").LocalPlayer.Backpack:WaitForChild('Main')
for i,v in pairs(wfc:GetDescendants()) do
    if v.Name:match("Moves") then
    slash = v
end
end
test1 = slash['ModuleScript']['Animations']
for i,v in pairs(test1:GetDescendants()) do
      if v.Name:match("Light") then
    slash = v
end
end

game.Players.LocalPlayer.Character['Bone']:Destroy()

-- superarmor
game:GetService("RunService").RenderStepped:Connect(function()
if superarmor == true then
for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
if v.Name:match("Damage") or v.Name:match("net") or v.Name:match("Knock") or v.Name:match("Wall") or v.Name:match("Stun") or v.Name:match("Hit") then
    v:Destroy()
end
end
for i,v in pairs(game.Players.LocalPlayer.Character.HumanoidRootPart:GetChildren()) do
if v.Name:match("Server") or v.Name:match("Body") or v.Name:match("Weld")then
    v:Destroy()
end
end
end
end)

-- gui stuff
local hpLabel = Instance.new('TextLabel')
hpLabel.Parent = sGui
hpLabel.BackgroundTransparency = 1
hpLabel.Font = 'Arcade'
hpLabel.Size = UDim2.new(0.15,0,0.07,0)
hpLabel.TextWrapped = true
hpLabel.TextScaled = true
hpLabel.Text = 'HP: '..tostring(hp)..'/'..tostring(maxhp)
hpLabel.TextColor3 = Color3.new(1,1,1)
hpLabel.Position = UDim2.new(0.75,0,0.65,0)

local boneLabel = Instance.new('TextLabel')
boneLabel.Parent = sGui
boneLabel.BackgroundTransparency = 1
boneLabel.Font = 'Arcade'
boneLabel.Size = UDim2.new(0.2,0,0.08,0)
boneLabel.TextWrapped = true
boneLabel.TextScaled = true
boneLabel.Text = 'Bones Stored: '..tostring(bones)
boneLabel.TextColor3 = Color3.new(1,1,1)
boneLabel.Position = UDim2.new(0.75,0,0.6,0)

local nbar = player.PlayerGui.UI.Ui.StaminaBar:Clone()
nbar.Parent = player.PlayerGui.UI.Ui
nbar.Name = 'BlockBar'
nbar.Position = nbar.Position + UDim2.new(0,0,-0.0125,0)
for i,v in pairs(nbar:GetChildren()) do
    if not v:IsA('Frame') then v:Destroy() end
end
nbar.Bar.BackgroundColor3 = purple
spawn(function()
    while rs.Heartbeat:Wait() do
        boneLabel.Text = 'Bones Stored: '..tostring(bones)
    end
end)

function updateLabel()
    hpLabel.Text = 'HP: '..tostring(hp)..'/'..tostring(maxhp)
    local per = (hp/maxhp)*100;local x = (.45/100)*per
    char.Head.HealthBar.Frame.Health.Size = UDim2.new(x,0,0.25,0)
    nbar.Bar.Size = UDim2.new(blockmeter/150,0,1,0)
    char.Head.HealthBar.Frame.HealthLabel.Text = tostring(hp)..'/'..tostring(maxhp)
end
local hpv = 0
char.Head.ChildAdded:Connect(function(x)
    hpv=hpv+1
    if hpv ~= 1 then
    if x.Name == 'DamageShower' then
        if blockmeter > 0 then
            task.spawn(function()
            x:WaitForChild('Gui'):WaitForChild('TextLabel').Text = 'Blocked'
            x:WaitForChild('Gui'):WaitForChild('TextLabel').TextStrokeColor3 = Color3.fromRGB(160,160,160)
            task.wait(0.1)
            for _,v in pairs(char.Humanoid.Animator:GetPlayingAnimationTracks()) do
                print(v.Animation.AnimationId)
				if table.find(hurtanims, v.Animation.AnimationId) then
				    print('bad anim')
				    v:Stop()
				end
            end
		    end)
            blockmeter = blockmeter - 1
        else
            x:WaitForChild('Gui'):WaitForChild('TextLabel').Text = -1
            hp = hp - 1
        end
        updateLabel()
    end
    end
end)
-- fix lockon
unbind()
UserInputService.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton3 then
		if mouse.Target.Parent:FindFirstChild('Humanoid') and lockToggle == false then
		    local targ = mouse.Target.Parent
		    lockToggle = true
		    player.Backpack.Main.LockOnScript.LockOn.Value = targ
		elseif lockToggle == true then
		    lockToggle = false
		    player.Backpack.Main.LockOnScript.LockOn.Value = nil
		end
    end
end)

-- bones attack setup
spawn(function()
local A_1 =  {
    [1] = pass, 
    [2] = "Bones", 
    [3] = "Ground", 
    [4] = Vector3.new(0,1000,0)
}
local Event = game:GetService("ReplicatedStorage").Remotes.SansMoves
Event:InvokeServer(A_1)
end)
spawn(function()
local pp = char.Effects:WaitForChild('MultipleBones')
pp.Name = 'Kill'
spawn(function()
spawn(function() pp:WaitForChild('Warning'):Destroy() pp:WaitForChild('Warning'):Destroy() end)
task.wait(1)
spawn(function() pp:WaitForChild('Script'):Destroy() end)
end)
task.wait(1)
for _,v in pairs(pp:GetDescendants()) do
    if v.Name == 'RemoteEvent' then
        warn('found bone')
        boneremote = v
    end
end
end)

if not char:FindFirstChild('Bones') then
local bonefol = Instance.new('Folder')
bonefol.Parent = char
bonefol.Name = 'Bones'
end

song1:Play()
task.spawn(function()
task.wait(0.5)
ca(anims1)
end)
char.Head.HealthBar.Frame.PName.Text = 'DT!Sans'
char.Head.HealthBar.Frame.PName.TextColor3 = Color3.fromRGB(22,5,55)
char.Head.HealthBar.Frame.PName.TextStrokeColor3 = purple
char.Head.HealthBar.Frame.HealthLabel.Text = '250/250'
local plrGui = player.PlayerGui.UI.Ui
plrGui.Info.Attack.Text = 'Attack:120'
plrGui.Info.Defense.Text = 'Defense:767'
spawn(function()
    task.wait(0.5)
    plrGui.DamageShower.Damage.Value = 0
    plrGui.DamageShower.Visible = false
end)
game.Players.LocalPlayer.Character.Head.ChildAdded:Connect(function(v)
    if v.Name == 'TextBar' then
        v:WaitForChild('TextLabel')
        for _,x in pairs(v:GetChildren()) do
            game['Run Service'].Heartbeat:wait()
            x.TextColor3 = Color3.fromRGB(75, 2, 188)
        end
    end
end)

-- sword stuff
local sword1 = game:GetObjects('rbxassetid://9430837899')[1]
local sword2 = game:GetObjects('rbxassetid://9422796488')[1]
local swords = {}
table.insert(swords, sword1)
table.insert(swords, sword2)
task.wait()
for i,v in pairs(swords) do
    v.Parent = char
    if i == 1 then
        v.Handle.HandleL.Part0 = char['Left Arm']
        --sword01:Destroy()
    elseif i == 2 then
        v.Handle.HandleR.Part0 = char['Right Arm']
        --sword02:Destroy()
    end
    for u,x in pairs(v:GetDescendants()) do
        if x:IsA('Part') or x:IsA('MeshPart') then
            x.Transparency = 1
        end
    end
end
task.wait(0.2)
function enableSwords()
    for i,x in pairs(swords) do
        for c,v in pairs(x:GetDescendants()) do
            if not v:IsA('Weld') and not v:IsA('Motor6D') and not v:IsA('WeldConstraint') then
                task.spawn(function()
                v.Transparency = 0
                if v.Name == 'Blade' or v.Name == 'Handle' then
                    local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
                    local tween = game:GetService('TweenService'):Create(v, tweenInfo, {Transparency = 0.64})
                    tween:Play()
                end
                end)
            end
        end
    end
    task.spawn(function()
    local snd = game.ReplicatedStorage.Sounds.ChaosSaberSuccess:Clone()
    snd.Parent = char.Torso
    snd.Volume = 3
    snd:Play()
    task.wait(tonumber(snd.TimeLength))
    snd:Destroy()
    end)
end

function disableSwords()
    for i,x in pairs(swords) do
        for c,v in pairs(x:GetDescendants()) do
            if not v:IsA('Weld') and not v:IsA('Motor6D') and not v:IsA('WeldConstraint') then
                task.spawn(function()
                local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
                local tween = game:GetService('TweenService'):Create(v, tweenInfo, {Transparency = 1})
                tween:Play()
                end)
            end
        end
    end
end
if alternateSkin == false then
disableSwords()
end
-- axe stuff
task.spawn(function()
if alternateSkin == true then
    task.wait(1)
    local axe = game:GetObjects('rbxassetid://9682689015')[1]
    axe.Parent = char
    axe.Handle.HandleAttach.Part0 = char['Right Arm']
end
end)

-- game over
task.spawn(function()
local gameover = player.PlayerGui:WaitForChild('GameOver')

gameover.Sound:Destroy()
local cl = song5:Clone()
cl.Parent = gameover

gameover.Frame.ImageLabel.TextLabel.Script:Destroy()--destroys original the local script you want to modify or change completely
local function SCRIPT_JPEX75_FAKESCRIPT()--- making it into a function so that you can compile it into a local script
script = Instance.new('LocalScript',gameover.Frame.ImageLabel.TextLabel)-- creates a new local script instance

local sound = Instance.new("Sound", script)
sound.Name = 'Voice'
sound.SoundId = 'rbxassetid://5416491219'---voice id you want
space = [[ 
]]

repeat task.wait() until gameover.Enabled == true
wait(3)

local word = "It's alright sans. You did your best."
local length = string.len(word) 
for i = 1, length do
script.Parent.Text = string.sub(word, 1, i)
clone = sound:Clone()
clone.Parent = script
clone:Play()
wait(0.03)
end

wait(2)
word = "Better luck next time."
length = string.len(word) 
for i = 1, length do---you can aas many dialouges 
script.Parent.Text = string.sub(word, 1, i)
clone = sound:Clone()
clone.Parent = script
clone:Play()
wait(0.03)
end---with these lines

local mous-- to define mous so you can disconnect the connect function inside the connect function
mous = mouse.Button1Down:Connect(function()
Instance.new("StringValue", player.Character).Name = "Confirmed"
mous:Disconnect()
end)
end
coroutine.resume(coroutine.create(SCRIPT_JPEX75_FAKESCRIPT))
gameover.Frame.ImageLabel.TextLabel.LocalScript.Name = "Script"
end)

-- cd gui
task.spawn(function()
task.wait(1.4)
delay(0.1, function ()
    for _, v in pairs(getgc()) do
        if type(v) == 'function' and string.find(debug.getinfo(v)['source'], 'SansMoves') then
            local TargetKeycodes = {
                ['Enum.KeyCode.One'] = true,
                ['Enum.KeyCode.Two'] = true,
                ['Enum.KeyCode.Three'] = true,
                ['Enum.KeyCode.Four'] = true,
                ['Enum.KeyCode.Five'] = true,
                ['Enum.KeyCode.Six'] = true,
                ['Enum.KeyCode.E'] = true,
                ['Enum.KeyCode.Q'] = true
            }

            for i2, v2 in pairs(debug.getconstants(v)) do
                if string.find(tostring(v2), 'Enum.KeyCode')and TargetKeycodes[tostring(v2)] then
                    debug.setconstant(v, i2, Enum)
                end
            end
        end
    end
    end)
end)

plrGui.MoveDebounceShower.Moves1:Destroy()
plrGui.MoveDebounceShower.Moves3:Destroy()
local moves1 = plrGui.MoveDebounceShower.Moves2:Clone()
moves1.Parent = plrGui.MoveDebounceShower
moves1.Name = 'nMoves1'
moves1.Visible = true
plrGui.MoveDebounceShower.Moves2:Destroy()
plrGui.MoveDebounceShower.LocalScript.Disabled = true
plrGui.MoveDebounceShower.LocalScript.Disabled = false

spawn(function()
task.wait(0.5)
uiIndicator = player.PlayerGui.SansIndicator
uiIndicator.Indicator.TextStrokeColor3 = purple
uiIndicator.Help.TextStrokeColor3 = Color3.new(1,0,1)
end)

-- setting up moves
local selectedMode = 1
local maxModes = 3
local modeTexts = {
    'Bones',
    'Blasters',
    'Sword'
}

moves2 = moves1:Clone()
moves2.Name = 'nMoves2'
moves2.Parent = plrGui.MoveDebounceShower
moves2.Visible = false

moves3 = moves1:Clone()
moves3.Name = 'nMoves3'
moves3.Parent = plrGui.MoveDebounceShower
moves3.Visible = false

moves1['6']:Destroy()
moves1['5']:Destroy()

moves2['6']:Destroy()
moves2['5']:Destroy()
moves2['4']:Destroy()

moves3['6']:Destroy()
moves3['5']:Destroy()

bone1cd = false
bone2cd = false
bone3cd = false
bone4cd = false
blaster1cd = false
blaster2cd = false
blaster3cd = false
sword1cd = false
sword2cd = false
sword3cd = false
sword4cd = false
magic1cd = false
magic2cd = false
magic3cd = false
magic4cd = false
sword1P2cd = false
sword2P2cd = false
sword3P2cd = false

moves1['1'].Time.Value = 4
moves1['2'].Time.Value = 15
moves1['3'].Time.Value = 9
moves1['4'].Time.Value = 7

moves2['1'].Time.Value = 8
moves2['2'].Time.Value = 20
moves2['3'].Time.Value = 40

moves3['1'].Time.Value = 15
moves3['2'].Time.Value = 10
moves3['3'].Time.Value = 10
moves3['4'].Time.Value = 20

function activate(p)
    task.spawn(function()
        p:FindFirstChild('Activated').Value = true
        task.wait()
        p:FindFirstChild('Activated').Value = false
    end)
end

game:GetService("UserInputService").InputBegan:Connect(function(key, gc)
    if gc then return end
    if key.KeyCode == Enum.KeyCode["E"] then
        selectedMode = selectedMode + 1
        if selectedMode > maxModes then selectedMode = 1 end
        uiIndicator.Indicator.Text = modeTexts[selectedMode]..' Activated'
        task.wait()
        warn(tostring(selectedMode))
        if selectedMode == 1 then
            plrGui.MoveDebounceShower['nMoves1'].Visible = true
            plrGui.MoveDebounceShower['nMoves2'].Visible = false
            plrGui.MoveDebounceShower['nMoves3'].Visible = false
            if phase ~= 2 and alternateSkin == false then
            disableSwords()
            end
        elseif selectedMode == 2 then
            plrGui.MoveDebounceShower['nMoves1'].Visible = false
            plrGui.MoveDebounceShower['nMoves2'].Visible = true
            plrGui.MoveDebounceShower['nMoves3'].Visible = false
            if phase ~= 2 and alternateSkin == false then
            disableSwords()
            end
        elseif selectedMode == 3 then
            plrGui.MoveDebounceShower['nMoves1'].Visible = false
            plrGui.MoveDebounceShower['nMoves2'].Visible = false
            plrGui.MoveDebounceShower['nMoves3'].Visible = true
            if alternateSkin == false then
            enableSwords()
            end
        end
            
    elseif key.KeyCode == Enum.KeyCode["Q"] then
        selectedMode = selectedMode - 1
        if selectedMode < 1 then selectedMode = maxModes end
        uiIndicator.Indicator.Text = modeTexts[selectedMode]..' Activated'
        task.wait()
        warn(tostring(selectedMode))
        if selectedMode == 1 then
            plrGui.MoveDebounceShower['nMoves1'].Visible = true
            plrGui.MoveDebounceShower['nMoves2'].Visible = false
            plrGui.MoveDebounceShower['nMoves3'].Visible = false
            if phase ~= 2 and alternateSkin == false then
            disableSwords()
            end
        elseif selectedMode == 2 then
            plrGui.MoveDebounceShower['nMoves1'].Visible = false
            plrGui.MoveDebounceShower['nMoves2'].Visible = true
            plrGui.MoveDebounceShower['nMoves3'].Visible = false
            if phase ~= 2 and alternateSkin == false then
            disableSwords()
            end
        elseif selectedMode == 3 then
            plrGui.MoveDebounceShower['nMoves1'].Visible = false
            plrGui.MoveDebounceShower['nMoves2'].Visible = false
            plrGui.MoveDebounceShower['nMoves3'].Visible = true
            if alternateSkin == false then
            enableSwords()
            end
        end
    end
end)

-- Lmb animations setup
spawn(function()
for _,v in pairs(player.Backpack.Main.SansMoves.ModuleScript.Animations.BladesCombat:GetDescendants()) do
v:Destroy()
end
end)

--Phase 1 Normal lmb
spawn(function()
lmbCD = false
lmbFinish = false
lmbHit = 0
mouse = game.Players.LocalPlayer:GetMouse()
mouse.Button1Down:connect(function()
    if not lmbCD and not lmbFinish and phase == 1 and selectedMode ~= 3 then
        lmbHit = lmbHit + 1
        if lmbHit == 1 and phase == 1 and selectedMode ~= 3 then
            print("balls")
            local Anim = Instance.new("Animation")
            Anim.AnimationId = "rbxassetid://6994043923"
            local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
            k:Play()
            k:AdjustSpeed(1)
            local args = {
                [1] = getrenv()._G.Pass,
                [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
                [3] = {
                    ["HitTime"] = 1,
                    ["Type"] = "Normal",
                    ["HitEffect"] = "LightHitEffect",
                    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
                    ["Velocity"] = Vector3.new(0, 0.1, 0),
                    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
                    ["Damage"] = 3
        }
}
game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
lmbDebounce = true
task.wait(0.1)
lmbDebounce = false

        elseif lmbHit == 2 and phase == 1 and selectedMode ~= 3 then
            local Anim = Instance.new("Animation")
            Anim.AnimationId = "rbxassetid://6994050486"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "HeavyHitEffect",
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
        ["Velocity"] = Vector3.new(0, 0.1, 0),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 6
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
lmbDebounce = true
task.wait(0.1)
lmbDebounce = false

        elseif lmbHit == 3 and phase == 1 and selectedMode ~= 3 then
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://6994060442"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "LightHitEffect",
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
        ["Velocity"] = Vector3.new(0, 0.1, 0),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 3
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
lmbDebounce = true
task.wait(0.1)
lmbDebounce = false

        elseif lmbHit == 4 and phase == 1 and selectedMode ~= 3 then
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://6994071435"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Knockback",
        ["HitEffect"] = "HeavyHitEffect",
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
        ["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 45,
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 6
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
            
        wait(0.1)
        lmbFinish = true 
        lmbHit = 0
        wait(3)
        lmbFinish = false 
        end
    end
end)
end)

-------------------------------------------------------------------------------------

--Phase 1 Swords lmb
spawn(function()
lmbCD = false
lmbFinish = false
lmbHit = 0
mouse = game.Players.LocalPlayer:GetMouse()
mouse.Button1Down:connect(function()
    if not lmbCD and not lmbFinish and selectedMode == 3 and phase == 1 then
        lmbHit = lmbHit + 1
        if lmbHit == 1 and phase == 1 and selectedMode == 3 then
        local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4456884092"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "LightHitEffect",
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
        ["Velocity"] = Vector3.new(0, 0.1, 0),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.SwordHit,
        ["Damage"] = 3
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
lmbDebounce = true
task.wait(0.1)
lmbDebounce = false

        elseif lmbHit == 2 and phase == 1 and selectedMode == 3 then
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4456890962"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "HeavyHitEffect",
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
        ["Velocity"] = Vector3.new(0, 0.1, 0),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.SwordHit,
        ["Damage"] = 6
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
lmbDebounce = true
task.wait(0.1)
lmbDebounce = false

        elseif lmbHit == 3 and phase == 1 and selectedMode == 3 then
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4456894133"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "LightHitEffect",
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
        ["Velocity"] = Vector3.new(0, 0.1, 0),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.SwordHit,
        ["Damage"] = 3
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
lmbDebounce = true
task.wait(0.1)
lmbDebounce = false

        elseif lmbHit == 4 and phase == 1 and selectedMode == 3 then
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4456898259"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "HeavyHitEffect",
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
        ["Velocity"] = Vector3.new(0, 0.1, 0),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.SwordHit,
        ["Damage"] = 6
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
lmbDebounce = true
task.wait(0.1)
lmbDebounce = false

        elseif lmbHit == 5 and phase == 1 and selectedMode == 3 then
        local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4456901030"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Knockback",
        ["HitEffect"] = "HeavyHitEffect",
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
        ["Velocity"] = Vector3.new(0, 0.1, 0) + char.HumanoidRootPart.CFrame.lookVector * 45,
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.SwordHit,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
            
        wait(0.1)
        lmbFinish = true 
        lmbHit = 0
        wait(3)
        lmbFinish = false 
        end
    end
end)
end)
-------------------------------------------------------------------------

--Phase 2 lmb
spawn(function()
lmbCD = false
lmbFinish = false
lmbHit = 0
mouse = game.Players.LocalPlayer:GetMouse()

mouse.Button1Down:connect(function()
    if not lmbCD and not lmbFinish and phase == 2 and NOS ~= true and UsingSpeed ~= true then
        lmbHit = lmbHit + 1
        if lmbHit == 1 and phase == 2 then
        local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://9030758758"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
task.wait(0.4)
local A_1 =  {
          [1] = getrenv()._G.Pass, 
          [2] = "SlashEffect", 
          [3] = slash, 
          [4] = purple, 
          [5] = CFrame.new(0,0,0)*CFrame.fromEulerAnglesXYZ(math.rad(0), math.rad(180),math.rad(-195))
      }
      local Event = game:GetService("ReplicatedStorage").Remotes.Events
      Event:FireServer(A_1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "LightHitEffect",
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
        ["Velocity"] = Vector3.new(0, 0.1, 0),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.ChaosSaberSlice,
        ["Damage"] = 3
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
lmbDebounce = true
task.wait(0.1)
lmbDebounce = false

        elseif lmbHit == 2 and phase == 2 and NOS ~= true then
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://9278069933"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local A_1 =  {
          [1] = getrenv()._G.Pass, 
          [2] = "SlashEffect", 
          [3] = slash, 
          [4] = purple, 
          [5] = CFrame.new(0,0,0)*CFrame.fromEulerAnglesXYZ(math.rad(0), math.rad(180),math.rad(-50))
      }
      local Event = game:GetService("ReplicatedStorage").Remotes.Events
      Event:FireServer(A_1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "HeavyHitEffect",
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
        ["Velocity"] = Vector3.new(0, 0.1, 0),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.ChaosSaberSlice,
        ["Damage"] = 6
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
lmbDebounce = true
task.wait(0.1)
lmbDebounce = false

        elseif lmbHit == 3 and phase == 2 and NOS ~= true then
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://9030779063"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local A_1 =  {
          [1] = getrenv()._G.Pass, 
          [2] = "SlashEffect", 
          [3] = slash, 
          [4] = purple, 
          [5] = CFrame.new(0,0,0)*CFrame.fromEulerAnglesXYZ(math.rad(0), math.rad(180),math.rad(-180))
      }
      local Event = game:GetService("ReplicatedStorage").Remotes.Events
      Event:FireServer(A_1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "LightHitEffect",
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
        ["Velocity"] = Vector3.new(0, 0.1, 0),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.ChaosSaberSlice,
        ["Damage"] = 3
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
lmbDebounce = true
task.wait(0.1)
lmbDebounce = false

        elseif lmbHit == 4 and phase == 2 and NOS ~= true then
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://9030795057"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
task.wait(0.6)
local A_1 =  {
          [1] = getrenv()._G.Pass, 
          [2] = "SlashEffect", 
          [3] = slash, 
          [4] = purple, 
          [5] = CFrame.new(0,0,0)*CFrame.fromEulerAnglesXYZ(math.rad(0), math.rad(180),math.rad(-50))
      }
      local Event = game:GetService("ReplicatedStorage").Remotes.Events
      Event:FireServer(A_1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1,
        ["Type"] = "Normal",
        ["HitEffect"] = "HeavyHitEffect",
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
        ["Velocity"] = Vector3.new(0, 0.1, 0),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.ChaosSaberSlice,
        ["Damage"] = 6
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
lmbDebounce = true
task.wait(0.1)
lmbDebounce = false

        elseif lmbHit == 5 and phase == 2 and NOS ~= true then
        local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://9030807073"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
local A_1 =  {
          [1] = getrenv()._G.Pass, 
          [2] = "SlashEffect", 
          [3] = slash, 
          [4] = purple, 
          [5] = CFrame.new(0,0,0)*CFrame.fromEulerAnglesXYZ(math.rad(0), math.rad(180),math.rad(-180))
      }
      local Event = game:GetService("ReplicatedStorage").Remotes.Events
      Event:FireServer(A_1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 0.8,
        ["Type"] = "Knockback",
        ["HitEffect"] = "HeavyHitEffect",
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
        ["Velocity"] = Vector3.new(0, 0.1, 0) + char.HumanoidRootPart.CFrame.lookVector * 45,
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.ChaosSaberSlice,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
            
        wait(0.1)
        lmbFinish = true 
        lmbHit = 0
        wait(3)
        lmbFinish = false 
        end
    end
end)
end)
-------------------------------------------------------------------------

--Boosted LMB
spawn(function()
    mouse = game.Players.LocalPlayer:GetMouse()
    mouse.Button1Down:Connect(function()
        print("Pressed")
        if NOS == true and UsingSpeed == true then
            print("Boosted Start")
            local LockOn = player.Backpack.Main.LockOnScript.LockOn.Value
            if LockOn then
                targ = LockOn
                    task.spawn(function()
                        local Anim = Instance.new("Animation")
                        Anim.AnimationId = "rbxassetid://5657142368"
                        local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
                        k:Play()
                        k:AdjustSpeed(0)
                        task.wait(1)
                        k:AdjustSpeed(1)
                        for i = 0,50 do
                            boneremote:FireServer(LockOn)
                            hb:Wait()
                        end
                        task.wait(0.1)
                        local Anim = Instance.new("Animation")
                        Anim.AnimationId = "rbxassetid://5657143572"
                        local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
                        k:Play()
                        for i = 0,50 do 
                            boneremote:FireServer(LockOn)
                            hb:Wait()
                        end
                        NOS = false
                        UsingSpeed = false
                end)
            task.spawn(function()
                    local cl = game.ReplicatedStorage.Effects.WarningSans:Clone()
                    cl.Parent = char.Head
                    cl.Script:Destroy()
                        spawn(function()
                            local toggle = false
                                while task.wait(0.1) and cl do
                                    if not toggle then
                                        toggle = true
                                        cl.ImageLabel.ImageColor3 = Color3.fromRGB(255,255,20)
                                    elseif toggle then
                                        toggle = false
                                        cl.ImageLabel.ImageColor3 = Color3.fromRGB(255,0,4)
                                    end
                                end
                        end)
                        wait(1.5)
                        cl:Destroy()
            end)
            spawn(function()
            local sound = Instance.new('Sound',char.Head)
            local id = 6930257355
            sound.Volume = 7
            sound.SoundId = 'rbxassetid://'..id
            task.wait(1)
            sound:Play()
            task.wait(1)
            sound:Play()
            end)
            end
        end
    end)
end)



--Phase 3 and so on 

-- attacks
function bones4()
local LockOn = player.Backpack.Main.LockOnScript.LockOn.Value
if LockOn then
targ = LockOn
spawn(function()
_G.noorbit = false
for i = 1,1,1 do
spawn(function()
local A_1 =  {
      [1] = pass, 
      [2] = "Bones", 
      [3] = "AirSpawn2", 
      [4] = Vector3.new(154.23783874512, 138.37542724609, -477.81555175781)
}
local Event = game:GetService("ReplicatedStorage").Remotes.SansMoves
Event:InvokeServer(A_1)
end)
end
local a = 0
local tab = {}
local tab2 = {}
detect = char.Attacks.ChildAdded:Connect(function(pp)
if pp.Name == 'Bone' then
    a = a + 1
--pp:WaitForChild('NotTouched'):Destroy()
--pp:WaitForChild('LocalScript'):Destroy()
pp:WaitForChild('BodyVelocity'):Destroy()
local v1 = Instance.new('BodyPosition',pp)
fol = Instance.new('Folder',pp)
v1.Name = 'Client'
v1.MaxForce = Vector3.new(1,1,1)*100000
v1.D = 1000
v1.P = 30000
local v2 = Instance.new('BodyGyro',pp)
fol = Instance.new('Folder',pp)
v2.Name = 'Client'
v2.MaxTorque = Vector3.new(1,1,1)*10000
v2.D = 150
v2.P = 30000
v1.Position = targ.Torso.Position + Vector3.new(0,15,0)
v2.CFrame = targ.Torso.CFrame
table.insert(tab,v1)
table.insert(tab2,v2)
task.wait(0.4)
--v1:Destroy()
v1.Position = v1.Position - Vector3.new(0,17,0)
end
end)
end)
end
end

function bones3()
local bone = game.ReplicatedStorage.Effects.CrossBigBone:Clone()
bone.Parent = game.Players.LocalPlayer.Character.Attacks
local main = bone:FindFirstChild('Bone')
local p1 = main.Bone
p1.Name = 'Bone1'
p1.Color = Color3.fromRGB(107,10,241)
local p2 = main.Bone
p2.Name = 'Bone2'
p2.Color = Color3.fromRGB(107,10,241)
p2.Anchored = false
p1.Anchored = false
main.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-10,1) * CFrame.Angles(math.rad(70),0,0)

task.spawn(function()
task.wait(0.15)
local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false, 0)
local tween = game:GetService('TweenService'):Create(main, tweenInfo, {CFrame = main.CFrame * CFrame.new(0,-1,-9)})
tween:Play()
local snd = game:GetService("ReplicatedStorage").Resources.Sounds.Moves.Bones.SpawnBone:Clone()
snd.Parent = main
snd:Play()
task.wait(1.5)
local tweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
local tween = game:GetService('TweenService'):Create(main, tweenInfo, {Transparency = 1})
tween:Play()
local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
local tween = game:GetService('TweenService'):Create(p1, tweenInfo, {Transparency = 1})
tween:Play()
local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
local tween = game:GetService('TweenService'):Create(p2, tweenInfo, {Transparency = 1})
tween:Play()
task.wait(0.8)
bone:Destroy()
end)
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4057830287"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1.2)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 0.6, 
        ["Type"] = "Knockback", 
        ["HitEffect"] = "BoneHitEffect", 
        ['Karma'] = 10,
        ["CombatInv"] = true,
        ['BlockAble'] = false,
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.GutHurt, 
        ["Velocity"] = Vector3.new(0,25,0) + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 15, 
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 20
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
end

function blasters1()
local LockOn = player.Backpack.Main.LockOnScript.LockOn.Value
if LockOn then
targ = LockOn
task.spawn(function()
local A_1 =  {
      [1] = pass, 
      [2] = "GasterBlasters", 
      [3] = "SummonOne", 
      [4] = targ.HumanoidRootPart.Position
}
local Event = game:GetService("ReplicatedStorage").Remotes.SansMoves
Event:InvokeServer(A_1)
end)
local con = targ.Humanoid.HealthChanged:Connect(function()
    boneremote:FireServer(targ)
    hb:Wait()
end)
task.wait(1.5)
con:Disconnect()
end
end

function blasters2()
    local LockOn = player.Backpack.Main.LockOnScript.LockOn.Value
if LockOn then
targ = LockOn
task.spawn(function()
    local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://5080902449"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k.TimePosition = 1.5
k:AdjustSpeed(1.3)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 0.6, 
        ["Type"] = "Knockback", 
        ["HitEffect"] = "BoneHitEffect", 
        ['Karma'] = 10,
        ["CombatInv"] = true,
        ['BlockAble'] = false,
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.GutHurt, 
        ["Velocity"] = Vector3.new(0,5,0),
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 0
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
task.wait()
local A_1 = {
      [1] = pass, 
      [2] = "GasterBlasters", 
      [3] = "SummonFour", 
      [4] = targ.HumanoidRootPart.Position
}
local Event = game:GetService("ReplicatedStorage").Remotes.SansMoves
Event:InvokeServer(A_1)
end)
end
end

function blasters3()
local LockOn = player.Backpack.Main.LockOnScript.LockOn.Value
if LockOn then
char.HumanoidRootPart.CFrame = LockOn.HumanoidRootPart.CFrame * CFrame.new(0,0,4)
task.spawn(function()
local snd = game:GetService("ReplicatedStorage").Sounds.ChaosBusterWarningSound:Clone()
snd.Parent = char.HumanoidRootPart
snd:Play()
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://5861141100"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1.2)
task.wait(0.8)
snd:Destroy()
end)
task.wait(0.4)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 0.2, 
        ["Type"] = "Knockback", 
        ["HitEffect"] = "BoneHitEffect", 
        ['Karma'] = 15,
        ["CombatInv"] = true,
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.GutHurt, 
        ["Velocity"] = Vector3.new(0,-10,0), 
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.ShieldBreak,
        ["Damage"] = 30
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
task.wait(0.6)
if LockOn:FindFirstChild('Grounded') then
    char.HumanoidRootPart.CFrame = LockOn.HumanoidRootPart.CFrame * CFrame.new(0,0,-4)
    local A_1 =  {
      [1] = pass, 
      [2] = "Special3"
}
local Event = game:GetService("ReplicatedStorage").Remotes.SansMoves
Event:InvokeServer(A_1)
end
end
end

function swords1()
local LockOn = game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
if LockOn then 
local target = LockOn
spawn(function()
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://5084291021"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)
task.wait(0.5)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1, 
        ["Type"] = "Normal", 
        ["HitEffect"] = "BoneHitEffect", 
        ['Karma'] = 15,
        ["CombatInv"] = true,
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.GutHurt, 
        ["Velocity"] = Vector3.new(0,0.1,0), 
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 10
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
task.wait(0.3)
k:Stop()
if LockOn:FindFirstChild('Hit') then
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4427565376"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1.5)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1, 
        ["Type"] = "Knockback", 
        ["HitEffect"] = "BoneHitEffect", 
        ['Karma'] = 0,
        ["CombatInv"] = true,
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.GutHurt, 
        ["Velocity"] = char.HumanoidRootPart.CFrame.RightVector * 45, 
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
        ["Damage"] = 15
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
end
end)
end
end

function swords2()
local LockOn = game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
if LockOn then 
local target = LockOn
char.HumanoidRootPart.Anchored = true

-- anim / sound 1
spawn(function()
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://7266743882"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k.TimePosition = 1.2
k:AdjustSpeed(0)
wait(1.5)
k:AdjustSpeed(1.5)

spawn(function()
local sound = Instance.new('Sound',char.Head)
local id = 6930257355
sound.Volume = 7
sound.SoundId = 'rbxassetid://'..id
sound:Play()
end)

slashing = true
end)

-- sound 2
local sound = Instance.new('Sound',char.Head)
local id = 2888333253
sound.Volume = 2
sound.SoundId = 'rbxassetid://'..id
sound:Play()

-- indicator
spawn(function()
local cl = game.ReplicatedStorage.Effects.WarningSans:Clone()
cl.Parent = char.Head
cl.Script:Destroy()
spawn(function()
local toggle = false
while task.wait(0.1) and cl do
if not toggle then
    toggle = true
    cl.ImageLabel.ImageColor3 = Color3.fromRGB(255,255,20)
elseif toggle then
    toggle = false
    cl.ImageLabel.ImageColor3 = Color3.fromRGB(255,0,4)
end
end
end)
wait(1.5)
cl:Destroy()
end)

-- damage/effect
spawn(function()
repeat task.wait() until slashing == true
warn('true')
effect('BurstEffect',CFrame.new(0,0,0),Color3.fromRGB(255,255,255),0.5,CFrame.fromEulerAnglesXYZ(0,0,math.rad(math.random(-25,25))))
createbone(math.random(5,10))
end)

spawn(function()
wait(1.61)
for i = 0,50 do
    boneremote:FireServer(LockOn)
    hb:Wait()
end
end)

wait(1.6)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1, 
        ["Type"] = "Knockback", 
        ["HitEffect"] = "BoneHitEffect", 
        ['Karma'] = 15,
        ["CombatInv"] = true,
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.GutHurt, 
        ["Velocity"] = Vector3.new(0,-10,0), 
        ["Damage"] = 30
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
char.HumanoidRootPart.Anchored = false
slashing = false
end
end

function swords3()
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://4612158434"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1)

local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 1, 
        ["Type"] = "Knockback", 
        ["HitEffect"] = "KnifeHitEffect", 
        ["CombatInv"] = true,
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.GutHurt, 
        ["Velocity"] = Vector3.new(0, -10, 0), 
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.ChaosSaberSlice,
        ["Damage"] = 15
    }
}
game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
end

function swords4()
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://5657458641"
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
k:AdjustSpeed(1.3)
task.wait(0.25)
local A_1 =  {
          [1] = getrenv()._G.Pass, 
          [2] = "SlashEffect", 
          [3] = slash, 
          [4] = purple, 
          [5] = CFrame.new(0,0,0)*CFrame.fromEulerAnglesXYZ(math.rad(0), math.rad(180),math.rad(-110))
      }
      local Event = game:GetService("ReplicatedStorage").Remotes.Events
      Event:FireServer(A_1)
local args = {
    [1] = getrenv()._G.Pass,
    [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
    [3] = {
        ["HitTime"] = 0.4, 
        ["Type"] = "Knockback", 
        ["HitEffect"] = "KnifeHitEffect", 
        ["CombatInv"] = true,
        ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.GutHurt, 
        ["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 100, 
        ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Burst,
        ["Damage"] = 25
    }
}

game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
end

-- Magic Mode

function magic2()
    local LockOn = player.Backpack.Main.LockOnScript.LockOn.Value
    if LockOn then
        targ = LockOn
        task.spawn(function()
            local A_1 = {
                [1] = pass,
                [2] = "GasterBlasters",
                [3] = "SummonOneBig",
                [4] = targ.HumanoidRootPart.Position
            }
           local Event = game:GetService("ReplicatedStorage").Remotes.SansMoves
           Event:InvokeServer(A_1)
        end)
        
        local con = targ.Humanoid.HealthChanged:Connect(function()
            boneremote:FireServer(targ)
            hb:Wait()
        end)
        task.wait(1.5)
        con:Disconnect()
    end
end


-- Sword Mode
function sword1P2()
    local LockOn = player.Backpack.Main.LockOnScript.LockOn.Value
    if LockOn then
        targ = LockOn
        task.spawn(function()
            local Anim = Instance.new("Animation")
            Anim.AnimationId = "rbxassetid://6996147456"
            local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
            k:Play()
            k:AdjustSpeed(1.2)
            local args = {
                [1] = pass,
                [2] = targ,
                [3] = {
                    ["HitTime"] = 1,
                    ["Type"] = "Normal",
                    ["HitEffect"] = "BoneHitEffect",
                    ['Karma'] = 10,
                    ["CombatInv"] = false,
                    ['BlockAble'] = false,
                    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.GutHurt,
                    ["Velocity"] = Vector3.new(0, 0.1, 0),
                    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.ChaosSaberSlice,
                    ["Damage"] = 10
                }
            }
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
            
            task.wait(0.5)
            
            local Anim = Instance.new("Animation")
            Anim.AnimationId = "rbxassetid://6996150488"
            local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
            k:Play()
            k:AdjustSpeed(1.2)
            local args = {
                [1] = pass,
                [2] = targ,
                [3] = {
                    ["HitTime"] = 1,
                    ["Type"] = "Normal",
                    ["HitEffect"] = "BoneHitEffect",
                    ['Karma'] = 10,
                    ["CombatInv"] = false,
                    ['BlockAble'] = false,
                    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.GutHurt,
                    ["Velocity"] = Vector3.new(0, 0.1, 0),
                    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.ChaosSaberSlice,
                    ["Damage"] = 10
                }
            }
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
            
            task.wait(0.5)
            
            local Anim = Instance.new("Animation")
            Anim.AnimationId = "rbxassetid://6996156784"
            local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
            k:Play()
            k:AdjustSpeed(1.2)
            local args = {
                [1] = pass,
                [2] = targ,
                [3] = {
                    ["HitTime"] = 1,
                    ["Type"] = "Knockback",
                    ["HitEffect"] = "BoneHitEffect",
                    ['Karma'] = 10,
                    ["CombatInv"] = false,
                    ['BlockAble'] = false,
                    ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.GutHurt,
                    ["Velocity"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 40,
                    ["Sound"] = game:GetService("ReplicatedStorage").Sounds.ChaosSaberSlice,
                    ["Damage"] = 10
                }
            }
            game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
        end)
    end
end

function sword2P2()
    local LockOn = player.Backpack.Main.LockOnScript.LockOn.Value
    if LockOn then
        targ = LockOn
		task.spawn(function()
		    char.HumanoidRootPart.Anchored = true
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://7003950381"
			local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
			k:Play()
			local sound = Instance.new('Sound',char.Head)
            local id = 3195202687
            sound.Volume = 2
            sound.SoundId = 'rbxassetid://'..id
            sound:Play()
			k:AdjustSpeed(1)
			task.wait(1.6)
			k:Stop()
			char.HumanoidRootPart.Anchored = false
			NOS = true
			task.wait(10)
			NOS = false
		end)
    end
end

function Speed()
	while NOS == true do
	    game.Players.LocalPlayer.Backpack.Main.RunSpeed.Value = 90
	    task.wait(0)
	    if not NOS == false then
	        
	    else
	        game.Players.LocalPlayer.Backpack.Main.RunSpeed.Value = 45
	        break
	    end
        if NOS == false then
            game.Players.LocalPlayer.Backpack.Main.RunSpeed.Value = 45
        end
	end
end

local attackConP1 = game:GetService("UserInputService").InputBegan:Connect(function(key, gc)
    if gc then return end
    if key.KeyCode == Enum.KeyCode["One"] and not bone1cd and not char:FindFirstChild('UsingBone') and selectedMode == 1 then
        spawn(function()
            activated(moves1['1'])
            bone1cd = true
            task.wait(moves1['1'].Time.Value + 0.2)
            bone1cd = false
        end)
        local LockOn = player.Backpack.Main.LockOnScript.LockOn.Value
        if LockOn then
            for i = 0,50 do
            boneremote:FireServer(LockOn)
            hb:Wait()
            end
        end
        
    elseif key.KeyCode == Enum.KeyCode["Two"] and not bone2cd and not char:FindFirstChild('UsingBone') and selectedMode == 1 then
        spawn(function()
            activate(moves1['2'])
            bone2cd = true
            task.wait(moves1['2'].Time.Value + 0.2)
            bone2cd = false
        end)
        local LockOn = player.Backpack.Main.LockOnScript.LockOn.Value
        if LockOn then
            spawn(function()
                local A_1 =  {
                    [1] = pass, 
                    [2] = "Bones", 
                    [3] = "Ground2", 
                    [4] = LockOn.HumanoidRootPart.Position + Vector3.new(0,-2,0)
                } 
                local Event = game:GetService("ReplicatedStorage").Remotes.SansMoves
                Event:InvokeServer(A_1)
            end)
            task.wait(1.4)
            if LockOn:FindFirstChild('Hit') then
                if LockOn.Type.Value ~= 'Frisk' then
                for i = 1,10 do
                    boneremote:FireServer(LockOn)
                    task.wait(0.02)
                end
                else
                for i = 0,25 do
                    boneremote:FireServer(LockOn)
                    task.wait(0.02)
                end
                end
            end
            -- 'Damaged'
            
        end
    elseif key.KeyCode == Enum.KeyCode["Three"] and not bone3cd and not char:FindFirstChild('UsingBone') and selectedMode == 1 then
        spawn(function()
            activate(moves1['3'])
            bone3cd = true
            task.wait(moves1['3'].Time.Value + 0.2)
            bone3cd = false
        end)
        bones3()
    elseif key.KeyCode == Enum.KeyCode["Four"] and not bone4cd and not char:FindFirstChild('UsingBone') and selectedMode == 1 then
        spawn(function()
            activate(moves1['4'])
            bone4cd = true
            task.wait(moves1['4'].Time.Value + 0.2)
            bone4cd = false
        end)
        bones4()
        
    elseif key.KeyCode == Enum.KeyCode["One"] and not blaster1cd and not char:FindFirstChild('UsingBone') and selectedMode == 2 then
        spawn(function()
            activate(moves2['1'])
            blaster1cd = true
            task.wait(moves2['1'].Time.Value + 0.2)
            blaster1cd = false
        end)
        blasters1()
        
    elseif key.KeyCode == Enum.KeyCode["Two"] and not blaster2cd and not char:FindFirstChild('UsingBone') and selectedMode == 2 then
        spawn(function()
            activate(moves2['2'])
            blaster2cd = true
            task.wait(moves2['1'].Time.Value + 0.2)
            blaster2cd = false
        end)
        blasters2()
            
    elseif key.KeyCode == Enum.KeyCode["Three"] and not blaster3cd and not char:FindFirstChild('UsingBone') and selectedMode == 2 then
        spawn(function()
            activate(moves2['3'])
            blaster3cd = true
            task.wait(moves2['3'].Time.Value + 0.2)
            blaster3cd = false
        end)
        blasters3()
        
    elseif key.KeyCode == Enum.KeyCode["One"] and not swords1cd and not char:FindFirstChild('UsingBone') and selectedMode == 3 then
        spawn(function()
            activate(moves3['1'])
            swords1cd = true
            task.wait(moves3['1'].Time.Value + 0.2)
            swords1cd = false
        end)
        swords1()
        
    elseif key.KeyCode == Enum.KeyCode["Two"] and not swords2cd and not char:FindFirstChild('UsingBone') and selectedMode == 3 then
        spawn(function()
            activate(moves3['2'])
            swords2cd = true
            task.wait(moves3['2'].Time.Value + 0.2)
            swords2cd = false
        end)
        swords2()
        
    elseif key.KeyCode == Enum.KeyCode["Three"] and not swords3cd and not char:FindFirstChild('UsingBone') and selectedMode == 3 then
        spawn(function()
            activate(moves3['3'])
            swords3cd = true
            task.wait(moves3['3'].Time.Value + 0.2)
            swords3cd = false
        end)
        swords3()
        
    elseif key.KeyCode == Enum.KeyCode["Four"] and not swords4cd and not char:FindFirstChild('UsingBone') and selectedMode == 3 then
        spawn(function()
            activate(moves3['4'])
            swords4cd = true
            task.wait(moves3['4'].Time.Value + 0.2)
            swords4cd = false
        end)
        swords4()
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(key, gc)
    if gc then return end
    if key.KeyCode == Enum.KeyCode["Z"] then
        spawn(function()
            local A_1 =  {
                [1] = pass, 
                [2] = "Telekinesis", 
                [3] = "Start", 
                [4] = char
            } 
            local Event = game:GetService("ReplicatedStorage").Remotes.SansMoves
            Event:InvokeServer(A_1)
        end)
    end 
end)

game:GetService("UserInputService").InputBegan:Connect(function(key, gc)
    if gc then return end
    if key.KeyCode == Enum.KeyCode["Zero"] then
spawn(function()
for i = 1,1,1 do
spawn(function()
local A_1 =  {
      [1] = pass, 
      [2] = "Bones", 
      [3] = "AirSpawn", 
      [4] = Vector3.new(154.23783874512, 138.37542724609, -477.81555175781)
}
local Event = game:GetService("ReplicatedStorage").Remotes.SansMoves
Event:InvokeServer(A_1)
end)
end
local a1 = 0
detect = char.Attacks.ChildAdded:Connect(function(pp2)
if pp2.Name == 'Bone' then
    a1 = a1 + 1
pp2:WaitForChild('NotTouched'):Destroy()
pp2:WaitForChild('LocalScript'):Destroy()
pp2:WaitForChild('BodyVelocity'):Destroy()
local v1 = Instance.new('BodyPosition',pp2)
local fol = Instance.new('Folder',pp2)
v1.Name = 'Client'
v1.MaxForce = Vector3.new(1,1,1)*100000
v1.D = 1000
v1.P = 30000
local v2 = Instance.new('BodyGyro',pp2)
fol = Instance.new('Folder',pp2)
v2.Name = 'Client'
v2.MaxTorque = Vector3.new(1,1,1)*10000
v2.D = 150
v2.P = 30000
v1.Position = char.Torso.Position - Vector3.new(0,50,0)
v2.CFrame = targ.Torso.CFrame
table.insert(storage, pp2)
bones = #storage
end
end)
end)
end
end)

game:GetService("UserInputService").InputBegan:Connect(function(key, gc)
    if gc then return end
    if key.KeyCode == Enum.KeyCode["KeypadOne"] then
        hp = 499
        updateLabel()
    end 
end)
game:GetService("UserInputService").InputBegan:Connect(function(key, gc)
    if gc then return end
    if key.KeyCode == Enum.KeyCode["KeypadTwo"] then
        hp = 1000
        updateLabel()
    end 
end)
game:GetService("UserInputService").InputBegan:Connect(function(key, gc)
    if gc then return end
    if key.KeyCode == Enum.KeyCode["KeypadZero"] then
        hp = math.huge
        updateLabel()
    end 
end)
game:GetService("UserInputService").InputBegan:Connect(function(key, gc)
    if gc then return end
    if key.KeyCode == Enum.KeyCode["KeypadThree"] then
        blockmeter = 0
        updateLabel()
        task.wait()
        local A_1 =
        
        {
            [1] = getrenv()._G.Pass, 
            [2] = "Damage", 
            [3] = 1, 
            [4] = game.Players.LocalPlayer.Character
        }
        local Event = game.ReplicatedStorage.Remotes.Events:FireServer(A_1)

    end
end)
game:GetService("UserInputService").InputBegan:Connect(function(key, gc)
    if gc then return end
    if key.KeyCode == Enum.KeyCode["KeypadFour"] and UsingSpeed == false then
        sword1P2()
    end
end)
game:GetService("UserInputService").InputBegan:Connect(function(key, gc)
    if gc then return end
    if key.KeyCode == Enum.KeyCode["KeypadFive"] and UsingSpeed == false then
        magic2()
    end
end)
game:GetService("UserInputService").InputBegan:Connect(function(key, gc)
    if gc then return end
    if key.KeyCode == Enum.KeyCode["KeypadSix"] then
        sword2P2()
        UsingSpeed = true
        task.wait(1.6)
        Speed()
    end
end)

-- phase 2
repeat hb:Wait() until hp <= 249
phase = 2
attackConP1:Disconnect()
stopMusic()
task.wait()
song2:Play()
if alternateSkin == false then
disableSwords()
end

task.wait(1.5)
if alternateSkin == false then
enableSwords()
sword1:Destroy()
end
maxModes = 2
modeTexts = {
    'Magic',
    'Sword'
}
if selectedMode > maxModes then selectedMode = 1 
end
uiIndicator.Indicator.Text = modeTexts[selectedMode]..' Activated'
