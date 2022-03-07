### 🌲 Table of Contents

-   [General Structure]()
-   [Comments]()
-   [Data Types]()
    -   [Integer]()
    -   [String]()
    -   [Null]()
    -   [Array]()
    -   [Boolean]()
    -   [Float]()
    -   [Object]()
-   [Imports]()
-   [Variables]()

&nbsp;

### General Structure

Like JSON, `key -> values` are the foundation of everything. The general structure is the following one:

```
key: value
```

> notice the space between the `:` and the `value`.

#### Keys

<details>
    <summary>Keys can only contain ASCII letters and underscores <code>(A-Za-z0-9_)</code></summary>

```
key: "value"
key_1: "value"
2001: "value"

// invalid keys
my-key: "value"
இந்தியா: "value"
```

</details>

<details>
    <summary>Literal keys must be specified using backticks</summary>

```
`mainland!tv.קום`: "value"
```

</details>

<details>
    <summary>Keys cannot be empty</summary>

```
: "value" //invalid
```

</details>

<details>
    <summary>Keys cannot be duplicated</summary>

```
hello: "world"
hello: "momma!"
```

</details>

#### Values

Values can have any of the following data types:

-   Integer
-   String
-   Null
-   Array
-   Boolean
-   Float
-   Object

&nbsp;

### Comments

Comments are an integral part of any program, that's why you've got two ways to use them:

```
// single-line comment here!

/*
  multi-line comment
*/
```

&nbsp;

### Data Types

A data type, in programming, is a classification that specifies which type of value a variable has and what type of mathematical, relational or logical operations can be applied to it without causing an error

#### Integer `(int)`

Integers contain whole numbers:

-   Integers can simply be whole numbers
-   Positive numbers may be prefixed with a `+`
-   Negative numbers are prefixed with a `-`
-   Large numbers can be separeted using underscores (`_`) to enhance readability. The only condition is that they must be surrounded by at least one digit on each side

```
i1: -35
i2: 0
i3: +104
i4: 201
i5: 2_005
```

#### String `(str)`

Strings contain alphanumeric characters

Basic strings can be represented using quotation marks (`""`). Keep in mind that some Unicode characters must be escaped:

```
hello: "world!\nYou may call me \"Jeff\""
```

#### Null `(null)`

-   Use the keyword `null`

```
key: null
```

#### Array `(arr)`

-   Arrays are declared using brackets (`{}`)
-   Elements are separated by commas (`,`), except for the last one
-   Empty arrays can be declared by leaving the brackets empty
-   Arrays can contain values of different types

```
environment: {
	term: "linux",
	histsize: 5000,
	theme: "light",
	package_manage: "pacman"
}

nested_array: {
	{ 1, 0, 1 },
	{ "h", "a", "l" , "l", "o" }
}

friends: {}
```

#### Boolean `(bool)`

-   must be either `true` or `false`

```
has_child: true
likes_pineapple: false
```

#### Float `(float)`

Floating points contain numbers with a decimal points:

#### Object `(bool)`

Objects are used to represent “things” with characteristics (AKA properties):

-   Objects are declared using squared brackets (`[]`)
-   Empty objects can be declared leaving the brackets empty

```
user: [
	name: "Michael Theodor Mouse",
	age: 34,
	married: false
]

spouse: []
```

&nbsp;

### Imports

Imports are statements used to "bring in" other `.koy` files:

-   `import`: import another `.koy` file.

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

&nbsp;

### Variables

Everything in a `.koy` file is a variable:

+ They can be accessed using `${}`
+ Variables within an array can be accessed using the `.` notation
+ The value of a variable can be overwritten using `<<`
+ When using `<<` on an array or an object, it will replace its fields

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

```
// normal variables
hello: "world"
another_hello: ${hello} << "momma!" // notice that hello = "world"

mouse: "Mickey" << "Minnie"

// object
user: [
	name: "Michael Theodor Mouse",
	age: 93
]

// array
ports: { 8000, 8001, 8002 }

laptop: {
	name: "Lenovo Thinkpad",
	owner: ${user} << []
		name: "Dominic Toretto"
	],
	ports: ${ports} << { 2: 8007 }
}
```

> Note: you are not overwritting the variable you are calling, you are overwriting the value of the variable you are calling or the same variable itself (fifth line). On arrays/objects you are simply overwriting fields, not the whole array/object.

&nbsp;
