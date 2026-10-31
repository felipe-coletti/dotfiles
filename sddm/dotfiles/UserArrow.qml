// Seta ao lado do nome do usuário, para trocar de usuário
import QtQuick 2.15

Text {
    id: arrow

    property string icon
    signal clicked()

    text: icon
    color: mouse.containsMouse ? "#d4d4d4" : "#808080"
    font.family: "JetBrainsMono Nerd Font"
    font.pointSize: 13

    MouseArea {
        id: mouse
        anchors.fill: parent
        anchors.margins: -6
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: arrow.clicked()
    }
}
