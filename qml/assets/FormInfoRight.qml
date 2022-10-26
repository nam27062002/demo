import QtQuick 2.0
import QtQuick.Controls 2.3
Rectangle{
    id: viewInfo
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    height: 60
    property string text11: "text"
    property string text12: "text"
    property int distance: 231
    Text {
        id: t1
        text: qsTr(viewInfo.text11+":")
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: 14
        anchors.left: parent.left
    }
    Text {
        id: t2
        color: "#2e37ff"
        text: qsTr(viewInfo.text12)
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: 14
        anchors.left: parent.left
        anchors.verticalCenterOffset: 0
        anchors.leftMargin: distance
    }
}
