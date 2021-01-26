local SWEP = SWEP

AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("SwepDisguise::Change")


net.Receive("SwepDisguise::Change", function(len, ply)
	if not ply:GetActiveWeapon():GetClass() == "swep_disguise" then return end
	if not ply:Alive() then ply:ChatPrint("Deads can't change their clothes ¯\\_(ツ)_/¯") return end
	local string = net.ReadString()
	local key = net.ReadUInt(8)

	local teammodels = RPExtraTeams[ply:Team()].model
	local keymodels = RPExtraTeams[key].model
	
	if string == "reset" then 
		if istable(teammodels) then
			ply:SetModel(table.Random(teammodels))
		else
			ply:SetModel(teammodels)
		end
	else
		if istable(keymodels) then
			ply:SetModel(table.Random(keymodels))
		else
			ply:SetModel(keymodels)
		end
	end
end)
