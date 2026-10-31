import Quickshell
import Quickshell.Wayland
import QtQuick

// What the lock screen shows on each monitor: time, date, user and the
// password field
WlSessionLockSurface {
    id: surface

    required property var lock

    color: Theme.bg

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    // Hides the mouse cursor
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.BlankCursor
    }

    BarText {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -140
        text: I18n.format(clock.date, I18n.t.clockAlt)
        font.pixelSize: 64
    }

    // In the long format of the system language
    BarText {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -70
        text: clock.date.toLocaleDateString(Qt.locale(), Locale.LongFormat)
        color: Theme.textDim
        font.pixelSize: 14
    }

    BarText {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -15
        text: "󰀄  " + Quickshell.env("USER")
        font.pixelSize: 13
    }

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 45
        width: 280
        height: 44
        radius: 4
        color: Theme.bgAlt
        border.width: 2
        border.color: surface.lock.failed ? Theme.accent : surface.lock.checking ? Theme.text : Theme.border

        BarText {
            anchors.centerIn: parent
            visible: input.text === ""
            text: "󰌾"
            color: surface.lock.failed ? Theme.accent : Theme.textDim
            font.pixelSize: 16
        }

        TextInput {
            id: input

            anchors.fill: parent
            anchors.leftMargin: 16
            anchors.rightMargin: 16
            horizontalAlignment: TextInput.AlignHCenter
            verticalAlignment: TextInput.AlignVCenter
            echoMode: TextInput.Password
            passwordCharacter: "●"
            color: Theme.text
            font.family: Theme.font
            font.pixelSize: 10
            font.letterSpacing: 4
            clip: true
            focus: true
            readOnly: surface.lock.checking
            cursorVisible: false

            Component.onCompleted: forceActiveFocus()
            onTextEdited: surface.lock.failed = false
            Keys.onReturnPressed: surface.lock.unlock(text)
            Keys.onEnterPressed: surface.lock.unlock(text)
            Keys.onEscapePressed: text = ""
        }
    }

    Connections {
        target: surface.lock

        function onCleared() {
            input.text = "";
        }
    }
}
