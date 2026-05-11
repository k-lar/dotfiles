local M = {}
local min_cursor_zoom = 1.0
local max_cursor_zoom = 10.0

local function clamp_cursor_zoom(value)
	return math.max(min_cursor_zoom, math.min(value, max_cursor_zoom))
end

function M.envs(vars)
	for k, v in pairs(vars) do
		hl.env(k, v)
	end
end

function M.get_cursor_zoom_factor()
	local zoom = hl.get_config("cursor.zoom_factor")
	zoom = tonumber(zoom)

	if not zoom then
		return min_cursor_zoom
	end

	return zoom
end

function M.set_cursor_zoom_factor(value)
	local zoom = tonumber(value) or min_cursor_zoom

	hl.config({
		cursor = {
			zoom_factor = clamp_cursor_zoom(zoom)
		}
	})
end

function M.scale_cursor_zoom(delta)
	local current = M.get_cursor_zoom_factor()
	M.set_cursor_zoom_factor(current + delta)
end

return M
