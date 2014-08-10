import QtQuick 2.0


Rectangle {
    id: captchaRect
    anchors.fill: parent
    Text {
        anchors.fill: parent
        text: qsTr("sorry there is no captcha support on android yet. You have to quit and wait until their is no captcha on the login page anymore.");
    }
}
