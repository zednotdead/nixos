import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.services.drawer

WrapperItem {
    id: root
    required property DesktopEntry modelData
    implicitHeight: 60
    anchors.left: parent?.left
    anchors.right: parent?.right

    WrapperMouseArea {
        onClicked: {
            root.modelData.execute();
            DrawerState.visible = false;
        }

        WrapperRectangle {
            anchors.fill: parent
            color: mouse.hovered ? Qt.rgba(0, 0, 0, 0.2) : Qt.rgba(0, 0, 0, 0)

            Item {
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10

                ColumnLayout {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: icon.width

                    Layout.fillWidth: true

                    Text {
                        text: root.modelData.name
                        font.pointSize: 11
                        font.bold: true
                        style: Text.Raised
                        styleColor: "gray"
                    }

                    Text {
                        text: root.modelData.comment
                        font.pointSize: 8
                    }
                }

                IconImage {
                    id: icon
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    source: Quickshell.iconPath(root.modelData?.icon, "image-missing")
                    implicitSize: parent.height * 0.5
                    Layout.maximumWidth: implicitSize
                }
            }
        }
    }

    HoverHandler {
        id: mouse
        cursorShape: Qt.PointingHandCursor
    }
}
