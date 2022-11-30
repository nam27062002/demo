import QtQuick 2.0
import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Dialogs 1.3
import QtQml 2.0
import Qt.labs.qmlmodels 1.0
import QtQuick.Controls 1.4
import "../assets"

Rectangle{
    id: content
    anchors.fill: parent
    color: "#00000000"
    ToggleButton{
        anchors.top: parent.top
        anchors.topMargin: -35
        onClicked: { animationMenu.running = true}
    }
    Rectangle{
        id: leftButton
        width: 70
        color: "#1c1d20"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        PropertyAnimation{
            id: animationMenu
            target: leftButton
            property: "width"
            to: if(leftButton.width == 70) return 200; else return 70
            duration: 600
            easing.type: Easing.InOutQuint
        }
        LeftMenuBtn{
            id: btnControl
            btnIconSource: "../../images/svg_images/control.svg"
            anchors.top: btn1.bottom
            text: "Control panel"
            colorDefault: "#55aaff"
            onClicked: {
                backend.loopPanel()
                mainWindow.width = 1100
                mainWindow.height = 700
                view.push(Qt.resolvedUrl("PagePanel.qml"))
            }

        }
        LeftMenuBtn{
            id: btnInfomation
            anchors.top: btnControl.bottom
            btnIconSource: "../../images/svg_images/infomation.svg"
            text: "Summary"
            onClicked: {
                mainWindow.width = 1700
                mainWindow.height = 700
                view.push(Qt.resolvedUrl("PageSummary.qml"))
            }

        }
        LeftMenuBtn{
            id: btnSystem
            anchors.top: btnInfomation.bottom
            btnIconSource: "../../images/svg_images/system.svg"
            text: "System Monitor"
            onClicked: {
                backend.loopSystem()
                mainWindow.width = 1700
                mainWindow.height = 700
                view.push(Qt.resolvedUrl("PageSystemMonitor.qml"))
            }

        }
        LeftMenuBtn{
            id: btnHistory
            anchors.top: btnSystem.bottom
            btnIconSource: "../../images/svg_images/history.svg"
            text: "Usage History"
            isActive: true


        }
    }
    Rectangle{
        id: content1
        color: "#2c313c"
        border.width: 0
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.left: leftButton.right
        MouseArea{
            id: mouseArea
            anchors.fill: parent
            hoverEnabled:true

            Rectangle {
                id: content3
                visible: false
                color: "#ffffff"
                radius: 30
                anchors.left: content2.right
                anchors.right: parent.right
                anchors.top: content2.top
                anchors.bottom: content2.bottom
                anchors.leftMargin: 20
            }

            Rectangle {
                id: rectangle
                x: 212
                y: 150
                width: 574
                height: 453
                color: "#ffffff"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Grid {
                id: grid
                x: 228
                y: 150
                width: 574
                height: 453
                Rectangle {
                        id: aaa
                        color: "#ffffff"
                        anchors.fill: parent
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 0
                        anchors.topMargin: 0

                        TableView {
                            anchors.fill: parent
                            clip: true

                            TableViewColumn {
                                role: "STT"
                                title: "STT"
                                width: 50

                            }

                            TableViewColumn {
                                role: "Device"
                                title: "Device"
                            }

                            TableViewColumn {
                                role: "Status"
                                title: "Status"
                            }
                            TableViewColumn {
                                role: "Datetime"
                                title: "Datetime"
                                width: 200

                            }
                            model: ListModel {
                                id: list0
                            }
                        }
                    }
            }

        }
        Rectangle{
            id: content2
            color:"#00000000"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 120
            anchors.leftMargin: 100
            anchors.rightMargin: 127

        }

    }
    Component.onCompleted:{
        backend.seenDay();
        backend.getHistory();
    }
    Connections{
        target: backend
        function onSeenToday(data){
            fromDay.indexDay = data[0] - 1
            fromDay.indexMonth = data[1] - 1
            fromDay.indexYear = data[2] - 2000
            fromDay1.indexDay = data[0] - 1
            fromDay1.indexMonth = data[1] - 1
            fromDay1.indexYear = data[2] - 2000
        }
        function onSeenHistory(data){
            list0.clear()
            for (let i = 0; i < data.length;i++){
                list0.append({STT: i,Device:data[i][0],Status: data[i][1],Datetime: data[i][2]})
            }
        }

    }

}


/*##^##
Designer {
    D{i:0;autoSize:true;height:700;width:1100}
}
##^##*/
