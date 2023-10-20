cmake_minimum_required(VERSION 3.2)
project(test_app LANGUAGES CXX C ASM)


find_package(test_lib REQUIRED)
add_executable(test_app main.cpp)
target_link_libraries(test_app PUBLIC test_lib::test_lib)
install (TARGETS test_app RUNTIME DESTINATION bin)

install(
    FILES test_lib_source_dir.env
    DESTINATION debug
    )
