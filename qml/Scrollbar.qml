import QtQuick 2.0

Rectangle {
    property variant flickable // The flickable to which the scrollbar is attached to, must be set
    property bool vertical: true // false for horizontal
    property int scrollbarWidth: 10

    color: "black"
    radius: vertical ? width/2 : height/2

    // Scrollbar appears automatically when content is bigger than the Flickable
    opacity: (flickable.flicking || flickable.moving) ? (vertical ? (height >= parent.height ? 0 : 0.5)
                                                                  : (width >= parent.width ? 0 : 0.5))
                                                      : 0

    // Calculate width/height and position based on the content size and position of
    // the Flickable
    width: vertical ? scrollbarWidth : flickable.visibleArea.widthRatio * parent.width
    height: vertical ? flickable.visibleArea.heightRatio * parent.height : scrollbarWidth
    x: vertical ? parent.width - width : flickable.visibleArea.xPosition * parent.width
    y: vertical ? flickable.visibleArea.yPosition * parent.height : parent.height - height

    // Animate scrollbar appearing/disappearing
    Behavior on opacity { NumberAnimation { duration: 200 }}
}
