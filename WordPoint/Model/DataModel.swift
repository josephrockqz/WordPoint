//
//  DataModel.swift
//  WordPoint
//
//  Created by Joseph Rock on 12/21/22.
//

import ARKit
import RealityKit
import SwiftUI

/**
 * This implementation may have to be thought out more
 * Need  to account for users changing this setting and having to store
 * their choice for later sessions
 */
// this will have to be dynamic based on stored value
var planePreference = PlanePreference.vertical

final class DataModel: ObservableObject {
    
    static var shared = DataModel()
    @Published var arView: ARView!
    @Published var enableAR = true
    
    init() {
        
        arView = ARView(frame: .zero)
                
        let config = ARWorldTrackingConfiguration()
        config.addPlaneDetection()
        
        arView.session.run(config)
        arView.addCoaching()
        arView.addDebugOptions()
        
        // Load the "Laser" scene from the "Experience" Reality File
        let laserAnchor = try! Experience.loadLaser()
        // Add the laser anchor to the scene
        arView.scene.anchors.append(laserAnchor)
        
//        // Handle ARSession events via delegate
//        context.coordinator.view = arView
//        session.delegate = context.coordinator
//
//        // Handle taps
//        arView.addGestureRecognizer(
//            UITapGestureRecognizer(
//                target: context.coordinator,
//                action: #selector(Coordinator.handleTap)
//            )
//        )
        
    }
}

extension ARView: ARCoachingOverlayViewDelegate {
    
    // Add coaching overlay
    func addCoaching() {
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.delegate = self
        coachingOverlay.session = self.session
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        switch planePreference {
            case .horizontal:
                coachingOverlay.goal = .horizontalPlane
            case .vertical:
                coachingOverlay.goal = .verticalPlane
            case .horizontalAndVertical:
                coachingOverlay.goal = .anyPlane
        }
        self.addSubview(coachingOverlay)
    }
    
}

extension ARView {
    
    // Add debug options
    func addDebugOptions() {
        #if DEBUG
        self.debugOptions = [.showFeaturePoints, .showAnchorOrigins, .showAnchorGeometry, .showPhysics]
        #endif
    }
    
}

extension ARWorldTrackingConfiguration {
    
    // Add plane detection
    func addPlaneDetection() {
        switch planePreference {
        case .horizontal:
            self.planeDetection = [.horizontal]
        case .vertical:
            self.planeDetection = [.vertical]
        case .horizontalAndVertical:
            self.planeDetection = [.horizontal, .vertical]
        }
    }
    
}
