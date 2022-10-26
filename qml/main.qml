import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Dialogs 1.3
import 'assets'
Window {
    id: mainWindow
    property string statePage: "password"
    width: 1500
    height: 700
    visible: true
    x: screen.width/2 - width/2
    y: screen.height/2 - height/2
    property color backgroundColor: "#2c313c"
    property color tagBarColor: "#1c1d20"
    property string sourceIconApp: "../images/icon.ico"
    property bool stateWindowSize: false
    property bool isCenterScreeen: true
    property int toWidth: 1200
    property int toHeight: 700
    flags: Qt.Window | Qt.FramelessWindowHint

    // animation window center
    PropertyAnimation{
        id: animationXWindow
        target: mainWindow
        property: "x"
        to: screen.width/2 - mainWindow.width/2
        duration: 1000
        easing.type: Easing.InOutQuint
    }
    PropertyAnimation{
        id: animationYWindow
        target: mainWindow
        property: "y"
        to: screen.height/2 - mainWindow.height/2
        duration: 1000
        easing.type: Easing.InOutQuint
    }
    PropertyAnimation{
        id: animationZoomWindow1
        target: mainWindow
        property: "width"
        to: toWidth
        duration: 2000
        easing.type: Easing.InOutQuint
    }
    PropertyAnimation{
        id: animationZoomWindow2
        target: mainWindow
        property: "height"
        to: toHeight
        duration: 2000
        easing.type: Easing.InOutQuint
    }
    // background
    Rectangle{
        id: background
        color: backgroundColor
        anchors.fill: parent
        // tagbar
        Rectangle{
            id: tagbar
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: 35
            color: tagBarColor
            // title
            Rectangle{
                id: title
                color: "#00000000"
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: 105
                anchors.leftMargin: if (statePage == "password") return 0; else if (statePage == "panel") return 70
                // event move window
                DragHandler {
                    onActiveChanged: if(active && !stateWindowSize){
                                         mainWindow.startSystemMove()
                                     }
                                    else{
                                        if (mainWindow.x != screen.width/2 - mainWindow.width/2 && mainWindow.y != screen.height/2 - mainWindow.height/2){
                                            isCenterScreeen = false
                                        }
                                        else{
                                            isCenterScreeen = true
                                        }
                                     }
                }
                MouseArea{
                    anchors.fill: parent
                    acceptedButtons: Qt.RightButton
                    onClicked: {
                        isCenterScreeen = true
                        animationXWindow.running = true
                        animationYWindow.running = true
                    }
                }
                // icon window
                Image{
                    id: icon
                    source: sourceIconApp
                    width: 22
                    height: 22
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                }
                // text title
                Label{
                    id: textTitle
                    text: if (statePage == "password") return "Enter your password"; else if (statePage == "panel") return "Device Manage";
                    color: "#c3cbdd"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: icon.right
                    anchors.leftMargin: 10

                }
            }
            // button minimize, maximize, close
            Rectangle{
                id: mutiButton
                color: "#00000000"
                anchors.left: title.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                // button minimize
                ImgButton{
                    id: buttonMinize
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    width: 35
                    onClicked: {
                        mainWindow.showMinimized()
                    }
                }
                // button maximize
                ImgButton{
                    id: buttonMaximize
                    anchors.left: buttonMinize.right
                    anchors.top: buttonMinize.top
                    anchors.bottom: buttonMinize.bottom
                    width: 35
                    btnIconSource: "../images/svg_images/maximize_icon.svg"
                    onClicked: {
                        if (!stateWindowSize){
                            mainWindow.showMaximized()
                            buttonMaximize.btnIconSource = "../images/svg_images/restore_icon.svg"
                        }
                        else{
                            mainWindow.showNormal()
                            buttonMaximize.btnIconSource = "../images/svg_images/maximize_icon.svg"
                        }
                        stateWindowSize = !stateWindowSize
                    }
                }
                // button close
                ImgButton{
                    id: buttonClose
                    anchors.left: buttonMaximize.right
                    anchors.top: buttonMaximize.top
                    anchors.bottom: buttonMaximize.bottom
                    width: 35
                    btnIconSource: "../images/svg_images/close_icon.svg"
                    onClicked: {
                        backend.closeProgram()
                        mainWindow.close()
                    }
                }
            }
        }
        Rectangle{
            id: content
            color: "#00000000"
            anchors.top: tagbar.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            StackView{
                id: view
                anchors.fill: parent
                initialItem: Qt.resolvedUrl("pages/PageSummary.qml")
            }
        }
    }
    MouseArea {
        id: resizeLeft
        width: 10
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        cursorShape: Qt.SizeHorCursor
        DragHandler{
            target: null
            onActiveChanged: if (active) {
                                 mainWindow.startSystemResize(Qt.LeftEdge)
                             }
                             else{
                                if (isCenterScreeen){
                                    animationXWindow.running = true
                                    animationYWindow.running = true
                                }
                             }
        }

    }

    MouseArea {
        id: resizeRight
        width: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.topMargin: 35
        anchors.bottomMargin: 20
        cursorShape: Qt.SizeHorCursor

        DragHandler{
            target: null
            onActiveChanged: if (active) {
                                 mainWindow.startSystemResize(Qt.RightEdge)
                             }
                             else{
                                 if (isCenterScreeen){
                                     animationXWindow.running = true
                                     animationYWindow.running = true
                                 }
                             }
        }
    }

        MouseArea {
            id: resizeBottom
            height: 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 20
            anchors.leftMargin: 20
            cursorShape: Qt.SizeVerCursor
            DragHandler{
                target: null
                onActiveChanged: if (active) {
                                     mainWindow.startSystemResize(Qt.BottomEdge)
                                 }
                                 else{
                                     if (isCenterScreeen){
                                         animationXWindow.running = true
                                         animationYWindow.running = true
                                     }
                                 }
            }
        }
    Connections{
        target: backend
        function onCheckPassword(IsPassword){
            if (IsPassword){
                statePage = "panel";
                backend.loopPanel()
                mainWindow.width = 1500
                mainWindow.height = 700
                view.push(Qt.resolvedUrl("pages/PagePanel.qml"))
            }
        }
    }

}






/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
