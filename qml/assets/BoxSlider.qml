import QtQuick 2.0
import QtQuick.Controls 2.5
Rectangle {
    id: boxSlider
    width: 390
    height: 80
    radius: 20
    color: "#ffffff"
    border.color: "#00ff08"
    border.width: 2
    property string name: "Panel Brightness"
    Slider {
        id: slider
        x: 57
        y: 29
        width: 220
        height: 40
        to: 100
        value: 50
        onValueChanged: {
            if (name == "Panel Brightness"){
                backend.funcChangeBrightness(parseInt(slider.value));
            }
            else if (name == "Panel Volume"){
                backend.changeVolume(parseInt(slider.value))
            }
        }
    }

    Text {
        id: text1
        x: 64
        y: 8
        width: 169
        height: 26
        text: qsTr(name)
        font.pixelSize: 17
    }

    Text {
        id: text2
        x: 321
        y: 41
        text: qsTr(parseInt(slider.value).toString() +"%")
        font.pixelSize: 15
    }

    Image {
        id: image
        x: 15
        y: 38
        width: 56
        height: 22
        source: "../../images/arrow-left1.png"
        fillMode: Image.PreserveAspectFit
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                image.source = "../../images/arrow-left2.png"
            }
            onExited: {
                image.source = "../../images/arrow-left1.png"
            }
            onClicked: {
                if (slider.value - 10 >= 0)
                    slider.value -= 10
                else{
                    slider.value = 0
                }
            }
        }
    }

    Image {
        id: image1
        x: 283
        y: 38
        width: 32
        height: 22
        source: "../../images/arrow-right1.png"
        fillMode: Image.PreserveAspectFit
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                image1.source = "../../images/arrow-right2.png"
            }
            onExited: {
                image1.source = "../../images/arrow-right1.png"
            }
            onClicked: {
                if (slider.value + 10 <= 100){
                    slider.value += 10
                }
                else{
                    slider.value = 100
                }
//                if (name == "Panel Brightness"){
//                    backend.funcChangeBrightness(slider.value);
//                }
            }
        }
    }
    Connections{
        target: backend
        function onPercentBrightness(data){
            if (name == "Panel Brightness"){
                slider.value = data;
            }
        }
        function onPercentVolume(data){
            if (name == "Panel Volume"){
                slider.value = data;
            }
        }
    }

}
