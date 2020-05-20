local factory_names = { "factory-1", "factory-2", "factory-3" }
local floor_names = { "factory-floor", "factory-pattern" }

local space_layer = "layer-14"
local factory_collision_mask = {"item-layer","object-layer","player-layer","water-tile"}


local function make_factory_placeable_on_space(name)
  log("Editing collision_mask for: " .. name)

  data.raw["storage-tank"][name].collision_mask = factory_collision_mask
end


local function make_factories_placeable_on_space()
  for i=1, #factory_names do
    make_factory_placeable_on_space(factory_names[i]) -- generic factory item

    for j=10,99 do
      make_factory_placeable_on_space(factory_names[i] .. "-s" .. j) -- specific factory
    end
    
    make_factory_placeable_on_space(factory_names[i] .. "-i") -- invalid factory
  end
end


local function make_space_buildings_placeable_over_factory_floors()
  for i=1, #factory_names do
    for j=1, #floor_names do
      local tile_name = floor_names[j] .. "-" .. i

      log("Editing collision_mask for: " .. tile_name)

      data.raw.tile[tile_name].collision_mask = { space_layer }
    end
  end
end


make_factories_placeable_on_space()
make_space_buildings_placeable_over_factory_floors()
