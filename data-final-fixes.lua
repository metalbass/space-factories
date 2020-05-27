local SPACE_FACTORIES = "__space-factories__"

local factory_collision_mask = {"item-layer","object-layer","player-layer","water-tile", "ground-tile"}

local function copy_factory(original_name, suffix, allow_recipe, minable_count)
    local entity = table.deepcopy(data.raw["storage-tank"][original_name .. suffix])
    entity.name = "space-" .. original_name .. suffix
    entity.localised_name = {"entity-name." .. entity.name .. suffix}

    entity.collision_mask = factory_collision_mask

    entity.minable.result = entity.name
    entity.minable.count = minable_count

    entity.pictures.picture.layers[2].filename = SPACE_FACTORIES .. "/graphics/factory/".. original_name ..".png"

    local item = table.deepcopy(data.raw.item[original_name .. suffix])
    item.name = entity.name
    item.localised_name = {"item-name." .. entity.name}

    item.icon = SPACE_FACTORIES .. "/graphics/icon/".. original_name ..".png"

    item.place_result = entity.name

    if allow_recipe then
        local recipe = table.deepcopy(data.raw.recipe[original_name .. suffix])
        recipe.name = entity.name
        recipe.localised_name = {"recipe-name." .. entity.name}
        recipe.result = entity.name

        data:extend({entity, item, recipe})
    else
        data:extend({entity, item})
    end

end

local function copy_factory_overlay(original_name)
    local overlay = table.deepcopy(data.raw["simple-entity"][original_name .. "-overlay"])
    overlay.name = "space-" .. original_name .. "-overlay"

    overlay.picture.layers[2].filename = SPACE_FACTORIES .. "/graphics/factory/".. original_name ..".png"

    data:extend({overlay})
end

local function copy_factory_floors()
    local space_platform = data.raw.tile["se-space-platform-plating"]

    local space_factory_floor = table.deepcopy(data.raw.tile["factory-floor-1"])
    space_factory_floor.name = "space-factory-floor"

    space_factory_floor.collision_mask = space_platform.collision_mask

    space_factory_floor.variants.main = space_platform.variants.main

    local space_factory_floor_pattern = table.deepcopy(space_factory_floor)
    space_factory_floor_pattern.name = "space-factory-floor-pattern"
    space_factory_floor_pattern.tint = { r = 0.75, g = 0.75, b = 0.75, a = 1 }

    local space_factory_entrance = table.deepcopy(data.raw.tile["factory-entrance-1"])
    space_factory_entrance.name = "space-factory-entrance"
    space_factory_entrance.variants.main = space_platform.variants.main

    data:extend({space_factory_floor, space_factory_floor_pattern, space_factory_entrance})
end


local factory_names = {"factory-1", "factory-2", "factory-3"}

for _, original_name in ipairs(factory_names) do
    copy_factory(original_name, "", true, 0)
    for i=10,99 do
        copy_factory(original_name, "-s" .. i, false, 1)
    end
    copy_factory(original_name, "-i", false, 1)

    copy_factory_overlay(original_name)
end

copy_factory_floors()
