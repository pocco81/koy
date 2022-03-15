local koy_parser = require("src.lib")
local inspect = require("deps.inspect")

local koy_sample = require("src.utils").dump_file("./samples/s1.koy")
local parsed_koy = koy_parser.decode(koy_sample)

-- NOTE: when using inspector, tables that have the same content will be represented by pointers:
--[[ for example:
{
  person1 = <1>{
    age = 121,
    name = "Michael"
  },
  person2 = <table 1>
}
--]]

print(inspect(parsed_koy))
