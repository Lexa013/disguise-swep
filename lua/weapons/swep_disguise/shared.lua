AddCSLuaFile()

local SWEP = SWEP

SWEP.PrintName = "Disguise Swep"
SWEP.Author = "Lexa"
SWEP.Category = "Lexa"

SWEP.ViewModel = "models/weapons/v_c4.mdl"
SWEP.ViewModelFOV = 45
SWEP.WorldModel = "models/weapons/w_c4.mdl"

SWEP.Slot = 1
SWEP.SlotPos = 1

SWEP.DrawCrosshair = true
SWEP.Spawnable = true

-- Disable ammo
SWEP.DrawAmmo = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize	 = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.Skins = {
	-- team                 -- preview
    [TEAM_CITIZEN] = "models/player/gman_high.mdl",
    [YOUR TEAM INDEX] = "Model you want as preview",
}

function SWEP:Initialize()
	-- self:SetHoldType("normal")
end

function SWEP:SetupDataTables()

end

function SWEP:PrimaryAttack()
	if not CLIENT then return end

	if !IsFirstTimePredicted() then return end

	local frame = vgui.Create("DFrame")
	frame:SetSize(ScrW() * 0.260, ScrH() * 0.25)
	frame:SetTitle("Choose your new model")
	frame:MakePopup()
	frame:Center()

	local resetbtn = frame:Add("DButton")
	resetbtn:SetText("Reset")
	resetbtn:Dock(BOTTOM)
	resetbtn.DoClick = function()
		net.Start("SwepDisguise::Change")
		net.WriteString("reset")
		net.WriteUInt(1, 8)
		net.SendToServer()
	end

	local scroll = frame:Add("DScrollPanel")
	scroll:Dock(FILL)

	local list = scroll:Add("DIconLayout")
	list:Dock(FILL)
	list:SetSpaceX(5)
	list:SetSpaceY(5)

	for k, v in pairs(self.Skins) do
		local model = list:Add("SpawnIcon")
		model:SetModel(v)
		model:SetTooltip(team.GetName(k))

		model.DoClick = function(self)
			net.Start("SwepDisguise::Change")
			net.WriteString("change")
			net.WriteUInt(k, 8)
			net.SendToServer()
		end
	end

end

