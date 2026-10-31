import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Notifications
import Quickshell.Wayland
import QtQuick

// Notification popups in the top right corner of the focused monitor, under
// the bar, newest on top. Click one to run its default action; right click
// or the × closes it. They stay while the mouse is over them
PanelWindow {
    id: root

    readonly property int maxShown: 5
    readonly property var shown: server.trackedNotifications.values.slice().reverse().slice(0, maxShown)

    screen: {
        const focused = Hyprland.focusedMonitor;
        return Quickshell.screens.find(s => focused && s.name === focused.name) ?? Quickshell.screens[0];
    }
    visible: shown.length > 0
    color: "transparent"
    anchors.top: true
    anchors.right: true
    margins.top: 6
    margins.right: 6
    implicitWidth: 360 + 2 * shadowSize
    implicitHeight: column.implicitHeight + 2 * shadowSize
    exclusionMode: ExclusionMode.Normal
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "quickshell-notifications"
    // Only the cards take clicks, not the shadow around them
    mask: Region { item: column }

    readonly property int shadowSize: 16

    NotificationServer {
        id: server

        keepOnReload: false
        actionsSupported: true
        bodyMarkupSupported: true
        bodyHyperlinksSupported: true
        imageSupported: true
        persistenceSupported: true

        onNotification: notification => notification.tracked = true
    }

    Column {
        id: column

        x: root.shadowSize
        y: root.shadowSize
        width: 360
        spacing: 10

        Repeater {
            model: root.shown

            NotificationCard {}
        }
    }
}
