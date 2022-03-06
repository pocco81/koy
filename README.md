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

### 📣 Rant

**Disclaimers**:
+ these are just my thoughts on config/data serialization languages. Feel free to disagree (and to open an issue, I'm open to discussions.)
+ all this is for the sake of creating a _bettter_ language, however I still haven't decided if I'll end up making this. Initially this repo was just meant to be a rant, but I don't know, maybe something good will come out of here!

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
meta: {
	user: [
		hostname: "lenovo thinkpad",
		username: "pocco81"
	],
	environment: {
		term: "linux",
		histsize: 5000,
		histignore: "&:ls:[bf]g:exit",
		theme: "light",
		package_manage: "pacman"
	}
}
device: {
	colorscheme: "gruvbox-${theme}",
	pkgs: "1465 ${package_manager}",
	description: `Lorem ipsum dolor sit ${username}, elit.\n
		Integer quis sapien varius, congue purus sed,\n
		fringilla risus`,
	available: true,
	date_of_acquisition: 2011-05-27T07,
	ip: "10.0.0.1",
	average_temps: {
		cpu: 79.5,
		gpu: 72.0
	},
	ports: { 8000, 80001, 8002 }
}
```

> Note: this file can be found [here](https://github.com/Pocco81/koy-lang/blob/main/example.koy)

&nbsp;

### 🎁 Documentation

You can read the docs [here](https://github.com/Pocco81/koy-lang/tree/main/docs)

---
