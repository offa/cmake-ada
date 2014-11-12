# CMake Ada - Ada language support for CMake
# Copyright (C) 2014 offa
#
# This file is part of CMake Ada.
#
# CMake Ada is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# CMake Ada is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with CMake Ada. If not, see <http://www.gnu.org/licenses/>.

if(UNIX)
    set(CMAKE_ADA_OUTPUT_EXTENSION .o)
else()
    set(CMAKE_ADA_OUTPUT_EXTENSION .o)
endif()

set(CMAKE_ADA_SOURCE_FILE_EXTENSIONS adb ads)


if(CMAKE_ADA_COMPILER_ID)
    include(Compiler/${CMAKE_ADA_COMPILER_ID}-ADA OPTIONAL)
endif()


set(CMAKE_ADA_FLAGS ${CMAKE_ADA_FLAGS_INIT} CACHE STRING "Flags used by the compiler during all build types.")

if( NOT CMAKE_NOT_USING_CONFIG_FLAGS )
    if( NOT CMAKE_NO_BUILD_TYPE )
        set(CMAKE_ADA_BUILD_TYPE ${CMAKE_BUILD_TYPE_INIT} CACHE STRING "Choose the type of build, options are: None (CMAKE_ADA_FLAGS used) Debug Release RelWithDebInfo MinSizeRel.")
    endif()

    set(CMAKE_ADA_FLAGS_DEBUG "${CMAKE_ADA_FLAGS_DEBUG_INIT}" CACHE STRING "Flags used by the compiler during debug builds.")
    set(CMAKE_ADA_FLAGS_MINSIZEREL "${CMAKE_ADA_FLAGS_MINSIZEREL_INIT}" CACHE STRING "Flags used by the compiler during release minsize builds.")
    set(CMAKE_ADA_FLAGS_RELEASE "${CMAKE_ADA_FLAGS_RELEASE_INIT}" CACHE STRING "Flags used by the compiler during release builds.")
    set(CMAKE_ADA_FLAGS_RELWITHDEBINFO "${CMAKE_ADA_FLAGS_RELWITHDEBINFO_INIT}" CACHE STRING "Flags used by the compiler during Release with Debug Info builds.")
endif()

if(CMAKE_ADA_STANDARD_LIBRARIES_INIT)
    set(CMAKE_ADA_STANDARD_LIBRARIES "${CMAKE_ADA_STANDARD_LIBRARIES_INIT}" CACHE STRING "Libraries linked by defalut with all Ada applications.")
    mark_as_advanced(CMAKE_ADA_STANDARD_LIBRARIES)
endif()

include(CMakeCommonLanguageInclude)

# Removes objects after each target build
set(__CLEAN "rm -f *${CMAKE_ADA_OUTPUT_EXTENSION}")

set(CMAKE_ADA_COMPILE_OBJECT "<CMAKE_ADA_COMPILER> make -o <TARGET> <CMAKE_ADA_LINK_FLAGS> <SOURCE> -cargs <FLAGS>")
set(CMAKE_ADA_LINK_EXECUTABLE "" ${__CLEAN})
set(CMAKE_ADA_CREATE_STATIC_LIBRARY "<CMAKE_AR> cr <TARGET> <LINK_FLAGS> *${CMAKE_ADA_OUTPUT_EXTENSION}" "ranlib *.a" ${__CLEAN})

mark_as_advanced(CMAKE_ADA_FLAGS CMAKE_ADA_FLAGS_DEBUG CMAKE_ADA_FLAGS_MINSIZEREL CMAKE_ADA_FLAGS_RELEASE CMAKE_ADA_FLAGS_RELWITHDEBINFO)

set(CMAKE_ADA_INFORMATION_LOADED 1)
