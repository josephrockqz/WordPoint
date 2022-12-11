//
//  ARView.swift
//  WordPoint
//
//  Created by Joseph Rock on 12/11/22.
//

import ARKit
import RealityKit
import SwiftUI

struct ARViewContainer: UIViewRepresentable {
    
    // MARK: Properties
    
    // this will have to be dynamic based on stored value
    private var planePreference = PlanePreference.horizontal
    
    // MARK: UIView Functions
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Start AR session
        let session = arView.session
        let config = ARWorldTrackingConfiguration()
        switch planePreference {
        case .horizontal:
            config.planeDetection = [.horizontal]
        case .vertical:
            config.planeDetection = [.vertical]
        case .horizontalAndVertical:
            config.planeDetection = [.horizontal, .vertical]
        }
        session.run(config)

        // Add coaching overlay
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = session
        switch planePreference {
        case .horizontal:
            coachingOverlay.goal = .horizontalPlane
        case .vertical:
            coachingOverlay.goal = .verticalPlane
        case .horizontalAndVertical:
            coachingOverlay.goal = .anyPlane
        }
        arView.addSubview(coachingOverlay)

        // Set debug options
        #if DEBUG
        arView.debugOptions = [.showFeaturePoints, .showAnchorOrigins, .showAnchorGeometry]
        #endif
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()

        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}
