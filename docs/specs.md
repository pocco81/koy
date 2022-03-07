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
    <summary>Keys can only contain ASCII letters and underscores <code>(A-Za-z0-9\_)</code></summary>

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

##### Values

Values can have any of the following data types:

-   Integer
-   String
-   Null
-   Array
-   Boolean
-   Float
-   Object

### Data Types

#### Integer

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
