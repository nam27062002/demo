import QtQuick 2.0
import QtQuick.Controls 2.5
Rectangle{
    id:powerMode
    width: 200
    height: 150
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
    border.width: 3
    radius: 15
    border.color: if (powerMode.status == 0) return "#a4a1a1"; else if (powerMode.status == 1) return "#00ff08"; else if (powerMode.status == 2) return "#81f0b6"
    property int status: 0
    property string url : "../../images/high.png"
    property string url1 : "../../images/high1.png"
    property string url2 : "../../images/high2.png"
    property string t: "High Performance"
    Image {
        id: image
        x: 100
        y: 22
        width: 89
        height: 74
        source: if (powerMode.status == 0) return url1; else if (powerMode.status == 1) return url; else if (powerMode.status == 2) return url2;
        anchors.horizontalCenterOffset: 1
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
    }

    Text {
        id: text1
        x: 0
        y: 111
        width: 200
        height: 15
        color: if (powerMode.status == 0) return "#958b8b"; else if (powerMode.status == 1) return "black"; else if (powerMode.status == 2) return "black";
        text: qsTr(t)
        font.pixelSize: 16
        horizontalAlignment: Text.AlignHCenter
        font.bold: if (powerMode.status == 0 || powerMode.status == 2) return false; else if (powerMode.status == 1) return true;
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/
