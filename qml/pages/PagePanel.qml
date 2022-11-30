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
            isActive: true

        }
        LeftMenuBtn{
            id: btnInfomation
            anchors.top: btnControl.bottom
            btnIconSource: "../../images/svg_images/infomation.svg"
            text: "Summary"
            onClicked: {
                backend.loopPanel()
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
                mainWindow.width = 1700
                mainWindow.height = 700
                backend.loopPanel()
                backend.loopSystem()
                view.push(Qt.resolvedUrl("PageSystemMonitor.qml"))
            }

        }
        LeftMenuBtn{
            id: btnHistory
            anchors.top: btnSystem.bottom
            btnIconSource: "../../images/svg_images/history.svg"
            text: "Usage History"
            onClicked: {
                backend.loopPanel()
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
            id: panel0
            color:"#00000000"
            anchors.right: parent.right
            anchors.left: parent.left
            height: 200

            Rectangle{
                color:"#00000000"
                id: formHighPower
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                width: parent.width/3
                ButtonPower{
                    id: btn1
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled:true
                        onEntered:{
                            if (btn1.status == 0){
                                btn1.status = 2;
                            }
                        }
                        onExited: {
                            if (btn1.status == 2){
                                btn1.status = 0
                            }
                        }
                        onClicked: {
                            btn1.status = 1;
                            btn2.status = 0;
                            bnt3.status = 0;
                            backend.changeModePower(1);

                        }
                    }
                }

            }
            Rectangle{
                color:"#00000000"
                id: formBalancePower
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: formHighPower.right
                width: parent.width/3
                ButtonPower{
                    id: btn2
                    url: "../../images/balance.png"
                    url1: "../../images/balance1.png"
                    url2: "../../images/balance2.png"
                    t: "Balanced"
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled:true
                        onEntered:{
                            if (btn2.status == 0){
                                btn2.status = 2;
                            }
                        }
                        onExited: {
                            if (btn2.status == 2){
                                btn2.status = 0
                            }
                        }
                        onClicked:{
                            btn1.status = 0;
                            btn2.status = 1;
                            bnt3.status = 0;
                            backend.changeModePower(2);
                        }
                    }
                }
            }
            Rectangle{
                color:"#00000000"
                id: formSavePower
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: formBalancePower.right
                width: parent.width/3
                ButtonPower{
                    id: bnt3
                    url: "../../images/save.png"
                    url1: "../../images/save1.png"
                    url2: "../../images/save2.png"
                    t: "Power Saver"
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled:true
                        onEntered:{
                            if (bnt3.status == 0){
                                bnt3.status = 2;
                            }
                        }
                        onExited: {
                            if (bnt3.status == 2){
                                bnt3.status = 0
                            }
                        }
                        onClicked: {
                            btn1.status = 0;
                            btn2.status = 0;
                            bnt3.status = 1;
                            backend.changeModePower(3);
                        }
                    }
                }
            }
        }
        Rectangle{
            id: panel1
            anchors.top: panel0.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            height: 150
            color:"#00000000"
            Rectangle{
                id:formWifi
                color:"#00000000"
                anchors.top: parent.top
                anchors.left:parent.left
                anchors.bottom: parent.bottom
                width: parent.width/3
                ButtonSwitch{
                    anchors.verticalCenter: parent.verticalCenter ;
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            Rectangle{
                id:formBluetooth
                color:"#00000000"
                anchors.top: parent.top
                anchors.left:formWifi.right
                anchors.bottom: parent.bottom
                width: parent.width/3
                ButtonSwitch{
                    sourceImg: "../../images/bluetooth.svg"
                    nameDevice: "Bluetooth"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            Rectangle{
                id:formMicro
                color:"#00000000"
                anchors.top: parent.top
                anchors.left:formBluetooth.right
                anchors.bottom: parent.bottom
                width: parent.width/3
                ButtonSwitch{
                    nameDevice: "Micro"
                    sourceImg: "../../images/micro.svg"
                    h: 45
                    anchors.verticalCenter: parent.verticalCenter ;
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
        Rectangle{
            id: panel2
            anchors.top: panel1.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            height: 150
            color:"#00000000"
            Rectangle{
                id:formKeyboard
                color:"#00000000"

                anchors.top: parent.top
                anchors.left:parent.left
                anchors.bottom: parent.bottom
                width: parent.width/3
                ButtonSwitch{
                    nameDevice: "Keyboard"
                    w: 50
                    h: 35
                    marginLeft: 186
                    sourceImg: "../../images/keyboard.png"
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.horizontalCenter: parent.horizontalCenter;

                }
            }
            Rectangle{
                id:formWebcam
                color:"#00000000"
                anchors.top: parent.top
                anchors.left:formKeyboard.right
                anchors.bottom: parent.bottom
                width: parent.width/3
                ButtonSwitch{
                    nameDevice: "Webcam"
                    sourceImg: "../../images/webcam.png"
                    anchors.verticalCenter: parent.verticalCenter ;
                    anchors.horizontalCenter: parent.horizontalCenter}
            }
            Rectangle{
                id:formTouchpad
                color:"#00000000"
                anchors.top: parent.top
                anchors.left:formWebcam.right
                anchors.bottom: parent.bottom
                width: parent.width/3
                ButtonSwitch{
                    nameDevice: "Touchpad"
                    sourceImg: "../../images/touchpad.png"
                    anchors.verticalCenter: parent.verticalCenter ;
                    anchors.horizontalCenter: parent.horizontalCenter}
            }
        }
        Rectangle{
            id:panel3
            color:"#00000000"
            anchors.top: panel2.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            Rectangle{
                id:brightness
                color:"#00000000"
                anchors.top:parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                width: parent.width/2
                BoxSlider{
                    anchors.verticalCenter: parent.verticalCenter ;
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            Rectangle{
                id:volume
                color:"#00000000"
                anchors.top:parent.top
                anchors.bottom: parent.bottom
                anchors.left: brightness.right
                anchors.right: parent.right
                BoxSlider{
                    name: "Panel Volume"
                    anchors.verticalCenter: parent.verticalCenter ;
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
        Connections{
            target: backend
            function onStatusModePower(data){
                if (data == 1 && btn1.status != 1){
                    btn1.status = 1;
                    btn2.status = 0;
                    bnt3.status = 0;
                }
                else if (data == 2 && btn2.status != 1){
                    btn1.status = 0;
                    btn2.status = 1;
                    bnt3.status = 0;
                }
                if (data == 3 && bnt3.status != 1){
                    btn1.status = 0;
                    btn2.status = 0;
                    bnt3.status = 1;
                }
            }
        }
    }

}




/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.5;height:700;width:1100}
}
##^##*/
