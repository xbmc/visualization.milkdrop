cmake_minimum_required(VERSION 3.5)
project(vis_milkdrop)

include_directories(${PROJECT_SOURCE_DIR})

set(SHADER_FILES dx11/DefaultVertexShader.hlsl
                 dx11/DiffusePixelShader.hlsl
                 dx11/ColorPixelShader.hlsl
                 dx11/TexturePixelShader.hlsl)
set(SHADER_INCLUDES)

foreach(SHADER_FILE ${SHADER_FILES})
  get_filename_component(FileName ${SHADER_FILE} NAME_WE)
  if(${FileName} MATCHES "(.+Vertex.+)")
    set(ShaderType vs)
  elseif(${FileName} MATCHES "(.+Pixel.+)")
    set(ShaderType ps)
  else()
    message(FATAL_ERROR "Unknown shader type.")
  endif()
  set(IncFile ${FileName}.inc)
  list(APPEND SHADER_INCLUDES ${IncFile})

  add_custom_command(
    OUTPUT ${CMAKE_CURRENT_SOURCE_DIR}/${IncFile}
    COMMAND fxc /nologo /T${ShaderType}_4_0_level_9_1 /Vn ${FileName}Code /Fh ${IncFile} ${SHADER_FILE}
    MAIN_DEPENDENCY ${SHADER_FILE}
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    VERBATIM)
endforeach(SHADER_FILE)

set(SOURCES dx11/CommonStates.cpp
            dx11/DX11Context.cpp
            dxcontext.cpp
            fft.cpp
            pluginshell.cpp
            utility.cpp
            milkdropfs.cpp
            plugin.cpp
            state.cpp
            support.cpp)

add_subdirectory(ns-eel2)

if(CORE_SYSTEM_NAME STREQUAL windowsstore)
  add_definitions(-D_WIN32_WINNT=0x0A00 -D_WINDOWS)
else()
  add_definitions(-D_WIN32_WINNT=0x0600 -D_WINDOWS)
endif()
remove_definitions(-D_USE_32BIT_TIME_T)
add_library(vis_milkdrop STATIC ${SOURCES} ${SHADER_INCLUDES})

target_link_libraries(vis_milkdrop ns-eel2)
