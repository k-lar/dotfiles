local focusFlashTag = "focus_flash"
local focusFlashFadeTag = "focus_flash_fade"
local focusFlashDuration = 500
local focusFlashFadeDuration = 300

local focusFlashTimers = {}
local focusFlashFadeTimers = {}

local function stop_timer(timer)
	if timer then
		timer:set_enabled(false)
	end
end

local function clear_focus_tags(selector)
	stop_timer(focusFlashTimers[selector])
	stop_timer(focusFlashFadeTimers[selector])
	focusFlashTimers[selector] = nil
	focusFlashFadeTimers[selector] = nil
	hl.dispatch(hl.dsp.window.tag({ window = selector, tag = "-" .. focusFlashTag }))
	hl.dispatch(hl.dsp.window.tag({ window = selector, tag = "-" .. focusFlashFadeTag }))
end

local function flash_window_border(window)
	if not window or not window.address then
		return
	end

	local selector = "address:" .. window.address
	local target = hl.get_window(selector)
	if not target or target.hidden then
		return
	end

	clear_focus_tags(selector)
	hl.dispatch(hl.dsp.window.tag({ window = selector, tag = "-" .. focusFlashFadeTag }))
	hl.dispatch(hl.dsp.window.tag({ window = selector, tag = "+" .. focusFlashTag }))

	focusFlashTimers[selector] = hl.timer(function()
		local current = hl.get_window(selector)
		focusFlashTimers[selector] = nil

		if not current then
			clear_focus_tags(selector)
			return
		end

		hl.dispatch(hl.dsp.window.tag({ window = selector, tag = "+" .. focusFlashFadeTag }))
		hl.dispatch(hl.dsp.window.tag({ window = selector, tag = "-" .. focusFlashTag }))

		focusFlashFadeTimers[selector] = hl.timer(function()
			local faded = hl.get_window(selector)
			focusFlashFadeTimers[selector] = nil

			if not faded then
				clear_focus_tags(selector)
				return
			end

			hl.dispatch(hl.dsp.window.tag({ window = selector, tag = "-" .. focusFlashFadeTag }))
		end, { timeout = focusFlashFadeDuration, type = "oneshot" })
	end, { timeout = focusFlashDuration, type = "oneshot" })
end

hl.curve("focus_flash_border_curve", {
	type = "bezier",
	points = {
		{ 0.16, 1.0 },
		{ 0.3, 1.0 },
	}
})

hl.animation({
	leaf = "border",
	enabled = true,
	speed = 3,
	bezier = "focus_flash_border_curve",
})

hl.window_rule({
	match = { tag = focusFlashTag },
	border_color = "rgb(689D6A)",
})

hl.window_rule({
	match = { tag = focusFlashFadeTag },
	border_color = "rgba(689D6A00)",
})

hl.on("window.active", function(window)
	flash_window_border(window)
end)