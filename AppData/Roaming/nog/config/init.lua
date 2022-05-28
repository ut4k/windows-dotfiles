local direction_keys = {
  h = "left",
  j = "down",
  k = "up",
  l = "right"
}

local barStatusFancySymbol = function(symbol_)
  return {
    name = "FancySymbol",
    render = function()
      return {{ text = symbol_ }}
    end
  }
end

local barStatusFullScreenIndicator = function(indicator_active, indicator_inactive)
  return {
    name = "FullscreenIndicator",
    render = function(display_id)
      local ws_id = nog.get_focused_ws_of_display(display_id)

      if not ws_id then
        return {{ text = "" }}
      end

      local info = nog.get_ws_info(ws_id)

      return {{
        text = "🖥:" .. (info.is_fullscreen and indicator_active or indicator_inactive),
      }}
    end
  }
end


-- Nog has 10 workspaces
-- local workspaces = { 1, 2 }
local workspaces = { 1 }

-- nog.config.bar.font = "Fantasque Sans Mono"
nog.config.bar.font = "FantasqueSansMono Nerd Font"
nog.config.bar.font_size = 14
-- nog.config.bar.color = 0x843460
nog.config.bar.color = 0x393837
nog.config.bar.components = {
  left = {
	barStatusFancySymbol(" "),
	nog.components.padding(1),
	nog.components.workspaces()
  },
  center = { nog.components.current_window() },
  right = { 
    nog.components.split_direction({
		" ", " "
	}),
	nog.components.padding(1),
    nog.components.active_mode(),
	
	barStatusFullScreenIndicator("✔", "-"),
	nog.components.padding(1),
    nog.components.datetime("%Y/%m/%d %H:%M:%S"),
  }
}

nog.config.work_mode = true
-- draws the app bar while nog is in work mode
nog.config.display_app_bar = true
-- nog.config.display_app_bar = false
nog.config.launch_on_startup = false
nog.config.multi_monitor = true
-- hides the task bar while nog is in work mode
nog.config.remove_task_bar = t
nog.config.outer_gap  = 8
nog.config.inner_gap  = 8
nog.config.use_border = true
nog.config.light_theme = false
nog.config.remove_title_bar = false

-- We customize the first two workspaces with a custom display text
-- nog.config.workspaces = {
--   [1] = {
--    -- e62b : vim symbol
--    -- text = "  "
--    text = " 1 "
--   },
--   [2] = {
--    -- text = "  "
--    text = " 2 "
--   },
-- }


nog.config.rules = {
  -- we want to ignore explorer.exe, because the user experience is better when in floating mode IMO
	["explorer.exe"] = { 
		action = "ignore"
	},
	["taskmgr.exe"] = { 
		action = "ignore"
	}
}

nog.gbind("alt+i", nog.win_ignore)
nog.gbind("alt+q", nog.win_close)
nog.gbind("alt+m", nog.win_minimize)
nog.gbind("alt+x", nog.quit)

-- nog.nbind_tbl will map each key to its value so writing the nog.nbind_tbl line is equal to the following
nog.gbind("alt+l", function() nog.ws_focus("Right") end)
nog.gbind("alt+k", function() nog.ws_focus("Up") end)
nog.gbind("alt+j", function() nog.ws_focus("Down") end)
nog.gbind("alt+h", function() nog.ws_focus("Left") end)



nog.nbind("alt+c", nog.win_close)

-- RESIZE
-- nog.nbind("control+1", function()
-- 	nog.ws_resize("Up", 5)
-- end)
-- nog.gbind("control+2", function()
-- 	nog.ws_resize("Down", 5)
-- end)

nog.gbind("control+3", function()
-- nog.gbind("shift+h", function()
	nog.ws_resize("Left", 5)
end)
nog.gbind("control+shift+3", function()
-- nog.gbind("control+shift+h", function()
	nog.ws_resize("Left", -5)
	-- nog.ws_resize("Right", -5)
end)
nog.gbind("control+4", function()
-- nog.gbind("control+l", function()
	nog.ws_resize("Right", 5)
end)
nog.gbind("control+shift+4", function()
-- nog.gbind("control+shift+l", function()
	nog.ws_resize("Right", -5)
	-- nog.ws_resize("Left", -5)
end)

nog.nbind_tbl("alt", nog.ws_focus, direction_keys)
nog.nbind_tbl("alt+control", nog.ws_swap, direction_keys)

nog.nbind("alt+plus", function()
  nog.ws_set_split_direction("Vertical")
end)
nog.nbind("alt+minus", function()
  nog.ws_set_split_direction("Horizontal")
end)

nog.nbind("alt+control+f", nog.win_toggle_floating)
nog.nbind("alt+control+w", nog.toggle_work_mode)
nog.nbind("alt+f", nog.ws_toggle_fullscreen)

nog.nbind_tbl("alt+shift", nog.win_move_to_ws, workspaces)
nog.nbind_tbl("alt+control", nog.ws_move_to_monitor, workspaces)
nog.nbind_tbl("alt", nog.ws_change, workspaces)
