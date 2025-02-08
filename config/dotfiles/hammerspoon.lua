local hyper = { "cmd", "ctrl", "alt", "shift" }
local ghostty = hs.application.get("Ghostty")
local spaces = require("hs.spaces")
local eventtap = require("hs.eventtap")

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

hs.hotkey.bind(hyper, "d", function()
	hs.execute("/opt/homebrew/bin/yabai -m window --focus east")
end)

hs.hotkey.bind(hyper, "a", function()
	hs.execute("/opt/homebrew/bin/yabai -m window --focus west")
end)

hs.hotkey.bind(hyper, "w", function()
	hs.execute("/opt/homebrew/bin/yabai -m window --focus north")
end)

hs.hotkey.bind(hyper, "s", function()
	hs.execute("/opt/homebrew/bin/yabai -m window --focus south")
end)

hs.hotkey.bind(hyper, "t", function()
	hs.execute("/opt/homebrew/bin/yabai -m window --toggle float")
end)

-- Switch to the adjacent space by delta (-1 for previous, +1 for next)
local function switchSpace(delta)
	local currentSpace = hs.spaces.activeSpace()
	local screen = hs.screen.mainScreen()
	local spacesForScreen = hs.spaces.allSpaces()[screen:getUUID()]
	if not spacesForScreen then
		return
	end

	local idx
	for i, space in ipairs(spacesForScreen) do
		if space == currentSpace then
			idx = i
			break
		end
	end
	if idx and spacesForScreen[idx + delta] then
		hs.spaces.gotoSpace(spacesForScreen[idx + delta])
	end
end

-- Listen for otherMouseDown events with the cmd key held
local mouseListener = eventtap.new({ hs.eventtap.event.types.otherMouseDown }, function(e)
	local flags = e:getFlags()
	if flags.cmd then
		local btn = e:getProperty(hs.eventtap.event.properties["mouseEventButtonNumber"])
		if btn == 3 then -- Assumed mouse button 4 (previous)
			switchSpace(-1)
			return true
		elseif btn == 4 then -- Assumed mouse button 5 (next)
			switchSpace(1)
			return true
		end
	end
	return false
end)

mouseListener:start()
