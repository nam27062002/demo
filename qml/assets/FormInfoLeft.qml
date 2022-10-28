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
                if (name1 == "Battery"){
                    content.distance = 200
                }
                else if (name1 == "Memory"){
                    content.distance = 315
                }
                else if (name1 == "OS"){
                    content.distance = 170
                }
                else if (name1 == "CPU"){
                    content.distance = 160
                }
                else if (name1 == "DISK"){
                    content.distance = 250
                }
                else if (name1 == "GPU"){
                    content.distance = 250
                }
                if (content.lastClick == ""){
                    content.lastClick = name1

                    backend.showScreen(name1,1) // show

                }
                else if (name1 == content.lastClick){
                    content.lastClick = ""
                    backend.showScreen(name1,2) // hiden
                }
                else if (name1 != content.lastClick){
                    content.lastClick = name1
                    backend.showScreen(name1,0) // change
                }


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

