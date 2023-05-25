/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Main view controller for the AR experience.
*/

import ARKit
import SceneKit
import UIKit
import Foundation

struct TextureData {
    let title: String
    let desc: String
}

class ViewController: UIViewController, ARSessionDelegate {
    
    // MARK: Outlets

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var texture1ImageView: UIImageView!
    @IBOutlet weak var texture2ImageView: UIImageView!
    @IBOutlet weak var texture3ImageView: UIImageView!
    @IBOutlet weak var texture4ImageView: UIImageView!
    
    let textures: [TextureData] = [
        TextureData(title: "Korean Look", desc: "Focus on a youthful natural appearance with a glowing complexion, straight brows, gradient lips, and soft, shimmery eye makeup."),
        TextureData(title: "American Look", desc: "Emphasize a flawless, airbrushed complexion, defined eyes with eyeliner and mascara, sculpted cheekbones, and a bold lip color. "),
        TextureData(title: "Professional Look", desc: "Use more polished and sophisticated approach, with well-defined brows, a subtle smoky eye, and a neutral lip color."),
        TextureData(title: "Minimalist Look", desc: "Opting for a minimalistic approach with light coverage foundation, a touch of mascara, and a natural lip color, for a fresh and effortless look.")
    ]
    
    @IBOutlet weak var titleLabel: UILabel!
    var activeIndex: Int = 0
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var blueButton: UIButton!
    @IBAction func changeFilter(_ sender: UIButton) {
        
    }

    var faceAnchorsAndContentControllers: [ARFaceAnchor: VirtualContentController] = [:]
    
    var selectedVirtualContent: VirtualContentType! {
        didSet {
            guard oldValue != nil, oldValue != selectedVirtualContent
                else { return }
            
            // Remove existing content when switching types.
            for contentController in faceAnchorsAndContentControllers.values {
                contentController.contentNode?.removeFromParentNode()
            }
            
            // If there are anchors already (switching content), create new controllers and generate updated content.
            // Otherwise, the content controller will place it in `renderer(_:didAdd:for:)`.
            for anchor in faceAnchorsAndContentControllers.keys {
                let contentController = selectedVirtualContent.makeController()
                if let node = sceneView.node(for: anchor),
                let contentNode = contentController.renderer(sceneView, nodeFor: anchor) {
                    node.addChildNode(contentNode)
                    faceAnchorsAndContentControllers[anchor] = contentController
                }
            }
            updateLabel()
        }
    }
    
    // MARK: - View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.session.delegate = self
        sceneView.automaticallyUpdatesLighting = true
        
        // Set the initial face content.
        selectedVirtualContent = VirtualContentType(rawValue: activeIndex)
        setupTextureImageView()
        updateLabel()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // AR experiences typically involve moving the device without
        // touch input for some time, so prevent auto screen dimming.
        UIApplication.shared.isIdleTimerDisabled = true
        
        // "Reset" to run the AR session for the first time.
        resetTracking()
    }
    
    func setupTextureImageView() {
        texture1ImageView.isUserInteractionEnabled = true
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(textureImage1DidTapped))
        texture1ImageView.addGestureRecognizer(tapGesture1)
        
        texture2ImageView.isUserInteractionEnabled = true
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(textureImage2DidTapped))
        texture2ImageView.addGestureRecognizer(tapGesture2)
        
        texture3ImageView.isUserInteractionEnabled = true
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(textureImage3DidTapped))
        texture3ImageView.addGestureRecognizer(tapGesture3)
        
        texture4ImageView.isUserInteractionEnabled = true
        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(textureImage4DidTapped))
        texture4ImageView.addGestureRecognizer(tapGesture4)
    }
    
    @objc func textureImage1DidTapped() {
        activeIndex = 0
        guard let contentType = VirtualContentType(rawValue: activeIndex)
            else { fatalError("unexpected virtual content tag") }
        selectedVirtualContent = contentType
    }
    @objc func textureImage2DidTapped() {
        activeIndex = 1
        guard let contentType = VirtualContentType(rawValue: activeIndex)
            else { fatalError("unexpected virtual content tag") }
        selectedVirtualContent = contentType
    }
    @objc func textureImage3DidTapped() {
        activeIndex = 2
        guard let contentType = VirtualContentType(rawValue: activeIndex)
            else { fatalError("unexpected virtual content tag") }
        selectedVirtualContent = contentType
    }
    @objc func textureImage4DidTapped() {
        activeIndex = 3
        guard let contentType = VirtualContentType(rawValue: activeIndex)
            else { fatalError("unexpected virtual content tag") }
        selectedVirtualContent = contentType
    }
    
    func updateLabel() {
         titleLabel.text = textures[activeIndex].title
         descLabel.text = textures[activeIndex].desc
    }
    // MARK: - ARSessionDelegate

    func session(_ session: ARSession, didFailWithError error: Error) {
        guard error is ARError else { return }
        
        let errorWithInfo = error as NSError
        let messages = [
            errorWithInfo.localizedDescription,
            errorWithInfo.localizedFailureReason,
            errorWithInfo.localizedRecoverySuggestion
        ]
        let errorMessage = messages.compactMap({ $0 }).joined(separator: "\n")
        
        DispatchQueue.main.async {
            self.displayErrorMessage(title: "The AR session failed.", message: errorMessage)
        }
    }
    
    /// - Tag: ARFaceTrackingSetup
    func resetTracking() {
        guard ARFaceTrackingConfiguration.isSupported else { return }
        let configuration = ARFaceTrackingConfiguration()
        if #available(iOS 13.0, *) {
            configuration.maximumNumberOfTrackedFaces = ARFaceTrackingConfiguration.supportedNumberOfTrackedFaces
        }
        configuration.isLightEstimationEnabled = true
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
        faceAnchorsAndContentControllers.removeAll()
    }
    
    // MARK: - Error handling
    
    
    func displayErrorMessage(title: String, message: String) {
        // Present an alert informing about the error that has occurred.
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Restart Session", style: .default) { _ in
            alertController.dismiss(animated: true, completion: nil)
            self.resetTracking()
        }
        alertController.addAction(restartAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // Auto-hide the home indicator to maximize immersion in AR experiences.
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    // Hide the status bar to maximize immersion in AR experiences.
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension ViewController: ARSCNViewDelegate {
        
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor else { return }
        
        // If this is the first time with this anchor, get the controller to create content.
        // Otherwise (switching content), will change content when setting `selectedVirtualContent`.
        DispatchQueue.main.async {
            let contentController = self.selectedVirtualContent.makeController()
            if node.childNodes.isEmpty, let contentNode = contentController.renderer(renderer, nodeFor: faceAnchor) {
                node.addChildNode(contentNode)
                self.faceAnchorsAndContentControllers[faceAnchor] = contentController
            }
        }
    }
    
    /// - Tag: ARFaceGeometryUpdate
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor,
            let contentController = faceAnchorsAndContentControllers[faceAnchor],
            let contentNode = contentController.contentNode else {
            return
        }
        
        contentController.renderer(renderer, didUpdate: contentNode, for: anchor)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor else { return }
        
        faceAnchorsAndContentControllers[faceAnchor] = nil
    }
}

