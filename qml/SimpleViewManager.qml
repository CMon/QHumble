import QtQuick 2.0

import "assets/js/SimpleViewManager.js" as SVM

Rectangle {
    id: viewManager

    default property alias content: viewsContainer.children

    clip: true

    PropertyAnimation {
        id: currentViewAnimation
        duration : 500
        property: "x"
        easing.type: Easing.OutQuad
        onRunningChanged: if(!running) target.visible = false
    }

    PropertyAnimation {
        id: nextViewAnimation
        duration : 500
        property: "x"
        easing.type: Easing.OutQuad
    }

    Rectangle {
        id: viewsContainer
        anchors.fill: parent
    }

    Component.onCompleted: {
        var views = viewsContainer.children;

        if(views.length > 0) {
            SVM.currentView = views[0];

            var view;
            for(var i = 0; i < views.length; i++) {
                view = views[i]
                view.visible = (i == 0);
                //view.anchors.fill = parent;
                SVM.connectViewEvents(view);
            }
        }
    }

    function previousView () {
        SVM.previousView();
    }
}
