### Comments

Comments are an integral part of any program, that's why you've got two ways to use them:

```
// single-line comment here!

/*
  multi-line comment
*/
```

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

-   Integer: `int`
-   String: `str`
-   Null: `null`
-   Array: `arr`
-   Boolean: `bool`
-   Float: `float`
-   Object: `obj`

### Data Types

#### Integer `(int)`

Integers are whole numbers which may be positve or negative:
+ Integers can simply be whole numbers
+ Positive numbers may be prefixed with a `+`
+ Negative numbers may be prefixed with a `-`
+ Large numbers can be separeted using underscores (`_`) to enhance readability. The only condition is that they must be surrounded by at least one digit on each side

```
i1: -35
i2: 0
i3: +104
i4: 201
i5: 2_005
```

#### String `(str)`

Basic strings can be represented using quotation marks (`""`). Keep in mind that some Unicode characters must be escaped:

```
hello: "world!\nYou may call me \"Jeff\""
```

#### Null `(null)`

+ Use the keyword `null`

```
key: null
```

#### Array `(arr)`

+ Arrays are declared using brackets (`{}`)
+ Elements are separated by commas (`,`), except for the last one
+ Empty arrays can be declared by leaving the brackets empty
+ Arrays can contain values of different types

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

+ must be either `true` or `false`

```
has_child: true
likes_pineapple: false
```

#### Float `(float)`

#### Object `(bool)`

+ Objects are declared using squared brackets (`[]`)
+ Empty objects can be declared leaving the brackets empty

```
user: [
	name: "Michael Theodor Mouse",
	age: 34,
	married: false
]

spouse: []
```

### Statements

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
