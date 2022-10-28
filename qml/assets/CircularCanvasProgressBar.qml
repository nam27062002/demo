import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.0
ProgressBar {
    id: control
    property color colorBorder: "green"
    property string name1: "CPU"
    property bool isRam: false
    property int ram: 1
    property real valueUse: 2
    background: Rectangle {
        radius: control.width / 2
        color: "#000000"

        Rectangle{
            anchors.fill: parent
            radius: control.width / 2
            anchors.topMargin: 20
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            anchors.bottomMargin: 20
            color: "#2c313c"

        }
    }

    onValueChanged: canvas.requestPaint()
    contentItem: Canvas {
        id: canvas
        antialiasing: true

        property int strokeWidth: 20

        onPaint: {
            var ctx = getContext("2d");
            ctx.save();

            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.beginPath();
            ctx.lineWidth = strokeWidth;
            ctx.strokeStyle = colorBorder;
            ctx.arc(control.width / 2,
                    control.height / 2,
                    Math.min(canvas.width - strokeWidth, canvas.height - strokeWidth) / 2,
                    -Math.PI / 2,
                    control.value * 2 * Math.PI - Math.PI / 2);
            ctx.stroke();
            ctx.restore();
        }

        Label {
            id: label
            color: "white"
            text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'Titillium Web'; font-size:11pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'MS Shell Dlg 2'; font-size:16pt; font-weight:600; color:"+colorBorder+";\">"+name1+"</span><span style=\" font-family:'MS Shell Dlg 2'; font-size:16pt;\"> </span><span style=\" font-family:'MS Shell Dlg 2'; font-size:16pt; color:#ffffff;\">USAGE</span></p></body></html>"
            textFormat: Text.RichText
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: parent.height/3
        }

        Label {
            id: label1
            color: colorBorder
            text: Math.round(control.value*100 * 100)/100 + "%"
            textFormat: Text.RichText
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            font.pointSize: 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top:parent.top
            anchors.topMargin: if (!isRam) return parent.height*2/3.5; else return parent.height/2
        }

        Label {
            id: label2
            visible: if (isRam) return true; else return false;
            color: "#ffffff"
            text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'Titillium Web'; font-size:11pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'MS Shell Dlg 2'; font-size:16pt; font-weight:600; color:"+colorBorder+";\">"+Math.round(control.valueUse * 100)/100+"</span><span style=\" font-family:'MS Shell Dlg 2'; font-size:16pt; font-weight:600; color:#ffffff;\">/"+ram+"GB</span></p></body></html>"
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenterOffset: 1
            anchors.topMargin: parent.height*2/3
            anchors.horizontalCenter: parent.horizontalCenter
            textFormat: Text.RichText
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:500;width:500}D{i:6}
}
##^##*/
