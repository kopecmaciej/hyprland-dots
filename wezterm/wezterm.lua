local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Tokyo Night"
config.enable_wayland = false
config.window_background_opacity = 0.9
config.prefer_egl = false

config.allow_square_glyphs_to_overflow_width = "Always"

config.font = wezterm.font("JetBrainsMonoNerdFont", { weight = "Regular", italic = false })
config.font_size = 14

wezterm.on("update-right-status", function(window, pane)
	local leader = ""
	if window:leader_is_active() then
		leader = "L"
	end
	window:set_right_status(leader)
end)

config.leader = { key = "f", mods = "CTRL", timeout_milliseconds = 1000 }
config.colors = { compose_cursor = "orange" }
config.hide_tab_bar_if_only_one_tab = true
-- config.enable_tab_bar = false

wezterm.on("toggle-tabbar", function(window, _)
	local overrides = window:get_config_overrides() or {}
	if overrides.enable_tab_bar == false then
		wezterm.log_info("tab bar shown")
		overrides.enable_tab_bar = true
	else
		wezterm.log_info("tab bar hidden")
		overrides.enable_tab_bar = false
	end
	window:set_config_overrides(overrides)
end)

local act = wezterm.action
config.keys = {
	-- new tab
	{ key = "c", mods = "LEADER", action = act.SpawnTab("DefaultDomain") },
	-- close tab
	{ key = "x", mods = "LEADER", action = act.CloseCurrentTab({ confirm = true }) },
	-- move to the left tab
	{ key = "h", mods = "SHIFT|ALT", action = act.ActivateTabRelative(-1) },
	-- move to the right tab
	{ key = "l", mods = "SHIFT|ALT", action = act.ActivateTabRelative(1) },
	-- move to the left pane
	{ key = "l", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Next") },
	-- move to the right pane
	{ key = "h", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Next") },
	-- split pane horizontally
	{ key = "-", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	-- split pane vertically
	{ key = "-", mods = "LEADER|CTRL", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- toggle full screen
	{ key = "f", mods = "LEADER", action = act.ToggleFullScreen },
	-- toggle title bar
	{ key = "T", mods = "CTRL", action = act.EmitEvent("toggle-tabbar") },
	{
		key = "n",
		mods = "SHIFT|CTRL",
		action = act.ToggleFullScreen,
	},
}

return config
