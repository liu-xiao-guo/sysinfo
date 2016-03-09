import QtQuick 2.0
import Ubuntu.Components 1.1
import QtSystemInfo 5.0
import Ubuntu.Components.ListItems 1.0 as ListItems

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "sysinfo.liu-xiao-guo"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(100)
    height: units.gu(75)

    Page {
        title: i18n.tr("SysInfo")

        DeviceInfo {
            id: deviceInfos
        }

        BatteryInfo {
            id: batteryInfo
        }

        NetworkInfo {
            id: networkInfo
        }

        ScreenSaver {
            id: screenSaver
            screenSaverEnabled: true
        }

        Flickable {
            anchors.fill: parent
            contentHeight: content.childrenRect.height

            Column {
                id: content
                anchors.left: parent.left
                anchors.right: parent.right

                ListItems.Empty {
                    height: ubuntuLabel.height + deviceLabel.height + units.gu(6)

                    Column {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.centerIn: parent
                        spacing: units.gu(2)
                        Label {
                            id: ubuntuLabel
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: ""
                            fontSize: "x-large"
                        }
                        Label {
                            id: deviceLabel
                            objectName: "deviceLabel"
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: deviceInfos.manufacturer() + " " + deviceInfos.model()
                        }
                    }
                    highlightWhenPressed: false
                }

                ListItems.SingleValue {
                    text: "Battery Level"
                    value: batteryInfo.level
                }

                ListItems.SingleValue {
                    text: "Battery Index"
                    value: batteryInfo.batteryIndex
                }

                ListItems.SingleValue {
                    text: "Battery charging state"
                    value: batteryInfo.chargingState
                }

                ListItems.SingleValue {
                    text: "Unique Device ID"
                    value: deviceInfos.uniqueDeviceID()
                }

                ListItems.SingleValue {
                    text: "Product Name"
                    value: deviceInfos.productName()
                }

                ListItems.SingleValue {
                    text: "Current network mode"
                    value: {
                        switch(networkInfo.currentNetworkMode) {
                        case 0:
                            return "UnknownMode";
                        case 1:
                            return "GsmMode";
                        case 2:
                            return "CdmaMode";
                        case 3:
                            return "WcdmaMode";
                        case 4:
                            return "WlanMode";
                        case 5:
                            return "EthernetMode";
                        case 8:
                            return "LteMode";
                        case 9:
                            return "TdscdmaMode";
                        }
                    }
                }

                ListItems.SingleValue {
                    text: "Network status"
                    value: {
                        switch (networkInfo.networkStatus(3, 0) ) {
                        case 0:
                            return "UnknownStatus";
                        case 1:
                            return "NoNetworkAvailable";
                        case 2:
                            return "EmergencyOnly";
                        case 3:
                            return "Searching"
                        case 4:
                            return "Busy";
                        case 5:
                            return "Denied";
                        case 6:
                            return "HomeNetwork";
                        case 7:
                            return "Roaming";
                        }
                    }
                }

                ListItems.SingleValue {
                    objectName: "imeiItem"
                    property string imeiNumber
                    imeiNumber: deviceInfos.imei(0)
                    text: "IMEI"
                    value: imeiNumber
                    visible: imeiNumber
                }
            }

        }
    }
}

