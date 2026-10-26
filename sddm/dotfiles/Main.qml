// Tela de login no mesmo layout de .config/hypr/hyprlock.conf
import QtQuick 2.15

Rectangle {
    id: root

    // Cores da paleta (.config/colors/palette.css)
    readonly property color bgAlt:      "#2a2a2a"
    readonly property color borderColor: "#3a3a3a"
    readonly property color textColor:  "#d4d4d4"
    readonly property color textDim:    "#808080"
    readonly property color accent:     "#c0392b"
    readonly property string fontFamily: "JetBrainsMono Nerd Font"

    // Usuário fixo (último logado), sem troca de usuário, como no hyprlock
    readonly property string userName: userModel.lastUser !== ""
        ? userModel.lastUser
        : userModel.data(userModel.index(0, 0), Qt.UserRole + 1)
    property int sessionIndex: sessionModel.lastIndex

    property date now: new Date()
    property bool checking: false
    property bool failed: false

    width: 1920
    height: 1080
    color: "#1e1e1e"

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.now = new Date()
    }

    Connections {
        target: sddm
        function onLoginFailed() {
            password.text = ""
            root.checking = false
            root.failed = true
        }
    }

    // Hora
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -120
        text: Qt.formatTime(root.now, "HH:mm")
        color: root.textColor
        font.family: root.fontFamily
        font.pointSize: 64
    }

    // Data (segue o locale do sistema)
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -50
        text: Qt.formatDate(root.now, "dddd, dd MMMM")
        color: root.textDim
        font.family: root.fontFamily
        font.pointSize: 14
    }

    // Usuário (apenas exibição)
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -5
        text: "󰀄  " + root.userName
        color: root.textColor
        font.family: root.fontFamily
        font.pointSize: 13
    }

    // Campo de senha
    Rectangle {
        width: 280
        height: 44
        radius: 4
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 40
        color: root.bgAlt
        border.width: 2
        border.color: root.failed ? root.accent
                    : root.checking ? root.textColor
                    : root.borderColor

        TextInput {
            id: password
            anchors.fill: parent
            anchors.margins: 12
            verticalAlignment: TextInput.AlignVCenter
            horizontalAlignment: TextInput.AlignHCenter
            echoMode: TextInput.Password
            passwordCharacter: "•"
            color: root.textColor
            font.family: root.fontFamily
            font.pointSize: 12
            clip: true
            focus: true

            onTextChanged: if (text !== "") root.failed = false
            onAccepted: {
                root.checking = true
                sddm.login(root.userName, text, root.sessionIndex)
            }
        }

        Text {
            anchors.centerIn: parent
            visible: password.text === ""
            text: "󰌾"
            color: root.textDim
            font.family: root.fontFamily
            font.pointSize: 12
        }
    }

    // Reiniciar / desligar (o hyprlock não tem, mas no login são necessários)
    Row {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 24
        spacing: 20

        PowerButton {
            visible: sddm.canReboot
            icon: "󰜉"
            onClicked: sddm.reboot()
        }

        PowerButton {
            visible: sddm.canPowerOff
            icon: "󰐥"
            onClicked: sddm.powerOff()
        }
    }

    Component.onCompleted: password.forceActiveFocus()
}