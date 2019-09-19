# YAML

## ~
    
Equivaut à Null, NULL, null

## -

Equivaut à un tableau

Hyphens indicate list items. Lists can contain simple values like strings:
```
- "string1"
- "string2"
```
In JSON:
```
["string1", "string2"]
```
They can also contain sets of key-value pairs:
```
- item1key1: "string1"
  item1key2: "string2"
- item2key1: "string3"
  item2key2: "string4"
```
In JSON:
```
[{
  item1key1: "string1",
  item1key2: "string2"
},{
  item2key1: "string3",
  item2key2: "string4"
}]
```
That's what tasks is. Each hyphen starts a new list item (a task), and each list item may have multiple key-value pairs (properties of the task).