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

include(CMakeDetermineCompiler)
include(Platform/${CMAKE_SYSTEM_NAME}-ADA OPTIONAL)

if( NOT CMAKE_ADA_COMPILER_NAMES )
    set(CMAKE_ADA_COMPILER_NAMES gnat)
endif()

if( NOT CMAKE_ADA_COMPILER )
    set(CMAKE_ADA_COMPILER_INIT NOTFOUND)

    if( $ENV{ADA} MATCHES ".+" )
        get_filename_component(CMAKE_ADA_COMPILER_INIT $ENV{ADA} PROGRAM PROGRAM_ARGS CMAKE_ADA_FLAGS_ENV_INIT)

        if(NOT EXISTS ${CMAKE_ADA_COMPILER_INIT})
            message(FATAL_ERROR "Could not find compiler set in environment variable ADA:\n$ENV{ADA}.")
        endif()
    endif()

    _cmake_find_compiler(ADA)
endif()

set(CMAKE_ADA_COMPILER ${CMAKE_ADA_COMPILER} CACHE STRING "Ada compiler" FORCE)
mark_as_advanced(CMAKE_ADA_COMPILER)

execute_process(COMMAND ${CMAKE_ADA_COMPILER} "--version" RESULT_VARIABLE ADA_COMPILER_RTN OUTPUT_VARIABLE ADA_COMPILER_OUTPUT)

if( ${ADA_COMPILER_RTN} EQUAL "0" )
    message(WARNING "No version information available")
else()
    string(REGEX MATCH ".*(GNAT) ([0-9]+\\.[0-9]+(\\.[0-9]*)*).*" ADA_COMPILER_OUTPUT_MATCH ${ADA_COMPILER_OUTPUT})
    set(CMAKE_ADA_COMPILER_VERSION ${CMAKE_MATCH_2})
    set(CMAKE_ADA_COMPILER_ID "GNU")
endif()



if( NOT CMAKE_ADA_COMPILER_ID_RUN )
    set(CMAKE_ADA_COMPILER_ID_RUN 1)
    include(${CMAKE_ROOT}/Modules/CMakeDetermineCompilerId.cmake)
    CMAKE_DETERMINE_COMPILER_ID(ADA ADAFLAGS CMakeCompilerId.adb)
endif()


configure_file(${CMAKE_ROOT}/Modules/CMakeADACompiler.cmake.in
                ${CMAKE_PLATFORM_INFO_DIR}/CMakeADACompiler.cmake
                @ONLY IMMEDIATE)

set(CMAKE_ADA_COMPILER_ENV_VAR "ADA")
