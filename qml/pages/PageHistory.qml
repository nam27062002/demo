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
                view.push(Qt.resolvedUrl("PagePanel.qml"))
            }

        }
        LeftMenuBtn{
            id: btnInfomation
            anchors.top: btnControl.bottom
            btnIconSource: "../../images/svg_images/infomation.svg"
            text: "Summary"
            onClicked: {
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
        anchors.right: parent.right
        anchors.left: leftButton.right
        MouseArea{
            anchors.fill: parent
            hoverEnabled:true
        }
        Rectangle{
            id: content2
            color:"#00000000"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 100
            anchors.leftMargin: 100
            anchors.rightMargin: 100
            Rectangle{
                id: a1
                color: "#00000000"
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                width: parent.width/2


            }
        }

    }

}




/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.33;height:700;width:1700}
}
##^##*/
