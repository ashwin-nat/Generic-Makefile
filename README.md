# Generic Makefile
This is a generic Makefile for C and C++ projects that supports the following.
* Separate source and include directories
* Sub-directories in both source and include directories.
* Separate directories for object and executables (will be created automatically)
* Object directory will contain a directory structure that mirrors that of the source directory
* Customizable directory names, file extensions and executable file names
* Customizable compiler and linker flags

## Installation

Just copy this makefile to the root directory of your project and its ready to use.

## Demo program
A demo C program is included in this repo. The directory structure for this program is
```
.
├── inc
│   ├── a
│   │   └── a.h
│   ├── b
│   │   └── b.h
│   └── c
│       └── c.h
├── Makefile
└── src
    ├── a
    │   └── a.c
    ├── b
    │   └── b.c
    ├── c
    │   └── c.c
    └── main.c
```
To build the program, just use make
```
make
```

## Known issues
This Makefile uses the unix shell find command to identify the files and directories recursively. This means that this Makefile will only work on Unix based platforms, and not on Windows

## License
[MIT](https://choosealicense.com/licenses/mit/)