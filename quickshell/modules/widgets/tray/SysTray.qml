import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import qs.modules.widgets.tray

// TODO: More fancy animation
RowLayout {
    id: rowLayout

    Repeater {
        model: SystemTray.items
        SysTrayItem {
            required property SystemTrayItem modelData
            item: modelData
        }
    }
}
