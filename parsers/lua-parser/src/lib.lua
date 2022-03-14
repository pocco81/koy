local KOY = {
	-- sets whether the parser should follow the KOY spec strictly
	-- currently, no errors are thrown for the following rules if strictness is turned off:
	--   tables having mixed keys
	--   redefining a table
	--   redefining a key within a table
	strict = true,
}

local escape_chars = {
	b = "\b",
	t = "\t",
	n = "\n",
	f = "\f",
	r = "\r",
	['"'] = '"',
	["\\"] = "\\",
}

function string.insert(str1, str2, pos)
	return str1:sub(1, pos) .. str2 .. str1:sub(pos + 1)
end

-- taken from: https://stackoverflow.com/questions/640642/how-do-you-copy-a-lua-table-by-value
function table.shallow_copy(t)
  local t2 = {}
  for k,v in pairs(t) do
    t2[k] = v
  end
  return t2
end

local function dump_file(file)
	local f = assert(io.open(file, "rb"))
	local content = f:read("*all")
	f:close()
	return content
end

-- converts KOY data into a lua table
function KOY.decode(koy, options)
	options = options or {}
	local strict = (options.strict ~= nil and options.strict or KOY.strict)

	if type(koy) ~= "string" then
		error("Error: expected argument of type 'string', got " .. type(koy))
	elseif koy == "" then
		return {}
	end

	-- the official KOY definition of whitespace
	local ws = "[\009\032]"

	-- the official KOY definition of newline
	local nl = "[\10"
	do
		local crlf = "\13\10"
		nl = nl .. crlf
	end
	nl = nl .. "]"

	local buffer = "" -- stores text dat
	local cursor = 1 -- the current location within the string to parse
	local out = {} -- the output table
	_G.obj = out -- the current table to write to

	-- ========= Standard Utilities

	-- 	-- produce a parsing error message
	-- the error contains the line number of the current position
	local function err(message, strictOnly)
		if not strictOnly or (strictOnly and strict) then
			local line = 1
			local c = 0
			for l in koy:gmatch("(.-)" .. nl) do
				c = c + l:len()
				if c >= cursor then
					break
				end
				line = line + 1
			end
			error("KOY: " .. message .. " on line " .. line .. ".", 4)
		end
	end

	--- returns the next n characters from the current position
	local function char(n)
		n = n or 0
		return koy:sub(cursor + n, cursor + n)
	end

	-- moves the current position forward n (default: 1) characters
	local function step(n)
		n = n or 1
		cursor = cursor + n
	end

	-- remove the (Lua) whitespace at the beginning and end of a string
	local function trim(str)
		return str:gsub("^%s*(.-)%s*$", "%1")
	end

	-- prevent infinite loops by checking whether the cursor is
	-- at the end of the document or not
	local function bounds()
		return cursor <= koy:len()
	end

	-- ========= PARSERS for unreal elements
	--- NOTE: Any parse_<.> func will parse the current char and any followign one that matches it

	local function parse_newline()
		while char():match(nl) do
			step()
		end
	end

	local function parse_tab()
		while char():match("[\t]") do
			step()
		end
	end

	local function parse_whitespace()
		while char():match(ws) do
			step()
		end
	end

	local function parse_sl_comment()
		if char() == "/" and char(1) == "/" then
			while not char():match(nl) do
				step()
			end
		end
	end

	local function parse_ml_comment()
		if char() == "/" and char(1) == "*" then
			-- find() returns two values but when operated on it uses only the first one
			step((koy:find("*/", cursor + 2) + 2) - cursor)
		end
	end

	-- track whether the current key was quoted or not
	local quoted_key = false

	-- elements that can be ignored
	local space_elements = {
		["\n"] = parse_newline,
		["\t"] = parse_tab,
		[" "] = parse_whitespace,
		[nl] = parse_newline,
		["//"] = parse_sl_comment,
		["/*"] = parse_ml_comment,
	}

	-- get current character, but do something special if it's a forward slash (/)
	local function get_current_element()
		if char() == "/" then
			return "/" .. char(1)
		end

		return char()
	end

	-- placeholder for a parser_func
	local unreal_element_parser_f

	local function not_real_element() -- real chars: anything that's not in the space_elements table
		local f = space_elements[get_current_element()]
		if f then
			unreal_element_parser_f = f
			return true
		end
	end

	--- skip any char in the `space_elements` table
	local function skip_unreal_elements()
		while not_real_element() do
			unreal_element_parser_f()
			-- unreal_element_parser_f = nil
		end
	end

	-- ========= PARSERS for real elements

	-- delcaring before because some of them need each other often
	local parse_string, parse_number, parse_array, parse_inline_table, parse_boolean, parse_variable, get_value

	local vmp = {} -- var_match_placeholder
	-- by definition, a variable in Koy looks like: ${var_name} and be escaped using \
	local function var_avaiable(str)
		--[[ NOTE:
			lua doesn't support proper regex, so the equivalent of:
				[^\\]\$\{(.+?)\}
			is in lua:
				[^\\]%$%{(.-)%}
		--]]
		-- match a literal $ that is after anything but a \, followed by a {, followed by any text until you find the first }
		local beginning, ending, match = str:find("[^\\]%$%{(.-)%}")
		if beginning ~= nil and ending ~= nil and match ~= "" then
			vmp = { [1] = beginning, [2] = ending, [3] = match }
			return true
		end
		return false
	end

	-- will parse all variables in a string if given or the variable as the value of the previous key if not (e.g. key: ${this})
	function parse_variable(str)
		-- in-string varaibles
		if str ~= nil then
			local parsed_str = str
			while var_avaiable(parsed_str) do
				local substitution = tostring(load("return obj." .. vmp[3])())
				if substitution == "nil" then
					err("bad substitution. Variable '" .. vmp[3] .. "' is not defined")
				end
				parsed_str = parsed_str:sub(1, vmp[1]) .. substitution .. parsed_str:sub(vmp[2] + 1, parsed_str:len())
			end

			return parsed_str
		else -- variable as value of a key
			local literal_var = ""
			if char(1) == "{" then
				step(2) -- steps over $ and {, ends up at .
				-- "%}" .. nl
				while bounds() do
					if char():match(nl) then
						err("Variables cannot have line breaks")
					elseif char():match("%}") then
						step()
						break
					else
						literal_var = literal_var .. char()
						step()
					end
				end
			end
			-- for some reason, loading the `obj` into string directly makes `substitution` a pointer
			-- (i.e. if we change a value on `substitution`, `obj` will also have that change)
			-- so here its loaded and then its values are copied into `substitution`
			local substitution = table.shallow_copy(load("return obj.person1")())
			if substitution == nil then
				err("bad substitution. Variable '" .. vmp[3] .. "' is not defined")
			end

			local substitution_type = type(substitution)

			if substitution_type == "table" then
				if not char():match(nl) then
					local overwrites
					while not char():match(nl) do
						if char() == "<" and char(1) == "<" then
							step(2) -- <<-
							skip_unreal_elements()
							if char() == "{" then
								overwrites = parse_inline_table()
								-- check this
								break
							end
						end
						step()
					end

					for k, v in pairs(overwrites.value) do
						substitution[k] = v
					end
				end
			end

			return { value = substitution, type = substitution_type }
		end
	end

	function parse_string()
		local quoteType = char() -- should be single or double quote

		-- this is a multiline string if the next 2 characters match
		local multiline = (char(1) == char(2) and char(1) == char())

		-- buffer to hold the string
		local str = ""

		-- skip the quotes
		step(multiline and 3 or 1)

		while bounds() do
			if multiline and char():match(nl) and str == "" then
				step() -- skip line break line at the beginning of multiline string
			end

			-- keep going until we encounter the quote character again
			if char() == quoteType then
				if multiline then
					if char(1) == char(2) and char(1) == quoteType then
						step(3)
						break
					end
				else
					step()
					break
				end
			end

			if char():match(nl) and not multiline then
				err("Single-line string cannot contain line break")
			end

			-- if we're in a double-quoted string, watch for escape characters!
			if quoteType == '"' and char() == "\\" then
				if multiline and char(1):match(nl) then
					-- skip until first non-whitespace character
					step(1) -- go past the line break
					while bounds() do
						if not char():match(ws) and not char():match(nl) then
							break
						end
						step()
					end
				else
					-- utf function from http://stackoverflow.com/a/26071044
					-- converts \uXXX into actual unicode
					local function utf(char)
						local bytemarkers = { { 0x7ff, 192 }, { 0xffff, 224 }, { 0x1fffff, 240 } }
						if char < 128 then
							return string.char(char)
						end
						local charbytes = {}
						for bytes, vals in pairs(bytemarkers) do
							if char <= vals[1] then
								for b = bytes + 1, 2, -1 do
									local mod = char % 64
									char = (char - mod) / 64
									charbytes[b] = string.char(128 + mod)
								end
								charbytes[1] = string.char(vals[2] + char)
								break
							end
						end
						return table.concat(charbytes)
					end

					if escape_chars[char(1)] then
						-- normal escape
						str = str .. escape_chars[char(1)]
						step(2) -- go past backslash and the character
					elseif char(1) == "u" then
						-- utf-16
						step()
						local uni = char(1) .. char(2) .. char(3) .. char(4)
						step(5)
						uni = tonumber(uni, 16)
						if (uni >= 0 and uni <= 0xd7ff) and not (uni >= 0xe000 and uni <= 0x10ffff) then
							str = str .. utf(uni)
						else
							err("Unicode escape is not a Unicode scalar")
						end
					elseif char(1) == "U" then
						-- utf-32
						step()
						local uni = char(1) .. char(2) .. char(3) .. char(4) .. char(5) .. char(6) .. char(7) .. char(8)
						step(9)
						uni = tonumber(uni, 16)
						if (uni >= 0 and uni <= 0xd7ff) and not (uni >= 0xe000 and uni <= 0x10ffff) then
							str = str .. utf(uni)
						else
							err("Unicode escape is not a Unicode scalar")
						end
					else
						err("Invalid escape")
					end
				end
			else
				-- if we're not in a double-quoted string, just append it to our buffer raw and keep going
				str = str .. char()
				-- print("char: .. '" .. char() .. "'\t" .. str)
				step()
			end
		end

		-- return { value = str, type = "string" }
		return { value = parse_variable(str), type = "string" }
	end

	function parse_number()
		local num = ""
		local exp
		local date = false
		while bounds() do
			if char():match("[%+%-%.eE_0-9]") then
				if not exp then
					if char():lower() == "e" then
						-- as soon as we reach e or E, start appending to exponent buffer instead of
						-- number buffer
						exp = ""
					elseif char() ~= "_" then
						num = num .. char()
					end
				elseif char():match("[%+%-0-9]") then
					exp = exp .. char()
				else
					err("Invalid exponent")
				end
			elseif
				char():match(ws)
				or char() == "#"
				or char():match(nl)
				or char() == ","
				or char() == "]"
				or char() == "}"
			then
				break
			elseif char() == "T" or char() == "Z" then
				-- parse the date (as a string, since lua has no date object)
				date = true
				while bounds() do
					if char() == "," or char() == "]" or char() == "#" or char():match(nl) or char():match(ws) then
						break
					end
					num = num .. char()
					step()
				end
			else
				err("Invalid number")
			end
			step()
		end

		if date then
			return { value = num, type = "date" }
		end

		local float = false
		if num:match("%.") then
			float = true
		end

		exp = exp and tonumber(exp) or 0
		num = tonumber(num)

		if not float then
			return {
				-- lua will automatically convert the result
				-- of a power operation to a float, so we have
				-- to convert it back to an int with math.floor
				value = math.floor(num * 10 ^ exp),
				type = "int",
			}
		end

		return { value = num * 10 ^ exp, type = "float" }
	end

	function parse_array()
		step() -- skip [
		parse_whitespace()

		local arrayType
		local array = {}

		while bounds() do
			if char() == "]" then
				break
			elseif char():match(nl) then
				-- skip
				step()
				parse_whitespace()
			elseif char() == "#" then
				while bounds() and not char():match(nl) do
					step()
				end
			else
				-- get the next object in the array
				local v = get_value()
				if not v then
					break
				end

				-- set the type if it hasn't been set before
				if arrayType == nil then
					arrayType = v.type
				elseif arrayType ~= v.type then
					err("Mixed types in array", true)
				end

				array = array or {}
				table.insert(array, v.value)

				if char() == "," then
					step()
				end
				parse_whitespace()
			end
		end
		step()

		return { value = array, type = "array" }
	end

	function parse_inline_table()
		step() -- skip opening brace

		local buffer = ""
		local quoted = false
		local tbl = {}

		while bounds() do
			if char() == "}" then
				break
			elseif char() == "'" or char() == '"' then
				buffer = parse_string().value
				quoted = true
			elseif char() == ":" then
				if not quoted then
					buffer = trim(buffer)
				end

				step() -- skip :
				parse_whitespace()

				-- if char():match(nl) then
				-- 	err("Newline in inline table")
				-- end

				local v = get_value().value
				tbl[buffer] = v

				parse_whitespace()

				if char() == "," then
					step()
					-- elseif char():match(nl) then
					-- 	err("Newline in inline table")
				end

				quoted = false
				buffer = ""
			else
				buffer = buffer .. char()
				step()
			end
		end
		step() -- skip closing brace

		return { value = tbl, type = "array" }
	end

	function parse_boolean()
		local v
		if koy:sub(cursor, cursor + 3) == "true" then
			step(4)
			v = { value = true, type = "boolean" }
		elseif koy:sub(cursor, cursor + 4) == "false" then
			step(5)
			v = { value = false, type = "boolean" }
		else
			err("Invalid primitive")
		end

		parse_whitespace()
		if char() == "#" then
			while not char():match(nl) do
				step()
			end
		end

		return v
	end

	-- figure out the type and get the next value in the document
	function get_value()
		if char() == '"' or char() == "'" then
			return parse_string()
		elseif char():match("[%+%-0-9]") then
			return parse_number()
		elseif char():match("%$") then
			return parse_variable()
		elseif char() == "[" then
			return parse_array()
		elseif char() == "{" then
			return parse_inline_table()
		else
			return parse_boolean()
		end
		-- date regex (for possible future support):
		-- %d%d%d%d%-[0-1][0-9]%-[0-3][0-9]T[0-2][0-9]%:[0-6][0-9]%:[0-6][0-9][Z%:%+%-%.0-9]*
	end

	-- track whether the current key was quoted or not
	local quoted_key = false

	local function is_iterable()
		if cursor <= koy:len() then
			return true
		end
		return false
	end

	-- run over the string while possible
	while is_iterable() do
		skip_unreal_elements()

		if char() == ":" then -- variable
			-- expect whitespaces with multilinecomments
			step()
			parse_whitespace()
			parse_ml_comment()
			parse_whitespace()

			-- trim key name
			buffer = trim(buffer)

			if buffer:match("^[0-9]*$") and not quoted_key then
				buffer = tonumber(buffer)
			end

			if buffer == "" and not quoted_key then
				err("Empty key name")
			end

			local v = get_value()

			if v then
				-- if the key already exists in the current object, throw an error
				if obj[buffer] then
					err('Cannot redefine key "' .. buffer .. '"', true)
				end
				obj[buffer] = v.value
			end

			-- clear the buffer
			buffer = ""
			quoted_key = false

			-- skip whitespace and comments
			parse_whitespace()
			if char() == "/" and char(1) == "/" then
				while bounds() and not char():match(nl) do
					step()
				end
			end

			-- if there is anything left on this line after parsing a key and its value,
			-- throw an error
			if not char():match(nl) and cursor < koy:len() then
				err("Invalid primitive")
			end
		elseif char() == "[" then -- array
			buffer = ""
			step()
			local tableArray = false

			-- if there are two brackets in a row, it's a table array!
			if char() == "[" then
				tableArray = true
				step()
			end

			obj = out

			local function processKey(isLast)
				isLast = isLast or false
				buffer = trim(buffer)

				if not quoted_key and buffer == "" then
					err("Empty table name")
				end

				if isLast and obj[buffer] and not tableArray and #obj[buffer] > 0 then
					err("Cannot redefine table", true)
				end

				-- set obj to the appropriate table so we can start
				-- filling it with values!
				if tableArray then
					-- push onto cache
					if obj[buffer] then
						obj = obj[buffer]
						if isLast then
							table.insert(obj, {})
						end
						obj = obj[#obj]
					else
						obj[buffer] = {}
						obj = obj[buffer]
						if isLast then
							table.insert(obj, {})
							obj = obj[1]
						end
					end
				else
					obj[buffer] = obj[buffer] or {}
					obj = obj[buffer]
				end
			end

			while bounds() do
				if char() == "]" then
					if tableArray then
						if char(1) ~= "]" then
							err("Mismatching brackets")
						else
							step() -- skip inside bracket
						end
					end
					step() -- skip outside bracket

					processKey(true)
					buffer = ""
					break
				elseif char() == '"' or char() == "'" then
					buffer = parse_string().value
					quoted_key = true
				elseif char() == "." then
					step() -- skip period
					processKey()
					buffer = ""
				else
					buffer = buffer .. char()
					step()
				end
			end

			buffer = ""
			quoted_key = false
		elseif char() == '"' or char() == "'" then
			-- quoted key
			buffer = parse_string().value
			quoted_key = true
		end

		buffer = buffer .. (char():match(nl) and "" or char())
		-- print("buffer (" .. cursor .. "): '" .. buffer .. "'")
		step()

		-- assert keywords
		if buffer == "import" then
			parse_whitespace()
			parse_ml_comment()
			parse_whitespace()

			if char() == '"' then --single file import
				local file_path = parse_string()["value"]
				-- https://stackoverflow.com/questions/59561776/how-do-i-insert-a-string-into-another-string-in-lua
				koy = koy:sub(1, cursor) .. "\n" .. dump_file(file_path) .. koy:sub(cursor + 1)
				buffer = ""
			elseif char() == "{" then -- multiline import
				step() -- skip opening brace
				local file_paths = {}

				while bounds() do
					if char() == "'" or char() == '"' then
						file_paths[#file_paths + 1] = parse_string().value
					elseif char() == "," then
						step()
						skip_unreal_elements()
					elseif char() == "}" then
						break
					else
						skip_unreal_elements()
					end
				end
				step() -- skip closing brace

				local length_until_file = cursor
				for _, file_path in pairs(file_paths) do
					local file = dump_file(file_path)
					koy = koy:sub(1, length_until_file) .. "\n" .. file .. koy:sub(length_until_file + 1)
					length_until_file = length_until_file + file:len()
				end
				buffer = ""
			end
		end
	end

	return out
end

function KOY.encode(tbl)
	local koy = ""

	local cache = {}

	local function parse(tbl)
		for k, v in pairs(tbl) do
			if type(v) == "boolean" then
				koy = koy .. k .. " = " .. tostring(v) .. "\n"
			elseif type(v) == "number" then
				koy = koy .. k .. " = " .. tostring(v) .. "\n"
			elseif type(v) == "string" then
				local quote = '"'
				v = v:gsub("\\", "\\\\")

				-- if the string has any line breaks, make it multiline
				if v:match("^\n(.*)$") then
					quote = quote:rep(3)
					v = "\\n" .. v
				elseif v:match("\n") then
					quote = quote:rep(3)
				end

				v = v:gsub("\b", "\\b")
				v = v:gsub("\t", "\\t")
				v = v:gsub("\f", "\\f")
				v = v:gsub("\r", "\\r")
				v = v:gsub('"', '\\"')
				v = v:gsub("/", "\\/")
				koy = koy .. k .. " = " .. quote .. v .. quote .. "\n"
			elseif type(v) == "table" then
				local array, arrayTable = true, true
				local first = {}
				for kk, vv in pairs(v) do
					if type(kk) ~= "number" then
						array = false
					end
					if type(vv) ~= "table" then
						v[kk] = nil
						first[kk] = vv
						arrayTable = false
					end
				end

				if array then
					if arrayTable then
						-- double bracket syntax go!
						table.insert(cache, k)
						for kk, vv in pairs(v) do
							koy = koy .. "[[" .. table.concat(cache, ".") .. "]]\n"
							for k3, v3 in pairs(vv) do
								if type(v3) ~= "table" then
									vv[k3] = nil
									first[k3] = v3
								end
							end
							parse(first)
							parse(vv)
						end
						table.remove(cache)
					else
						-- plain ol boring array
						koy = koy .. k .. " = [\n"
						for kk, vv in pairs(first) do
							koy = koy .. tostring(vv) .. ",\n"
						end
						koy = koy .. "]\n"
					end
				else
					-- just a key/value table, folks
					table.insert(cache, k)
					koy = koy .. "[" .. table.concat(cache, ".") .. "]\n"
					parse(first)
					parse(v)
					table.remove(cache)
				end
			end
		end
	end

	parse(tbl)

	return koy:sub(1, -2)
end

return KOY
