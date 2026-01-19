cmake_minimum_required(VERSION 3.16)

project(Calabiyau-Rolling VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.8 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appCalabiyau-Rolling
    main.cpp
)

qt_add_qml_module(appCalabiyau-Rolling
    URI Calabiyau-Rolling
    VERSION 1.0
    QML_FILES
        Main.qml
    RESOURCES
        images/明.png
        images/拉薇.png
        images/梅瑞狄斯.png
        images/令.png
        images/香奈美.png
        images/艾卡.png
        images/珐格兰丝.png
        images/玛拉.png
        images/星绘.png
        images/奥黛丽.png
        images/玛德蕾娜.png
        images/绯莎.png
        images/白墨.png
        images/加拉蒂亚.png
        images/米雪儿李.png
        images/信.png
        images/心夏.png
        images/伊薇特.png
        images/芙拉薇娅.png
        images/忧雾.png
        images/蕾欧娜.png
        images/千代.png
        images/maps/88区.png
        images/maps/404基地.png
        images/maps/奥卡努斯.png
        images/maps/柯西街区.png
        images/maps/欧拉港口.png
        images/maps/科斯迷特.png
        images/maps/空间实验室.png
        images/maps/风曳镇.png
)

set_target_properties(appCalabiyau-Rolling PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appCalabiyau-Rolling
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appCalabiyau-Rolling
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
