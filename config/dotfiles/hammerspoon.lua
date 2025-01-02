hs.application.enablespotlightfornamesearches(true)

-- hs.hotkey.bind({ "cmd" }, "left", function()
-- 	local win = hs.window.focusedWindow()
-- 	local f = win:frame()
-- 	local screen = win:screen()
-- 	local max = screen:frame()
--
-- 	f.x = max.x
-- 	f.y = max.y
-- 	f.w = max.w / 2
-- 	f.h = max.h
-- 	win:setFrame(f)
-- end)
--
-- hs.hotkey.bind({ "cmd" }, "right", function()
-- 	local win = hs.window.focusedWindow()
-- 	local f = win:frame()
-- 	local screen = win:screen()
-- 	local max = screen:frame()
--
-- 	f.x = max.x + (max.w / 2)
-- 	f.y = max.y
-- 	f.w = max.w / 2
-- 	f.h = max.h
-- 	win:setFrame(f)
-- end)

-- hs.hotkey.bind({ "cmd" }, "up", function()
-- 	local win = hs.window.focusedWindow()
-- 	local screen = win:screen()
-- 	local max = screen:frame()
--
-- 	win:setFrame(max)
-- end)

hs.hotkey.bind({ "cmd", "ctrl", "alt", "shift" }, "R", function()
	hs.reload()
end)

local app = hs.application.get("Ghostty")

if app == nil or not app:isRunning() then
	hs.hotkey.bind({ "cmd" }, "return", function()
		hs.application.open("Ghostty")
		hs.reload()
	end)
end

local hyper = { "cmd", "ctrl", "alt", "shift" }

hs.hotkey.bind(hyper, "space", function()
	hs.execute("yabai -m space --mirror y-axis")
end)
