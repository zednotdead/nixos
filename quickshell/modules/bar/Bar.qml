import Quickshell
import QtQuick
import QtQuick.Layouts
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
        top: true
        right: true
        left: true
    }

    property int barHeight: 40

    aboveWindows: false
    exclusiveZone: barHeight

    Rectangle {
        id: bar
        z: -1

	color: Theme.background

        implicitHeight: root.barHeight

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        Item {
            id: bgWrapper

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.leftMargin: 10
            anchors.rightMargin: 20

            anchors.verticalCenter: parent.verticalCenter

            Workspaces {
                id: ws

                anchors.left: sb.right
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
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
