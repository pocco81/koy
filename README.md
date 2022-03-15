<p align="center">
  <h2 align="center">🎏 Koy</h2>
</p>

<p align="center">
	Experimental human-friendly data serialization language
</p>

<p align="center">
	<a href="https://github.com/Pocco81/koy-lang/stargazers">
		<img alt="Stars" src="https://img.shields.io/github/stars/Pocco81/koy-lang?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41"></a>
	<a href="https://github.com/Pocco81/koy-lang/issues">
		<img alt="Issues" src="https://img.shields.io/github/issues/Pocco81/koy-lang?style=for-the-badge&logo=bilibili&color=F5E0DC&logoColor=D9E0EE&labelColor=302D41"></a>
	<a href="https://github.com/Pocco81/koy-lang">
		<img alt="Repo Size" src="https://img.shields.io/github/repo-size/Pocco81/koy-lang?color=%23DDB6F2&label=SIZE&logo=codesandbox&style=for-the-badge&logoColor=D9E0EE&labelColor=302D41"/></a>
</p>

&nbsp;

<p align="center">
	Koy is a new flexible and feature-rich data serialization language; easy for you, your dog and your average 5 year-old. Its design allows easy-to-write parsers (in multiple languages) to map the data to hash tables.
</p>

&nbsp;

### 🌤️ Example

```koy
/*
	Hello world! this is a simple Koy document
	and you are reading a multi-line comment :^)
*/

// let's import some settings, shall we?
import "./settings/screen.koy"

title: "Koy Example"

person: {
	name: "Michael Theodor Mouse",
	age: 34
}

laptop: {
	owner: ${person} << {
		username: "mickey1234"
	},
	temp:int 203.04,
	married: true,
	document: ${title}
}

ports: [ 8001, 8002, 8003 ]
```

> As it can be seen, Koy isn't only good for deeply nested data, but also for avoiding an unambiguous use of it, managing their data-types and modularizing them.

&nbsp;

### 📣 Rant

**Disclaimers**:

-   these are just my thoughts on config/data serialization languages. Feel free to disagree (and to open an issue, I'm open to discussions.)
-   all this is for the sake of creating a _bettter_ language, however I still haven't decided if I'll end up making this. Initially this repo was just meant to be a rant, but I don't know, maybe something good will come out of here!

With that said, let's continue...

I like how XML is useful for porting data across platforms, however I dislike the fact that it "repeats itself" too much (opening and closing tags), so often times it feels visually jammed. JSON, however, is vastly nicer on the eyes due to its notable hierarchical structure. But now, looking more at its syntax I can't help but feel like it's _too strict_(?) (numbers and longstrings are a nightmare); apart from that, given that JSON is a data-only-type-of-config-language, nice stuff such as comments are not baked into it. On the other end of the spectrum, TOML, which focuses on being easy to read due to obvious sematic sucks for deeply nested _data_. The `.` convention simply doesn't cut it for me. Furthermore, something that I wish any of these included by default is native support for variable placeholders. I know, YAML has aliases and anchors which sorta do the job? however these simply don't work as such because they can't be inserted arbitrarily throughout a YAML file, which sucks too. Speaking about YAML, it is unnecessarily complex. Like, c'mon? 4 ways to define a simple boolean?

&nbsp;

### 🙋 Proposal

[Data serialization](https://hazelcast.com/glossary/serialization/) languages should be simple as in easy to read and write, easy to structure, not visually obstrusive, feature rich, maintainable, verbose and have obvious semantincs understandable by your average 5 year-old.

#### 📄 Specific Features

-   Variables!
-   Comments! (I'm looking at you JSON)
-   Support a wide-array of data types, such as:
    -   String
    -   Integer
    -   Float
    -   Boolean
    -   Object
    -   Array (key-value, key)
    -   Data and Times
-   Import statement (modularization!)

#### ☄️ Non-Specific Features

-   The name must be short. People don't realize it yet but the `0.000000001` milliseconds they save every time they type `conf.ini` vs `conf.json` could be used to spend more time with your loved ones!
-   Have a standard _convention_ of errors (e.g. `NegativeArraySizeException` in Java)

&nbsp;

### 👷 Initiative

This is **Koy**, just a proof of concept for what I ambition my _ideal_ data serialization language to look like:

```
/*
	Hello world! this is a simple Koy document
	and you are reading a multi-line comment :^)
*/

// let's import some settings, shall we?
import "./settings/screen.koy"

title: "Koy Example"

user: {
	name: "Michael Theodor Mouse",
	age: 23,
	married: true
}

ports: [ 8001, 8002, 8003 ]
```

> Note: this file can be found [here](https://github.com/Pocco81/koy-lang/blob/main/example.koy)

&nbsp;

### 🎁 Documentation

You can read Koy's docs [here](https://github.com/Pocco81/koy-lang/tree/main/docs)

&nbsp;

### 📜 ToDo

Check out the list [here](https://github.com/Pocco81/koy-lang/projects/1).
