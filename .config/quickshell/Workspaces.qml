import Quickshell
import Quickshell.Hyprland
import QtQuick

// Workspaces as carousel dots, in order (1, 2, 3...). Workspaces 1-3 are
// always shown, like waybar's persistent workspaces.
// - active: a wider pill in the text color
// - with windows: a filled dot; empty: just the outline
// - urgent: a dot in the accent color
// Click a dot to go to it (its number shows on hover); scroll over the dots
// to go to the next or previous one, like SUPER + scroll
Item {
    id: root

    required property var screen

    readonly property var monitor: Hyprland.monitorFor(screen)
    readonly property int activeId: monitor?.activeWorkspace?.id ?? -1
    readonly property var workspaces: Hyprland.workspaces.values
    readonly property var ids: {
        const ids = new Set([1, 2, 3]);
        for (const workspace of workspaces) {
            if (workspace.id > 0)
                ids.add(workspace.id);
        }
        return Array.from(ids).sort((a, b) => a - b);
    }

    // With the Lua config, Hyprland takes dispatchers as Lua, like the ones
    // in binds.lua
    function goTo(target) {
        Hyprland.dispatch(`hl.dsp.focus({ workspace = ${JSON.stringify(target)} })`);
    }

    implicitWidth: dots.implicitWidth
    implicitHeight: 24

    Row {
        id: dots

        anchors.verticalCenter: parent.verticalCenter

        Repeater {
            model: root.ids

            // The whole slot takes the click, not only the dot
            Item {
                id: slot

                required property int modelData
                readonly property var workspace: root.workspaces.find(w => w.id === modelData)
                readonly property bool active: modelData === root.activeId
                // Hyprland only keeps empty workspaces while they're active
                readonly property bool occupied: !!workspace
                readonly property bool urgent: workspace?.urgent ?? false

                width: dot.width + 8
                height: root.implicitHeight

                Rectangle {
                    id: dot

                    anchors.centerIn: parent
                    width: slot.active ? 18 : 8
                    height: 8
                    radius: height / 2
                    color: slot.active ? Theme.text
                        : slot.urgent ? Theme.accent
                        : !slot.occupied ? "transparent"
                        : mouse.containsMouse ? Theme.text
                        : Theme.textDim
                    border.width: slot.active || slot.urgent || slot.occupied ? 0 : 1
                    border.color: mouse.containsMouse ? Theme.text : Theme.textDim

                    Behavior on width {
                        NumberAnimation {
                            duration: 200
                            easing.type: Easing.OutCubic
                        }
                    }

                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }
                }

                MouseArea {
                    id: mouse

                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: root.goTo(slot.modelData)
                    onWheel: event => root.goTo(event.angleDelta.y > 0 ? "e-1" : "e+1")
                }

                Tooltip {
                    target: slot
                    text: slot.workspace?.name ?? String(slot.modelData)
                    shown: mouse.containsMouse
                }
            }
        }
    }
}
