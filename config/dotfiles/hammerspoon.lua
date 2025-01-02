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
