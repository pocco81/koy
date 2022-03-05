# 🐟 koy-lang

Experimental human-friendly data serialization language

## Rant

Disclaimer: these are just my thoughts on config/data serialization languages. Feel free to disagree (and to open an issue, I'm open to discussions.)

I like how XML is useful for portting data across platforms, however I dislike the fact that it "repeats itself" (too much opening and closing tags), so often times it feels visually jammed. JSON, however, is much more nicesly structered due to its notable hierarchical structure. But now, looking more at its syntax I can't help but feel like it's _too strict_(?) (numbers and longstrings are a nightmare); apart from that, given that JSON is a data-only-type-of-config-language, nice stuff such as comments are not baked into it. On the other end of the spectrum, TOML, which focuses on being easy to read due to obvious sematic sucks for deeply nested _data_. The `.` convention simply doesn't cut it for me. Furthermore, something that I wish any of these included by default is native support for variable placeholders. I know, YAML has aliases and anchors which sorta do the job? however these simply don't work as such because they can't be inserted arbitrarily throughout a YAML file, which sucks too. Speaking about YAML, it is unnecessarily complex. Like, c'mon? 4 ways to define a simple boolean?

## My Proposal

[Data serialization](https://hazelcast.com/glossary/serialization/) languages should be simple as in easy to read and write, easy to structure, not visually obstrusive, feature rich, maintainable and have obvious semantincs understandable by your average 5 year-old.

### Specific Features

+ Comments! (I'm looking at you JSON)
+ Support a wide-array of data types, for instance:
	+ String
	+ Integer
	+ Float
	+ Boolean
	+ Object
	+ Array (key-value, key)
	+ Data and Times
+ Import statement (modularization!)
+ Variables!

### Non-Specific Features

+ The name must be short. People don't realize it yet but the `0.000000001` milliseconds they save every time they type `conf.ini` vs `conf.json` could be used to spend more time with your loved ones!
+ Have a standard *convention* of errors (e.g. `NegativeArraySizeException` in JAVA)
