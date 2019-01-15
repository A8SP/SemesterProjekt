import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import QtQuick.Scene3D 2.0
import QtQuick.Controls.Material 2.3

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Extras 2.0


ApplicationWindow{
    visible: true
    width: 640
    height: 480
    color: "#c7c7c8"
    title: qsTr("Konfigurator")
    property bool loaderSlot1: false;
    property bool loaderSlot2: false;
    property bool loaderSlot3: false;


//    FileDialog{
//        id: fileDialog0
//        onAccepted:{
//            sceneLoaderSlot1.source = fileDialog0.fileUrl
//        }
//    }
//    FileDialog{
//        id: fileDialog1
//        onAccepted:{
//            sceneLoaderSlot2.source = fileDialog1.fileUrl
//        }
//    }
//    FileDialog{
//        id: fileDialog2
//        onAccepted:{
//            sceneLoaderSlot3.source = fileDialog2.fileUrl
//        }
//    }


    Scene3D {
        anchors.rightMargin: 0
        anchors.bottomMargin: 91
        anchors.topMargin: 40
        anchors.leftMargin: 106
        anchors.fill: parent
        aspects: ["input", "logic"]
        cameraAspectRatioMode: Scene3D.AutomaticAspectRatio



        Entity{
            id: sceneRoot



            Camera{
                id: camera
                projectionType: CameraLens.PerspectiveProjection
                fieldOfView: 46
                aspectRatio: 16/9
                nearPlane : 0.1
                farPlane : 1000.0
                position: Qt.vector3d( 0.0, 0.0, 10.0 )
                upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
                viewCenter: Qt.vector3d( 0.0, 0.0, 0.0 )

            }

            OrbitCameraController{
                camera: camera
            }

            components: [
                RenderSettings{
                    activeFrameGraph: ForwardRenderer{
                        clearColor: "transparent";
                        camera: camera
                    }
                }

            ]

            Entity{
                id: tisch

                components: [


                    Transform {
                        //scale: 0.004
                        matrix: {
                            var m = Qt.matrix4x4();
                            m.rotate(90, Qt.vector3d(0, 1, 0));
                            m.rotate(120, Qt.vector3d(0, 1, 0));
                            m.rotate(20, Qt.vector3d(-1, 1, 0));
                            m.rotate(8, Qt.vector3d(0, 0, -1));
                            m.scale(0.004);
                            return m
                        }
                        translation: Qt.vector3d(3, -2, 0)

                    },
                    Material{
                        parameters: [
                         Parameter { name: "color"; value: "blue" }]
                    } ,

                    SceneLoader{
                       id: sceneLoaderTisch
                       source:  "file:///"+applicationDirPath+"/../../smallFLEX/BASIS_TABLE.STL"
                    }

                ]
            }



            Entity{
                id: slot1
                enabled: loaderSlot1
                components: [
                    Transform {

                        translation: Qt.vector3d(-1, 0, 0)
                        scale: 0.01
                    },
                    SceneLoader{
                        id: sceneLoaderSlot1
                        onStatusChanged: {
                            console.log("sceneLoaderSlot1 status: " + status);
                        }
                    }
                ]
            }

            Entity{
                id: slot2
                enabled: loaderSlot2
                components: [
                    Transform {
                        matrix: {
                            var m = Qt.matrix4x4();
                            //m.rotate(90, Qt.vector3d(0, 1, 0));
                            m.rotate(120, Qt.vector3d(0, 1, 0));
                            m.rotate(20, Qt.vector3d(-1, 1, 0));
                            m.rotate(15, Qt.vector3d(0, 0, 1));
                            m.scale(0.004);
                            return m
                        }
                        translation: Qt.vector3d(1, -0.4, 4)
                    },

                    SceneLoader{
                        id: sceneLoaderSlot2
                        onStatusChanged: {
                            console.log("sceneLoaderSlot2 status: " + status);
                        }
                    }
                ]
            }

            Entity{
                id: slot3
                enabled: loaderSlot3
                components: [
                    Transform {
                        translation: Qt.vector3d(1, 0, 0)
                        scale: 0.5
                    },

                    SceneLoader{
                        id: sceneLoaderSlot3
                        onStatusChanged: {
                            console.log("sceneLoaderSlot3 status: " + status);
                        }
                    }
                ]
            }

        }
    }

    Pane {
        id: nav
        x: 0
        y: 0
        width: 108
        height: 480
        opacity: 0.5
        clip: false
        hoverEnabled: false

        Image {
            id:basis
            x: -12
            y: 0
            width: 108
            height: 87
            source: "file:///"+applicationDirPath+"/../../smallFLEX/BASISSTATION.png"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    loaderSlot1.source = "file:///"+applicationDirPath+"/../../smallFLEX/BASISSTATION.STL"
                }
            }
        }

        Image {
            id:conveyor
            x: -12
            y: 90
            width: 108
            height: 87
            source: "file:///"+applicationDirPath+"/../../smallFLEX/CONVEYOR.png"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    loaderSlot1.source = "file:///"+applicationDirPath+"/../../smallFLEX/CONVEYOR.STL"
                }
            }
        }

    }

}
