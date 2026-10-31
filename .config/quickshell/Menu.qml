import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects

// A menu in the middle of the screen, like wofi's: a search field over a
// list. The launcher and the power menu are built on it. It opens on the
// focused monitor and closes with Escape or a click outside
PanelWindow {
    id: menu

    // IPC target: `quickshell ipc call <name> toggle`
    required property string name
    // [{ label, icon (a glyph) or image (a file), run() }]
    property var entries: []
    property string placeholder
    property int menuWidth: 400
    property int menuHeight: 600
    readonly property alias query: input.text
    property int current: 0

    readonly property int shadowSize: 16

    function open() {
        const focused = Hyprland.focusedMonitor;
        const target = Quickshell.screens.find(s => focused && s.name === focused.name);
        if (target)
            screen = target;
        input.text = "";
        current = 0;
        visible = true;
        input.forceActiveFocus();
    }

    function close() {
        visible = false;
    }

    function toggle() {
        if (visible)
            close();
        else
            open();
    }

    function move(step) {
        if (entries.length > 0)
            current = (current + step + entries.length) % entries.length;
    }

    function activate(index) {
        const entry = entries[index];
        if (!entry)
            return;
        close();
        entry.run();
    }

    visible: false
    color: "transparent"
    implicitWidth: menuWidth + 2 * shadowSize
    implicitHeight: menuHeight + 2 * shadowSize
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    WlrLayershell.namespace: "quickshell-" + name

    onEntriesChanged: current = 0

    IpcHandler {
        target: menu.name

        function toggle(): void {
            menu.toggle();
        }
    }

    // A click outside the menu closes it
    HyprlandFocusGrab {
        windows: [menu]
        active: menu.visible
        onCleared: menu.close()
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

        anchors.fill: parent
        anchors.margins: menu.shadowSize
        radius: 4
        color: Qt.alpha(Theme.bg, 0.99)

        // Search field: an icon and the text over a line
        Item {
            id: field

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 12
            anchors.topMargin: 10
            height: input.implicitHeight + 16

            BarText {
                id: searchIcon

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: "󰍉"
                font.pixelSize: 14
            }

            TextInput {
                id: input

                anchors.left: searchIcon.right
                anchors.leftMargin: 8
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.text
                selectionColor: Theme.bgHover
                selectedTextColor: Theme.text
                font.family: Theme.font
                font.pixelSize: 14
                clip: true

                Keys.onEscapePressed: menu.close()
                Keys.onReturnPressed: menu.activate(menu.current)
                Keys.onEnterPressed: menu.activate(menu.current)
                Keys.onUpPressed: menu.move(-1)
                Keys.onDownPressed: menu.move(1)
                Keys.onTabPressed: menu.move(1)
                Keys.onBacktabPressed: menu.move(-1)

                BarText {
                    anchors.verticalCenter: parent.verticalCenter
                    visible: input.text === ""
                    text: menu.placeholder.toUpperCase()
                    color: Theme.textDim
                    font.pixelSize: 14
                }
            }

            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: input.activeFocus ? Theme.text : Theme.border
            }
        }

        ListView {
            id: list

            anchors.top: field.bottom
            anchors.topMargin: 8
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            anchors.left: parent.left
            anchors.right: parent.right
            clip: true
            spacing: 4
            model: menu.entries
            currentIndex: menu.current
            boundsBehavior: Flickable.StopAtBounds
            highlightMoveDuration: 0

            delegate: Rectangle {
                id: row

                required property var modelData
                required property int index
                readonly property bool selected: index === menu.current

                x: 10
                width: list.width - 20
                height: 32
                radius: 4
                color: selected ? Theme.bgHover : "transparent"

                Row {
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 10

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        visible: !!row.modelData.image
                        source: row.modelData.image ?? ""
                        width: 22
                        height: 22
                        sourceSize.width: 44
                        sourceSize.height: 44
                        asynchronous: true
                    }

                    BarText {
                        anchors.verticalCenter: parent.verticalCenter
                        visible: !!row.modelData.icon
                        text: row.modelData.icon ?? ""
                        color: row.selected ? Theme.text : Theme.textDim
                        font.pixelSize: 16
                    }

                    BarText {
                        anchors.verticalCenter: parent.verticalCenter
                        text: row.modelData.label
                        color: row.selected ? Theme.text : Theme.textDim
                        width: row.width - 60
                        elide: Text.ElideRight
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: menu.current = row.index
                    onClicked: menu.activate(row.index)
                }
            }
        }
    }
}
