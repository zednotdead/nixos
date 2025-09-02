import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs.services.hyprland

RowLayout {
    id: root
    spacing: 8

    Repeater {
        model: Hyprland.workspaces

        Workspace {
            required property HyprlandWorkspace modelData
            workspace: modelData
        }
    }
}
