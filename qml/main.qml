import QtQuick 2.2
import QtQuick.Controls 1.1

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }

    SimpleViewManager {
        id: mainViewManger
        anchors.fill: parent
        color: "#343434"

        PageLogin {
            id: pageLogin
            anchors.fill: parent
        }

        PageCaptcha {
            id: pageCaptcha
            anchors.fill: parent
        }

        PageBundles {
            id: pageBundles
            anchors.fill: parent
        }
    }
}
