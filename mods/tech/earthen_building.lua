-------------------------------------------------------------
--EARTHEN BUILDING
-- construction from loose stones, mud etc


---------------------------------
--DRYSTACK
-- walls made from stacked stones (no mortar, hence dry)
-- made from loose found stones

minetest.register_node("tech:drystack", {
	description = "Drystack",
	tiles = {"tech_drystack.png"},
	stack_max = minimal.stack_max_bulky *2,
	groups = {cracky = 3, crumbly = 1, oddly_breakable_by_hand = 1},
	sounds = nodes_nature.node_sound_stone_defaults(),
})



-- Stairs and slab for drystack
stairs.register_stair_and_slab(
	"drystack",
	"tech:drystack",
	"mixing_spot",
	"true",
	{cracky = 3, crumbly = 1, oddly_breakable_by_hand = 1},
	{"tech_drystack.png"},
	"Drystack Stair",
	"Drystack Slab",
	minimal.stack_max_bulky *4,
	nodes_nature.node_sound_stone_defaults()
)


------------------------------------------
--MUDBRICK

minetest.register_node('tech:mudbrick', {
	description = 'Mudbrick',
	tiles = {"tech_mudbrick.png"},
	stack_max = minimal.stack_max_bulky *2,
	groups = {crumbly = 2, cracky = 3, oddly_breakable_by_hand = 1},
	sounds = nodes_nature.node_sound_dirt_defaults(),
})

stairs.register_stair_and_slab(
	"mudbrick",
	"tech:mudbrick",
	"mixing_spot",
	"true",
	{crumbly = 2, cracky = 3, oddly_breakable_by_hand = 1},
	{"tech_mudbrick.png"},
	"Mudbrick Stair",
	"Mudbrick Slab",
	minimal.stack_max_bulky *4,
	nodes_nature.node_sound_dirt_defaults()
)


	-----------------------------------------------------------
	--WATTLE

minetest.register_node('tech:wattle', {
	description = 'Wattle',
	drawtype = "nodebox",
	node_box = {
		type = "connected",
		fixed = {{-1/8, -1/2, -1/8, 1/8, 1/2, 1/8}},
		-- connect_bottom =
		connect_front = {{-1/8, -1/2, -1/2,  1/8, 1/2, -1/8}},
		connect_left = {{-1/2, -1/2, -1/8, -1/8, 1/2,  1/8}},
		connect_back = {{-1/8, -1/2,  1/8,  1/8, 1/2,  1/2}},
		connect_right = {{ 1/8, -1/2, -1/8,  1/2, 1/2,  1/8}},
	},
	connects_to = { "group:crumbly", "group:tree", "group:log", "group:stone", "group:soft_stone", 'tech:wattle', 'tech:thatch'},
	paramtype = "light",
	tiles = {"tech_wattle_top.png",
	 				"tech_wattle_top.png",
					"tech_wattle.png",
					"tech_wattle.png",
					"tech_wattle.png",
					"tech_wattle.png" },
	inventory_image = "tech_wattle.png",
	wield_image = "tech_wattle.png",
	stack_max = minimal.stack_max_bulky * 2,
	groups = {choppy = 3, oddly_breakable_by_hand = 1, flammable = 1},
	sounds = nodes_nature.node_sound_wood_defaults(),
})




------------------------------------------
--THATCH

minetest.register_node('tech:thatch', {
	description = 'Thatch',
	tiles = {"tech_thatch.png"},
	stack_max = minimal.stack_max_bulky * 4,
	groups = {snappy=3, flammable=1},
	sounds = nodes_nature.node_sound_leaves_defaults(),
	on_burn = function(pos)
		if math.random()<0.5 then
			minetest.set_node(pos, {name = "tech:small_wood_fire"})
			minetest.check_for_falling(pos)
		else
			minetest.remove_node(pos)
		end
	end,
})

stairs.register_stair_and_slab(
	"thatch",
	"tech:thatch",
	"mixing_spot",
	"true",
	{snappy=3, flammable=1},
	{"tech_thatch.png"},
	"Thatch Stair",
	"Thatch Slab",
	minimal.stack_max_bulky * 8,
	nodes_nature.node_sound_leaves_defaults()
)



---------------------------------------
--Recipes

--
--Hand crafts (Cradting spot)
--

----craft drystack from gravel
crafting.register_recipe({
	type = "crafting_spot",
	output = "tech:drystack",
	items = {"nodes_nature:gravel 2"},
	level = 1,
	always_known = true,
})

--recycle drystack with some loss
crafting.register_recipe({
	type = "mixing_spot",
	output = "nodes_nature:gravel",
	items = {"tech:drystack"},
	level = 1,
	always_known = true,
})


----mudbrick from clay + sand and fibre
--(other recipes could be done also, but limit it for simplicity)
crafting.register_recipe({
	type = "crafting_spot",
	output = "tech:mudbrick 2",
	--items = {"nodes_nature:clay_wet", "nodes_nature:sand_wet", "group:fibrous_plant"},
	items = {"nodes_nature:clay", "nodes_nature:sand_wet", "group:fibrous_plant"},
	level = 1,
	always_known = true,
})


----Wattle from sticks
crafting.register_recipe({
	type = "crafting_spot",
	output = "tech:wattle",
	items = {"tech:stick 6"},
	level = 1,
	always_known = true,
})


--recycle wattle with some loss
crafting.register_recipe({
	type = "mixing_spot",
	output = "tech:stick 4",
	items = {"tech:wattle"},
	level = 1,
	always_known = true,
})


----Thatch from  fibre
crafting.register_recipe({
	type = "crafting_spot",
	output = "tech:thatch",
	items = {"group:fibrous_plant 8"},
	level = 1,
	always_known = true,
})