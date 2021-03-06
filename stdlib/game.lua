--- Game module
-- @module game

Game = {}

--- Messages all players currently connected to the game
-- @param msg message to send to players
-- @param condition (optional) optional condition to be true for the player to be messaged
-- @return the number of players who received the message
function Game.print_all(msg, condition)
    local num = 0
	for _, player in ipairs(game.players) do
		if player.valid and player.connected then
            if condition == nil or select(2, pcall(condition, player)) then
			    player.print(msg)
                num = num + 1
            end
		end
	end
    return num
end

--- Messages all players with the given force connected to the game
-- @param force (may be force name string, or force object) the players with the given force to message
-- @param msg message to send to players
-- @return the number of players who received the message
function Game.print_force(force, msg)
    local force_name
    if type(force) == "string" then
        force_name = force
    else
        force_name = force.name
    end
	return Game.print_all(msg, function(player)
        return player.force.name == force_name
    end)
end

--- Messages all players with the given surface connected to the game
-- @param surface the players with the given surface to message
-- @param msg message to send to players
-- @return the number of players who received the message
function Game.print_surface(surface, msg)
    local surface_name
    if type(surface) == "string" then
        surface_name = surface
    else
        surface_name = surface.name
    end
	return Game.print_all(msg, function(player)
        return player.surface.name == surface_name
    end)
end
