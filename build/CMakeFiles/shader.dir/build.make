# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.24

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /opt/homebrew/Cellar/cmake/3.24.1/bin/cmake

# The command to remove a file.
RM = /opt/homebrew/Cellar/cmake/3.24.1/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/ntrujillo/Classes/CSCE_441/assignment_04

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/ntrujillo/Classes/CSCE_441/assignment_04/build

# Include any dependencies generated for this target.
include CMakeFiles/shader.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/shader.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/shader.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/shader.dir/flags.make

CMakeFiles/shader.dir/src/Program.cpp.o: CMakeFiles/shader.dir/flags.make
CMakeFiles/shader.dir/src/Program.cpp.o: /Users/ntrujillo/Classes/CSCE_441/assignment_04/src/Program.cpp
CMakeFiles/shader.dir/src/Program.cpp.o: CMakeFiles/shader.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/ntrujillo/Classes/CSCE_441/assignment_04/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/shader.dir/src/Program.cpp.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/shader.dir/src/Program.cpp.o -MF CMakeFiles/shader.dir/src/Program.cpp.o.d -o CMakeFiles/shader.dir/src/Program.cpp.o -c /Users/ntrujillo/Classes/CSCE_441/assignment_04/src/Program.cpp

CMakeFiles/shader.dir/src/Program.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/shader.dir/src/Program.cpp.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/ntrujillo/Classes/CSCE_441/assignment_04/src/Program.cpp > CMakeFiles/shader.dir/src/Program.cpp.i

CMakeFiles/shader.dir/src/Program.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/shader.dir/src/Program.cpp.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/ntrujillo/Classes/CSCE_441/assignment_04/src/Program.cpp -o CMakeFiles/shader.dir/src/Program.cpp.s

CMakeFiles/shader.dir/src/main.cpp.o: CMakeFiles/shader.dir/flags.make
CMakeFiles/shader.dir/src/main.cpp.o: /Users/ntrujillo/Classes/CSCE_441/assignment_04/src/main.cpp
CMakeFiles/shader.dir/src/main.cpp.o: CMakeFiles/shader.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/ntrujillo/Classes/CSCE_441/assignment_04/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/shader.dir/src/main.cpp.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/shader.dir/src/main.cpp.o -MF CMakeFiles/shader.dir/src/main.cpp.o.d -o CMakeFiles/shader.dir/src/main.cpp.o -c /Users/ntrujillo/Classes/CSCE_441/assignment_04/src/main.cpp

CMakeFiles/shader.dir/src/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/shader.dir/src/main.cpp.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/ntrujillo/Classes/CSCE_441/assignment_04/src/main.cpp > CMakeFiles/shader.dir/src/main.cpp.i

CMakeFiles/shader.dir/src/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/shader.dir/src/main.cpp.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/ntrujillo/Classes/CSCE_441/assignment_04/src/main.cpp -o CMakeFiles/shader.dir/src/main.cpp.s

# Object files for target shader
shader_OBJECTS = \
"CMakeFiles/shader.dir/src/Program.cpp.o" \
"CMakeFiles/shader.dir/src/main.cpp.o"

# External object files for target shader
shader_EXTERNAL_OBJECTS =

shader: CMakeFiles/shader.dir/src/Program.cpp.o
shader: CMakeFiles/shader.dir/src/main.cpp.o
shader: CMakeFiles/shader.dir/build.make
shader: /Users/ntrujillo/Classes/CSCE_441/glfw/debug/src/libglfw3.a
shader: /Users/ntrujillo/Classes/CSCE_441/glew/lib/libGLEW.a
shader: CMakeFiles/shader.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/ntrujillo/Classes/CSCE_441/assignment_04/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX executable shader"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/shader.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/shader.dir/build: shader
.PHONY : CMakeFiles/shader.dir/build

CMakeFiles/shader.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/shader.dir/cmake_clean.cmake
.PHONY : CMakeFiles/shader.dir/clean

CMakeFiles/shader.dir/depend:
	cd /Users/ntrujillo/Classes/CSCE_441/assignment_04/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/ntrujillo/Classes/CSCE_441/assignment_04 /Users/ntrujillo/Classes/CSCE_441/assignment_04 /Users/ntrujillo/Classes/CSCE_441/assignment_04/build /Users/ntrujillo/Classes/CSCE_441/assignment_04/build /Users/ntrujillo/Classes/CSCE_441/assignment_04/build/CMakeFiles/shader.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/shader.dir/depend
