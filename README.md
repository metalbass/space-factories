# HOW TO USE
In order to avoid rewriting Factorissimo, this mod tries to mimic the factories that Factorissimo already handles. It's not prepared to be used like this, so we will need to modify it a bit.

1. Go to your mods folder (e.g. %appadata%/Factorio/mods/)
2. Extract Factorissimo (e.g. %appadata%/Factorio/mods/Factorissimo2_2.4.2/)
3. Delete .zip file
4. Add this code at the bottom of Factorissimo2_2.4.2/layout.lua

		remote.add_interface("factorissimo-layout", {
			add_factory_layouts = function(layouts)
				for _, layout in ipairs(layouts) do
					layout_generators[layout.name] = function()
						return layout
					end
				end
			end
		})

5. Add this code at the bottom of Factorissimo2_2.4.2/control.lua

		remote.add_interface("factorissimo-control", {
			add_factory_names = function(layouts)
				for _, layout in ipairs(layouts) do
					local name = layout.name
					
					SAVE_ITEMS[name] = {}
					for n = 10,99 do
						SAVE_NAMES[name .. "-s" .. n] = true
						SAVE_ITEMS[name][n] = name .. "-s" .. n
					end
				end
			end
		})

6. Add this mod to your mods folder

Since the recipes are blocked by default, you will need to use this command to use them, for now:

		/c for name, recipe in pairs(game.player.force.recipes) do recipe.enabled = true end

# TODO:
- Localization support
- Add technology to unlock the recipes
- Balance recipes (they should probably consume space platforms)
- Find help to produce decent assets
- Proper testing
