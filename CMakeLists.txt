cmake_minimum_required(VERSION 3.20)
project(test)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# ============================== Libraries ==============================
set(OpenCV_DIR "D:/libraries/opencv-4.11.0_cuda-12.8/")
set(Qt_DIR "D:/Qt/6.9.1/msvc2022_64")
set(CMAKE_PREFIX_PATH "${OpenCV_DIR};${Qt_DIR}")

find_package(OpenCV REQUIRED COMPONENTS core highgui videoio imgproc imgcodecs)
find_package(Qt6 REQUIRED COMPONENTS core gui Widgets)

# ============================== Target ==============================
add_executable(${PROJECT_NAME} main.cpp)
target_link_libraries(${PROJECT_NAME} PRIVATE
    ${OpenCV_LIBS}
    Qt6::Core
    Qt6::Gui
    Qt6::Widgets
)

# ============================== Post Build ==============================
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    ${CMAKE_SOURCE_DIR}/resources
    $<TARGET_FILE_DIR:${PROJECT_NAME}>/resources
)
foreach(lib ${OpenCV_LIBS})
    add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        $<TARGET_FILE:${lib}>
        $<TARGET_FILE_DIR:${PROJECT_NAME}>
    )
endforeach()
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${Qt_DIR}/bin/windeployqt.exe
    $<TARGET_FILE:${PROJECT_NAME}>
    --no-translations
    --no-opengl-sw
    --no-compiler-runtime
    --no-system-d3d-compiler
    --no-quick-import
    --no-qml
    --no-svg
    --no-network
)

# ============================== Install ==============================
set(CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR}/install)
set(INSTALL_BIN_DIR ${CMAKE_INSTALL_PREFIX}/bin)
install(FILES README.md DESTINATION ${CMAKE_INSTALL_PREFIX})
install(DIRECTORY resources DESTINATION ${CMAKE_INSTALL_PREFIX})

install(TARGETS ${PROJECT_NAME} RUNTIME DESTINATION ${INSTALL_BIN_DIR})
foreach(lib ${OpenCV_LIBS})
    install(FILES $<TARGET_FILE:${lib}> DESTINATION ${INSTALL_BIN_DIR})
endforeach()
install(CODE "
    execute_process(COMMAND \"${Qt_DIR}/bin/windeployqt.exe\"
        \"${INSTALL_BIN_DIR}/${PROJECT_NAME}.exe\"
        --no-translations
        --no-opengl-sw
        --no-compiler-runtime
        --no-system-d3d-compiler
        --no-quick-import
        --no-qml
        --no-svg
        --no-network
        RESULT_VARIABLE result
        OUTPUT_VARIABLE output
        ERROR_VARIABLE error
    )
    message(STATUS \"windeployqt result: \${result}\")
    if(result)
        message(FATAL_ERROR \"windeployqt failed: \${error}\")
    endif()
")

