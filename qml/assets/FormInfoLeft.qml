import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
Rectangle{
    height: 120
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
    property string src: "../../images/OS.png"
    property string name1: "OS"
    property string name2: "Microsoft Windows 10"
    property int  h: 100
    property int w: 100
    width: 450
    Image {
        id: image
        x: 8
        y: 12
        width: w
        height: h
        source: src
        fillMode: Image.PreserveAspectFit
        MouseArea{
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                backend.showScreen(name1)
            }
        }
    }

    Label {
        id: label
        x: 136
        y: 33
        color: "#fc2696"
        text: qsTr(name1)
        font.bold: true
    }

    Label {
        id: label1
        x: 136
        y: 69
        color: "#656a6e"
        text: qsTr(name2)
    }

}

