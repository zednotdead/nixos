import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Button {
    id: root
    Layout.fillHeight: true
    icon.source: Qt.resolvedUrl("../../res/logoff_button.png")
    icon.height: 20
    icon.width: 20
    hoverEnabled: true

    background: Rectangle {
        anchors.fill: parent
        gradient: {
            if (root.down) {
                return gPressed;
            }
            if (root.hovered) {
                return gHover;
            }

            return gNormal;
        }
    }

    contentItem: WrapperItem {
        anchors.fill: root
        leftMargin: 10
        rightMargin: 10

        RowLayout {
            IconImage {
                source: root.icon.source
                implicitSize: root.icon.width || root.icon.height
            }
            Text {
                text: root.text
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                font.italic: true
                style: Text.Raised
            }
        }
    }

    Gradient {
        id: gNormal
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
    }

    Gradient {
        id: gHover
        GradientStop {
            position: 0.0
            color: Qt.rgba(145, 201, 255, .3)
        }
        GradientStop {
            position: 0.9
            color: Qt.rgba(145, 201, 255, .3)
        }
        GradientStop {
            position: 0.98
            color: Qt.rgba(49, 132, 255, .3)
        }
        GradientStop {
            position: 1.0
            color: Qt.rgba(49, 132, 255, .3)
        }
    }

    Gradient {
        id: gPressed
        GradientStop {
            position: 0.0
            color: Qt.rgba(22, 76, 168, .5)
        }
        GradientStop {
            position: 0.1
            color: Qt.rgba(42, 93, 182, .5)
        }
        GradientStop {
            position: 1.0
            color: Qt.rgba(42, 93, 182, .5)
        }
    }
}
