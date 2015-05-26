project(visualization.milkdrop)

cmake_minimum_required(VERSION 2.6)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${PROJECT_SOURCE_DIR})

find_package(kodi REQUIRED)

include_directories(${PROJECT_SOURCE_DIR}/lib
                    ${KODI_INCLUDE_DIR})

set(MILKDROP_SOURCES src/MilkdropXBMC.cpp
                     src/XmlDocument.cpp)

add_definitions(-DHAS_DX -D_CRT_SECURE_NO_WARNINGS)

add_subdirectory(lib/vis_milkdrop)

set(DEPLIBS evallib vis_milkdrop)

build_addon(visualization.milkdrop MILKDROP DEPLIBS)

include(CPack)
