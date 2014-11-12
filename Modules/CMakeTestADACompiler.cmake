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

include(CMakeTestCompilerCommon)
unset(CMAKE_ADA_COMPILER_WORKS CACHE)

if( NOT CMAKE_ADA_COMPILER_WORKS )
    PrintTestCompilerStatus("ADA" "")
    set(_ADA_TEST_FILE "${CMAKE_BINARY_DIR}/${CMAKE_FILES_DIRECTORY}/CMakeTmp/TestAdaCompiler.adb")
    
    file(WRITE ${_ADA_TEST_FILE}
        "procedure testAdaCompiler is\n"
        "begin\n"
        "   null;\n"
        "end testAdaCompiler;\n")

    try_compile(CMAKE_ADA_COMPILER_WORKS ${CMAKE_BINARY_DIR}
                ${_ADA_TEST_FILE}
                OUTPUT_VARIABLE __CMAKE_ADA_COMPILER_OUTPUT)

    set(CMAKE_ADA_COMPILER_WORKS ${CMAKE_ADA_COMPILER_WORKS})
    unset(CMAKE_ADA_COMPILER_WORKS CACHE)
    set(ADA_TEST_WAS_RUN 1)
endif()

if( NOT CMAKE_ADA_COMPILER_WORKS)
    PrintTestCompilerStatus("ADA" " -- broken")

    file(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeError.log
        "Determining if the Ada compiler works failed with "
        "the following output:\n${__CMAKE_ADA_COMPILER_OUTPUT}\n\n")

    message(FATAL_ERROR "The Ada compiler \"${CMAKE_ADA_COMPILER}\" "
        "is not able to compile a simple test program.\nIt fails "
        "with the following output:\n ${__CMAKE_ADA_COMPILER_OUTPUT}\n\n"
        "CMake will not be able to correctly generate this project.")
else()
    if( ADA_TEST_WAS_RUN )
        PrintTestCompilerStatus("ADA" " -- works")

        file(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeOutput.log
            "Determining if the Ada compiler works passed with "
            "the following output:\n${__CMAKE_ADA_COMPILER_OUTPUT}\n\n")
    endif()
endif()

unset(__CMAKE_ADA_COMPILER_OUTPUT)


