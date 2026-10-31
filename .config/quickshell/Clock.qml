import Quickshell
import QtQuick
import QtQuick.Controls

// Clock in the format of the system language; click to switch to the short
// format, and hover for the month calendar (scroll to change the month,
// middle click to go back to the current one)
Item {
    id: root

    property bool compact: false
    property int monthOffset: 0
    readonly property var shownMonth: {
        const date = new Date(clock.date.getFullYear(), clock.date.getMonth() + monthOffset, 1);
        return { year: date.getFullYear(), month: date.getMonth() };
    }

    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitHeight

    // Formats the date; languages whose AM/PM Qt only has in Latin letters
    // (Hindi, Bengali) set their own words in I18n
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    BarText {
        id: label
        anchors.centerIn: parent
        text: I18n.format(clock.date, root.compact ? I18n.t.clockAlt : I18n.t.clock)
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton
        onClicked: event => {
            if (event.button === Qt.MiddleButton)
                root.monthOffset = 0;
            else
                root.compact = !root.compact;
        }
        onWheel: event => root.monthOffset += event.angleDelta.y > 0 ? -1 : 1
        onContainsMouseChanged: if (!containsMouse) root.monthOffset = 0
    }

    PopupWindow {
        anchor.item: root
        anchor.edges: Edges.Bottom
        anchor.gravity: Edges.Bottom
        visible: mouse.containsMouse
        color: "transparent"
        implicitWidth: calendar.implicitWidth + 24
        implicitHeight: calendar.implicitHeight + 16 + 6

        Rectangle {
            anchors.fill: parent
            anchors.topMargin: 6
            radius: 8
            color: Theme.bgHover

            Column {
                id: calendar
                anchors.centerIn: parent
                spacing: 6

                BarText {
                    anchors.horizontalCenter: parent.horizontalCenter
                    // The standalone month name ("октябрь", not "октября")
                    text: `${Qt.locale().standaloneMonthName(root.shownMonth.month)} ${root.shownMonth.year}`
                    font.bold: true
                }

                DayOfWeekRow {
                    width: grid.width
                    locale: grid.locale
                    delegate: BarText {
                        required property string shortName
                        // "seg." → "seg", so the names fit in the columns
                        text: shortName.replace(/\.$/, "")
                        color: Theme.textDim
                        horizontalAlignment: Text.AlignHCenter
                    }
                }

                MonthGrid {
                    id: grid
                    width: 7 * 32
                    month: root.shownMonth.month
                    year: root.shownMonth.year
                    locale: Qt.locale()
                    delegate: BarText {
                        required property var model
                        readonly property bool today: model.today
                        text: model.day
                        horizontalAlignment: Text.AlignHCenter
                        opacity: model.month === grid.month ? 1 : 0.3
                        font.bold: today
                        font.underline: today
                    }
                }
            }
        }
    }
}
