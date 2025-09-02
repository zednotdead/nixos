pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Widgets
import qs.services.notifications
import qs.modules.widgets

PanelWindow {
    id: root
    exclusionMode: ExclusionMode.Ignore

    implicitWidth: 600
    implicitHeight: 600

    visible: false

    anchors {
        bottom: true
        right: true
    }

    margins {
        bottom: 40
    }

    ListModel {
        id: notifs
    }

    StyledListView {
        id: lv
        anchors.fill: parent

        model: ScriptModel {
            values: [...NotificationService.popups]
        }

        delegate: WrapperRectangle {
            id: wrapper

            required property NotificationService.Notif modelData
            required property int index

            ClippingRectangle {
                anchors.top: parent.top

                radius: 10
                implicitWidth: notif.implicitWidth
                implicitHeight: notif.implicitHeight

                NotificationItem {
                    id: notif
                    notification: wrapper.modelData
                }
            }
        }
    }

    Behavior on implicitHeight {
        Anim {}
    }

    component Anim: NumberAnimation {
        duration: 100
        easing.type: Easing.BezierSpline
    }
}
