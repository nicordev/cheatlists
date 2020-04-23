# Bash - Text formatting

> Use `echo -e` to use text formatting.

Syntaxe: 
```bash
\e[FORMAT;FORMAT;FORMATm
```

- `\e` is the escape character (`\033` works too).
- `[` mark the beginning of the format code.
- `;` separate formating code sequence.
- `m` mark the end of the format code.
- `FORMAT` has to be replaced by a formatting code:
    - character effects using 1 digit:

        code | effect
        ---- | ------
        0    | normal
        1    | bold
        4    | underlined
        5    | blinking
        7    | reverse colors

    - colors using 2 digit:
        - first digit (the target):
            
            code | effect
            ---- | ------
            3    | foreground
            4    | background
        - second digit (the color):

            code | effect
            ---- | ------
            0    | black
            1    | red
            2    | green
            3    | brown
            4    | blue
            5    | purple
            6    | cyan
            7    | light gray