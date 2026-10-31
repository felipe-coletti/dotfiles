import Quickshell
import Quickshell.Hyprland
import QtQuick

// Workspaces 1-3 are always shown, like waybar's persistent workspaces;
// the active one is underlined
Row {
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

    spacing: 4

    Repeater {
        model: root.ids

        Rectangle {
            id: button

            required property int modelData
            readonly property var workspace: root.workspaces.find(w => w.id === modelData)
            readonly property bool active: modelData === root.activeId
            readonly property bool highlighted: active || (workspace?.urgent ?? false)

            width: label.implicitWidth + 16
            height: 24
            color: mouse.containsMouse && !highlighted ? Theme.bgHover : "transparent"

            BarText {
                id: label
                anchors.centerIn: parent
                text: button.workspace?.name ?? button.modelData
                color: button.highlighted || mouse.containsMouse ? Theme.text : Theme.textDim
            }

            Rectangle {
                visible: button.highlighted
                anchors.bottom: parent.bottom
                width: parent.width
                height: 2
                color: Theme.text
            }

            MouseArea {
                id: mouse
                anchors.fill: parent
                hoverEnabled: true
                // With the Lua config, Hyprland takes dispatchers as Lua, like
                // the ones in binds.lua
                onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${button.modelData} })`)
            }
        }
    }
}
