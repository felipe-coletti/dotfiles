import Quickshell
import QtQuick

// Quickshell entry point: a wallpaper and a bar on each screen; the menus,
// the notifications and the volume/brightness indicator show on the
// focused screen, and the lock screen on all of them
ShellRoot {
    Variants {
        model: Quickshell.screens

        Scope {
            id: screenScope

            required property var modelData

            Wallpaper {
                modelData: screenScope.modelData
            }

            Bar {
                modelData: screenScope.modelData
            }
        }
    }

    Launcher {}
    PowerMenu {}
    Notifications {}
    Lock {}
    Osd {}
}
