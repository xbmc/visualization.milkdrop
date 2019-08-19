cmake_minimum_required(VERSION 3.5)
project(ns-eel2)

set(SOURCES ns-eel.h
            ns-eel-addfuncs.h
            ns-eel-int.h
            nseel-caltab.c
            nseel-cfunc.c
            nseel-compiler.c
            nseel-eval.c
            nseel-lextab.c
            nseel-ram.c
            nseel-yylex.c)

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
  find_program(CMAKE_ASM_NASM_COMPILER NAMES nasm nasmw)
  enable_language(ASM_NASM)
  set(SOURCES ${SOURCES} 
    asm-nseel-x64.asm
  )
endif()

add_library(ns-eel2 STATIC ${SOURCES})
