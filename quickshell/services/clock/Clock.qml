// Time.qml
pragma Singleton

import Quickshell

Singleton {
    id: root
    readonly property date date: clock.date
    // an expression can be broken across multiple lines using {}
    readonly property string time: {
        // The passed format string matches the default output of
        // the `date` command.
        Qt.formatDateTime(clock.date, "dddd, d MMM yyyy,  hh:mm AP");
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
