local koy_parser = require("src.lib")
local inspect = require("deps.inspect")

local koy_sample = require("src.utils").dump_file("./samples/s1.koy")
local parsed_koy = koy_parser.decode(koy_sample)

print(inspect(parsed_koy))
