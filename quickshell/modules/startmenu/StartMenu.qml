pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.services.drawer

PopupWindow {
    id: root
    implicitWidth: 500
    implicitHeight: l.implicitHeight
    color: "transparent"

    anchor.gravity: Edges.Top | Edges.Left

    visible: DrawerState.visible

    ColumnLayout {
        id: l
        anchors.fill: parent
        spacing: 0

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 80
            topLeftRadius: 10
            topRightRadius: 10

            gradient: Gradient {
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

            Text {
                anchors.fill: parent
                anchors.leftMargin: 20
                verticalAlignment: Text.AlignVCenter

                text: Quickshell.env("USER") ?? "user"
                style: Text.Raised
                color: "white"
                font.pointSize: 24
                font.bold: true
                font.italic: true
            }
        }

        ClippingRectangle {
            id: box
            color: "white"
            Layout.fillWidth: true
            Layout.preferredHeight: 600

            ListView {
                anchors.fill: parent
                anchors.topMargin: 10
                anchors.bottomMargin: 10

                model: ScriptModel {
                    id: model
                    values: [...DesktopEntries.applications.values]
                }

                delegate: appItem
                ScrollBar.vertical: ScrollBar {}
            }

            Component {
                id: appItem
                AppItem {}
            }
        }

        Rectangle {
            id: bot
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            gradient: Gradient {
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

            RowLayout {
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                spacing: 0
                StartMenuBottomBarButton{
                    Layout.fillHeight: true
                    text: "log out"
                    icon.source: Qt.resolvedUrl("../../res/logoff_button.png")
                    icon.height: 20
                    icon.width: 20
                    onClicked: Quickshell.execDetached({
                      command: ["uwsm", "stop"]
                    })
                }

                StartMenuBottomBarButton{
                    Layout.fillHeight: true
                    text: "shut down"
                    icon.source: Qt.resolvedUrl("../../res/shutdown_button.png")
                    icon.height: 20
                    icon.width: 20

                    onClicked: Quickshell.execDetached({
                      command: ["systemctl", "poweroff"]
                    })
                }
            }
        }
    }
}
