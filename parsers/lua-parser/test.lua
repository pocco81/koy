local koy_parser = require("src.lib")
local inspect = require("deps.inspect")

local koy_sample = require("src.utils").dump_file("./samples/s1.koy")
local parsed_koy = koy_parser.decode(koy_sample)
print(inspect(parsed_koy))

-- local hello = world
-- local key = "ayy $1  ${hey} i'm a ${ffd} ${a} key. ${hello} lol [hello]"
--
-- local test_key = "The fat cat sat on the mat."
--
-- -- local regex = [[${.*}]]
-- print( key:find("[\\$][\\{].*[\\}]") )
--
--
-- -- print(key)
-- -- print(key:find("\\[(.*?)\\]"))
-- -- print(key:find("[\\$]")) -- matches $
-- -- print(key:find("([\\$][\\{])")) -- matches ${
-- -- print(key:find("([\\$][\\{]).+([\\}])")) -- matches ${ whatever in here }
-- -- print(key:find("([\\$][\\{]).([\\}])")) -- matches ${a} only one char
--
-- -- print(key:find("[\\{](.*?)[\\}]"))
--
-- -- print(key:find("([\\$][\\{])([\\}])")) -- matches ${a} only one char
--
-- -- print(key:sub(18,18))
--
-- -- print(test_key:match("(f|c|m)at\.?"))
