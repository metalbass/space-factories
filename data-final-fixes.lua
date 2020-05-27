local factory_names = {"factory-1", "factory-2", "factory-3"}


local function copy_factory(original_name, suffix, allow_recipe, minable_count)
    local entity = table.deepcopy(data.raw["storage-tank"][original_name .. suffix])
    entity.name = "space-" .. original_name .. suffix
    entity.localised_name = {"entity-name." .. entity.name .. suffix}

    entity.minable.result = entity.name
    entity.minable.count = minable_count

    entity.pictures.picture.layers[2].filename = "__space-factories__/graphics/factory/".. original_name ..".png"

    local item = table.deepcopy(data.raw.item[original_name .. suffix])
    item.name = entity.name
    item.localised_name = {"item-name." .. entity.name}

    item.icon = "__space-factories__/graphics/icon/".. original_name ..".png"

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


for _, original_name in ipairs(factory_names) do
    copy_factory(original_name, "", true, 0)
    for i=10,99 do
        copy_factory(original_name, "-s" .. i, false, 1)
    end
    copy_factory(original_name, "-i", false, 1)

    local overlay = table.deepcopy(data.raw["simple-entity"][original_name .. "-overlay"])
    overlay.name = "space-" .. original_name .. "-overlay"

    overlay.picture.layers[2].filename = "__space-factories__/graphics/factory/".. original_name ..".png"

    data:extend({overlay})
end
