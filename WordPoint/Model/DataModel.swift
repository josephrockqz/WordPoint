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
//        arView.addDebugOptions()
        arView.addCoaching()
    }
}

extension ARView {
    // fire sphere
    func fireSphere() {
        let ball = CustomSphere()
        
        let mesh = MeshResource.generateText(
                    "JAH",
                    extrusionDepth: 0.2,
                    font: .systemFont(ofSize: 2),
                    containerFrame: .zero,
                    alignment: .center,
                    lineBreakMode: .byTruncatingMiddle)
                
        let material = SimpleMaterial(color: .yellow, isMetallic: false)
        let entity = ModelEntity(mesh: mesh, materials: [material])
        entity.scale = SIMD3<Float>(0.3, 0.3, 1)
        
        ball.addChild(entity)
        
        entity.setPosition(SIMD3<Float>(-0.541, 0.05, 0), relativeTo: ball)
        
        let ballAnchor = AnchorEntity(.camera)
        ballAnchor.addChild(ball)
        self.scene.addAnchor(ballAnchor)
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
        // MARK: TODO
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
