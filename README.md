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

**Disclaimer**: these are just my thoughts on config/data serialization languages. Feel free to disagree (and to open an issue, I'm open to discussions.)

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

### Specs Sheet

General info:

+ **Filename Extension**: `.koy`
+ **MIME Type**: `application/koy`

Now getting into the juicy part! here is a small cheat sheet made with ❤️  so that you won't have to go over the general doc :)

&nbsp;

<details>
    <summary><i>Cheat sheet for symbols</i></summary>
&nbsp;

<table>
<tr>
<td> Symbols </td> <td> Function </td> <td> Example </td>

</tr>
<tr>
<td> <code>//</code> </td>
<td> Single-line comment </td>
<td>

```
// hello world!
```

</td>
</tr>

<tr>
<td> <code>/**/</code> </td>
<td> Multi-line comment </td>
<td>

```
/*
	This is a multi-line comment and
	you are watcing Disney channel!
*/
```

</td>
</tr>

</tr>
<tr>
<td> <code>${}</code> </td>
<td> Call a variable </td>
<td>

```
// simple usage
name: "Michael Theodor Mouse"
hello: "Good evening ${name}"

// with arrays (using the `.` notation)
user: {
	name: "Michael",
	surnames: "Theodor Mouse"
}
hi: "Good morning ${user.name}"
```

</td>
</tr>

</tr>
<tr>
<td> <code>""</code> </td>
<td> Define a normal string </td>
<td>

```
hello: "world"
```

</td>
</tr>

</tr>
<tr>
<td> <code>""" """</code> </td>
<td> Define a multi-line string </td>
<td>

```
hello: """My name is
	Michael Theodor Mouse, but
	you can call me Peter.
"""
```

</td>
</tr>

</tr>
<tr>
<td> <code>` `</code> </td>
<td> Define a literal key </td>
<td>

```
`mainland!tv.קום`: "value"
```

</td>
</tr>

</tr>
<tr>
<td> <code>' '</code> </td>
<td> Define a literal value </td>
<td>

```
weird_path: 'pc/\fds!fd/\&24324%!@'
```

</td>
</tr>

</tr>
<tr>
<td> <code>{}</code> </td>
<td> Define an array </td>
<td>

```
metadata: {
	OS: "Arch Linux",
	Kernel: "linux-hardened"
}
```

</td>
</tr>

</tr>
<tr>
<td> <code>[]</code> </td>
<td> Define an object </td>
<td>

```
user: {
	name: "Michael Theodor Mouse",
	age: 92
}
```

</td>
</tr>

</tr>
<tr>
<td> <code>import</code> </td>
<td> Import other <code>.koy</code> files </td>
<td>

```
// single import
import "./directory/settings.koy"

// multiple imports
import {
	"./directory/user0.koy",
	"./directory/user1.koy",
	"./directory/user2.koy"
}
```

</td>
</tr>

</tr>
<tr>
<td> <code><<</code> </td>
<td> Overwrite values </td>
<td>

```
// normal variables
hello: "world"
another_hello: ${hello} << "momma!"

// arrays
user: {
	name: "Michael Theodor Mouse",
	age: 93
}

laptop: {
	name: "Lenovo Thinkpad",
	owner: ${user} << {
		name: "Dominic Toretto"
	}
}
```

</td>
</tr>

</table>

<br />
</details>

<details>
    <summary><i>Cheat sheet for rules</i></summary>
&nbsp;

<br />
</details>

<details>
    <summary><i>Example <code>.koy</code> file using every feature</i></summary>
&nbsp;

<br />
</details>

&nbsp;

#### Comments

Comments are an integral part of any program, that's why you've got two ways to use them:

```
// single-line comment here!

/*
  multi-line comment
*/
```

#### General Structure

Like JSON, `key -> values` are the foundation of everything. The general structure is the following one:

```
key: value
```

> notice the space between the `:` and the `value`.

##### Keys

+ Keys can only contain ASCII letters and underscores (A-Za-z0-9_)

```
key: "value"
key_1: "value"
2001: "value"

// invalid keys
my-key: "value"
இந்தியா: "value"
```

+ Literal keys must be specified using backticks

```
`mainland!tv.קום`: "value"
```

+ Keys must not be empty

```
: "value" //invalid
```

+ Keys cannot be duplicated

```
hello: "world"
hello: "momma!"
```

##### Values

Values can have any of the following data types:
+ Integer
+ String
+ Null
+ Array
+ Boolean
+ Float
+ Object

### Data Types

#### Integer


### Statements

+ `import`: import another `.koy` file.

```
// single import example
import "./directory/my_config.koy"

// multiple imports
import {
	"./directory/user0.koy",
	"./directory/user1.koy",
	"./directory/user2.koy"
}
```

