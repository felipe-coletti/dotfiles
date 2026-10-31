import Quickshell
import QtQuick

// Opens the power menu
BarItem {
    text: "󰐥"
    color: hovered ? Theme.text : Theme.textDim
    onClicked: Quickshell.execDetached(["quickshell", "ipc", "call", "power", "toggle"])
}
