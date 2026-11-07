import Quickshell
import Quickshell.Wayland
import QtQuick

// What the lock screen shows on each monitor: time, date, user and the
// password field. Same layout, sizes and font as the login screen
// (sddm/dotfiles/Main.qml): keep both in sync
WlSessionLockSurface {
    id: surface

    required property var lock
    readonly property string font: "JetBrainsMono Nerd Font"

    color: Theme.bg

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    // In the 12 or 24 hour format of the system language
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -128
        text: I18n.format(clock.date, I18n.t.clockAlt)
        color: Theme.text
        font.family: surface.font
        font.pixelSize: 90
    }

    // In the long format of the system language
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -53
        text: clock.date.toLocaleDateString(Qt.locale(), Locale.LongFormat)
        color: Theme.textDim
        font.family: surface.font
        font.pixelSize: 20
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -5
        // The current user (no spaces after the icon if the name is missing)
        readonly property string name: Quickshell.env("USER") || Quickshell.env("LOGNAME") || ""
        text: name ? "󰀄  " + name : "󰀄"
        color: Theme.text
        font.family: surface.font
        font.pixelSize: 18
    }

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 43
        width: 296
        height: 46
        radius: 4
        color: Theme.bgAlt
        border.width: 2
        border.color: surface.lock.failed ? Theme.negative : surface.lock.checking ? Theme.text : Theme.border

        TextInput {
            id: input

            anchors.fill: parent
            anchors.margins: 12
            horizontalAlignment: TextInput.AlignHCenter
            verticalAlignment: TextInput.AlignVCenter
            echoMode: TextInput.Password
            passwordCharacter: "•"
            color: Theme.text
            font.family: surface.font
            font.pixelSize: 17
            clip: true
            focus: true
            readOnly: surface.lock.checking

            Component.onCompleted: forceActiveFocus()
            onTextEdited: surface.lock.failed = false
            Keys.onReturnPressed: surface.lock.unlock(text)
            Keys.onEnterPressed: surface.lock.unlock(text)
            Keys.onEscapePressed: text = ""
        }

        Text {
            anchors.centerIn: parent
            visible: input.text === ""
            text: "󰌾"
            color: Theme.textDim
            font.family: surface.font
            font.pixelSize: 17
        }
    }

    Connections {
        target: surface.lock

        function onCleared() {
            input.text = "";
        }
    }
}
