//
//  DataModel.swift
//  WordPoint
//
//  Created by Joseph Rock on 12/21/22.
//

import ARKit
import RealityKit
import SwiftUI

// MARK: Local Constants

/**
 * This implementation may have to be thought out more
 * Need  to account for users changing this setting and having to store
 * their choice for later sessions
 */
var planePreference = PlanePreference.vertical
var automaticCoachingOverlay = true

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
//        arView.addDebugOptions()
        
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
    
    func fireLaser() {
        print("hey")
        
        let xRandom = Float.random(in: -3.0...0)
        let yRandom = Float.random(in: -3.0...0)
        let zRandom = Float.random(in: -3.0...0)
        let box = CustomLaser(color: .yellow, position: [xRandom, yRandom, zRandom])
        arView.scene.anchors.append(box)
        
        let laserAnchor = try! Experience.loadLaser()
        arView.scene.anchors.append(laserAnchor)
    }
}

extension ARView: ARCoachingOverlayViewDelegate {
    
    // Add coaching overlay
    func addCoaching() {
        let coachingOverlay = ARCoachingOverlayView()
        // if user has coaching overlay turned off in settings, then skip
        coachingOverlay.activatesAutomatically = automaticCoachingOverlay
        if (coachingOverlay.activatesAutomatically == false) {
            return
        }
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
    
    public func coachingOverlayViewDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        // TODO
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
