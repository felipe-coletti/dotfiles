pragma Singleton

import Quickshell
import QtQuick

// Colors from .config/colors/palette.css (keep both in sync)
Singleton {
    readonly property color bg: "#1e1e1e"
    readonly property color bgAlt: "#2a2a2a"
    readonly property color bgHover: "#3a3a3a"
    readonly property color text: "#d4d4d4"
    readonly property color textDim: "#808080"
    readonly property color accent: "#c0392b"
    readonly property color border: "#3a3a3a"

    readonly property string font: "JetBrainsMono Nerd Font Propo"
    readonly property int fontSize: 12
}
