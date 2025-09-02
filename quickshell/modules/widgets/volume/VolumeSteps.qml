import QtQuick
import QtQuick.Layouts

Item {
  id: root

  required property string align;
  required property double margin;
  required property int amount;

  anchors.left: align === "right" ? parent.horizontalCenter : parent.left
  anchors.right: align === "right" ? parent.right : parent.horizontalCenter
  anchors.top: parent.top
  anchors.bottom: parent.bottom
  ColumnLayout {
    anchors.right: root.align === "right" ? parent.right : undefined
    anchors.rightMargin: root.align === "right" ? root.margin : undefined

    anchors.left: root.align === "left" ? parent.left : undefined
    anchors.leftMargin: root.align === "left" ? root.margin : undefined

    anchors.top: parent.top
    anchors.bottom: parent.bottom
    Repeater {
      model: root.amount
      Rectangle {
        width: 20
        height: 1
        color: "#808080"
      }
    }
  }
}
