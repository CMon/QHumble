import QtQuick 2.1

Item {
    smooth: true
    anchors.verticalCenter: parent.verticalCenter

    property string source

    Loading {
        x: 1
        y: 1
        width: parent.height
        height: parent.height
        visible: realImage.status != Image.Ready
    }

    Image {
        id: realImage
        source: parent.source
        fillMode: Image.PreserveAspectFit
        x: 1
        y: 1
        width: parent.height
        height: parent.height
        opacity: 0
        onStatusChanged: {
            if(status==Image.Ready) image.state="loaded"
        }
    }

    states: State {
        name: "loaded"
        PropertyChanges {
            target: realImage
            opacity:1
        }
    }

    transitions: Transition {
        NumberAnimation {
            target: realImage
            property: "opacity"
            duration: 200
        }
    }
}
