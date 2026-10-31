import Quickshell
import QtQuick

// The status bar: workspaces on the left, the clock in the middle and the
// status icons on the right, like the waybar it replaces
PanelWindow {
    id: bar

    required property var modelData

    readonly property int barHeight: 32
    readonly property int shadowHeight: 12

    screen: modelData
    anchors {
        top: true
        left: true
        right: true
    }
    // The shadow under the bar takes no space and lets clicks through
    implicitHeight: barHeight + shadowHeight
    exclusiveZone: barHeight
    mask: Region { item: background }
    color: "transparent"

    Rectangle {
        id: background
        width: parent.width
        height: bar.barHeight
        color: Qt.alpha(Theme.bg, 0.99)

        Workspaces {
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            screen: bar.screen
        }

        Clock {
            anchors.centerIn: parent
        }

        Row {
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            spacing: 15

            Network {}
            BluetoothStatus {}
            Audio {}
            Brightness { monitor: bar.modelData.name }
            Battery {}
            PowerButton {}
        }
    }

    Rectangle {
        anchors.top: background.bottom
        width: parent.width
        height: bar.shadowHeight
        gradient: Gradient {
            GradientStop { position: 0; color: Qt.rgba(0, 0, 0, 0.4) }
            GradientStop { position: 1; color: "transparent" }
        }
    }
}
