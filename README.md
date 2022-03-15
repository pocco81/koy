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
	Koy is a new flexible and feature-rich data serialization language; easy for you, your dog and your average 5 year-old. Its design focused on being visually unobstrusive while keeping an overall sense of verbosity, allows easy-to-write parsers (in multiple languages) to effortlessly map the data to hash tables.
</p>

&nbsp;

### 🐣 Example

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

> As shown here, Koy isn't only good for deeply nested data, but also for avoiding an unambiguous use of it, managing their data-types and modularizing them.

&nbsp;

### 📋 Characteristics

-   **Friendly Syntax with Obvious Semantics**: everything in a Koy file works on a `key` -> `value` basis, therefore you can nest data as much as you want and no matter what, it's easy to comprehend at a glance.
-   **Standard Errors**: Koy defines a list of semantic errors throwable for when the parser screams _"oh crap! what is this?"_. This way developers get an implementation-agnostic definition that helps them debug their program's config faster.
-   **Unambiguous**: Koy has one, and only _ONE_ way to define each thing, because doing the opposite would increase the overall complexity of the language.
-   **Feature Rich:** Koy supports:
    -   comments
    -   variables
    -   type casting & coercion
    -   data overwritting
    -   importing other koy files
    -   native data-types:
        -   Integer (`int`)
        -   String (`str`)
        -   Null (`null`)
        -   Array (`arr`)
        -   Boolean (`bool`)
        -   Float (`flt`)
        -   Object (`obj`)

&nbsp;

### 🪴 Index

+ Library Implementations
+ IDE/DE Support
+ Documentation
+ ToDo List
+ FAQ
+ License

&nbsp;

&nbsp;

### 📚 Library Implementations

The following is a list of library implementations for Koy: 

- Lua: [`lua-parser`](https://github.com/Pocco81/koy-lang/tree/main/parsers/lua-parser)

&nbsp;

### 🖼️ IDE/DE Support

The following is a list of IDE/DE plugins available for Koy:

> 👷🛑 Under dev

&nbsp;

### 🎁 Documentation

You can read Koy's docs [here](https://github.com/Pocco81/koy-lang/tree/main/docs)

&nbsp;

### 🧻 ToDo List

Check out the list [here](https://github.com/Pocco81/koy-lang/projects/1).

&nbsp;

### 🙋 FAQ

-   _**Why?**_

**Disclaimers**:

-   these are just my thoughts on config/data serialization languages. Feel free to disagree (and to open an issue, I'm open to discussions.)
-   all this is for the sake of creating a _bettter_ language, however I still haven't decided if I'll end up making this. Initially this repo was just meant to be a rant, but I don't know, maybe something good will come out of here!

With that said, let's continue...

I like how XML is useful for porting data across platforms, however I dislike the fact that it "repeats itself" too much (opening and closing tags), so often times it feels visually jammed. JSON, however, is vastly nicer on the eyes due to its notable hierarchical structure. But now, looking more at its syntax I can't help but feel like it's _too strict_(?) (numbers and longstrings are a nightmare); apart from that, given that JSON is a data-only-type-of-config-language, nice stuff such as comments are not baked into it. On the other end of the spectrum, TOML, which focuses on being easy to read due to obvious sematic sucks for deeply nested _data_. The `.` convention simply doesn't cut it for me. Furthermore, something that I wish any of these included by default is native support for variable placeholders. I know, YAML has aliases and anchors which sorta do the job? however these simply don't work as such because they can't be inserted arbitrarily throughout a YAML file, which sucks too. Speaking about YAML, it is unnecessarily complex. Like, c'mon? 4 ways to define a simple boolean?

**Koy**, in a sense, is just a proof of concept for what I ambition my _ideal_ data serialization language to look like.

&nbsp;

### 📜 License

Koy is released under the MIT license, which grants the following permissions:

-   Commercial use
-   Distribution
-   Modification
-   Private use

For more convoluted language, see the [LICENSE](https://github.com/koy-lang/koy-lang/blob/main/LICENSE).

&nbsp;
