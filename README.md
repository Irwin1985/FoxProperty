# FoxProperty
The `FoxProperty` class represents a persistent set of properties. 

<h2>Features</h2>

- It is used to maintain list of value in which the key is a string and the value can be of any type.
- One useful capability of the Properties class is that you can specify a default property that will be returned if no value is associated with a certain key.

# Table of Contents

- [Installation](#installation)
- [Simple Test](#simple-test)
- [Using Iterator](#using-iterator)
- [License](#license)


## Installation

```
Just copy the FoxProperty prg anywhere into your project PATH folder.
```

## Simple Test
```xBase
// declare the FoxProperty Prg
Set Procedure to "FoxProperty" Additive

// Creating an FoxProperty Object
loProp = NewProperty()

// Put something
loProp.Put("language", "Visual FoxPro")
// And Get the specified key.
?loProp.GetProperty("language") // Visual FoxPro

// You may also provide default returned values if the specified key does not exist.
?"My name is: ", loProp.GetProperty("name", "no name key found") // My name is: no name key found
```
## Using Iterator

```xBase
// You may query the whole key-value pairs by using an iterator.
loProp.Put("name", "John")
loProp.Put("last_name", "Doe")
loProp.Put("age", 34)
loProp.Put("gender", "male")
loProp.Put("birthday", Date(1985, 11, 15))

// Iterate the keys
Do While (loProp.HasNext())
   lcKey = loProp.Next()
   ?"My Key is: ", lcKey, " and its content is: ", loProp.GetProperty(lcKey)
EndDo
```
## License

FoxProperty is released under the MIT Licence.
