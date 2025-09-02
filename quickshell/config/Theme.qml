pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property Gradient barBackground: Gradient {
        GradientStop {
            position: 0.0
            color: "#3168d5"
        }
        GradientStop {
            position: 0.09
            color: "#4993e6"
        }
        GradientStop {
            position: 0.18
            color: "#245dd7"
        }
        GradientStop {
            position: 0.5
            color: "#245ddb"
        }
        GradientStop {
            position: 0.89
            color: "#2561de"
        }
        GradientStop {
            position: 1.0
            color: "#1941a5"
        }
    }

    property color workspaceFocused: this.color05
    property color workspaceFocusedHover: Qt.lighter(this.workspaceFocused, 1.2)
    property color workspaceUnfocused: Qt.darker(this.workspaceFocused, 1.5)
    property color workspaceUnfocusedHover: Qt.lighter(this.workspaceUnfocused, 1.2)

    property color buttonInactive: this.color05
    property color buttonHover: Qt.lighter(this.buttonInactive, 1.2)
    property color buttonActive: Qt.lighter(this.buttonInactive, 1.5)

    property alias wallpaper: adapter.wallpaper
    property alias background: adapter.background
    property alias foreground: adapter.foreground
    property alias color00: adapter.color0
    property alias color01: adapter.color1
    property alias color02: adapter.color2
    property alias color03: adapter.color3
    property alias color04: adapter.color4
    property alias color05: adapter.color5
    property alias color06: adapter.color6
    property alias color07: adapter.color7
    property alias color08: adapter.color8
    property alias color09: adapter.color9
    property alias color10: adapter.color10
    property alias color11: adapter.color11
    property alias color12: adapter.color12
    property alias color13: adapter.color13
    property alias color14: adapter.color14
    property alias color15: adapter.color15

    FileView {
        path: Qt.resolvedUrl("./theme.json")
        watchChanges: true
        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()

        onLoaded: root.ready = true
        onLoadFailed: error => {
            if (error == FileViewError.FileNotFound) {
                writeAdapter();
            }
        }

        JsonAdapter {
            id: adapter
            property string wallpaper: ""
            property color background: "#000"
            property color foreground: "#000"
            property color color0: "#000"
            property color color1: "#000"
            property color color2: "#000"
            property color color3: "#000"
            property color color4: "#000"
            property color color5: "#000"
            property color color6: "#000"
            property color color7: "#000"
            property color color8: "#000"
            property color color9: "#000"
            property color color10: "#000"
            property color color11: "#000"
            property color color12: "#000"
            property color color13: "#000"
            property color color14: "#000"
            property color color15: "#000"
        }
    }

    property bool ready: false
}
