import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import QtQuick

Item {
  id: root
  implicitWidth: 20
  implicitHeight: 20

  property bool volumeWindowShown: false;
  property PwNode audioSource: Pipewire.defaultAudioSink

  PwObjectTracker {
		objects: [ Pipewire.defaultAudioSink ]
	}

	Connections {
		target: Pipewire.defaultAudioSink?.audio

		function onVolumeChanged() {
			timeoutCloser.restart();
		}

    function onMutedChanged() {
			timeoutCloser.restart();
    }
	}


  IconImage {
    source: {
      return Pipewire.defaultAudioSink?.audio.muted
      ? Qt.resolvedUrl("../../../res/mute.png")
      : Qt.resolvedUrl("../../../res/volume.png")
    }
    implicitSize: 24
  }

  Timer {
    id: timeoutCloser
    running: false
    repeat: false
    interval: 3 * 1000
    onTriggered: root.volumeWindowShown = false;
  }

  VolumeWindow {
    anchor {
      item: root
      edges: Edges.Top
      gravity: Edges.Top
      rect.x: root.width / 2
      rect.y: -(root.height / 2)
    }
    visible: root.volumeWindowShown
  }

  MouseArea {
    id: mouse
    anchors.fill: root
    onClicked: {
      root.volumeWindowShown = !root.volumeWindowShown
      timeoutCloser.start()
    }
  }
}
