import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Effects

// One notification: icon, title, text and its action buttons
Item {
    id: card

    required property Notification modelData
    readonly property Notification notification: modelData
    readonly property bool critical: notification.urgency === NotificationUrgency.Critical
    // Array.from: the list of actions isn't a JS array in every Qt version
    readonly property var actions: Array.from(notification.actions)
    readonly property string icon: notification.image
        || (notification.appIcon ? Quickshell.iconPath(notification.appIcon, true) : "")

    width: parent.width
    height: box.implicitHeight

    // Closes by itself after the time the app asked for (5 seconds when it
    // didn't say), unless it's critical or the mouse is over it
    Timer {
        interval: card.notification.expireTimeout > 0 ? card.notification.expireTimeout * 1000 : 5000
        running: !card.critical && !mouse.containsMouse
        onTriggered: card.notification.expire()
    }

    RectangularShadow {
        anchors.fill: box
        radius: box.radius
        offset.y: 4
        blur: 12
        color: Qt.rgba(0, 0, 0, 0.4)
    }

    Rectangle {
        id: box

        width: parent.width
        implicitHeight: content.implicitHeight + 24
        radius: 4
        color: Qt.alpha(Theme.bg, 0.99)
        border.width: 1
        border.color: card.critical ? Theme.accent : Theme.border

        MouseArea {
            id: mouse

            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: event => {
                const action = card.actions.find(a => a.identifier === "default");
                if (event.button === Qt.LeftButton && action)
                    action.invoke();
                card.notification.dismiss();
            }
        }

        Column {
            id: content

            x: 12
            y: 12
            width: parent.width - 24
            spacing: 10

            Row {
                width: parent.width
                spacing: 10

                Image {
                    visible: card.icon !== ""
                    source: card.icon
                    width: 32
                    height: 32
                    sourceSize.width: 64
                    sourceSize.height: 64
                    fillMode: Image.PreserveAspectFit
                    asynchronous: true
                }

                BarText {
                    visible: card.icon === ""
                    width: 32
                    horizontalAlignment: Text.AlignHCenter
                    text: "󰂚"
                    font.pixelSize: 22
                    color: card.critical ? Theme.accent : Theme.textDim
                }

                Column {
                    width: parent.width - 42 - close.width - 10
                    spacing: 4

                    BarText {
                        width: parent.width
                        text: card.notification.summary || card.notification.appName
                        font.bold: true
                        elide: Text.ElideRight
                    }

                    BarText {
                        width: parent.width
                        visible: text !== ""
                        text: card.notification.body
                        color: Theme.textDim
                        textFormat: Text.StyledText
                        wrapMode: Text.Wrap
                        maximumLineCount: 4
                        elide: Text.ElideRight
                        linkColor: Theme.text
                        onLinkActivated: link => Qt.openUrlExternally(link)
                    }
                }

                BarItem {
                    id: close

                    text: "󰅖"
                    color: hovered ? Theme.text : Theme.textDim
                    onClicked: card.notification.dismiss()
                }
            }

            // The other actions, as buttons (the default one is the click)
            Row {
                readonly property var actions: card.actions.filter(a => a.identifier !== "default")

                visible: actions.length > 0
                width: parent.width
                spacing: 6

                Repeater {
                    model: parent.actions

                    Rectangle {
                        required property NotificationAction modelData

                        width: (content.width - 6 * (parent.actions.length - 1)) / parent.actions.length
                        height: 28
                        radius: 4
                        color: button.containsMouse ? Theme.bgHover : Theme.bgAlt

                        BarText {
                            anchors.centerIn: parent
                            width: parent.width - 12
                            horizontalAlignment: Text.AlignHCenter
                            elide: Text.ElideRight
                            text: parent.modelData.text
                        }

                        MouseArea {
                            id: button

                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                parent.modelData.invoke();
                                card.notification.dismiss();
                            }
                        }
                    }
                }
            }
        }
    }
}
