import QtQuick
import QtQuick.Controls
import Quickshell.Services.Pipewire

CheckBox {
  checked: Pipewire.defaultAudioSink?.audio.muted
  text: "Mute"
  onCheckStateChanged: {
    Pipewire.defaultAudioSink.audio.muted = !Pipewire.defaultAudioSink?.audio.muted
  }
}
