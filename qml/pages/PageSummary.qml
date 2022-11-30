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
            anchors.top: parent.top
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
            isActive: true
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
            onClicked: {
                mainWindow.width = 1100
                mainWindow.height = 700
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
            id:content2
            color: "white"
            radius: 30
            anchors.top:parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.topMargin: 100
            anchors.bottomMargin: 100
            anchors.rightMargin: 120
            anchors.leftMargin: 120
            PropertyAnimation{
                id: zoom
                target: content2
                property: "anchors.leftMargin"
                to: if(content2.anchors.leftMargin == 120) return 10; else return 120
                duration: 1000
                easing.type: Easing.InOutQuint
            }
            PropertyAnimation{
                id: zoom2
                target: content2
                property: "anchors.rightMargin"
                to: if(content2.anchors.rightMargin == 120) return 650; else return 120
                duration: 1000
                easing.type: Easing.InOutQuint
            }
            Rectangle{
                id:a1
                color:"#00000000"
                anchors.top:parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height/3
                Rectangle{
                    id: os
                    color:"#00000000"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom:parent.bottom
                    width: parent.width/2
                    FormInfoLeft{
                        id: aos
                        anchors.left: parent.left
                        anchors.leftMargin: 20


                    }

                }
                Rectangle{
                    color:"#00000000"
                    id: memory
                    anchors.left: os.right
                    anchors.top: os.top
                    anchors.bottom:os.bottom
                    width: parent.width/2
                    FormInfoLeft{
                        id: amemory
                        src: "../../images/RAM.png"
                        name1: "Memory"
                        name2: "8GB @ 3200MT/s"
                        anchors.left: parent.left
                        anchors.leftMargin: 20

                    }

                }
            }
            Rectangle{
                id:a2
                color:"#00000000"
                anchors.top:a1.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height/3
                Rectangle{
                    color:"#00000000"
                    id: cpu
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom:parent.bottom
                    width: parent.width/2
                    FormInfoLeft{
                        id: acpu
                        src: "../../images/CPU.png"
                        name1: "CPU"
                        name2: "11th Gen Intel(R) Core(TM) i5-1155G7 @2.50GHz"
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                    }

                }
                Rectangle{
                    id: battery
                    color:"#00000000"
                    anchors.left: cpu.right
                    anchors.top: cpu.top
                    anchors.bottom:cpu.bottom
                    width: parent.width/2
                    FormInfoLeft{
                        id: abattery
                        src: "../../images/battery.png"
                        name1: "Battery"
                        name2: "52,44Wh"
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                    }

                }
            }
            Rectangle{
                id:a3
                color:"#00000000"
                anchors.top:a2.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height/3
                Rectangle{
                    id: disk
                    color:"#00000000"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom:parent.bottom
                    width: parent.width/2
                    FormInfoLeft{
                        id: adisk
                        src: "../../images/SSD.png"
                        name1: "DISK"
                        name2: "KINGSTON OM8PDP3512B-AI1"
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                    }

                }
                Rectangle{
                    id: gpu
                    color:"#00000000"
                    anchors.left: disk.right
                    anchors.top: disk.top
                    anchors.bottom:disk.bottom
                    width: parent.width/2
                    FormInfoLeft{
                        id: agpu
                        src: "../../images/GPU.png"
                        name1: "GPU"
                        name2: "11th Gen Intel(R) Core(TM) i5-1155G7 @2.50GHz"
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                    }

                }
            }
        }
        Rectangle{
            id:content3
            color: "#ffffff"
            radius: 30
            visible: false
            anchors.top: content2.top
            anchors.left: content2.right
            anchors.right: parent.right
            anchors.bottom: content2.bottom
            anchors.leftMargin: 20
            anchors.rightMargin: 20

            ListView {
                id: listView
                anchors.fill: parent
                anchors.topMargin: 20
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                anchors.bottomMargin: 50
                delegate: Item {
                    x: 5
                    width: 80
                    height: 40
                    Row {
                        id: row1
                        FormInfoRight{
                            id: tttt
                            text11: name
                            text12: name2
                            distance: content.distance
                        }
                    }
                }
                model: ListModel {
                    id: list0
                    ListElement {
                        name: "Grey"
                        name2: "red"
                    }

                    ListElement {
                        name: "Red"
                        name2: "red"
                    }

                    ListElement {
                        name: "Blue"
                        name2: "red"
                    }

                    ListElement {
                        name: "Green"
                        name2: "red"
                    }
                }
            }
        }
    }
//    Component.onCompleted: {
//        backend.seenInfoOS()
//    }
    Connections{
        target: backend
        function onSeenSignalShowSceen(data,val){
            list0.clear()
            if (val == 1){
                zoom.running = true
                zoom2.running = true
                for (let i = 0; i < data.length;i++){
                    list0.append({"name": data[i][0],"name2":data[i][1] })
                }
                delay(800,function(){
                    content3.visible = true
                })
            }
            else if (val == 0){
                for (let i = 0; i < data.length;i++){
                    list0.append({"name": data[i][0],"name2":data[i][1] })
                }
            }
            else if (val == 2){
                zoom.running = true
                zoom2.running = true
                delay(800,function(){
                    content3.visible = false
                })

            }
        }
        function onSeenInfo(data){
            console.log(data)
            aos.name2 = data[0]
            acpu.name2 = data[1]
            adisk.name2 = data[2]
            amemory.name2 = data[3]
            abattery.name2 = data[4]
            agpu.name2 = data[5]
        }
    }
}







/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.5;height:700;width:1700}
}
##^##*/
