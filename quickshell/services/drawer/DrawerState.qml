// Time.qml
pragma Singleton

import Quickshell

Singleton {
    id: root

    property bool visible: false
    property bool shouldClose: false
    property bool shouldOpen: false

    function reset(shouldBeVisible) {
        DrawerState.shouldOpen = false;
        DrawerState.shouldClose = false;
        DrawerState.visible = shouldBeVisible;
    }

    function open() {
        if (shouldOpen || shouldClose)
            return;
        root.visible = true;
        root.shouldOpen = true;
    }

    function close() {
        if (shouldOpen || shouldClose)
            return;
        root.shouldClose = true;
    }

    function toggle() {
        if (root.visible) {
            root.close();
        } else {
            root.open();
        }
    }
}
