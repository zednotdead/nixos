import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.modules.startmenu
import qs.modules.widgets.workspaces
import qs.modules.widgets.clock
import qs.modules.widgets.tray
import qs.modules.widgets.start
import qs.modules.widgets.volume
import qs.config

PanelWindow {
    id: root
    color: "transparent"

    anchors {
        bottom: true
        right: true
        left: true
    }

    property int barHeight: 40

    aboveWindows: false
    exclusiveZone: barHeight

    Rectangle {
        id: bar
        z: -1

        gradient: Theme.barBackground

        implicitHeight: root.barHeight

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        Item {
            id: bgWrapper

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10

            anchors.verticalCenter: parent.verticalCenter

            Workspaces {
                id: ws

                anchors.left: sb.right
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
            }

            StartButton {
                id: sb

                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }

            RowLayout {
                layoutDirection: Qt.RightToLeft
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.verticalCenter: parent.verticalCenter

                Clock {}
                Volume {}
                SysTray {}
            }
        }
    }
}
