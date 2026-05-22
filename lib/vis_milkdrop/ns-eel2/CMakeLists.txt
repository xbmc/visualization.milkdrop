cmake_minimum_required(VERSION 3.18)
project(ns-eel2)

set(SOURCES
  nseel-caltab.c
  nseel-cfunc.c
  nseel-compiler.c
  nseel-eval.c
  nseel-lextab.c
  nseel-ram.c
  nseel-yylex.c
  y.tab.c
)

set(HEADERS
  glue_aarch64.h
  glue_arm.h
  glue_port.h
  glue_ppc.h
  glue_x86.h
  glue_x86_64_sse.h
  ns-eel.h
  ns-eel-addfuncs.h
  ns-eel-func-ref.h
  ns-eel-int.h
  y.tab.h
)

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
  string(TOLOWER "${CMAKE_GENERATOR_PLATFORM}" CMAKE_GENERATOR_PLATFORM_LC)
  if(CMAKE_SYSTEM_PROCESSOR STREQUAL "ARM64" OR CMAKE_GENERATOR_PLATFORM_LC STREQUAL "arm64")
    enable_language(ASM_MARMASM)
    list(APPEND SOURCES asm-nseel-aarch64-msvc.asm)
  elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "AMD64" OR CMAKE_GENERATOR_PLATFORM_LC STREQUAL "x64")
  find_program(CMAKE_ASM_NASM_COMPILER NAMES nasm nasmw)
    enable_language(ASM_NASM)
    list(APPEND SOURCES asm-nseel-x64-sse.asm)
  endif()
endif()

add_library(ns-eel2 STATIC ${SOURCES} ${HEADER})
