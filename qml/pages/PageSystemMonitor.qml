import QtQuick 2.0
import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Dialogs 1.3
import "../assets"
Rectangle{
    id: content
    anchors.fill: parent
    color: "#00000000"
    property string lastClick: ""
    property int distance: 150
    Timer {
        id: timer
    }
    function delay(delayTime,cb) {
        timer.interval = delayTime;
        timer.repeat = false;
        timer.triggered.connect(cb);
        timer.start();
    }
    ToggleButton{
        anchors.top: parent.top
        anchors.topMargin: -35
        onClicked: {
            animationMenu.running = true
        }
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
            anchors.top: parent.top
            text: "Control panel"
            colorDefault: "#55aaff"
            onClicked: {
                backend.loopPanel()
                backend.loopSystem()
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
                backend.loopSystem()
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
            isActive: true
        }
        LeftMenuBtn{
            id: btnHistory
            anchors.top: btnSystem.bottom
            btnIconSource: "../../images/svg_images/history.svg"
            text: "Usage History"
            onClicked: {
                mainWindow.width = 1100
                mainWindow.height = 700
                backend.loopSystem()
                view.push(Qt.resolvedUrl("PageHistory.qml"))
            }
        }
    }
    Rectangle{
        id: content1
        color: "#2c313c"
        border.width: 0
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: leftButton.right
        MouseArea{
            anchors.fill: parent
            hoverEnabled:true
        }
        Rectangle{
            id: box1
            color:"#00000000"
            anchors.top:parent.top
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            width: parent.width/2
            Rectangle{
                id: box11
                color:"#00000000"
                anchors.top: parent.top
                anchors.leftMargin: 1
                anchors.topMargin: 162
                anchors.left: parent.left
                width: parent.width/2
                height: parent.height/2
                CircularCanvasProgressBar{
                    id: cpu
                    width: 280
                    height: 280
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    value: 0.5
                    colorBorder: "#F6FF00"
                }
            }
            Rectangle{
                id: box12
                color:"#00000000"
                anchors.top: parent.top
                anchors.leftMargin: 7
                anchors.topMargin: 162
                anchors.left: box11.right
                width: parent.width/2
                height: parent.height/2
                CircularCanvasProgressBar{
                    id: ram
                    width: 280
                    height: 280
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    value: 0.5
                    name1: "RAM"
                    isRam: true
                    colorBorder: "#55FF7F"
                }
            }
            Rectangle{
                id: box21
                color:"#00000000"
                anchors.top: box11.bottom
                anchors.left: box11.left
                width: parent.width/2
                height: parent.height/2
            }
            Rectangle{
                color:"#00000000"
                id: box22
                anchors.top: box21.top
                anchors.left: box21.right
                width: parent.width/2
                height: parent.height/2
            }
        }

        Rectangle {
            id: box2
            width: parent.width/2
            color: "#00000000"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.leftMargin: 815
            anchors.topMargin: 0
            Rectangle {
                id: box13
                width: parent.width/2
                height: parent.height/2
                color: "#00000000"
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 1
                anchors.topMargin: 162
                CircularCanvasProgressBar {
                    id: cpu1
                    name1: "GPU"
                    width: 280
                    height: 280
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    value: 0.5
                    colorBorder: "#ff028d"
                }
            }

            Rectangle {
                id: box14
                width: parent.width/2
                height: parent.height/2
                color: "#00000000"
                anchors.left: box13.right
                anchors.top: parent.top
                anchors.leftMargin: 7
                anchors.topMargin: 162
                CircularCanvasProgressBar {
                    id: ram1
                    aaa: 0
                    name1: "Battery"
                    width: 280
                    height: 280
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    value: 0.5
                    isRam: true
                    colorBorder: "#05a8d0"
                }
            }

            Rectangle {
                id: box23
                width: parent.width/2
                height: parent.height/2
                color: "#00000000"
                anchors.left: box13.left
                anchors.top: box13.bottom
            }

            Rectangle {
                id: box24
                width: parent.width/2
                height: parent.height/2
                color: "#00000000"
                anchors.left: box23.right
                anchors.top: box23.top
            }
        }
    }
    Component.onCompleted: {
        backend.seenDataSystemm()
    }
    Connections{
        target: backend
        function onSeenPercentCPU(data){
            data /= 100
            cpu.value = data
        }
        function onSeenDataSystem(data){
            ram.ram = data
        }
        function onSeenPercentRAM(data){
            data /= 100
            ram.valueUse = ram.ram * data
            ram.value = data
        }
        function onSeenPercentGPU(data){
            data /= 100
            cpu1.value = data;
        }
        function onSeenPercentBattery(data){
            data /= 100
            ram1.value = data;
        }
    }
}




/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.5;height:700;width:1700}
}
##^##*/
