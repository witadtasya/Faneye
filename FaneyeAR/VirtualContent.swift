//
//  VirtualContent.swift
//  FaneyeAR
//
//  Created by Wita Dewisari Tasya on 23/05/23.
//

import ARKit
import SceneKit

enum VirtualContentType: Int {
    case texture1, texture2, texture3, texture4
    
    func makeController() -> VirtualContentController {
        switch self {
        case .texture1:
            return TexturedFace(index: 0)
        case .texture2:
            return TexturedFace(index: 1)
        case .texture3:
            return TexturedFace(index: 2)
        case .texture4:
            return TexturedFace(index: 3)
        }
    }
}

/// For forwarding `ARSCNViewDelegate` messages to the object controlling the currently visible virtual content.
protocol VirtualContentController: ARSCNViewDelegate {
    /// The root node for the virtual content.
    var contentNode: SCNNode? { get set }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode?
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor)
}
