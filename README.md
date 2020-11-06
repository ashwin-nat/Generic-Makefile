# Generic Makefile
This is a generic Makefile for C and C++ projects (FORTRAN should also work) that supports the following.
* Separate source and include directories
* Sub-directories in both source and include directories.
* Separate directories for object and executables (will be created automatically)
* Object directory will contain a directory structure that mirrors that of the source directory
* Customizable directory names, file extensions and executable file names
* Customizable compiler and linker flags
* Separate debug and release targets

## Installation and Usage

Just copy this makefile to the root directory of your project and its ready to use.
1. Copy the Makefile to the root directory of your project
2. Set the COMPILER variable to CC for C projects and CXX for C++ projects
3. Set/Check the SRCEXT and HDREXT variables for the file extensions of the source and header files respectively
4. Update the BINNAME variable to the name of the executable file required.
5. Update the SRCDIR, HDRDIR, OBJDIR and BINDIR variables if required

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
This Makefile uses non-portable commands, namely
* find
* mkdir -p
* rm -rf

This implies that it will only work on Unix based platforms (Unix, Linux, OSX, etc), and not on Windows

## License
[MIT](https://choosealicense.com/licenses/mit/)