import Quickshell
import QtQuick

// Quickshell entry point: one bar on each screen; the menus, the
// notifications and the volume/brightness indicator show on the focused
// screen, and the lock screen on all of them
ShellRoot {
    Variants {
        model: Quickshell.screens

        Bar {}
    }

    Launcher {}
    PowerMenu {}
    Notifications {}
    Lock {}
    Osd {}
}
