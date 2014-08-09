import QtQuick 2.0

Rectangle {
    id: pageBundlesRect
    width: 100
    height: 62

    readonly property string __orderListUrl: "https://www.humblebundle.com/api/v1/user/order";
    property bool loading: false

    function reloadBundles() {
        pageBundlesRect.loading = true;
        var data = "ajax=true";

        var xhr = new XMLHttpRequest();
        xhr.open("GET", __orderListUrl, true);

        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.setRequestHeader("Content-length", data.length)

        xhr.onreadystatechange = function() {
            if (xhr.readyState == xhr.DONE) {
                if (xhr.status == 200) {
                    console.log(xhr.responseText);
                } else if (xhr.status == 0) {
                    console.log("Error: ", xhr.status, xhr.statusText);
                    // this typically happens if no internet connection is there at all
                }
            }  else if (xhr.status == 401) {
                console.log("need to relogin");
                pageLogin.visible = true;
            } else if (xhr.status != 200) {
                console.log("Error: ", xhr.status)
            }
            pageLoginRect.loading = false;
        }
        console.log(encodedUsername)
        xhr.send(data);
    }

    Loading {
        width: 50
        height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        visible: pageBundlesRect.loading
    }

}
