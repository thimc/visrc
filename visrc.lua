require('vis')
local path = os.getenv("HOME") .. '/.config/vis/'
local fennel = require("fennel")
fennel.dofile(path .. "goto-ref.fnl")
fennel.dofile(path .. "visrc.fnl")
