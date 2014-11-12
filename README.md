# CMake Ada

Ada language support for CMake.


## Installation

```
cmake -P install.cmake
```

**Alternative:**

Copy the content of `Modules` directory into `Modules` of the CMake installation.


## Usage

The Ada language is enabled by either `project(<NAME> ADA)` or `enable_language(ADA)` within the `CMakeLists.txt`.

CMake is used as usual:

```
# Out of source build
$ mkdir build
$ cd build

$ cmake ..
$ make
```

## Example

```cmake
cmake_minium_required(VERSION 2.6)

project(AdaTest)


# Enable Ada support
enable_language(ADA)

# Build an executable with a source file and a package
add_executable(${PROJECT_NAME} src/Main.adb src/TestPackge.ads)

# Build a (static) library
add_library(${PROJECT_NAME}-static src/TestLib.adb)
```

This will build an application `AdaTest` and a static library `libAdaTest-static.a`.


## Limitations

Since this modul is in a very early development state, there are some limitations at the moment:

 - only *GNAT* is supported
 - `gnat make` is used instead of `gnat compile` / `gnat bind` / `gnat link`
 - Shared libraries / modules are not supported yet


## License

**GNU General Public License (GPL)**

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.