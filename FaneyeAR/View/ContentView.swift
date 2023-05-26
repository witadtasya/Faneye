//
//  ContentView.swift
//  FaneyeAR
//
//  Created by Wita Dewisari Tasya on 22/05/23.
//

import SwiftUI
import RealityKit
import ARKit

// For Snapshot
var arView: ARView!

// UI and Functions
struct ContentView : View {
    @State private var isHelpButtonTapped = false
    @State private var activeIndex: Int = 0 // Chat GPT
    
    // Take Snapshot
    func TakeSnapshot() {
        arView.snapshot(saveToHDR: false) { (image) in
            // 2
            let compressedlmage = UIImage(
                data: (image?.pngData())!)
            // 3
            UIImageWriteToSavedPhotosAlbum(compressedlmage!, nil, nil, nil)
        }
    }
    
    
    // UI AR
    var body: some View {
        VStack{
            ZStack {
                // Call AR View Container
                ARViewContainer().edgesIgnoringSafeArea(.all)
                
                // Help Button
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            isHelpButtonTapped = true
                        }) {
                            Image(systemName: "questionmark.circle")
                                .font(.system(size: 32))
                                .foregroundColor(.white)
                                .padding()
                        }
                        .padding(16)
                        .offset(x: -12, y: -12)
                        .sheet(isPresented: $isHelpButtonTapped, onDismiss: {
                            // Code to run when the sheet is dismissed
                        }) {
                            PopUpView(isHelpButtonTapped: $isHelpButtonTapped)
                                .background(Color.clear) // Customize the sheet appearance
                                .ignoresSafeArea() // Ignore safe area edges if desired
                        }
                    }
                    Spacer()
                    Button(action: { self.TakeSnapshot()
                    }) {
                        Image(systemName: "circle.inset.filled")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                            .padding()
                    }
                }
            }
            
        }
    }
}


// AR Function
struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        arView = ARView(frame: .zero)
        
        // Set the AR configuration to use the front camera
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        arView.session.run(configuration)
        
        // Call AR function
        
        
        // Ini dari kode bawaan
        // Load the "Box" scene from the "Experience" Reality File
         let boxAnchor = try! Experience.loadBox()
        // Add the box anchor to the scene
         arView.scene.anchors.append(boxAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

class ARViewModel: NSObject, ObservableObject, ARSessionDelegate {
    @Published var faceAnchorsAndContentControllers: [ARFaceAnchor: VirtualContentController] = [:]
    private let arSession = ARSession()
    
    override init() {
        super.init()
        arSession.delegate = self
    }
}


#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
