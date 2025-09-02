import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

PopupWindow {
  id: win
  implicitWidth: 100
  implicitHeight: 200

  WrapperItem {
    anchors.fill: parent
    topMargin: 10
    bottomMargin: 10

    ColumnLayout {
      implicitWidth: parent.width
      implicitHeight: parent.height - 20
      spacing: 10

      VolumeSlider {}

      Item {
        Layout.fillWidth: true
        Layout.preferredHeight: 20

        VolumeMuteCheckbox {
          anchors.fill: parent
        }
      }
    }
  }
}
