hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "W", function()
  hs.notify.new({ title = "Hammerspoon", informativeText = "Hello world!" }):send()
end)

hs.hotkey.bind({ "cmd" }, "return", function()
  hs.application.open("WezTerm")
end)

hs.hotkey.bind({ "cmd" }, "Left", function()
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

hs.hotkey.bind({ "cmd" }, "Right", function()
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

-- not optimal
hs.hotkey.bind({ "cmd", "ctrl", "alt", "shift" }, "H", function()
  local space = hs.spaces.focusedSpace()
  local spaces = hs.spaces.spacesForScreen()

  for i, x in pairs(spaces) do
    if x == space then
      S = i
    end
  end

  local spaceleft = spaces[S - 1]

  hs.spaces.gotoSpace(spaceleft)
end)
hs.hotkey.bind({ "cmd", "ctrl", "alt", "shift" }, "L", function()
  local space = hs.spaces.focusedSpace()
  local spaces = hs.spaces.spacesForScreen()

  for i, x in pairs(spaces) do
    if x == space then
      S = i
    end
  end

  local spaceright = spaces[S + 1]

  hs.spaces.gotoSpace(spaceright)
end)

hs.hotkey.bind({ "cmd", "ctrl", "alt", "shift" }, "R", function()
  hs.reload()
end)
