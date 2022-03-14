<p align="center">
  <h2 align="center">🌙 lua-parser</h2>
</p>

<p align="center">
	Koy library for Lua
</p>

&nbsp;

```lua
local koy_parser = require("koy")
local sample = [[
person: {
	name: "Michael Theodor Mouse",
	age: null
}
]]

local koy_table = koy_parser.decode(sample)

for k,v in pairs(koy_table) do
	print(k .. ": " .. tostring(v))
end
```

### ✨ Features

+ `decode(<string>)`: receives a Koy string and transforms into Lua table (object)
+ `encode(<string>)`: transforms Lua table (object) into valid Koy

### 🍣 Caveats

+ `null` values are stored as `"nil"` (in a string) because there is no way to represent them with their actual keyword (`nil`) in a Lua table. See [this](https://stackoverflow.com/questions/40441508/how-to-represent-nil-in-a-table) Stackoverflow question.
