--Royal_Death.lua

H = wesnoth.require "lua/helper.lua"

--WML constructs
W = H.set_wml_action_metatable{} --Treats tags as callable functions.
T = H.set_wml_tag_metatable{} --For subtags
V = H.set_wml_var_metatable{} --Contains WML variables.

_ = wesnoth.textdomain "royal_death"

--Returns a random value.
--range: A string giving the range of values. Warning: Any '-' will be changed
--to a '..'. This is so you can pass in a coordinate range and get back a single
--number.
local function random(range)
   range = range:gsub('-', '..')
   W.set_variable{
      name = 'random',
      rand = range
   }
   local result = V.random
   V.random = nil
   return result
end

--Picks a random hex and changes the terrain to a wall.
--x,y: The range of hexes to choose from.
wesnoth.register_wml_action(
   'place_wall',
   function(cfg)
      local x = random(cfg.x)
      local y = random(cfg.y)
      W.scroll_to{
	 x = x,
	 y = y
      }
      W.terrain{
	 terrain = 'Xos',
	 x = x,
	 y = y
      }
   end)

--Sets the turn limit to current turn + 6.
wesnoth.register_wml_action(
   'reset_turns',
   function()
      W.modify_turns{
	 value = wesnoth.current.turn + 6
      }
   end)
