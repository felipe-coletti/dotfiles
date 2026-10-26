// Ícone clicável do canto inferior direito (reiniciar / desligar)
import QtQuick 2.15

Text {
    id: button

    property string icon
    signal clicked()

    text: icon
    color: mouse.containsMouse ? "#d4d4d4" : "#808080"
    font.family: "JetBrainsMono Nerd Font"
    font.pointSize: 16

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: button.clicked()
    }
}