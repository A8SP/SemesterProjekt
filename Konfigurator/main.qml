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
    title: qsTr("3D")
    property bool loaderSlot1: false;
    property bool loaderSlot2: false;
    property bool loaderSlot3: false;

    header: ToolBar{

        RowLayout{
            anchors.fill: parent
            ToolButton{
                text: "Slot 1"
                onPressed:{
                    loaderSlot1 = !loaderSlot1;
                    if(loaderSlot1){
                        //sceneLoaderSlot1.source = "file:c:/.."
                        fileDialog0.open();
                    }
                }
            }
            ToolButton{
                text: "Slot 2"
                onPressed:{
                    loaderSlot2 = !loaderSlot2;
                    if(loaderSlot2){

                        fileDialog1.open();
                    }
                }
            }
            ToolButton{
                text: "Slot 3"
                onPressed:{
                    loaderSlot3 = !loaderSlot3;
                    if(loaderSlot3){
                        fileDialog2.open();
                    }
                }
            }
        }
    }

    FileDialog{
        id: fileDialog0
        onAccepted:{
            sceneLoaderSlot1.source = fileDialog0.fileUrl
        }
    }
    FileDialog{
        id: fileDialog1
        onAccepted:{
            sceneLoaderSlot2.source = fileDialog1.fileUrl
        }
    }
    FileDialog{
        id: fileDialog2
        onAccepted:{
            sceneLoaderSlot3.source = fileDialog2.fileUrl
        }
    }

    ListModel{
        id: myModel
             ListElement {
                 type: "Car 1"
                 description: "Auto mit der Modellnummer 110"
                 imagePath: "file:c:/.."
             }
             ListElement {
                 type: "Car 2"
                 description: "Auto mit der Modellnummer 111"
                 imagePath: "file:c:/.."
             }
    }


    ListView {
        id: listView
        width: 100
        height: parent.height

        model: myModel

        delegate: ItemDelegate {
             Text{
                 id: myText
                 y: 20; anchors.horizontalCenter: parent.horizontalCenter
                 text: type
             }


            Image{
                id: myIcon
                anchors { top: myText.bottom }
                width: 80
                height: 80
                source: imagePath
            }
            height: 110
            onClicked: console.log("clicked:", modelData)
        }

        ScrollIndicator.vertical: ScrollIndicator { }
    }

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
                        clearColor: "transparent"
                        camera: camera
                    }
                },

                InputSettings{
                    MouseArea {
                        width: 200; height: 200
                        onClicked: console.log("hello")
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
                         Parameter { name: "diffuseColor"; value: "blue" }]
                    } ,

                    SceneLoader{
                        id: sceneLoaderTisch
                        source: "file:c:/.." // hier url zu BASIS_TABLE.*
                        onStatusChanged: {
                            console.log("sceneLoaderTisch status: " + status);
                        }
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

}
