import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick

Scope {
  id: root

  property bool barVisible: false

  PanelWindow {
    id: bar

    visible: root.barVisible
    exclusiveZone: root.barVisible ? height : 0
    color: "transparent"

    anchors {
      top: true
    }

    margins {
      top: 12
    }

    implicitWidth: pill.implicitWidth
    implicitHeight: pill.implicitHeight

    Rectangle {
      id: pill
      implicitWidth: clockText.implicitWidth + 34
      implicitHeight: 32
      radius: height / 2
      color: "#991a1b26"
      border.width: 1
      border.color: "#33c0caf5"

      Text {
        id: clockText
        anchors.centerIn: parent
        text: Qt.formatDateTime(clock.date, "h:mm AP")
        color: "#c0caf5"
        font.pixelSize: 14
      }
    }
  }

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }

  GlobalShortcut {
    name: "barToggle"
    description: "Toggle status bar visibility"

    onPressed: root.barVisible = !root.barVisible
  }

  IpcHandler {
    target: "bar"

    function toggle(): void {
      root.barVisible = !root.barVisible;
    }

    function show(): void {
      root.barVisible = true;
    }

    function hide(): void {
      root.barVisible = false;
    }
  }
}
