import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Pipewire

Item {
  id: root
  Layout.fillWidth: true
  Layout.preferredHeight: 150
  property double stepsMargin: 15;
  property double stepsAmount: 10;

  VolumeSteps {
    align: "left";
    amount: root.stepsAmount
    margin: root.stepsMargin
  }

  Slider {
    enabled: !Pipewire.defaultAudioSink?.audio.muted;
    anchors.fill: parent
    from: 0.0
    value: Pipewire.defaultAudioSink?.audio.volume
    snapMode: Slider.SnapAlways
    stepSize: 0.05
    to: 1.0
    orientation: Qt.Vertical
    onValueChanged: () => {
      Pipewire.defaultAudioSink.audio.volume = value
    }
  }

  VolumeSteps {
    align: "right";
    amount: root.stepsAmount
    margin: root.stepsMargin
  }
}
