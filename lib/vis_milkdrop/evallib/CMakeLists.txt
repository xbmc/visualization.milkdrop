project(evallib)

enable_language(C)

cmake_minimum_required(VERSION 2.6)

set(SOURCES CAL_TAB.C
            cfunc.c
            Compiler.c
            eval.c
            Gettok.c
            Lextab.c
            LLSAVE.C
            Yylex.c)

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
  # disable optimization for cfunc.c and Compiler.c
  set_source_files_properties(cfunc.c Compiler.c COMPILE_FLAGS -Od)
endif()

add_library(evallib STATIC ${SOURCES})
