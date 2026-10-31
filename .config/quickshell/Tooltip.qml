import Quickshell
import QtQuick

// Text shown under a bar item while the mouse is over it
PopupWindow {
    id: tip

    property Item target
    property string text
    property bool shown

    anchor.item: target
    anchor.edges: Edges.Bottom
    anchor.gravity: Edges.Bottom
    visible: shown && text !== ""
    color: "transparent"
    implicitWidth: label.implicitWidth + 20
    implicitHeight: label.implicitHeight + 12 + 6

    Rectangle {
        anchors.fill: parent
        anchors.topMargin: 6
        radius: 8
        color: Theme.bgHover

        BarText {
            id: label
            anchors.centerIn: parent
            text: tip.text
        }
    }
}
