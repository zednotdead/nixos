import QtQuick
import Quickshell.Widgets
import qs.services.drawer

WrapperMouseArea {
    id: root
    hoverEnabled: true

    property int borderImageWidth: 99
    property int borderImageHeight: 31
    property double ratio: borderImageWidth / borderImageHeight

    implicitWidth: ratio * height

    onClicked: function () {
        DrawerState.visible = !DrawerState.visible;
    }

    property string imagePrefix: {
        const base = "../../../res/start_button";
        if (DrawerState.visible) {
            return `${base}_press`;
        }
        if (root.pressed) {
            return `${base}_press`;
        }
        if (root.containsMouse) {
            return `${base}_hover`;
        }
        return base;
    }

    Image {
        source: Qt.resolvedUrl(root.imagePrefix + "_border.png")
        anchors.fill: parent

        Image {
            source: Qt.resolvedUrl(root.imagePrefix + "_body.png")
            anchors.fill: parent

            anchors.leftMargin: (5 / root.borderImageWidth) * root.width
            anchors.topMargin: (2 / root.borderImageHeight) * root.height
            anchors.bottomMargin: (3 / root.borderImageHeight) * root.height
            anchors.rightMargin: (13 / root.borderImageWidth) * root.width

            Item {
                anchors.fill: parent
                anchors.leftMargin: 5

                Image {
                    id: flag
                    source: Qt.resolvedUrl("../../../res/start_flag.png")
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    text: "start"
                    color: "white"
                    style: Text.Raised
                    font.pointSize: 15
                    font.bold: true
                    font.italic: true

                    anchors.left: flag.right
                    anchors.leftMargin: 6
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }

}
