import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

// Volume of the default output; click mutes, scroll changes it by 5%
BarItem {
    id: root

    readonly property var sink: Pipewire.defaultAudioSink
    readonly property bool ready: sink?.audio ?? false
    readonly property int volume: ready ? Math.round(sink.audio.volume * 100) : 0
    readonly property bool muted: ready && sink.audio.muted
    readonly property bool headphones: /head(phone|set)/i.test(sink?.description ?? "")
    readonly property string icon: headphones ? "󰋋"
        : volume < 34 ? "󰕿"
        : volume < 67 ? "󰖀"
        : "󰕾"

    visible: ready
    text: muted ? `󰝟 ${I18n.t.muted}` : `${icon} ${volume}%`
    color: muted ? Theme.accent : Theme.text
    tooltip: `${sink?.description ?? ""}\n${I18n.t.volumeHint}`

    onClicked: if (ready) sink.audio.muted = !sink.audio.muted
    onScrolled: direction => {
        if (ready)
            sink.audio.volume = Math.max(0, Math.min(1, sink.audio.volume + direction * 0.05));
    }

    // Keeps the sink's volume and mute state up to date
    PwObjectTracker {
        objects: [root.sink]
    }
}
