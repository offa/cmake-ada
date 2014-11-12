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

include(Compiler/GNU)

__compiler_gnu(ADA)

set(CMAKE_ADA_FLAGS_INIT "-gnato -gnatwa -gnatQ -gnat2005")
