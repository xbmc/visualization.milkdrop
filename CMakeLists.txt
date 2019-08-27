cmake_minimum_required(VERSION 3.5)
project(visualization.milkdrop)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${PROJECT_SOURCE_DIR})

find_package(Kodi REQUIRED)

include_directories(${PROJECT_SOURCE_DIR}/lib
                    ${INCLUDES}
                    ${KODI_INCLUDE_DIR}/.. # Hack way with "/..", need bigger Kodi cmake rework to match right include ways (becomes done in future)
                    )

set(MILKDROP_SOURCES src/MilkdropXBMC.cpp)

add_definitions(-DHAS_DX -D_CRT_SECURE_NO_WARNINGS)

add_subdirectory(${PROJECT_SOURCE_DIR}/lib/vis_milkdrop)

set(DEPLIBS vis_milkdrop)

build_addon(visualization.milkdrop MILKDROP DEPLIBS)

include(CPack)
