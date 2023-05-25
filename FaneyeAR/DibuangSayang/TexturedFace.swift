////
////  TexturedFace.swift
////  FaneyeAR
////
////  Created by Wita Dewisari Tasya on 23/05/23.
////
//
//import Foundation
//import ARKit
//import SceneKit
//
//struct TexturedFace: VirtualContentController {
//    let textureImages: [UIImage] = [#imageLiteral(resourceName: "MLB"), #imageLiteral(resourceName: "LogoApp"), #imageLiteral(resourceName: "MLD"), #imageLiteral(resourceName: "MLA")]
//    let index: Int
//
//    mutating func makeContentNode() -> SCNNode? {
//#if targetEnvironment(simulator)
//#error("ARKit is not supported in iOS Simulator. Connect a physical iOS device and select it as your Xcode run destination, or select Generic iOS Device as a build-only destination.")
//#else
//        let faceGeometry = ARSCNFaceGeometry(device: MTLCreateSystemDefaultDevice()!)!
//        let material = faceGeometry.firstMaterial!
//
//        if index < textureImages.count {
//            material.diffuse.contents = textureImages[index]
//        } else {
//            material.diffuse.contents = #imageLiteral(resourceName: "videoTexture")
//        }
//        material.lightingModel = .physicallyBased
//
//        contentNode = SCNNode(geometry: faceGeometry)
//        return contentNode
//#endif
//    }
//
//    func updateNode(_ node: SCNNode, for anchor: ARAnchor) {
//        guard let faceGeometry = node.geometry as? ARSCNFaceGeometry,
//              let faceAnchor = anchor as? ARFaceAnchor
//        else {return}
//
//        faceGeometry.update(from: faceAnchor.geometry)
//    }
//
////    var contentNode: SCNNode?
////    let textureImages: [UIImage] = [#imageLiteral(resourceName: "MLB"), #imageLiteral(resourceName: "LogoApp"), #imageLiteral(resourceName: "MLD"), #imageLiteral(resourceName: "MLA")]
////    let index: Int
//
//    init(index: Int) {
//        self.index = index
//    }
//
////    mutating func makeContentNode() -> SCNNode? {
////#if targetEnvironment(simulator)
////#error("ARKit is not supported in iOS Simulator. Connect a physical iOS device and select it as your Xcode run destination, or select Generic iOS Device as a build-only destination.")
////#else
////        let faceGeometry = ARSCNFaceGeometry(device: MTLCreateSystemDefaultDevice()!)!
////        let material = faceGeometry.firstMaterial!
////
////        if index < textureImages.count {
////            material.diffuse.contents = textureImages[index]
////        } else {
////            material.diffuse.contents = #imageLiteral(resourceName: "videoTexture")
////        }
////        material.lightingModel = .physicallyBased
////
////        contentNode = SCNNode(geometry: faceGeometry)
////        return contentNode
////#endif
////    }
//
//    func updateNode(_ node: SCNNode, for anchor: ARFaceAnchor) {
//        guard let faceGeometry = node.geometry as? ARSCNFaceGeometry else { return }
//        faceGeometry.update(from: anchor.geometry)
//    }
//
//    mutating func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
//            guard anchor is ARFaceAnchor else { return nil }
//
//            let faceGeometry = ARSCNFaceGeometry(device: MTLCreateSystemDefaultDevice()!)!
//            let material = faceGeometry.firstMaterial!
//
//            if index < textureImages.count {
//                material.diffuse.contents = textureImages[index]
//            } else {
//                material.diffuse.contents = #imageLiteral(resourceName: "videoTexture")
//            }
//            material.lightingModel = .physicallyBased
//
//            contentNode = SCNNode(geometry: faceGeometry)
//            return contentNode
//        }
//
//        func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
//            guard let faceGeometry = node.geometry as? ARSCNFaceGeometry,
//                  let faceAnchor = anchor as? ARFaceAnchor
//            else { return }
//
//            faceGeometry.update(from: faceAnchor.geometry)
//        }
//}
//
//extension TexturedFace: ARSessionDelegate {
//    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
//        guard let faceAnchor = anchors.first(where: { $0 is ARFaceAnchor }) as? ARFaceAnchor else { return }
//
//        // Perform updates to the face geometry based on the face anchor data.
//        // Update the material of the face geometry based on the `index` and `textureImages`.
//        // Example:
//        // let material = faceGeometry.firstMaterial!
//        // material.diffuse.contents = textureImages[index]
//    }
//}
