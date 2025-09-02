import QtQuick
import Quickshell.Widgets
import qs.services.notifications

WrapperRectangle {
    id: root
    color: "red"

    required property NotificationService.Notif notification

    implicitWidth: 800
    implicitHeight: 100

    Text {
      text: root.notification.summary
    }
}
