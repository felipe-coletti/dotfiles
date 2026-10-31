// Tela de login no mesmo layout, tamanhos e fonte da tela de bloqueio
// (.config/quickshell/LockSurface.qml): mantenha as duas iguais
import QtQuick 2.15

Rectangle {
    id: root

    // Cores da paleta (.config/colors/palette.css)
    readonly property color bgAlt:       "#2a2a2a"
    readonly property color borderColor: "#3a3a3a"
    readonly property color textColor:   "#d4d4d4"
    readonly property color textDim:     "#808080"
    readonly property color negative:    "#c0392b"
    readonly property string fontFamily: "JetBrainsMono Nerd Font"

    // Usuário: começa no último que entrou. Com mais de um usuário, as setas
    // ao lado do nome (ou ↑/↓ no campo de senha) trocam
    readonly property int userCount: userModel.rowCount()
    property int userIndex: Math.max(0, userModel.lastIndex)
    readonly property string userName: userModel.data(userModel.index(userIndex, 0), Qt.UserRole + 1) || ""

    function changeUser(step) {
        if (userCount < 2)
            return
        userIndex = (userIndex + step + userCount) % userCount
        password.text = ""
        failed = false
    }
    property int sessionIndex: sessionModel.lastIndex

    property date now: new Date()

    // Hora no formato do idioma do sistema, como na tela de bloqueio: 12h em
    // inglês, hindi e bengali (com AM/PM no idioma), 24h nos outros
    readonly property var amPm: ({
        "en": ["AM", "PM"],
        "hi": ["पूर्वाह्न", "अपराह्न"],
        "bn": ["পূর্বাহ্ণ", "অপরাহ্ণ"]
    })
    readonly property var twelveHour: amPm[Qt.locale().name.split("_")[0]]

    function time(date) {
        if (!twelveHour)
            return date.toLocaleTimeString(Qt.locale(), "HH:mm")
        // O "hh" só é 12h com o AP no formato; o AM/PM vem no idioma
        return date.toLocaleTimeString(Qt.locale(), "hh:mm AP")
            .replace(/\b(AM|PM)\b/i, twelveHour[date.getHours() < 12 ? 0 : 1])
    }
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
        text: root.time(root.now)
        color: root.textColor
        font.family: root.fontFamily
        font.pointSize: 64
    }

    // Data por extenso no formato do idioma do sistema
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -50
        text: root.now.toLocaleDateString(Qt.locale(), Locale.LongFormat)
        color: root.textDim
        font.family: root.fontFamily
        font.pointSize: 14
    }

    // Usuário, com as setas para trocar quando há mais de um
    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -5
        spacing: 16

        UserArrow {
            visible: root.userCount > 1
            icon: "󰅁"
            onClicked: root.changeUser(-1)
        }

        Text {
            text: "󰀄  " + root.userName
            color: root.textColor
            font.family: root.fontFamily
            font.pointSize: 13
        }

        UserArrow {
            visible: root.userCount > 1
            icon: "󰅂"
            onClicked: root.changeUser(1)
        }
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
        border.color: root.failed ? root.negative
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
            Keys.onUpPressed: root.changeUser(-1)
            Keys.onDownPressed: root.changeUser(1)
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

    // Reiniciar / desligar (a tela de bloqueio não tem, mas no login são necessários)
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