import QtQuick 2.0
import QtWebKit 3.0
import QtWebKit.experimental 1.0

WebView {
    id: webview
    url: "https://www.humblebundle.com/user/captcha"
    anchors.fill: parent

    signal reCaptchaEntered(string challenge, string response)

    experimental.preferences.navigatorQtObjectEnabled: true
    experimental.onMessageReceived: {
        var a = message.data.split("|")
        var challenge = a[0];
        var response  = a[1];
        webview.reCaptchaEntered(challenge, response)
    }
    experimental.userScripts: Qt.resolvedUrl("assets/js/CaptchaInjection.js");
}
