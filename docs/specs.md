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

-   Keys can only contain ASCII letters and underscores (A-Za-z0-9\_)

```
key: "value"
key_1: "value"
2001: "value"

// invalid keys
my-key: "value"
இந்தியா: "value"
```

-   Literal keys must be specified using backticks

```
`mainland!tv.קום`: "value"
```

-   Keys must not be empty

```
: "value" //invalid
```

-   Keys cannot be duplicated

```
hello: "world"
hello: "momma!"
```

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
