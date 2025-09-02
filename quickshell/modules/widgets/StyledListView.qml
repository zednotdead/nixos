import QtQuick

ListView {
    id: root

    maximumFlickVelocity: 3000

    add: Transition {
        NumberAnimation {
            properties: "x"
            duration: 1000
            easing.type: Easing.BezierSpline
        }
    }

    rebound: Transition {
        NumberAnimation {
            properties: "x,y"
            duration: 1000
            easing.type: Easing.BezierSpline
        }
    }
}
