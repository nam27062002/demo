import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Grid {
        rows: 2
        columns: 2

        padding: 20
        spacing: 20

        CircularProgressBar {
            width: 240
            height: 240

            NumberAnimation on value {
                to: 1.0
                duration: 5000
            }
        }

        CircularShapeProgressBar {
            width: 240
            height: 240

            NumberAnimation on value {
                to: 1.0
                duration: 5000
            }
        }

        CircularCanvasProgressBar {
            width: 240
            height: 240

            NumberAnimation on value {
                to: 1.0
                duration: 5000
            }
        }
    }
}
