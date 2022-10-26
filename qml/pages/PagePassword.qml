import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Dialogs 1.3
Rectangle{
    id: content
    color: "#00000000"
    anchors.fill: parent
    anchors.topMargin: 35
    property string name: ""
    Rectangle{
        id: boxPassword
        height: 300
        width: 300
        color: "#00000000"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        Rectangle{
            id: cicrle
            height: 150
            color: "#00000000"
            width: 150
            radius: 100
            border.color: "#ffffff"
            anchors.top: parent.top
            anchors.topMargin: 15
            border.width: 4
            anchors.horizontalCenter: parent.horizontalCenter
            MouseArea{
                anchors.fill: parent
                hoverEnabled:true
                onEntered: {
                    cicrle.border.color = "#8fffc9"
                    svgUser.color = "#8fffc9"
                }
                onExited: {
                    cicrle.border.color = "#ffffff"
                    svgUser.color = "#ffffff"
                }
            }
            Image {
                id: iconBtn

                source: "../../images/svg_images/user.svg"
                anchors.top: parent.top
                anchors.topMargin: 15
                anchors.horizontalCenter: parent.horizontalCenter
                height: 100
                width: 100
                visible: false
                fillMode: Image.PreserveAspectFit
                antialiasing: false
            }

            ColorOverlay{
                id: svgUser
                anchors.fill: iconBtn
                source: iconBtn
                color: "#ffffff"
                antialiasing: false
            }
        }
        Rectangle{
            id: namePC
            height: 50
            anchors.top: cicrle.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: inputPassword.top
            color: "#00000000"
            Text {
                id: textName
                text: qsTr(name)
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 30
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#8fffc9"
            }
        }
        Rectangle{
            height: 30
            id: inputPassword
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: cicrle.bottom
            anchors.rightMargin: 50
            anchors.leftMargin: 50
            anchors.topMargin: 60
            radius: 20
            color: "#00000000"
            border.color: "#8fffc9"
            border.width: 2

            TextInput {
                id: textInput
                focus: true
                text: qsTr("")
                anchors.fill: parent
                anchors.rightMargin: 35
                anchors.leftMargin: 10
                anchors.topMargin: 2
                font.pixelSize: 20
                echoMode: TextInput.Password
                enabled: true
                color: "white"
                Keys.onPressed: (event) => {
                    if (event.key + 1 == Qt.Key_Enter){
                        if (textInput.text != ""){
                            busyIndicator.visible = true
                            textInput.enabled = false
                            backend.funcCheckPassword(textInput.text)
                        }
                        else{
                            error.visible = true
                            inputPassword.border.color = "red"
                            imgEye.color = "red"
                            error.text = qsTr("password not entered")
                        }
                    }
                    else if (error.visible == true){
                        error.visible = false
                        imgEye.color = "white"
                        inputPassword.border.color = "#8fffc9"
                    }
                }
            }

            Image {
                id: image
                anchors.left: textInput.right
                anchors.top: parent.top
                width:30
                height: 30
                source: "../../images/svg_images/show.svg"
                fillMode: Image.PreserveAspectFit
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled:true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {

                        if (image.source.toString().includes("show")){
                            image.source = "../../images/svg_images/hide.svg"
                            textInput.echoMode =  TextInput.Normal
                        }
                        else{
                            image.source = "../../images/svg_images/show.svg"
                            textInput.echoMode = TextInput.Password
                        }
                    }
                }
            }
            ColorOverlay{
                id: imgEye
                anchors.fill: image
                source: image
                color: "#ffffff"
                antialiasing: false
            }


        }

        BusyIndicator {
            id: busyIndicator
            x: 249
            y: 216
            width: 51
            height: 49
            palette.dark: "green"
            visible: false

        }

        Text {
            id: error
            x: 60
            y: 270
            width: 190
            height: 25
            color: "red"
            text: qsTr("password not entered")
            font.pixelSize: 16
            visible: false
        }
    }
    Component.onCompleted: {
        backend.funcGetNamePC()
    }
    Connections{
        target: backend
        function onGetNamePC(namePC){
            name = namePC
            textInput.focus = true
        }
        function onCheckPassword(IsPassword){
            if (!IsPassword){
                error.visible = true
                inputPassword.border.color = "red"
                imgEye.color = "red"
                error.text = qsTr("password not entered")
                textInput.enabled = true
                busyIndicator.visible = false
                textInput.text = ""
            }
        }
    }

}


