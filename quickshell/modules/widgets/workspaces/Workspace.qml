import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import qs.config

WrapperItem {
    id: root
    required property HyprlandWorkspace workspace

    property int size: 20

    MouseArea {
        id: mouse
        implicitHeight: root.size
        implicitWidth: root.size
        anchors.fill: parent
        onClicked: Hyprland.dispatch("workspace " + root.workspace.id)

        Text {
            text: root.workspace.active ? `[ ${root.workspace.name} ]` : root.workspace.name
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            style: Text.Raised
        }
    }
}
