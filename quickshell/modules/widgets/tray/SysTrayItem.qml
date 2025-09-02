import Quickshell
import Quickshell.Widgets
import QtQuick.Layouts
import Quickshell.Services.SystemTray

WrapperMouseArea {
    id: root
    required property SystemTrayItem item
    property var bar: QsWindow.window
    property int offset: 300

    acceptedButtons: Qt.LeftButton | Qt.RightButton
    Layout.fillHeight: true
    implicitWidth: 24

    onClicked: function (ev) {
        switch (ev.button) {
        case Qt.LeftButton:
            item.activate();
            break;
        case Qt.RightButton:
            const p = trayIcon.mapToGlobal(Qt.point(0, 0));
            if (item.hasMenu)
                item.display(root.QsWindow.window, p.x, p.y);
            break;
        }
    }

    IconImage {
        id: trayIcon
        source: root.item.icon
        implicitHeight: parent.height
        implicitWidth: parent.width
    }
}
