add_executable(sysu-tester-mizuno_ai mizuno_ai.sysu.c)
target_link_libraries(sysu-tester-mizuno_ai sysu)
target_include_directories(
  sysu-tester-mizuno_ai
  PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/../../librarian/include)
install(TARGETS sysu-tester-mizuno_ai)
