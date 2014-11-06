project(vis_milkdrop)

enable_language(CXX)

cmake_minimum_required(VERSION 2.6)

include_directories(${PROJECT_SOURCE_DIR})

set(SOURCES dxcontext.cpp
            fft.cpp
            pluginshell.cpp
            utility.cpp
            milkdropfs.cpp
            plugin.cpp
            state.cpp
            support.cpp)

add_subdirectory(evallib)

add_library(vis_milkdrop STATIC ${SOURCES})

target_link_libraries(vis_milkdrop evallib)
