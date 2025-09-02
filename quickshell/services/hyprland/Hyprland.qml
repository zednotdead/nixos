pragma Singleton
import Quickshell
import Quickshell.Hyprland

Singleton {
    id: root
    property var workspaces: Hyprland.workspaces
}
