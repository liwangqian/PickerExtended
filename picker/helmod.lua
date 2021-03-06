-------------------------------------------------------------------------------
--[Planner Pin Panel (helmod)]--
-------------------------------------------------------------------------------
local Gui = require('stdlib/event/gui')
local lib = require('picker/lib')

local function pick_helmod_pin(event)
    local player = game.players[event.player_index]
    local recipe_name, item_name
    string.gsub(
        event.match,
        'PlannerPinPanel_recipe_block_%d+=(.+)=(.+)',
        function(a, b)
            recipe_name = a
            item_name = b
        end
    )
    local item = game.item_prototypes[item_name]
    local items = {}
    local module = event.element.parent['factory-modules' .. recipe_name]
    if module then
        for _, child in pairs(module.children) do
            local name = child.sprite and child.sprite:gsub('item/(.+)', '%1')
            if name and game.item_prototypes[name] then
                items[#items + 1] = {
                    item = name,
                    count = 1
                }
            end
        end
    end

    if item and event.shift then
        local stack = lib.get_item_stack(player, item.name) or player.cheat_mode and {name = item.name, count = 1}
        if stack then
            player.cursor_stack.set_stack(stack)
            return stack.valid and stack.clear()
        end
    elseif item then
        local entity = item.place_result
        local recipe = game.recipe_prototypes[recipe_name]
        if entity and recipe then
            local bp = lib.get_planner(player, 'blueprint', 'Pipette Blueprint')
            if bp then
                bp.clear_blueprint()
                bp.label = 'Pipette Blueprint'
                bp.allow_manual_label_change = false
                local bp_ents = {
                    {
                        entity_number = 1,
                        name = entity.name,
                        position = {0, 0},
                        recipe = recipe.name,
                        items = items[1] and items
                    }
                }
                bp.set_blueprint_entities(bp_ents)
                return bp.is_blueprint_setup() and bp
            end
        end
    end
end
Gui.on_click('PlannerPinPanel_recipe_block_%d+=.+=.+', pick_helmod_pin)
