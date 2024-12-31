hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "W", function()
	hs.notify.new({ title = "Hammerspoon", informativeText = "Hello world!" }):send()
end)

hs.hotkey.bind({ "cmd" }, "return", function()
	hs.application.open("Ghostty")
end)

hs.hotkey.bind({ "cmd", "ctrl", "alt", "shift" }, "H", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x
	f.y = max.y
	f.w = max.w / 2
	f.h = max.h
	win:setFrame(f)
end)

hs.hotkey.bind({ "cmd", "ctrl", "alt", "shift" }, "L", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + (max.w / 2)
	f.y = max.y
	f.w = max.w / 2
	f.h = max.h
	win:setFrame(f)
end)

hs.hotkey.bind({ "cmd", "ctrl", "alt", "shift" }, "R", function()
	hs.reload()
end)
