-- Central transition presets for awww wallpaper commands.
-- This file is not auto-applied by your current shell scripts yet.
-- Usage idea (from shell): `lua -e 'local c=dofile("..."); print(c.cli("default"))'`

local M = {}

M.defaults = {
  fps = 60,
  type = "grow",
  duration = 2.0,
  bezier = ".43,1.19,1,.4",
  angle = 45,
  pos = "center",
  invert_y = false,
}

M.profiles = {
  default = {
    fps = 60,
    type = "grow",
    duration = 2.0,
    bezier = ".43,1.19,1,.4",
    pos = "center",
  },

  random = {
    fps = 30,
    type = "random",
    duration = 1.0,
    bezier = ".43,1.19,1,.4",
  },

  effects = {
    fps = 60,
    type = "wipe",
    duration = 2.0,
    bezier = ".43,1.19,1,.4",
    angle = 45,
  },

  subtle = {
    fps = 45,
    type = "fade",
    duration = 1.5,
    bezier = ".25,.1,.25,1",
  },

  instant = {
    fps = 30,
    type = "none",
    duration = 0.0,
    bezier = ".54,0,.34,.99",
  },
}

local function merge(base, override)
  local out = {}
  for k, v in pairs(base) do
    out[k] = v
  end
  if override then
    for k, v in pairs(override) do
      out[k] = v
    end
  end
  return out
end

local function bool_flag(name, value)
  if value then
    return " --" .. name
  end
  return ""
end

function M.get(profile)
  return merge(M.defaults, M.profiles[profile] or M.profiles.default)
end

-- Returns a full argument string for `awww img ...`.
function M.cli(profile)
  local t = M.get(profile)
  return string.format(
    "--transition-fps %s --transition-type %s --transition-duration %s --transition-bezier %s --transition-angle %s --transition-pos %s%s",
    tostring(t.fps),
    tostring(t.type),
    tostring(t.duration),
    tostring(t.bezier),
    tostring(t.angle),
    tostring(t.pos),
    bool_flag("invert-y", t.invert_y)
  )
end

return M
