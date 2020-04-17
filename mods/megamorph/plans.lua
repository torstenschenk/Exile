-- Megamorph Boxes mapgen plans.lua



-- Rotation:
-- 0 Z+   1 X+   2 Z-   3 X-
-- ladders:  2 X+   3 X-   4 Z+   5 Z-

-----------------------------------------------------------------------
local mod = megamorph
local mod_name = 'megamorph'

local vn = vector.new
local register_geomorph = mod.register_geomorph

-----------------------------------------------------------------------
local n_ex = 'air'

--primary construction materials
local stone_main = 'nodes_nature:granite'
local stone_block_main = 'nodes_nature:granite_block'
local stone_brick_main = 'nodes_nature:granite_brick'
local stone_stairs_main = 'stairs:stair_granite_block'
local stone_stairs_block_main = 'stairs:stair_granite_brick'

--secondary
local stone_2nd = 'nodes_nature:basalt'
local stone_block_2nd = 'nodes_nature:basalt_block'
local stone_brick_2nd = 'nodes_nature:basalt_brick'
local stone_stairs_2nd = 'stairs:stair_basalt_block'
local stone_stairs_block_2nd = 'stairs:stair_basalt_brick'

--tertiary
local stone_3rd = 'nodes_nature:limestone'
local stone_block_3rd = 'nodes_nature:limestone_block'
local stone_brick_3rd = 'nodes_nature:limestone_brick'
local stone_stairs_3rd = 'stairs:stair_limestone_block'
local stone_stairs_block_3rd = 'stairs:stair_limestone_brick'

--furniture etc
--local lamp_block = ?
--local door = ?
--local ladder = ?

--natural
local freshwater = 'nodes_nature:freshwater_source'
local soil = 'nodes_nature:loam'
local lava = 'nodes_nature:lava_source'
local edible_mushroom = 'nodes_nature:zufani'
local medicinal_mushroom = 'nodes_nature:merki'

-----------------------------------------------------------------------
local ground = 20
local vault_width = 7
local vault_offset = math.floor(vault_width / 2)



-----------------------------------------------------------------------
local seal_underground = false
local seal_box = 	{act = 'cube', node = stone_main, loc = vn(0, 0, 0), size = vn(80, 80, 80)}

-----------------------------------------------------------------------

local p


-----------------------------------------------------------------------
--REUSABLE PARTS
-----------------------------------------------------------------------
if mod.geo_parts then
	return
end

mod.geo_parts = {}


local default_exits = {
	{act = 'cube', node = n_ex, loc = vn(0, 21, 19), size = vn(1, 3, 2)},
	{act = 'cube', node = n_ex, loc = vn(0, 21, 39), size = vn(1, 3, 2)},
	{act = 'cube', node = n_ex, loc = vn(0, 21, 59), size = vn(1, 3, 2)},
	{act = 'cube', node = n_ex, loc = vn(79, 21, 19), size = vn(1, 3, 2)},
	{act = 'cube', node = n_ex, loc = vn(79, 21, 39), size = vn(1, 3, 2)},
	{act = 'cube', node = n_ex, loc = vn(79, 21, 59), size = vn(1, 3, 2)},
	{act = 'cube', node = n_ex, loc = vn(19, 21, 0), size = vn(2, 3, 1)},
	{act = 'cube', node = n_ex, loc = vn(39, 21, 0), size = vn(2, 3, 1)},
	{act = 'cube', node = n_ex, loc = vn(59, 21, 0), size = vn(2, 3, 1)},
	{act = 'cube', node = n_ex, loc = vn(19, 21, 79), size = vn(2, 3, 1)},
	{act = 'cube', node = n_ex, loc = vn(39, 21, 79), size = vn(2, 3, 1)},
	{act = 'cube', node = n_ex, loc = vn(59, 21, 79), size = vn(2, 3, 1)},
	{act = 'cube', node = n_ex, loc = vn(0, 51, 39), size = vn(1, 3, 2)},
	{act = 'cube', node = n_ex, loc = vn(79, 51, 39), size = vn(1, 3, 2)},
	{act = 'cube', node = n_ex, loc = vn(39, 51, 0), size = vn(2, 3, 1)},
	{act = 'cube', node = n_ex, loc = vn(39, 51, 79), size = vn(2, 3, 1)},
}
mod.geo_parts['default_exits'] = default_exits


local upper_cross = {
	{act = 'cube', node = 'air', loc = vn(0, 51, 39), size = vn(80, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(39, 51, 0), size = vn(2, 3, 80)},
}
local placeholder_y51 = upper_cross
mod.geo_parts['upper_cross'] = upper_cross


local lower_cross = {
	{act = 'cube', node = 'air', loc = vn(19, 21, 0), size = vn(2, 3, 80)},
	{act = 'cube', node = 'air', loc = vn(39, 21, 0), size = vn(2, 3, 80)},
	{act = 'cube', node = 'air', loc = vn(0, 21, 39), size = vn(80, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(59, 21, 0), size = vn(2, 3, 80)},
	{act = 'cube', node = 'air', loc = vn(0, 21, 59), size = vn(80, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(0, 21, 19), size = vn(80, 3, 2)},
}
mod.geo_parts['lower_cross'] = lower_cross


-----------------------------------------------------
--GEOMORIA PLANS
-----------------------------------------------------
-----------------------------------------------------
--Crossroads
p = {}

for _, item in pairs(lower_cross) do
	table.insert(p, table.copy(item))
end

for _, item in pairs(upper_cross) do
	table.insert(p, table.copy(item))
end

for _, item in pairs(default_exits) do
	table.insert(p, table.copy(item))
end

for _, z in pairs({19, 39, 59}) do
	for _, x in pairs({19, 39, 59}) do
		table.insert(p, {
			act = 'puzzle',
			chance = 10,
			loc = vn(x - vault_offset, 21, z - vault_offset),
			size = vn(vault_width, vault_width, vault_width)
		})
	end
end

if seal_underground then
	table.insert(p, 1, table.copy(seal_box))
end

register_geomorph({
	name = 'crossroads',
	areas = 'geomoria',
	data = p,
})


-----------------------------------------------------
--pillared_room

p = {
	{act = 'cube', node = 'air', line = stone_block_main, treasure = 1, loc = vn(1, 21, 1), size = vn(78, 38, 78)},
	{act = 'cube', node = stone_block_main, loc = vn(1, 50, 1), size = vn(78, 1, 78)},
	{act = 'cube', node = 'air', loc = vn(5, 50, 5), size = vn(70, 1, 70)},
	{act = 'stair', node = stone_stairs_block_main, depth = 3, height = 4, param2 = 2, loc = vn(1, 21, 25), size = vn(2, 30, 30)},
	{act = 'stair', node = stone_stairs_block_main, depth = 3, height = 4, param2 = 0, loc = vn(77, 21, 25), size = vn(2, 30, 30)},
}

for _, item in pairs(default_exits) do
	table.insert(p, 2, table.copy(item))
end

for z = 7, 78, 9 do
	for x = 7, 78, 9 do
		local i = {act = 'cube', node = stone_block_2nd, loc = vn(z, 21, x), size = vn(2, 38, 2)}
		table.insert(p, i)
		--[[
		if not mod.let_there_be_light then
			for y = 25, 57, 9 do
				i = {act = 'cube', node = 'default:meselamp', loc = vn(z, y, x), size = vn(2, 1, 2), cheap_lighting = true}
				table.insert(p, i)
			end
		end
		]]
	end
end

if seal_underground then
	table.insert(p, 1, table.copy(seal_box))
end


register_geomorph({
	name = 'pillared_room',
	areas = 'geomoria',
	data = p,
})



-----------------------------------------------------
--reservoir

p = {
	{act = 'cube', node = 'air', loc = vn(20, 12, 11), size = vn(51, 36, 50)},
	{act = 'cube', node = freshwater, treasure = 5, loc = vn(20, 11, 11), size = vn(51, 10, 50)},
	{act = 'cube', node = stone_main, loc = vn(38, 11, 30), size = vn(17, 10, 16)},
	{act = 'cube', node = stone_main, loc = vn(39, 11, 11), size = vn(2, 10, 19)},
	{act = 'cube', node = freshwater, treasure = 3, loc = vn(49, 11, 62), size = vn(30, 5, 17)},
	{act = 'cube', node = freshwater, loc = vn(17, 11, 69), size = vn(32, 2, 2)},
	{act = 'cube', node = freshwater, loc = vn(43, 11, 61), size = vn(2, 2, 10)},
	{act = 'cube', node = freshwater, loc = vn(17, 11, 23), size = vn(2, 2, 46)},
	{act = 'cube', node = freshwater, treasure = 1, loc = vn(1, 11, 1), size = vn(18, 5, 22)},
	{act = 'cube', node = 'air', loc = vn(56, 21, 1), size = vn(8, 5, 5)},
	{act = 'cube', node = 'air', loc = vn(16, 21, 1), size = vn(8, 5, 5)},
	{act = 'cube', node = 'air', loc = vn(39, 21, 0), size = vn(2, 3, 11)},
	{act = 'cube', node = 'air', loc = vn(1, 21, 42), size = vn(15, 6, 16)},
	{act = 'cube', node = 'air', loc = vn(9, 21, 22), size = vn(7, 6, 19)},
	{act = 'cube', node = 'air', loc = vn(1, 21, 31), size = vn(4, 4, 7)},
	{act = 'cube', node = 'air', loc = vn(1, 21, 22), size = vn(4, 4, 8)},
	{act = 'cube', node = 'air', loc = vn(0, 21, 39), size = vn(9, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(6, 21, 10), size = vn(10, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(0, 21, 10), size = vn(16, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(72, 21, 47), size = vn(7, 4, 11)},
	{act = 'cube', node = 'air', loc = vn(71, 21, 34), size = vn(8, 6, 12)},
	{act = 'cube', node = 'air', loc = vn(72, 21, 1), size = vn(7, 5, 32)},
	{act = 'cube', node = 'air', loc = vn(71, 21, 19), size = vn(9, 2, 2)},
	{act = 'cube', node = 'air', loc = vn(49, 21, 62), size = vn(30, 6, 17)},
	{act = 'cube', node = 'air', loc = vn(1, 21, 62), size = vn(30, 6, 17)},
	{act = 'cube', node = 'air', loc = vn(37, 21, 75), size = vn(6, 4, 4)},
	{act = 'cube', node = 'air', loc = vn(0, 21, 59), size = vn(20, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(71, 21, 59), size = vn(9, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(6, 21, 10), size = vn(2, 3, 32)},
	{act = 'cube', node = 'air', loc = vn(0, 21, 19), size = vn(16, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(5, 21, 34), size = vn(1, 2, 2)},
	{act = 'cube', node = 'air', loc = vn(5, 21, 26), size = vn(1, 2, 2)},
	{act = 'cube', node = 'air', loc = vn(1, 21, 1), size = vn(14, 3, 9)},
	{act = 'cube', node = 'air', loc = vn(1, 21, 10), size = vn(4, 3, 8)},
	{act = 'cube', node = 'air', loc = vn(9, 21, 7), size = vn(7, 3, 11)},
	{act = 'cube', node = 'air', loc = vn(16, 21, 7), size = vn(44, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(19, 21, 5), size = vn(2, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(58, 21, 5), size = vn(2, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(21, 21, 73), size = vn(28, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(16, 21, 56), size = vn(2, 3, 6)},
	--{act = 'ladder', node = 'default:ladder_steel', param2 = 5, loc = vn(78, 11, 62), size = vn(1, 10, 1)},
	--{act = 'ladder', node = 'default:ladder_steel', param2 = 4, loc = vn(20, 21, 60), size = vn(1, 20, 1)},

	{act = 'cube', node = 'air', loc = vn(20, 41, 61), size = vn(51, 5, 9)},
	{act = 'cube', node = 'air', loc = vn(11, 41, 11), size = vn(9, 5, 59)},
	{act = 'stair', node = stone_stairs_main, height = 4, param2 = 2, loc = vn(16, 21, 36), size = vn(2, 20, 20)},
	{act = 'stair', node = stone_stairs_main, param2 = 3, loc = vn(1, 41, 39), size = vn(10, 10, 2)},
	{act = 'stair', node = stone_stairs_main, param2 = 0, loc = vn(39, 41, 69), size = vn(2, 10, 10)},

	{act = 'cube', node = 'air', loc = vn(71, 51, 39), size = vn(8, 3, 2)},
	{act = 'stair', node = stone_stairs_main, depth = 2, param2 = 2, loc = vn(69, 41, 51), size = vn(2, 10, 10)},
	{act = 'cube', node = 'air', loc = vn(69, 51, 13), size = vn(2, 3, 38)},
	{act = 'cube', node = 'air', loc = vn(61, 51, 13), size = vn(8, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(61, 31, 13), size = vn(2, 20, 2)},
	{act = 'cube', node = 'air', loc = vn(61, 50, 13), size = vn(2, 1, 2)}, --?
	{act = 'cube', node = 'air', loc = vn(60, 51, 41), size = vn(8, 4, 10)},
	{act = 'cube', node = 'air', loc = vn(60, 51, 29), size = vn(8, 4, 10)},
	{act = 'cube', node = 'air', loc = vn(28, 51, 30), size = vn(24, 6, 25)},
	{act = 'cube', node = 'air', loc = vn(52, 51, 41), size = vn(8, 3, 3)},
	{act = 'cube', node = 'air', loc = vn(44, 51, 27), size = vn(8, 3, 3)},
	{act = 'cube', node = 'air', loc = vn(28, 51, 27), size = vn(8, 3, 3)},
	{act = 'cube', node = 'air', loc = vn(44, 51, 55), size = vn(8, 3, 3)},
	{act = 'cube', node = 'air', loc = vn(28, 51, 55), size = vn(8, 3, 3)},
	{act = 'cube', node = stone_main, loc = vn(37, 51, 40), size = vn(5, 6, 5)},
	{act = 'cube', node = 'air', loc = vn(68, 51, 34), size = vn(1, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(68, 51, 44), size = vn(1, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(39, 51, 1), size = vn(2, 3, 29)},
}

for _, item in pairs(default_exits) do
	table.insert(p, 2, table.copy(item))
end

if seal_underground then
	table.insert(p, 1, table.copy(seal_box))
end

register_geomorph({
	name = 'reservoir',
	areas = 'geomoria',
	data = p,
})


-----------------------------------------------------
--market

p = {
	{act = 'cube', node = 'air', loc = vn(1, 21, 21), size = vn(2, 3, 40)},
	{act = 'cube', node = 'air', loc = vn(0, 21, 19), size = vn(7, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(5, 21, 17), size = vn(70, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(73, 21, 19), size = vn(7, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(19, 21, 1), size = vn(42, 6, 14)},
	{act = 'cube', node = 'air', loc = vn(73, 21, 46), size = vn(5, 3, 11)},
	{act = 'cube', node = 'air', loc = vn(73, 21, 23), size = vn(5, 3, 11)},
	{act = 'cube', node = 'air', loc = vn(75, 21, 39), size = vn(5, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(71, 21, 59), size = vn(9, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(69, 21, 23), size = vn(2, 3, 38)},
	{act = 'cube', node = 'air', loc = vn(21, 21, 21), size = vn(50, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(19, 21, 21), size = vn(2, 3, 59)},
	{act = 'cube', node = 'air', loc = vn(39, 21, 77), size = vn(22, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(44, 21, 75), size = vn(2, 3, 2)},
	{act = 'cylinder', node = 'air', axis = 'z', loc = vn(30, 25, 25), size = vn(10, 10, 50)},
	{act = 'cylinder', node = 'air', axis = 'z', loc = vn(40, 25, 25), size = vn(10, 10, 50)},
	{act = 'cylinder', node = 'air', axis = 'z', loc = vn(50, 25, 25), size = vn(10, 10, 50)},
	{act = 'cube', node = 'air', loc = vn(30, 21, 25), size = vn(30, 8, 50)},

	{act = 'cube', node = 'air', treasure = 8, loc = vn(24, 21, 64), size = vn(5, 3, 12)},
	{act = 'cube', node = 'air', treasure = 8, loc = vn(24, 21, 51), size = vn(5, 3, 12)},
	{act = 'cube', node = 'air', treasure = 8, loc = vn(24, 21, 38), size = vn(5, 3, 12)},
	{act = 'cube', node = 'air', treasure = 8, loc = vn(24, 21, 25), size = vn(5, 3, 12)},
	{act = 'cube', node = 'air', treasure = 8, loc = vn(61, 21, 64), size = vn(14, 3, 11)},
	{act = 'cube', node = 'air', treasure = 8, loc = vn(61, 21, 51), size = vn(5, 3, 12)},
	{act = 'cube', node = 'air', treasure = 8, loc = vn(61, 21, 38), size = vn(5, 3, 12)},
	{act = 'cube', node = 'air', treasure = 8, loc = vn(61, 21, 25), size = vn(5, 3, 12)},
	{act = 'cube', node = 'air', loc = vn(29, 21, 68), size = vn(1, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(29, 21, 56), size = vn(1, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(29, 21, 43), size = vn(1, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(29, 21, 30), size = vn(1, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(60, 21, 68), size = vn(1, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(60, 21, 56), size = vn(1, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(60, 21, 43), size = vn(1, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(60, 21, 30), size = vn(1, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(73, 21, 34), size = vn(2, 3, 12)},
	{act = 'cube', node = 'air', loc = vn(3, 21, 59), size = vn(16, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(11, 31, 13), size = vn(25, 4, 11)},
	{act = 'stair', node = stone_stairs_main, param2 = 3, loc = vn(33, 21, 14), size = vn(10, 10, 1)},
	{act = 'cube', node = 'air', loc = vn(61, 31, 56), size = vn(14, 4, 19)},
	--{act = 'ladder', node = 'default:ladder_steel', param2 = 4, loc = vn(63, 21, 74), size = vn(1, 10, 1)},
	{act = 'stair', node = stone_stairs_main, param2 = 0, loc = vn(73, 21, 49), size = vn(2, 10, 10)},
	{act = 'stair', node = stone_stairs_main, param2 = 1, loc = vn(6, 21, 57), size = vn(10, 10, 2)},
	{act = 'cube', node = 'air', loc = vn(16, 31, 24), size = vn(2, 4, 35)},
	{act = 'cube', node = 'air', treasure = 1, loc = vn(61, 31, 22), size = vn(2, 4, 34)},
	{act = 'cube', node = 'air', treasure = 3, loc = vn(36, 31, 22), size = vn(25, 4, 2)},
	{act = 'cube', node = 'air', loc = vn(3, 21, 57), size = vn(3, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(61, 31, 55), size = vn(2, 4, 1)},--?
	{act = 'cube', node = 'air', loc = vn(36, 31, 22), size = vn(1, 4, 2)},--?
	{act = 'stair', node = stone_stairs_main, param2 = 2, loc = vn(67, 31, 46), size = vn(2, 10, 10)},

	{act = 'cube', node = 'air', loc = vn(55, 41, 37), size = vn(10, 4, 10)},
	{act = 'cube', node = 'air', loc = vn(13, 41, 16), size = vn(53, 6, 15)},
	{act = 'cube', node = 'air', treasure = 8, loc = vn(12, 41, 31), size = vn(9, 4, 5)},
	{act = 'cube', node = 'air', treasure = 8, loc = vn(23, 41, 31), size = vn(9, 4, 5)},
	{act = 'cube', node = 'air', treasure = 8, loc = vn(34, 41, 31), size = vn(9, 4, 5)},
	{act = 'cube', node = 'air', treasure = 8, loc = vn(45, 41, 31), size = vn(9, 4, 5)},
	{act = 'cube', node = 'air', treasure = 8, loc = vn(56, 41, 31), size = vn(9, 4, 5)},
	{act = 'cube', node = 'air', treasure = 8, loc = vn(12, 41, 11), size = vn(9, 4, 5)},
	{act = 'cube', node = 'air', treasure = 8, loc = vn(23, 41, 11), size = vn(9, 4, 5)},
	{act = 'cube', node = 'air', treasure = 8, loc = vn(34, 41, 11), size = vn(9, 4, 5)},
	{act = 'cube', node = 'air', treasure = 8, loc = vn(45, 41, 11), size = vn(9, 4, 5)},
	{act = 'cube', node = 'air', treasure = 8, loc = vn(56, 41, 11), size = vn(9, 4, 5)},
	{act = 'cube', node = 'air', loc = vn(67, 41, 25), size = vn(2, 3, 21)},
	{act = 'cube', node = 'air', loc = vn(65, 41, 22), size = vn(4, 3, 3)},
	{act = 'stair', node = stone_stairs_main, param2 = 1, loc = vn(67, 41, 11), size = vn(10, 10, 2)},
	{act = 'cube', node = 'air', loc = vn(65, 41, 41), size = vn(2, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(65, 41, 11), size = vn(2, 3, 2)},

	{act = 'cube', node = 'air', loc = vn(77, 51, 3), size = vn(2, 3, 38)},
	{act = 'cube', node = 'air', loc = vn(1, 51, 39), size = vn(76, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(1, 51, 1), size = vn(78, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(1, 51, 3), size = vn(2, 3, 36)},
	{act = 'cube', node = 'air', loc = vn(39, 51, 75), size = vn(2, 3, 4)},
}

for x = 9, 69, 15 do
	table.insert(p, {act = 'cube', node = 'air', loc = vn(x, 51, 41), size = vn(2, 3, 34)})
	for z = 44, 74, 6 do
		table.insert(p, {act = 'cube', node = 'air', treasure = 20, loc = vn(x - 6, 51, z - 2), size = vn(5, 3, 5)})
		table.insert(p, {act = 'cube', node = 'air', treasure = 20, loc = vn(x + 3, 51, z - 2), size = vn(5, 3, 5)})
		table.insert(p, {act = 'cube', node = 'air', loc = vn(x - 1, 51, z), size = vn(1, 2, 1)})
		--table.insert(p, {act = 'cube', node = 'doors:door_wood_b', param2 = 3, loc = vn(x - 1, 51, z), size = vn(1, 1, 1)})
		table.insert(p, {act = 'cube', node = 'air', loc = vn(x + 2, 51, z), size = vn(1, 2, 1)})
		--table.insert(p, {act = 'cube', node = 'doors:door_wood_a', param2 = 1, loc = vn(x + 2, 51, z), size = vn(1, 1, 1)})
	end
end

if seal_underground then
	table.insert(p, 1, table.copy(seal_box))
end

for _, item in pairs(default_exits) do
	table.insert(p, 2, table.copy(item))
end

register_geomorph({
	name = 'market',
	areas = 'geomoria',
	data = p,
})


-----------------------------------------------------
--silly_straw

p = {
	{act = 'cube', node = 'air', loc = vn(19, 21, 76), size = vn(2, 3, 4)},
	{act = 'cube', node = 'air', loc = vn(5, 21, 74), size = vn(16, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(3, 21, 70), size = vn(2, 3, 6)},
	{act = 'cube', node = 'air', loc = vn(5, 21, 70), size = vn(20, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(23, 21, 72), size = vn(2, 3, 6)},
	{act = 'cube', node = 'air', loc = vn(25, 21, 76), size = vn(5, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(28, 21, 60), size = vn(2, 3, 16)},
	{act = 'cube', node = 'air', loc = vn(28, 21, 58), size = vn(27, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(53, 21, 41), size = vn(2, 3, 17)},
	{act = 'cube', node = 'air', loc = vn(50, 21, 39), size = vn(5, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(39, 21, 73), size = vn(2, 3, 6)},
	{act = 'cube', node = 'air', loc = vn(32, 21, 71), size = vn(20, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(52, 21, 63), size = vn(16, 15, 16)},
	{act = 'cube', node = 'air', loc = vn(75, 21, 59), size = vn(5, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(1, 21, 52), size = vn(2, 3, 15)},
	{act = 'cube', node = 'air', loc = vn(3, 21, 52), size = vn(8, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(9, 21, 54), size = vn(2, 3, 9)},
	{act = 'cube', node = 'air', loc = vn(11, 21, 61), size = vn(14, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(23, 21, 59), size = vn(2, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(13, 21, 57), size = vn(12, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(13, 21, 55), size = vn(2, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(13, 21, 53), size = vn(37, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(48, 21, 50), size = vn(2, 3, 3)},
	{act = 'cube', node = 'air', loc = vn(0, 21, 39), size = vn(5, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(3, 21, 41), size = vn(2, 3, 9)},
	{act = 'cube', node = 'air', loc = vn(5, 21, 48), size = vn(25, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(4, 21, 25), size = vn(4, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(8, 21, 25), size = vn(2, 3, 19)},
	{act = 'cube', node = 'air', loc = vn(8, 21, 44), size = vn(13, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(19, 21, 23), size = vn(2, 3, 21)},
	{act = 'cube', node = 'air', loc = vn(21, 21, 39), size = vn(9, 3, 2)},
	{act = 'cube', node = 'air', floor = stone_block_2nd, loc = vn(1, 21, 17), size = vn(78, 15, 6)},
	{act = 'cube', node = 'air', loc = vn(19, 21, 0), size = vn(2, 3, 5)},
	{act = 'cube', node = 'air', loc = vn(2, 21, 3), size = vn(17, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(2, 21, 5), size = vn(2, 3, 10)},
	{act = 'cube', node = 'air', loc = vn(4, 21, 13), size = vn(33, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(6, 21, 9), size = vn(6, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(6, 21, 11), size = vn(2, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(35, 21, 11), size = vn(2, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(35, 21, 9), size = vn(15, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(39, 21, 0), size = vn(2, 3, 17)},
	{act = 'cube', node = 'air', loc = vn(59, 21, 23), size = vn(2, 3, 13)},
	{act = 'cube', node = 'air', loc = vn(59, 21, 0), size = vn(2, 3, 17)},
	{act = 'cube', node = 'air', treasure = 3, loc = vn(59, 21, 36), size = vn(20, 3, 8)},
	{act = 'cube', node = 'air', treasure = 3, floor = stone_block_2nd, loc = vn(30, 21, 30), size = vn(20, 15, 20)},

	{act = 'cube', node = 'air', loc = vn(13, 31, 55), size = vn(2, 3, 22)},
	{act = 'cube', node = 'air', loc = vn(15, 31, 75), size = vn(2, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(17, 31, 45), size = vn(2, 3, 32)},
	{act = 'cube', node = 'air', loc = vn(4, 31, 53), size = vn(11, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(4, 31, 25), size = vn(2, 3, 28)},
	{act = 'cube', node = 'air', treasure = 1, loc = vn(8, 31, 35), size = vn(11, 3, 10)},
	{act = 'cube', node = 'air', treasure = 1, loc = vn(8, 31, 24), size = vn(11, 3, 10)},
	{act = 'cube', node = 'air', loc = vn(20, 31, 11), size = vn(2, 3, 6)},
	{act = 'cube', node = 'air', loc = vn(20, 31, 23), size = vn(2, 3, 18)},
	{act = 'cube', node = 'air', loc = vn(22, 31, 39), size = vn(8, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(32, 31, 52), size = vn(2, 3, 9)},
	{act = 'cube', node = 'air', loc = vn(34, 31, 52), size = vn(7, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(39, 31, 50), size = vn(2, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(39, 31, 23), size = vn(2, 3, 7)},
	{act = 'cube', node = 'air', loc = vn(39, 31, 5), size = vn(2, 3, 12)},
	{act = 'cube', node = 'air', loc = vn(41, 31, 5), size = vn(24, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(58, 31, 11), size = vn(2, 3, 6)},
	{act = 'cube', node = 'air', loc = vn(58, 31, 23), size = vn(2, 3, 40)},
	{act = 'cube', node = 'air', loc = vn(50, 31, 39), size = vn(8, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(63, 31, 58), size = vn(2, 3, 3)},
	{act = 'stair', node = stone_stairs_main, param2 = 1, loc = vn(3, 21, 65), size = vn(10, 10, 2)},
	{act = 'stair', node = stone_stairs_main, param2 = 1, loc = vn(12, 21, 9), size = vn(10, 10, 2)},
	{act = 'stair', node = stone_stairs_main, param2 = 1, loc = vn(50, 21, 9), size = vn(10, 10, 2)},
	{act = 'stair', node = stone_stairs_main, param2 = 3, loc = vn(65, 21, 59), size = vn(10, 10, 2)},
	{act = 'stair', node = stone_stairs_main, param2 = 2, loc = vn(32, 21, 61), size = vn(2, 10, 10)},
	--{act = 'ladder', node = 'default:ladder_steel', param2 = 3, loc = vn(4, 21, 25), size = vn(1, 10, 1)},
	{act = 'cube', node = 'air', loc = vn(59, 21, 9), size = vn(1, 3, 2)},

	{act = 'cube', node = 'air', loc = vn(63, 41, 17), size = vn(2, 3, 31)},
	{act = 'stair', node = stone_stairs_main, param2 = 2, loc = vn(63, 31, 48), size = vn(2, 10, 10)},
	{act = 'stair', node = stone_stairs_main, param2 = 0, loc = vn(63, 31, 7), size = vn(2, 10, 10)},

	{act = 'cube', node = stone_main, loc = vn(20, 30, 17), size = vn(2, 1, 6)},
	{act = 'cube', node = stone_main, loc = vn(39, 30, 17), size = vn(2, 1, 6)},
	{act = 'cube', node = stone_main, loc = vn(58, 30, 17), size = vn(2, 1, 6)},
	{act = 'cube', node = stone_main, loc = vn(56, 30, 63), size = vn(6, 1, 3)},
	{act = 'cube', node = stone_main, loc = vn(39, 30, 30), size = vn(2, 1, 20)},
	{act = 'cube', node = stone_main, loc = vn(30, 30, 39), size = vn(20, 1, 2)},

	{act = 'cube', node = 'air', loc = vn(1, 21, 58), size = vn(2, 3, 1)}, --?v..
	{act = 'cube', node = 'air', loc = vn(21, 21, 39), size = vn(1, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(6, 21, 12), size = vn(2, 3, 1)},
	{act = 'cube', node = 'air', loc = vn(38, 21, 9), size = vn(1, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(41, 21, 9), size = vn(1, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(59, 21, 23), size = vn(2, 3, 1)},
	{act = 'cube', node = 'air', loc = vn(13, 31, 67), size = vn(2, 3, 1)},
	{act = 'cube', node = 'air', loc = vn(13, 31, 34), size = vn(2, 3, 1)},--?^..
}

for _, item in pairs(default_exits) do
	table.insert(p, 2, table.copy(item))
end

for _, item in pairs(placeholder_y51) do
	table.insert(p, 2, table.copy(item))
end

if seal_underground then
	table.insert(p, 1, table.copy(seal_box))
end

register_geomorph({
	name = 'silly_straw',
	areas = 'geomoria',
	data = p,
})


-----------------------------------------------------
--lake_of_fire

p = {
	{act = 'cube', node = 'air', floor = stone_block_2nd, loc = vn(1, 21, 1), size = vn(78, 5, 78)},
	{act = 'cube', node = stone_2nd, loc = vn(9, 21, 9), size = vn(62, 1, 62)},
	{act = 'cube', node = stone_2nd, loc = vn(9, 23, 9), size = vn(62, 5, 62)},
	{act = 'cube', node = 'air', loc = vn(10, 11, 10), size = vn(60, 25, 60)},
	{act = 'cube', node = lava, loc = vn(10, 11, 10), size = vn(60, 5, 60)},
	{act = 'cube', node = stone_2nd, loc = vn(25, 11, 25), size = vn(30, 9, 30)},
	{act = 'cube', node = stone_block_2nd, loc = vn(25, 20, 25), size = vn(30, 1, 30)},
	{act = 'cube', node = stone_2nd, loc = vn(39, 20, 55), size = vn(2, 1, 15)},
	{act = 'cube', node = stone_2nd, loc = vn(39, 20, 10), size = vn(2, 1, 15)},
	{act = 'cube', node = stone_2nd, loc = vn(10, 20, 39), size = vn(15, 1, 2)},
	{act = 'cube', node = stone_2nd, loc = vn(55, 20, 39), size = vn(15, 1, 2)},
	{act = 'cube', node = 'air', loc = vn(70, 21, 39), size = vn(1, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(9, 21, 39), size = vn(1, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(39, 21, 70), size = vn(2, 3, 1)},
	{act = 'cube', node = 'air', loc = vn(39, 21, 9), size = vn(2, 3, 1)},
	{act = 'cube', node = stone_2nd, loc = vn(37, 20, 37), size = vn(6, 2, 6)},
	{act = 'cube', node = lava, loc = vn(38, 20, 38), size = vn(4, 2, 4)},
}

for _, item in pairs(default_exits) do
	table.insert(p, 2, table.copy(item))
end

for _, item in pairs(placeholder_y51) do
	table.insert(p, 2, table.copy(item))
end

if seal_underground then
	table.insert(p, 1, table.copy(seal_box))
end

register_geomorph({
	name = 'lake_of_fire',
	areas = 'geomoria',
	data = p,
})


-----------------------------------------------------
--fountain_court

p = {
	--{param = 'wet'},
	{act = 'cube', node = 'air', loc = vn(29, 11, 55), size = vn(2, 3, 16)},
	{act = 'cube', node = 'air', loc = vn(25, 11, 69), size = vn(4, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(25, 11, 9), size = vn(4, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(9, 11, 9), size = vn(2, 3, 62)},
	{act = 'cube', node = 'air', loc = vn(11, 11, 9), size = vn(4, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(11, 11, 24), size = vn(4, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(11, 11, 39), size = vn(4, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(11, 11, 54), size = vn(4, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(11, 11, 69), size = vn(4, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(49, 11, 59), size = vn(12, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(49, 11, 55), size = vn(2, 3, 4)},
	{act = 'cube', node = 'air', loc = vn(26, 11, 25), size = vn(30, 6, 30)},
	{act = 'cube', node = 'air', loc = vn(49, 11, 19), size = vn(2, 3, 6)},
	{act = 'cube', node = 'air', loc = vn(29, 11, 9), size = vn(2, 3, 16)},
	{act = 'cube', node = 'air', treasure = 3, loc = vn(15, 11, 5), size = vn(10, 6, 10)},
	{act = 'cube', node = 'air', treasure = 3, loc = vn(15, 11, 20), size = vn(10, 6, 10)},
	{act = 'cube', node = 'air', treasure = 3, loc = vn(15, 11, 35), size = vn(10, 6, 10)},
	{act = 'cube', node = 'air', treasure = 3, loc = vn(15, 11, 50), size = vn(10, 6, 10)},
	{act = 'cube', node = 'air', treasure = 3, loc = vn(15, 11, 65), size = vn(10, 6, 10)},
	{act = 'cube', node = stone_block_3rd, loc = vn(18, 11, 8), size = vn(4, 6, 4)},
	{act = 'cube', node = stone_block_3rd, loc = vn(18, 11, 23), size = vn(4, 6, 4)},
	{act = 'cube', node = stone_block_3rd, loc = vn(18, 11, 38), size = vn(4, 6, 4)},
	{act = 'cube', node = stone_block_3rd, loc = vn(18, 11, 53), size = vn(4, 6, 4)},
	{act = 'cube', node = stone_block_3rd, loc = vn(18, 11, 68), size = vn(4, 6, 4)},
	{act = 'cube', node = freshwater, loc = vn(19, 11, 9), size = vn(2, 10, 2)},
	{act = 'cube', node = freshwater, loc = vn(19, 11, 24), size = vn(2, 10, 2)},
	{act = 'cube', node = freshwater, loc = vn(19, 11, 39), size = vn(2, 10, 2)},
	{act = 'cube', node = freshwater, loc = vn(19, 11, 54), size = vn(2, 10, 2)},
	{act = 'cube', node = freshwater, loc = vn(19, 11, 69), size = vn(2, 10, 2)},

	{act = 'stair', node = stone_stairs_main, param2 = 1, loc = vn(61, 11, 59), size = vn(10, 10, 2)},
	{act = 'stair', node = stone_stairs_main, param2 = 2, loc = vn(39, 11, 1), size = vn(2, 10, 10)},
	{act = 'stair', node = stone_stairs_main, param2 = 3, loc = vn(39, 11, 19), size = vn(10, 10, 2)},
	{act = 'cube', node = 'air', loc = vn(39, 11, 11), size = vn(2, 3, 14)},
	{act = 'cube', node = stone_block_3rd, loc = vn(61, 21, 59), size = vn(1, 6, 2)},

	{act = 'cylinder', node = 'air', axis = 'z', loc = vn(10, 15, 1), size = vn(20, 20, 79)},
	{act = 'cube', node = stone_block_3rd, loc = vn(10, 15, 1), size = vn(20, 6, 79)},
	{act = 'cube', node = 'air', floor = stone_block_3rd, loc = vn(10, 21, 1), size = vn(20, 4, 79)},
	{act = 'cube', node = 'air', loc = vn(1, 21, 56), size = vn(8, 4, 8)},
	{act = 'cube', node = 'air', loc = vn(1, 21, 36), size = vn(8, 4, 8)},
	{act = 'cube', node = 'air', loc = vn(1, 21, 16), size = vn(8, 4, 8)},
	{act = 'cube', node = 'air', loc = vn(4, 21, 64), size = vn(2, 3, 7)},
	{act = 'cube', node = 'air', loc = vn(6, 21, 69), size = vn(4, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(4, 21, 44), size = vn(2, 3, 12)},
	{act = 'cube', node = 'air', loc = vn(6, 21, 49), size = vn(4, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(4, 21, 24), size = vn(2, 3, 12)},
	{act = 'cube', node = 'air', loc = vn(6, 21, 29), size = vn(4, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(4, 21, 9), size = vn(2, 3, 7)},
	{act = 'cube', node = 'air', loc = vn(6, 21, 9), size = vn(4, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(31, 21, 56), size = vn(8, 4, 8)},
	{act = 'cube', node = 'air', loc = vn(31, 21, 36), size = vn(8, 4, 8)},
	{act = 'cube', node = 'air', loc = vn(31, 21, 16), size = vn(8, 4, 8)},
	{act = 'cube', node = 'air', loc = vn(34, 21, 64), size = vn(2, 3, 5)},
	{act = 'cube', node = 'air', loc = vn(30, 21, 69), size = vn(9, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(34, 21, 44), size = vn(2, 3, 12)},
	{act = 'cube', node = 'air', loc = vn(30, 21, 49), size = vn(4, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(34, 21, 24), size = vn(2, 3, 12)},
	{act = 'cube', node = 'air', loc = vn(30, 21, 29), size = vn(4, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(34, 21, 9), size = vn(2, 3, 7)},
	{act = 'cube', node = 'air', loc = vn(30, 21, 9), size = vn(4, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(71, 21, 59), size = vn(9, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(39, 21, 39), size = vn(41, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(71, 21, 19), size = vn(9, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(59, 21, 1), size = vn(2, 3, 79)},
	{act = 'cube', node = 'air', loc = vn(39, 21, 69), size = vn(2, 3, 11)},

	{act = 'cube', node = stone_block_3rd, loc = vn(15, 21, 5), size = vn(10, 1, 10)},
	{act = 'cube', node = freshwater, loc = vn(16, 21, 6), size = vn(8, 1, 8)},
	{act = 'cube', node = stone_block_3rd, loc = vn(19, 21, 9), size = vn(2, 2, 2)},
	--{act = 'cube', node = mod_name..':water_source_tame', loc = vn(19, 23, 9), size = vn(2, 1, 2)},
	{act = 'cube', node = stone_block_3rd, loc = vn(15, 21, 20), size = vn(10, 1, 10)},
	{act = 'cube', node = freshwater, loc = vn(16, 21, 21), size = vn(8, 1, 8)},
	{act = 'cube', node = stone_block_3rd, loc = vn(19, 21, 24), size = vn(2, 2, 2)},
	--{act = 'cube', node = mod_name..':water_source_tame', loc = vn(19, 23, 24), size = vn(2, 1, 2)},
	{act = 'cube', node = stone_block_3rd, loc = vn(15, 21, 35), size = vn(10, 1, 10)},
	{act = 'cube', node = freshwater, loc = vn(16, 21, 36), size = vn(8, 1, 8)},
	{act = 'cube', node = stone_block_3rd, loc = vn(19, 21, 39), size = vn(2, 2, 2)},
	--{act = 'cube', node = mod_name..':water_source_tame', loc = vn(19, 23, 39), size = vn(2, 1, 2)},
	{act = 'cube', node = stone_block_3rd, loc = vn(15, 21, 50), size = vn(10, 1, 10)},
	{act = 'cube', node = freshwater, loc = vn(16, 21, 51), size = vn(8, 1, 8)},
	{act = 'cube', node = stone_block_3rd, loc = vn(19, 21, 54), size = vn(2, 2, 2)},
	--{act = 'cube', node = mod_name..':water_source_tame', loc = vn(19, 23, 54), size = vn(2, 1, 2)},
	{act = 'cube', node = stone_block_3rd, loc = vn(15, 21, 65), size = vn(10, 1, 10)},
	{act = 'cube', node = freshwater, loc = vn(16, 21, 66), size = vn(8, 1, 8)},
	{act = 'cube', node = stone_block_3rd, loc = vn(19, 21, 69), size = vn(2, 2, 2)},
	--{act = 'cube', node = mod_name..':water_source_tame', loc = vn(19, 23, 69), size = vn(2, 1, 2)},

	{act = 'cube', node = 'air', loc = vn(51, 31, 65), size = vn(20, 5, 10)},
	{act = 'cube', node = 'air', loc = vn(51, 31, 15), size = vn(10, 5, 10)},
	{act = 'cube', node = 'air', loc = vn(55, 31, 25), size = vn(2, 3, 27)},
	{act = 'cube', node = 'air', loc = vn(60, 31, 41), size = vn(2, 3, 24)},
	{act = 'cube', node = 'air', loc = vn(57, 31, 39), size = vn(8, 3, 2)},
	{act = 'cube', node = stone_block_3rd, loc = vn(54, 11, 49), size = vn(4, 6, 4)},
	{act = 'cube', node = 'air', loc = vn(55, 6, 50), size = vn(2, 25, 2)},
	{act = 'cube', node = 'air', loc = vn(55, 30, 50), size = vn(2, 1, 2)},--?
	{act = 'cube', node = 'air', treasure = 1, loc = vn(65, 31, 35), size = vn(10, 5, 10)},
	{act = 'cube', node = 'air', loc = vn(69, 31, 45), size = vn(2, 3, 5)},
	{act = 'cube', node = 'air', treasure = 1, loc = vn(65, 31, 50), size = vn(10, 5, 10)},
	{act = 'cube', node = 'air', loc = vn(57, 31, 39), size = vn(1, 3, 2)},--?

	{act = 'stair', node = stone_stairs_main, param2 = 3, loc = vn(61, 21, 19), size = vn(10, 10, 2)},
	{act = 'stair', node = stone_stairs_main, param2 = 1, loc = vn(41, 21, 69), size = vn(10, 10, 2)},
}

for _, item in pairs(default_exits) do
	table.insert(p, 2, table.copy(item))
end

for _, item in pairs(placeholder_y51) do
	table.insert(p, 2, table.copy(item))
end

if seal_underground then
	table.insert(p, 1, table.copy(seal_box))
end

register_geomorph({
	name = 'fountain_court',
	areas = 'geomoria',
	data = p,
})


-----------------------------------------------------
--mushroom_garden

p = {
	{act = 'cube', node = soil, loc = vn(5, 19, 5), size = vn(70, 2, 70)},
	{act = 'cube', node = soil, loc = vn(5, 19, 5), size = vn(70, 1, 70), treasure = 1},
	{act = 'cube', node = 'air', loc = vn(5, 21, 5), size = vn(70, 7, 70)},
	{act = 'cube', node = edible_mushroom, random = 30, loc = vn(5, 21, 5), size = vn(70, 1, 70)},
	{act = 'cube', node = 'air', loc = vn(19, 21, 75), size = vn(2, 3, 5)},
	{act = 'cube', node = 'air', loc = vn(39, 21, 75), size = vn(2, 3, 5)},
	{act = 'cube', node = 'air', loc = vn(59, 21, 75), size = vn(2, 3, 5)},
	{act = 'cube', node = 'air', loc = vn(19, 21, 0), size = vn(2, 3, 5)},
	{act = 'cube', node = 'air', loc = vn(39, 21, 0), size = vn(2, 3, 5)},
	{act = 'cube', node = 'air', loc = vn(59, 21, 0), size = vn(2, 3, 5)},
	{act = 'cube', node = 'air', loc = vn(0, 21, 19), size = vn(5, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(0, 21, 39), size = vn(5, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(0, 21, 59), size = vn(5, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(75, 21, 19), size = vn(5, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(75, 21, 39), size = vn(5, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(75, 21, 59), size = vn(5, 3, 2)},

	{act = 'stair', node = stone_stairs_main, param2 = 1, loc = vn(61, 21, 75), size = vn(10, 10, 2)},
	{act = 'stair', node = stone_stairs_main, param2 = 3, loc = vn(9, 21, 3), size = vn(10, 10, 2)},
	{act = 'cube', node = soil, loc = vn(5, 29, 5), size = vn(70, 2, 70)},
	{act = 'cube', node = soil, loc = vn(5, 29, 5), size = vn(70, 1, 70), treasure = 1},
	{act = 'cube', node = 'air', loc = vn(5, 31, 5), size = vn(70, 7, 70)},
	{act = 'cube', node = medicinal_mushroom, random = 30, loc = vn(5, 31, 5), size = vn(70, 1, 70)},
	{act = 'cube', node = 'air', loc = vn(71, 31, 75), size = vn(6, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(3, 31, 3), size = vn(6, 3, 2)},

	{act = 'stair', node = stone_stairs_main, param2 = 2, loc = vn(75, 31, 65), size = vn(2, 10, 10)},
	{act = 'stair', node = stone_stairs_main, param2 = 0, loc = vn(3, 31, 5), size = vn(2, 10, 10)},

	{act = 'cube', node = soil, loc = vn(5, 39, 5), size = vn(70, 2, 70)},
	{act = 'cube', node = soil, loc = vn(5, 39, 5), size = vn(70, 1, 70), treasure = 1},
	{act = 'cube', node = 'air', loc = vn(5, 41, 5), size = vn(70, 7, 70)},
	{act = 'cube', node = edible_mushroom, random = 30, loc = vn(5, 41, 5), size = vn(70, 1, 70)},
	{act = 'cube', node = 'air', loc = vn(75, 41, 60), size = vn(2, 3, 5)},
	{act = 'cube', node = 'air', loc = vn(3, 41, 15), size = vn(2, 3, 5)},
}

for _, item in pairs(default_exits) do
	table.insert(p, 2, table.copy(item))
end

for _, item in pairs(placeholder_y51) do
	table.insert(p, 2, table.copy(item))
end

if seal_underground then
	table.insert(p, 1, table.copy(seal_box))
end

register_geomorph({
	name = 'mushroom_garden',
	areas = 'geomoria',
	data = p,
})


-----------------------------------------------------
--arena

p = {
	{act = 'cube', node = 'air', loc = vn(15, 39, 15), size = vn(50, 6, 50)},
	{act = 'cube', node = 'air', loc = vn(16, 38, 16), size = vn(48, 7, 48)},
	{act = 'cube', node = 'air', loc = vn(17, 37, 17), size = vn(46, 8, 46)},
	{act = 'cube', node = 'air', loc = vn(18, 36, 18), size = vn(44, 9, 44)},
	{act = 'cube', node = 'air', loc = vn(19, 35, 19), size = vn(42, 10, 42)},
	{act = 'cube', node = 'air', loc = vn(20, 34, 20), size = vn(40, 11, 40)},
	{act = 'cube', node = 'air', loc = vn(21, 33, 21), size = vn(38, 12, 38)},
	{act = 'cube', node = 'air', loc = vn(22, 32, 22), size = vn(36, 13, 36)},
	{act = 'cube', node = 'air', treasure = 1, loc = vn(24, 21, 24), size = vn(32, 24, 32)},

	{act = 'cube', node = 'air', treasure = 4, loc = vn(30, 21, 65), size = vn(20, 5, 10)},
	{act = 'cube', node = 'air', treasure = 4, loc = vn(30, 21, 5), size = vn(20, 5, 10)},
	{act = 'cube', node = 'air', treasure = 4, loc = vn(65, 21, 30), size = vn(10, 5, 20)},
	{act = 'cube', node = 'air', treasure = 4, loc = vn(5, 21, 30), size = vn(10, 5, 20)},
	{act = 'cube', node = 'air', loc = vn(39, 21, 56), size = vn(2, 3, 24)},
	{act = 'cube', node = 'air', loc = vn(39, 21, 0), size = vn(2, 3, 24)},
	{act = 'cube', node = 'air', loc = vn(77, 21, 19), size = vn(3, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(77, 21, 59), size = vn(3, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(0, 21, 59), size = vn(3, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(0, 21, 19), size = vn(3, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(19, 21, 77), size = vn(2, 3, 3)},
	{act = 'cube', node = 'air', loc = vn(59, 21, 77), size = vn(2, 3, 3)},
	{act = 'cube', node = 'air', loc = vn(59, 21, 0), size = vn(2, 3, 3)},
	{act = 'cube', node = 'air', loc = vn(19, 21, 0), size = vn(2, 3, 3)},
	{act = 'cube', node = 'air', loc = vn(0, 21, 39), size = vn(24, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(56, 21, 39), size = vn(24, 3, 2)},

	{act = 'cube', node = 'air', loc = vn(19, 31, 65), size = vn(2, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(59, 31, 65), size = vn(2, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(59, 31, 13), size = vn(2, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(19, 31, 13), size = vn(2, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(65, 31, 19), size = vn(2, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(65, 31, 59), size = vn(2, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(13, 31, 59), size = vn(2, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(13, 31, 19), size = vn(2, 3, 2)},

	{act = 'stair', node = stone_stairs_block_2nd, param2 = 2, loc = vn(59, 21, 67), size = vn(2, 10, 10)},
	{act = 'stair', node = stone_stairs_block_2nd, param2 = 0, loc = vn(59, 21, 3), size = vn(2, 10, 10)},
	{act = 'stair', node = stone_stairs_block_2nd, param2 = 0, loc = vn(19, 21, 3), size = vn(2, 10, 10)},
	{act = 'stair', node = stone_stairs_block_2nd, param2 = 3, loc = vn(67, 21, 19), size = vn(10, 10, 2)},
	{act = 'stair', node = stone_stairs_block_2nd, param2 = 3, loc = vn(67, 21, 59), size = vn(10, 10, 2)},
	{act = 'stair', node = stone_stairs_block_2nd, param2 = 1, loc = vn(3, 21, 59), size = vn(10, 10, 2)},
	{act = 'stair', node = stone_stairs_block_2nd, param2 = 1, loc = vn(3, 21, 19), size = vn(10, 10, 2)},
	{act = 'stair', node = stone_stairs_block_2nd, param2 = 2, loc = vn(19, 21, 67), size = vn(2, 10, 10)},

	{act = 'cube', node = 'air', loc = vn(65, 39, 29), size = vn(2, 3, 22)},
	{act = 'cube', node = 'air', loc = vn(13, 39, 29), size = vn(2, 3, 22)},
	{act = 'cube', node = 'air', loc = vn(29, 39, 65), size = vn(22, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(29, 39, 13), size = vn(22, 3, 2)},

	{act = 'stair', node = stone_stairs_block_3rd, param2 = 2, loc = vn(65, 31, 51), size = vn(2, 8, 8)},
	{act = 'stair', node = stone_stairs_block_3rd, param2 = 0, loc = vn(65, 31, 21), size = vn(2, 8, 8)},
	{act = 'stair', node = stone_stairs_block_3rd, param2 = 2, loc = vn(13, 31, 51), size = vn(2, 8, 8)},
	{act = 'stair', node = stone_stairs_block_3rd, param2 = 0, loc = vn(13, 31, 21), size = vn(2, 8, 8)},
	{act = 'stair', node = stone_stairs_block_3rd, param2 = 3, loc = vn(51, 31, 65), size = vn(8, 8, 2)},
	{act = 'stair', node = stone_stairs_block_3rd, param2 = 1, loc = vn(21, 31, 65), size = vn(8, 8, 2)},
	{act = 'stair', node = stone_stairs_block_3rd, param2 = 3, loc = vn(51, 31, 13), size = vn(8, 8, 2)},
	{act = 'stair', node = stone_stairs_block_3rd, param2 = 1, loc = vn(21, 31, 13), size = vn(8, 8, 2)},
}

for _, item in pairs(default_exits) do
	table.insert(p, 2, table.copy(item))
end

for _, item in pairs(placeholder_y51) do
	table.insert(p, 2, table.copy(item))
end

if seal_underground then
	table.insert(p, 1, table.copy(seal_box))
end

register_geomorph({
	name = 'arena',
	areas = 'geomoria',
	data = p,
})


-----------------------------------------------------
--prison

p = {
	{act = 'cube', node = 'air', loc = vn(0, 21, 19), size = vn(1, 2, 2)},
	{act = 'cube', node = 'air', loc = vn(0, 21, 39), size = vn(1, 2, 2)},
	{act = 'cube', node = 'air', loc = vn(0, 21, 59), size = vn(1, 2, 2)},
	{act = 'cube', node = 'air', loc = vn(79, 21, 19), size = vn(1, 2, 2)},
	{act = 'cube', node = 'air', loc = vn(79, 21, 39), size = vn(1, 2, 2)},
	{act = 'cube', node = 'air', loc = vn(79, 21, 59), size = vn(1, 2, 2)},
	{act = 'cube', node = 'air', loc = vn(19, 21, 0), size = vn(2, 2, 1)},
	{act = 'cube', node = 'air', loc = vn(39, 21, 0), size = vn(2, 2, 1)},
	{act = 'cube', node = 'air', loc = vn(59, 21, 0), size = vn(2, 2, 1)},
	{act = 'cube', node = 'air', loc = vn(19, 21, 79), size = vn(2, 2, 1)},
	{act = 'cube', node = 'air', loc = vn(39, 21, 79), size = vn(2, 2, 1)},
	{act = 'cube', node = 'air', loc = vn(59, 21, 79), size = vn(2, 2, 1)},

	{act = 'cube', node = 'air', loc = vn(38, 21, 1), size = vn(4, 3, 78)},
	{act = 'cube', node = 'air', loc = vn(1, 21, 58), size = vn(78, 3, 4)},
	{act = 'cube', node = 'air', loc = vn(1, 21, 18), size = vn(78, 3, 4)},
	{act = 'cube', node = 'air', loc = vn(1, 21, 37), size = vn(8, 3, 6)},
	{act = 'cube', node = 'air', loc = vn(10, 21, 30), size = vn(25, 5, 20)},
	{act = 'cube', node = 'air', loc = vn(35, 21, 38), size = vn(3, 3, 4)},
	{act = 'cube', node = 'air', loc = vn(42, 21, 38), size = vn(37, 3, 4)},
	{act = 'cube', node = 'air', loc = vn(51, 21, 42), size = vn(2, 3, 1)},
	{act = 'cube', node = 'air', loc = vn(51, 21, 37), size = vn(2, 3, 1)},
	{act = 'cube', node = 'air', loc = vn(69, 21, 42), size = vn(2, 3, 1)},
	{act = 'cube', node = 'air', loc = vn(69, 21, 37), size = vn(2, 3, 1)},
	{act = 'cube', node = 'air', loc = vn(44, 21, 43), size = vn(16, 6, 9)},
	{act = 'cube', node = 'air', loc = vn(44, 21, 28), size = vn(16, 6, 9)},
	{act = 'cube', node = 'air', loc = vn(62, 21, 43), size = vn(16, 6, 9)},
	{act = 'cube', node = 'air', loc = vn(62, 21, 28), size = vn(16, 6, 9)},

	{act = 'cube', node = 'air', loc = vn(24, 21, 71), size = vn(13, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(43, 21, 71), size = vn(13, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(24, 21, 7), size = vn(13, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(43, 21, 7), size = vn(13, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(16, 21, 71), size = vn(8, 3, 8)},
	{act = 'cube', node = 'air', loc = vn(56, 21, 71), size = vn(8, 3, 8)},
	{act = 'cube', node = 'air', loc = vn(16, 21, 1), size = vn(8, 3, 8)},
	{act = 'cube', node = 'air', loc = vn(56, 21, 1), size = vn(8, 3, 8)},
--[[
	{act = 'cube', node = 'doors:door_wood_a', param2 = 3, loc = vn(0, 21, 59), size = vn(1, 1, 1)},
	{act = 'cube', node = 'doors:door_wood_b', param2 = 3, loc = vn(0, 21, 60), size = vn(1, 1, 1)},
	{act = 'cube', node = 'doors:door_wood_b', param2 = 1, loc = vn(79, 21, 59), size = vn(1, 1, 1)},
	{act = 'cube', node = 'doors:door_wood_a', param2 = 1, loc = vn(79, 21, 60), size = vn(1, 1, 1)},

	{act = 'cube', node = 'doors:door_wood_a', param2 = 3, loc = vn(0, 21, 19), size = vn(1, 1, 1)},
	{act = 'cube', node = 'doors:door_wood_b', param2 = 3, loc = vn(0, 21, 20), size = vn(1, 1, 1)},
	{act = 'cube', node = 'doors:door_wood_b', param2 = 1, loc = vn(79, 21, 19), size = vn(1, 1, 1)},
	{act = 'cube', node = 'doors:door_wood_a', param2 = 1, loc = vn(79, 21, 20), size = vn(1, 1, 1)},

	{act = 'cube', node = 'doors:door_wood_a', param2 = 0, loc = vn(39, 21, 79), size = vn(1, 1, 1)},
	{act = 'cube', node = 'doors:door_wood_b', param2 = 0, loc = vn(40, 21, 79), size = vn(1, 1, 1)},
	{act = 'cube', node = 'doors:door_wood_b', param2 = 2, loc = vn(39, 21, 0), size = vn(1, 1, 1)},
	{act = 'cube', node = 'doors:door_wood_a', param2 = 2, loc = vn(40, 21, 0), size = vn(1, 1, 1)},
]]
	{act = 'cube', node = 'air', loc = vn(37, 21, 71), size = vn(1, 2, 2)},
	{act = 'cube', node = 'air', loc = vn(42, 21, 71), size = vn(1, 2, 2)},
	--[[
	{act = 'cube', node = 'doors:door_wood_b', param2 = 1, loc = vn(37, 21, 71), size = vn(1, 1, 1)},
	{act = 'cube', node = 'doors:door_wood_a', param2 = 1, loc = vn(37, 21, 72), size = vn(1, 1, 1)},
	{act = 'cube', node = 'doors:door_wood_a', param2 = 3, loc = vn(42, 21, 71), size = vn(1, 1, 1)},
	{act = 'cube', node = 'doors:door_wood_b', param2 = 3, loc = vn(42, 21, 72), size = vn(1, 1, 1)},
]]
	{act = 'cube', node = 'air', loc = vn(37, 21, 7), size = vn(1, 2, 2)},
	{act = 'cube', node = 'air', loc = vn(42, 21, 7), size = vn(1, 2, 2)},
	--[[
	{act = 'cube', node = 'doors:door_wood_b', param2 = 1, loc = vn(37, 21, 7), size = vn(1, 1, 1)},
	{act = 'cube', node = 'doors:door_wood_a', param2 = 1, loc = vn(37, 21, 8), size = vn(1, 1, 1)},
	{act = 'cube', node = 'doors:door_wood_a', param2 = 3, loc = vn(42, 21, 7), size = vn(1, 1, 1)},
	{act = 'cube', node = 'doors:door_wood_b', param2 = 3, loc = vn(42, 21, 8), size = vn(1, 1, 1)},

	{act = 'cube', node = 'doors:door_wood_b', param2 = 1, loc = vn(79, 21, 39), size = vn(1, 1, 1)},
	{act = 'cube', node = 'doors:door_wood_a', param2 = 1, loc = vn(79, 21, 40), size = vn(1, 1, 1)},
]]
	{act = 'cube', node = 'air', loc = vn(9, 21, 39), size = vn(1, 2, 2)},

	--{act = 'cube', node = 'doors:door_wood_b', param2 = 1, loc = vn(9, 21, 39), size = vn(1, 1, 1)},
	--{act = 'cube', node = 'doors:door_wood_a', param2 = 1, loc = vn(9, 21, 40), size = vn(1, 1, 1)},

	{act = 'cube', node = 'air', loc = vn(28, 21, 26), size = vn(1, 2, 1)},--?
	{act = 'cube', node = 'air', loc = vn(27, 31, 26), size = vn(3, 3, 3)},
	{act = 'cube', node = 'air', loc = vn(28, 31, 29), size = vn(1, 3, 10)},
	{act = 'cube', node = 'air', loc = vn(3, 31, 39), size = vn(74, 3, 2)},
	{act = 'cube', node = 'air', treasure = 3, loc = vn(3, 31, 42), size = vn(9, 4, 6)},
	{act = 'cube', node = 'air', treasure = 3, loc = vn(47, 31, 42), size = vn(9, 4, 6)},
	{act = 'cube', node = 'air', treasure = 3, loc = vn(32, 31, 32), size = vn(9, 4, 6)},
	{act = 'cube', node = 'air', treasure = 3, loc = vn(64, 31, 32), size = vn(9, 4, 6)},
	{act = 'cube', node = 'air', treasure = 3, loc = vn(11, 31, 32), size = vn(9, 4, 6)},
	{act = 'cube', node = 'air', loc = vn(6, 31, 41), size = vn(2, 3, 1)},
	{act = 'cube', node = 'air', loc = vn(51, 31, 41), size = vn(2, 3, 1)},
	{act = 'cube', node = 'air', loc = vn(14, 31, 38), size = vn(2, 3, 1)},
	{act = 'cube', node = 'air', loc = vn(36, 31, 38), size = vn(2, 3, 1)},
	{act = 'cube', node = 'air', loc = vn(66, 31, 38), size = vn(2, 3, 1)},
	--{act = 'ladder', node = 'default:ladder_steel', param2 = 2, loc = vn(28, 21, 27), size = vn(1, 10, 1)},
}

for _, o in pairs({0, 43}) do
	for x = 4 + o, 32 + o, 4 do
		for _, y in pairs({57, 17}) do
			local i = {act = 'cube', node = 'air', loc = vn(x, 21, y + 5), size = vn(1, 2, 1)}
			table.insert(p, i)
			--i = {act = 'cube', node = 'doors:door_wood_a', param2 = 0, loc = vn(x, 21, y + 5), size = vn(1, 1, 1)}
			--table.insert(p, i)
			i = {act = 'cube', node = 'air', loc = vn(x - 1, 21, y + 6), size = vn(3, 3, 3)}
			table.insert(p, i)

			i = {act = 'cube', node = 'air', loc = vn(x, 21, y), size = vn(1, 2, 1)}
			table.insert(p, i)
			--i = {act = 'cube', node = 'doors:door_wood_a', param2 = 2, loc = vn(x, 21, y), size = vn(1, 1, 1)}
			--table.insert(p, i)
			i = {act = 'cube', node = 'air', loc = vn(x - 1, 21, y - 3), size = vn(3, 3, 3)}
			table.insert(p, i)
		end
	end
end

for _, item in pairs(placeholder_y51) do
	table.insert(p, 2, table.copy(item))
end

if seal_underground then
	table.insert(p, 1, table.copy(seal_box))
end

register_geomorph({
	name = 'prison',
	areas = 'geomoria',
	data = p,
})


-----------------------------------------------------
--stair_base

--[[
p = {
	{act = 'sphere', node = 'air', loc = vn(1, -18, 1), size = vn(78, 78, 78)},
	{act = 'cube', node = building_stone, loc = vn(1, 0, 1), size = vn(78, 21, 78)},
	{act = 'cube', node = 'default:stone_block', loc = vn(1, 20, 1), size = vn(78, 1, 78)},
}
]]


-- used in stair base as well as height

p = {
	{act = 'cube', node = stone_main, loc = vn(26, 0, 23), size = vn(5, 5, 31)},
	{act = 'cube', node = stone_main, loc = vn(26, 0, 49), size = vn(28, 26, 5)},
	{act = 'cube', node = stone_main, loc = vn(49, 19, 29), size = vn(5, 27, 28)},
	{act = 'cube', node = stone_main, loc = vn(29, 39, 26), size = vn(25, 27, 5)},
	{act = 'cube', node = stone_main, loc = vn(26, 59, 26), size = vn(5, 21, 28)},
	{act = 'cube', node = 'air', loc = vn(27, 0, 47), size = vn(3, 4, 6)},
	{act = 'stair', node = stone_stairs_main, height = 4, depth = 3, param2 = 1, loc = vn(30, 0, 50), size = vn(20, 20, 3)},
	{act = 'cube', node = 'air', loc = vn(47, 20, 50), size = vn(6, 4, 3)},
	{act = 'stair', node = stone_stairs_main, height = 4, depth = 3, param2 = 2, loc = vn(50, 20, 30), size = vn(3, 20, 20)},
	{act = 'cube', node = 'air', loc = vn(50, 40, 27), size = vn(3, 4, 6)},
	{act = 'stair', node = stone_stairs_main, height = 4, depth = 3, param2 = 3, loc = vn(30, 40, 27), size = vn(20, 20, 3)},
	{act = 'cube', node = 'air', loc = vn(27, 60, 27), size = vn(6, 4, 3)},
	{act = 'stair', node = stone_stairs_main, height = 4, depth = 3, param2 = 0, loc = vn(27, 60, 30), size = vn(3, 21, 20)},
}

--[[
register_geomorph({
	name = 'stair_height',
	areas = 'geomoria',
	data = p,
})
--]]

local q = table.copy(p)
p = {
	{act = 'sphere', node = 'air', loc = vn(35, 31, 35), size = vn(40, 40, 40)},
	{act = 'cube', node = stone_main, loc = vn(35, 31, 35), size = vn(40, 20, 40)},
	{act = 'cube', node = stone_block_main, loc = vn(35, 50, 35), size = vn(40, 1, 40)},

	{act = 'stair', node = stone_stairs_main, height = 4, param2 = 3, loc = vn(50, 41, 10), size = vn(10, 10, 2)},
	{act = 'stair', node = stone_stairs_main, height = 4, param2 = 0, loc = vn(10, 41, 25), size = vn(2, 10, 10)},
	{act = 'stair', node = stone_stairs_main, height = 4, param2 = 3, loc = vn(20, 41, 55), size = vn(10, 10, 2)},
	{act = 'cube', node = 'air', loc = vn(55, 41, 20), size = vn(15, 5, 50)},
	{act = 'cube', node = 'air', loc = vn(60, 46, 25), size = vn(5, 1, 40)},
	{act = 'cube', node = 'air', loc = vn(60, 41, 15), size = vn(2, 3, 5)},
	{act = 'cube', node = 'air', loc = vn(30, 41, 55), size = vn(2, 3, 10)},
	{act = 'cube', node = 'air', loc = vn(60, 41, 10), size = vn(10, 3, 5)},
	{act = 'cube', node = 'air', loc = vn(33, 41, 20), size = vn(22, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(23, 41, 9), size = vn(12, 4, 11)},
	{act = 'cube', node = 'air', loc = vn(12, 41, 9), size = vn(11, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(10, 41, 9), size = vn(2, 3, 16)},


	{act = 'cube', node = 'air', loc = vn(66, 51, 39), size = vn(13, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(39, 51, 66), size = vn(2, 3, 13)},
	{act = 'cube', node = 'air', loc = vn(1, 51, 39), size = vn(4, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(5, 51, 10), size = vn(2, 3, 55)},
	{act = 'cube', node = 'air', loc = vn(7, 51, 10), size = vn(43, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(25, 51, 14), size = vn(11, 4, 11)},
	{act = 'cube', node = 'air', loc = vn(38, 51, 14), size = vn(11, 4, 11)},
	{act = 'cube', node = 'air', loc = vn(51, 51, 14), size = vn(11, 4, 11)},
	{act = 'cube', node = 'air', loc = vn(64, 51, 14), size = vn(11, 4, 11)},
	{act = 'cube', node = 'air', loc = vn(36, 51, 1), size = vn(8, 4, 8)},
	{act = 'cube', node = 'air', loc = vn(39, 51, 9), size = vn(2, 3, 1)},
	{act = 'cube', node = 'air', loc = vn(29, 51, 12), size = vn(2, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(36, 51, 14), size = vn(2, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(49, 51, 23), size = vn(2, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(62, 51, 14), size = vn(2, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(5, 51, 65), size = vn(15, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(10, 51, 35), size = vn(2, 3, 30)},
	{act = 'cube', node = 'air', loc = vn(18, 51, 55), size = vn(2, 3, 10)},
	{act = 'cube', node = 'air', loc = vn(14, 51, 55), size = vn(2, 3, 10)},
	{act = 'stair', node = stone_stairs_main, height = 4, param2 = 2, loc = vn(14, 51, 45), size = vn(2, 10, 10)},

	{act = 'cube', node = 'air', loc = vn(14, 61, 22), size = vn(2, 3, 23)},
	{act = 'cube', node = 'air', loc = vn(14, 61, 4), size = vn(61, 5, 18)},
	{act = 'cube', node = 'air', loc = vn(16, 66, 6), size = vn(14, 1, 14)},
	{act = 'cube', node = 'air', loc = vn(36, 66, 6), size = vn(14, 1, 14)},
	{act = 'cube', node = 'air', loc = vn(56, 66, 6), size = vn(14, 1, 14)},
	{act = 'cube', node = 'air', loc = vn(50, 61, 22), size = vn(10, 5, 21)},
	{act = 'cube', node = stone_main, loc = vn(48, 60, 34), size = vn(14, 1, 42)},
	{act = 'cube', node = stone_main, loc = vn(34, 60, 54), size = vn(14, 1, 2)},
	{act = 'cube', node = 'air', loc = vn(23, 61, 54), size = vn(17, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(13, 61, 56), size = vn(12, 4, 16)},
	{act = 'cube', node = 'air', loc = vn(25, 61, 70), size = vn(9, 4, 9)},

	{act = 'cube', node = 'air', loc = vn(65, 31, 70), size = vn(7, 3, 9)},
	{act = 'cube', node = 'air', loc = vn(57, 31, 39), size = vn(12, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(57, 31, 11), size = vn(2, 3, 28)},
	{act = 'cube', node = 'air', loc = vn(35, 31, 70), size = vn(10, 3, 9)},
	{act = 'stair', node = stone_stairs_main, height = 4, param2 = 2, loc = vn(30, 31, 65), size = vn(2, 10, 10)},
	{act = 'cube', node = 'air', loc = vn(30, 31, 75), size = vn(5, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(45, 31, 75), size = vn(8, 3, 2)},

	{act = 'cube', node = 'air', loc = vn(57, 21, 1), size = vn(6, 6, 78)},
	{act = 'cube', node = 'air', loc = vn(63, 21, 58), size = vn(9, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(72, 21, 56), size = vn(7, 3, 8)},
	{act = 'stair', node = stone_stairs_main, depth = 2, height = 4, param2 = 3, loc = vn(69, 21, 39), size = vn(10, 10, 2)},
	{act = 'sphere', node = 'air', loc = vn(10, 11, 2), size = vn(20, 20, 20)},
	{act = 'cube', node = stone_main, loc = vn(10, 11, 2), size = vn(20, 10, 20)},
	{act = 'cube', node = stone_block_main, loc = vn(10, 20, 2), size = vn(20, 1, 20)},
	{act = 'cube', node = 'air', loc = vn(19, 21, 1), size = vn(2, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(35, 21, 21), size = vn(13, 5, 27)},
	{act = 'cube', node = 'air', loc = vn(37, 21, 55), size = vn(16, 5, 10)},
	{act = 'cube', node = 'air', loc = vn(51, 21, 53), size = vn(2, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(35, 21, 48), size = vn(2, 3, 9)},
	{act = 'stair', node = stone_stairs_main, height = 4, param2 = 0, loc = vn(51, 21, 65), size = vn(2, 10, 10)},
	{act = 'cube', node = 'air', loc = vn(39, 21, 65), size = vn(2, 3, 14)},
	{act = 'stair', node = stone_stairs_main, height = 4, param2 = 0, loc = vn(65, 21, 60), size = vn(2, 10, 10)},

	{act = 'cube', node = stone_stairs_main, param2 = 0, loc = vn(51, 20, 53), size = vn(2, 1, 1)},

	{act = 'cube', node = 'air', loc = vn(5, 26, 5), size = vn(4, 3, 6)},
	{act = 'cube', node = 'air', loc = vn(45, 31, 11), size = vn(12, 3, 2)},
	{act = 'stair', node = stone_stairs_main, height = 5, param2 = 1, loc = vn(40, 26, 11), size = vn(5, 5, 2)},
	{act = 'cube', node = 'air', loc = vn(5, 26, 11), size = vn(35, 3, 2)},
	{act = 'cube', node = stone_main, loc = vn(9, 25, 11), size = vn(22, 1, 2)},

	{act = 'cube', node = 'air', loc = vn(64, 21, 20), size = vn(7, 3, 1)},
	{act = 'cube', node ='air', loc = vn(64, 21, 20), size = vn(1, 3, 1)},--?
	{act = 'cube', node = 'air', loc = vn(41, 21, 11), size = vn(16, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(71, 21, 3), size = vn(2, 3, 52)},
	{act = 'cube', node = 'air', loc = vn(73, 21, 19), size = vn(6, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(74, 21, 42), size = vn(5, 4, 13)},
	{act = 'cube', node = 'air', loc = vn(73, 21, 48), size = vn(1, 2, 1)},
	--{act = 'cube', node = 'doors:door_wood_b', param2 = 1, loc = vn(73, 21, 48), size = vn(1, 1, 1)},

	{act = 'cube', node = 'air', loc = vn(29, 21, 11), size = vn(10, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(39, 21, 1), size = vn(2, 3, 12)},
	{act = 'cube', node = 'air', loc = vn(1, 21, 11), size = vn(10, 3, 2)},
	{act = 'cube', node = 'air', loc = vn(1, 21, 13), size = vn(2, 3, 8)},
	{act = 'cube', node = 'air', loc = vn(19, 21, 21), size = vn(2, 3, 58)},
	{act = 'cube', node = 'air', loc = vn(21, 21, 55), size = vn(14, 3, 2)},
	{act = 'cube', node = 'air', floor = stone_block_main, loc = vn(1, 21, 25), size = vn(14, 4, 50)},
	{act = 'cube', node = 'air', loc = vn(2, 25, 26), size = vn(12, 1, 48)},
	{act = 'cube', node = 'air', loc = vn(3, 26, 27), size = vn(10, 1, 46)},
	{act = 'cube', node = 'air', loc = vn(4, 27, 28), size = vn(8, 1, 44)},
	{act = 'cube', node = 'air', loc = vn(15, 21, 49), size = vn(4, 3, 2)},
	{act = 'cube', node = stone_block_3rd, loc = vn(5, 21, 30), size = vn(5, 1, 40)},
	{act = 'cube', node = freshwater, loc = vn(6, 21, 31), size = vn(3, 1, 38)},
	{act = 'stair', node = stone_stairs_main, height = 4, param2 = 2, loc = vn(70, 31, 60), size = vn(2, 10, 10)},
}

for y = 2, 78, 3 do
	for x = 56, 63, 7 do
		table.insert(p, {act = 'cube', node = 'air', loc = vn(x, 21, y), size = vn(1, 3, 1)})
	end
end

for _, y in pairs({1, 7, 13, 22, 28, 34, 40, 46, 52}) do
	table.insert(p, {act = 'cube', node = 'air', loc = vn(65, 21, y), size = vn(5, 3, 5)})
	table.insert(p, {act = 'cube', node = 'air', loc = vn(70, 21, y + 2), size = vn(1, 2, 1)})
--	table.insert(p, {act = 'cube', node = 'doors:door_wood_a', param2 = 3, loc = vn(70, 21, y + 2), size = vn(1, 1, 1)})
end

for _, y in pairs({1, 7, 13, 22, 28}) do
	table.insert(p, {act = 'cube', node = 'air', loc = vn(74, 21, y), size = vn(5, 3, 5)})
	table.insert(p, {act = 'cube', node = 'air', loc = vn(73, 21, y + 2), size = vn(1, 2, 1)})
	--table.insert(p, {act = 'cube', node = 'doors:door_wood_b', param2 = 1, loc = vn(73, 21, y + 2), size = vn(1, 1, 1)})
end

for _, y in pairs({24, 30, 36, 42, 48, 59, 65, 71}) do
	table.insert(p, {act = 'cube', node = 'air', loc = vn(22, 21, y), size = vn(5, 3, 5)})
	table.insert(p, {act = 'cube', node = 'air', loc = vn(21, 21, y + 2), size = vn(1, 2, 1)})
--	table.insert(p, {act = 'cube', node = 'doors:door_wood_b', param2 = 1, loc = vn(21, 21, y + 2), size = vn(1, 1, 1)})
end

for _, item in pairs(default_exits) do
	table.insert(p, 2, table.copy(item))
end

for i = #p, 1, -1 do
	table.insert(q, 6, p[i])
end

if seal_underground then
	table.insert(q, table.copy(seal_box))
end

register_geomorph({
	name = 'stair_base',
	areas = 'geomoria',
	data = q,
})