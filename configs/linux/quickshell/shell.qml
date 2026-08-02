import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick

Scope {
  id: root

  property bool barVisible: true

  PanelWindow {
    id: bar

    visible: root.barVisible
    exclusiveZone: root.barVisible ? height : 0
    color: "#1a1b26"

    anchors {
      top: true
      left: true
      right: true
    }

    implicitHeight: 30

    Text {
      anchors.centerIn: parent
      text: Qt.formatDateTime(clock.date, "HH:mm")
      color: "#c0caf5"
      font.pixelSize: 14
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
