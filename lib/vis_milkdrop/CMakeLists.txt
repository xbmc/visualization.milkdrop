project(vis_milkdrop)

enable_language(CXX)

cmake_minimum_required(VERSION 2.6)

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

add_subdirectory(evallib)

add_definitions(-D_WIN32_WINNT=0x0600 -DNTDDI_VERSION=0x06000000 -D_WINDOWS)
remove_definitions(-D_USE_32BIT_TIME_T)
add_library(vis_milkdrop STATIC ${SOURCES} ${SHADER_INCLUDES})

target_link_libraries(vis_milkdrop evallib)
