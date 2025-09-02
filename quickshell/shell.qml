pragma ComponentBehavior: Bound
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000
//@ pragma UseQApplication
//@ pragma IconTheme breeze-dark

import Quickshell
import qs.modules.bar
import qs.modules.startmenu
import qs.modules.notifications.popup

ShellRoot {
    Bar {
        id: bar
    }

    StartMenu {
        anchor.rect.y: bar.barHeight + 20
        anchor.window: bar
    }

    NotificationPopup {}
}
