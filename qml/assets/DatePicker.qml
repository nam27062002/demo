import QtQuick 2.0
import QtQuick.Controls 2.5
Rectangle{
    id: main
    width: 400
    height: 50
    color: '#00000000'
    property int indexDay: 0
    property int indexMonth: 0
    property int indexYear: 0
    Rectangle{
        id: day
        color: '#00000000'
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: parent.width/3
        ComboBox {
            id: comboboxDay
            width: 115
            height: 30
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            editable: true
            model: ListModel {
                id: listDay
                ListElement {
                    name: "1"
                }
            }
            currentIndex: indexDay
            Component.onCompleted: currentIndex = indexDay
            onAccepted: {
                if (find(editText) === -1)
                    listDay.append({text: editText})
            }
        }
    }
    Rectangle{
        id: month
        color: '#00000000'
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: day.right
        width: parent.width/3
        ComboBox {
            id: comboboxMonth
            width: 115
            height: 30
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            editable: true
            model: ListModel {
                id: listMonth
                ListElement {
                    name: "1"
                }
            }
            Component.onCompleted: currentIndex = indexMonth
            onAccepted: {
                if (find(editText) === -1)
                    listMonth.append({text: editText})
            }
        }
    }
    Rectangle{
        id: year
        color: '#00000000'
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: month.right
        anchors.right: parent.right
        ComboBox {
            id: comboboxYear
            width: 115
            height: 30
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            editable: true
            model: ListModel {
                id: listYear
                ListElement {
                    name: "1"
                }
            }
            Component.onCompleted: currentIndex = indexYear
            currentIndex: indexYear
            onAccepted: {
                if (find(editText) === -1)
                    listYear.append({text: editText})
            }
        }
    }
    function loadDay(value){
        listDay.clear()
        for(let i = 1;i <= value;i++){
            listDay.append({"name":i.toString()})
        }
    }
    function loadMonth(){
        listMonth.clear()
        for(let i = 1;i <= 12;i++){
            listMonth.append({"name":"Tháng " + i.toString()})
        }
    }
    function loadYear(){
        listYear.clear()
        for(let i = 2000;i <= 2022;i++){
            listYear.append({"name":i.toString()})
        }
    }

    Component.onCompleted:{
        loadDay(31)
        loadMonth()
        loadYear()
    }

}



