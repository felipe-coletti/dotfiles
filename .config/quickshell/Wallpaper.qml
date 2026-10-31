import Quickshell
import Quickshell.Wayland
import QtCore
import QtQuick

// Wallpaper behind the windows of one screen, cropped to fill it, over the
// palette's background while it loads. The images are in the Wallpapers
// folder of the pictures folder in the system language (Imagens, Pictures…),
// where the installer copies the repository's wallpapers/
PanelWindow {
    id: wallpaper

    required property var modelData

    // To use another wallpaper, put it in that folder and change this name
    readonly property string file: "level-curves.png"

    screen: modelData
    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Background
    WlrLayershell.namespace: "quickshell-wallpaper"
    color: Theme.bg

    Image {
        anchors.fill: parent
        source: StandardPaths.writableLocation(StandardPaths.PicturesLocation) + "/Wallpapers/" + wallpaper.file
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
    }
}