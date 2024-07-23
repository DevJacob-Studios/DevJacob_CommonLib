fx_version "cerulean"
lua54 "yes"
game "gta5"

author "DevJacob"
description "Collection of common and reuseable functions"
version "1.0.0"

client_scripts {
	"exports.lua",
	"client/drawText.lua",
	"client/getClosest.lua",
	"client/getNearby.lua",

	"shared/logging.lua",
	"shared/misc.lua",
	"shared/table.lua",
	"shared/math.lua",
}

server_scripts {
	"exports.lua",
	"server/utils.lua",
	"server/getNearby.lua",

	"shared/logging.lua",
	"shared/misc.lua",
	"shared/table.lua",
	"shared/math.lua",
}

--[[
	Example Import:
	DevJacobLib = exports["DevJacob_CommonLib"]:getLibObject(GetCurrentResourceName())
]]