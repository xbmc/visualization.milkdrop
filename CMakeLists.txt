project(visualization.milkdrop)

cmake_minimum_required(VERSION 2.6)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${PROJECT_SOURCE_DIR})

find_package(Kodi REQUIRED)
find_package(kodiplatform REQUIRED)
find_package(p8-platform REQUIRED)

include_directories(${PROJECT_SOURCE_DIR}/lib
                    ${INCLUDES}
                    ${kodiplatform_INCLUDE_DIRS}
                    ${p8-platform_INCLUDE_DIRS}
                    ${KODI_INCLUDE_DIR})

set(MILKDROP_SOURCES src/MilkdropXBMC.cpp
                     src/XmlDocument.cpp)

add_definitions(-DHAS_DX -D_CRT_SECURE_NO_WARNINGS)

add_subdirectory(${PROJECT_SOURCE_DIR}/lib/vis_milkdrop)

set(DEPLIBS vis_milkdrop)

list(APPEND DEPLIBS ${p8-platform_LIBRARIES})


build_addon(visualization.milkdrop MILKDROP DEPLIBS)

include(CPack)
