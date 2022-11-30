import QtQuick 2.0

Item {
    property string nameDevice: "Bluetooth"
    property int status: 1
    property string date: "24/11/2022"
    property int stt: 1
    Image {
        id: image
        x: 160
        y: 8
        width: 44
        height: 34
        source: if (nameDevice == "Bluetooth") return "../../images/bluetooth.svg";
        fillMode: Image.PreserveAspectFit
    }

    Text {
        id: text1
        x: 61
        y: 0
        width: 93
        height: 50
        text: qsTr(nameDevice)
        font.pixelSize: 17
        verticalAlignment: Text.AlignVCenter
        font.bold: true
    }

    Image {
        id: image1
        x: 243
        y: 0
        width: 100
        height: 50
        source:if (status == 1) return "../../images/—Pngtree—on button in green_8503423.png";
               else return "../../images/—Pngtree—toggle switch icon off button_6389076.png";
        fillMode: Image.PreserveAspectFit
    }

    Text {
        id: text2
        x: 390
        y: 0
        width: 110
        height: 50
        text: qsTr("11/23/2022")
        font.pixelSize: 17
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        font.bold: true
    }

    Text {
        id: text3
        x: 0
        y: 0
        width: 48
        height: 50
        text: stt
        font.pixelSize: 17
        verticalAlignment: Text.AlignVCenter
        font.bold: true
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:50;width:500}D{i:5}
}
##^##*/
