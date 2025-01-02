local hyper = { "cmd", "ctrl", "alt", "shift" }
local ghostty = hs.application.get("Ghostty")

hs.application.enableSpotlightForNameSearches(true)

hs.hotkey.bind(hyper, "R", function()
	hs.reload()
end)

if ghostty == nil or not ghostty:isRunning() then
	hs.hotkey.bind({ "cmd" }, "return", function()
		hs.application.open("Ghostty")
		hs.reload()
	end)
end

hs.hotkey.bind(hyper, "space", function()
	hs.execute("/opt/homebrew/bin/yabai -m space --mirror y-axis")
end)

hs.hotkey.bind(hyper, "o", function()
	hs.execute("/opt/homebrew/bin/yabai -m window --focus east")
end)

hs.hotkey.bind(hyper, "y", function()
	hs.execute("/opt/homebrew/bin/yabai -m window --focus west")
end)

hs.hotkey.bind(hyper, "i", function()
	hs.execute("/opt/homebrew/bin/yabai -m window --focus north")
end)

hs.hotkey.bind(hyper, "u", function()
	hs.execute("/opt/homebrew/bin/yabai -m window --focus south")
end)
