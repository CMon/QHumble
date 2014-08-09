import QtQuick 2.0
import QtQuick.Controls 1.1

Rectangle {
    id: pageLoginRect
    width: 100
    height: 62

    property bool loading: false
    readonly property string __loginUrl: "https://www.humblebundle.com/login";
    readonly property string __captchaUrl: "https://www.humblebundle.com/login/captcha";

    function login(username, password, captchaRequired) {
        pageLoginRect.loading = true;
        errorText.visible = false;

        var encodedUsername = encodeURIComponent(username);
        var encodedPassword = encodeURIComponent(password);
        var postData = "ajax=true" + "&username=" + encodedUsername + "&password=" + encodedPassword;

        var xhr = new XMLHttpRequest();
        if (!captchaRequired) {
            xhr.open("POST", __loginUrl, true);
        } else {
            postData += '&recaptcha_challenge_field' + recaptcha_challenge +
                        '&recaptcha_response_field' + recaptcha_response;
            xhr.open("POST", __captchaUrl, true);
        }

        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.setRequestHeader("Content-length", postData.length)



        if (storeCredentialsCheck.checked) {
            Settings.setUsername(username);
            Settings.setPassword(password);
        }




        xhr.onreadystatechange = function() {
            console.log("Foo" + xhr.responseText)

            if (xhr.readyState == xhr.DONE) {
                if (xhr.status == 200) {
                    console.log("logged in");
                    pageBundles.visible = true;
                    pageBundles.reloadBundles();
                    if (storeCredentialsCheck.checked) {
                        Settings.setUsername(username);
                        Settings.setPassword(password);
                    }
                } else if (xhr.status == 0) {
                    console.log("Error: ", xhr.status, xhr.statusText);
                    // this typically happens if no internet connection is there at all
                }
            } else if (xhr.status == 401) {
                console.log("Could not log in, bad credentials?");
                console.log(xhr.responseText)
                if (xhr.responseText != "") {
                    var errors = JSON.parse(xhr.responseText);
                    if (errors["captcha_required"]) {
                        pageCaptcha.visible = true
                    }
                }
            } else if (xhr.status != 200) {
                console.log("Error: ", xhr.status)
            }
            pageLoginRect.loading = false;
        }
        console.log(encodedUsername)
        xhr.send(postData);
    }

    Grid {
        id: grid
        y: 20

        anchors.horizontalCenter: parent.horizontalCenter
        columns: 2
        spacing: 5

        Label {
            text: qsTr("Login:")
        }
        TextField {
            id: loginInput
            width: 350

            text: Settings.getUsername()
        }

        Label {
            text: qsTr("Password:")
        }
        TextField {
            id: passwordInput
            width: 350
            echoMode: TextInput.Password

            text: Settings.getPassword()
        }
    }

    CheckBox {
        id: storeCredentialsCheck
        text: qsTr("Store Credentials")
        anchors.right: grid.right
        anchors.top: grid.bottom
        checked: true
    }

    Button {
        id: loginButton
        enabled: loginInput.text != "" && passwordInput.text != ""
        text: qsTr("Login")
        anchors.right: grid.right
        anchors.top: storeCredentialsCheck.bottom
        onClicked: login(loginInput.text, passwordInput.text, false)
    }

    Rectangle {
        anchors.right: grid.right
        anchors.left: grid.left
        anchors.top: loginButton.bottom

        Text {
            id: errorText
            anchors.right: parent.right
            text: qsTr("Login in failed.")
            color: "#ff0000"
            visible: false
        }

        Loading {
            width: 20
            height: 20
            anchors.left: errorText.left
            visible: pageLoginRect.loading
        }
    }
}
