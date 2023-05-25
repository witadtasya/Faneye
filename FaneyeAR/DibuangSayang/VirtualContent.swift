////
////  VirtualContent.swift
////  FaneyeAR
////
////  Created by Wita Dewisari Tasya on 23/05/23.
////
//
//import Foundation
//import ARKit
//import SceneKit
//
//enum VirtualContentType: Int {
//    case texture1, texture2, texture3, texture4
//    
//    func makeController() -> VirtualContentController {
//        switch self {
//        case .texture1:
//            return TexturedFace(index: 0)
//        case .texture2:
//            return TexturedFace(index: 1)
//        case .texture3:
//            return TexturedFace(index: 2)
//        case .texture4:
//            return TexturedFace(index: 3)
//        }
//    }
//}
//
//protocol VirtualContentController {
//    var contentNode: SCNNode? { get set }
//
//    func makeContentNode() -> SCNNode?
//    func updateNode(_ node: SCNNode, for anchor: ARAnchor)
//}
