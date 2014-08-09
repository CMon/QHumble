TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    humblebundleapi.cpp \
    settings.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    humblebundleapi.h \
    settings.h
