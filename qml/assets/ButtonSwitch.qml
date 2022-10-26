import QtQuick 2.0
import QtQuick.Controls 2.5
Rectangle {
    id: box
    width: 250
    height: 100
    color: "#ffffff"
    border.color: "#00ff08"
    border.width: 4
    radius: 20

    property string nameDevice: "Wi-Fi"
    property string sourceImg: "../../images/wifi-signal-svgrepo-com.svg"
    property int w: 40
    property int h: 40
    property int marginLeft: 193
    Image {
        id: image
        height: h
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: marginLeft
        width: w
        source: sourceImg
        anchors.verticalCenterOffset: 0
    }
    Switch {
        id: switch1
        x: 14
        checked: true
        y: 15
        width: 228
        height: 100
        z: 2
        text: qsTr(nameDevice)

        anchors.verticalCenter: parent.verticalCenter
        onCheckedChanged: {
            changeColorBorder.running = true
            if (!checked){
                s1.running = true
                colort1.running = true
                animationOffOn.running = true
                colort2.running = true
            }
            else{
                animationOffOn.running = true
                colort2.running = true
                s1.running = true
                colort1.running = true
            }
        }
        onClicked:{
            if (nameDevice == "Wi-Fi"){
                backend.turnOnAndOffWifi(checked)
            }
            else if (nameDevice == "Bluetooth"){
                backend.turnOnAndOffBluetooth(checked)
            }
            else if (nameDevice == "Keyboard"){
                backend.turnOnAndOffKeyboard(checked)
            }
            else if (nameDevice == "Webcam"){
                backend.turnOnAndOffWebcam(checked)
            }
            else if (nameDevice == "Touchpad"){
                backend.toggle_touchpad()
            }
            else if (nameDevice == "Micro"){
                backend.toggle_micro()
            }
        }

    }
    Text {
        id: text1
        x: 24
        y: 10
        color: "#08b30d"
        text: qsTr("ON")
        font.pixelSize: 20
        font.bold: true
    }
    PropertyAnimation{
        id: s1
        target: text1
        property: "y"
        to: if(text1.y == 10) return 40; else return 10
        duration: 200
        easing.type: Easing.InOutQuint
    }
    PropertyAnimation{
        id: colort1
        target: text1
        property: "color"
        to: if(text1.color == "#08b30d") return "white"; else return "#08b30d"
        duration: 200
        easing.type: Easing.InOutQuint
    }
    Text {
        id: text2
        x: 24
        y: 40
        color: "white"
        text: qsTr("OFF")
        font.pixelSize: 20
        font.bold: true
    }
    PropertyAnimation{
        id: animationOffOn
        target: text2
        property: "y"
        to: if(text2.y == 40){
                return 70;
            } else {
                return 40
            }
        duration: 200
        easing.type: Easing.InOutQuint
    }
    PropertyAnimation{
        id: colort2
        target: text2
        property: "color"
        to:if(text2.color == "#ffffff") return "red"; else return "#ffffff"
        duration: 200
        easing.type: Easing.InOutQuint
    }
    PropertyAnimation{
        id: changeColorBorder
        target: box
        property: "border.color"
        to:if(box.border.color == "#00ff08") return "red"; else return "#00ff08"
        duration: 400
        easing.type: Easing.InOutQuint
    }
    Connections{
        target: backend
        function move(){
            changeColorBorder.running = true
            if (switch1.checked){
                s1.running = true
                colort1.running = true
                animationOffOn.running = true
                colort2.running = true
            }
            else{
                animationOffOn.running = true
                colort2.running = true
                s1.running = true
                colort1.running = true
            }
        }
        function synchronize(){
            if (switch1.checked && box.border.color == "#ff0000"){
                move();
            }
            else if (switch1.checked == "false" && box.border.color == "#00ff08"){
                move();
            }
        }
        function onStatusWifi(data){
            if (nameDevice == "Wi-Fi"){
                if (data == "enabled" && switch1.checked == false){
                    switch1.checked = true;
                }
                else if (data == "disabled" && switch1.checked == true){
                    switch1.checked = false;
                }
                else{synchronize()}
            }
        }
        function onStatusBluetooth(data){
            if (nameDevice == "Bluetooth"){
                if (data.includes("Run") && switch1.checked == false){
                    switch1.checked = true;
                }
                else if (data.includes("Run") == false && switch1.checked == true){
                    switch1.checked = false;
                }
                else{synchronize()}
            }
        }
        function onStatusKeyboard(data){
            if (nameDevice == "Keyboard"){
                if (data == "On" && switch1.checked == false){
                    switch1.checked = true
                }
                else if (data == "Off" && switch1.checked == true){
                    switch1.checked = false
                }
                else{synchronize()}
            }
        }
        function onStatusWebcam(data){
            if (nameDevice == "Webcam"){
                if (data == "On" && switch1.checked == false){
                    switch1.checked = true
                }
                else if (data == "Off" && switch1.checked == true){
                    switch1.checked = false
                }
                else{synchronize()}

            }
        }
        function onStatusTouchpad(data){
            if (nameDevice == "Touchpad"){
                if (data.includes("enable") && switch1.checked == false){
                    switch1.checked = true;
                }
                else if (data.includes("enable") == false && switch1.checked == true){
                    switch1.checked = false;
                }
                else{synchronize()}
            }
        }
        function onStatusMicro(data){
            if (nameDevice == "Micro"){
                if (data && switch1.checked == false){
                    switch1.checked = true;
                }
                else if (!data && switch1.checked == true){
                    switch1.checked = false;
                }
                else{synchronize()}
            }
        }
    }
}



