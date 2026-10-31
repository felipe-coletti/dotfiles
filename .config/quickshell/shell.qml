import Quickshell
import QtQuick

// Quickshell entry point: one bar on each screen, and the menus and the
// notifications, which show on the focused screen, and the lock screen
ShellRoot {
    Variants {
        model: Quickshell.screens

        Bar {}
    }

    Launcher {}
    PowerMenu {}
    Notifications {}
    Lock {}
}
