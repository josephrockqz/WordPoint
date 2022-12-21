//
//  DataModel.swift
//  WordPoint
//
//  Created by Joseph Rock on 12/21/22.
//

import ARKit
import RealityKit
import SwiftUI

final class DataModel: ObservableObject {
    
    static var shared = DataModel()
    @Published var arView: ARView!
    @Published var enableAR = true
    // this will have to be dynamic based on stored value
    private var planePreference = PlanePreference.vertical
    
    init() {
        
        arView = ARView(frame: .zero)
        
//        arView.automaticallyConfigureSession = false
        
//        // Start AR session
//        let session = arView.session
//        let config = ARWorldTrackingConfiguration()
//        switch planePreference {
//        case .horizontal:
//            config.planeDetection = [.horizontal]
//        case .vertical:
//            config.planeDetection = [.vertical]
//        case .horizontalAndVertical:
//            config.planeDetection = [.horizontal, .vertical]
//        }
////        config.environmentTexture = .automatic
//        session.run(config)

//        // Add coaching overlay
//        let coachingOverlay = ARCoachingOverlayView()
//        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        coachingOverlay.session = session
//        switch planePreference {
//            case .horizontal:
//                coachingOverlay.goal = .horizontalPlane
//            case .vertical:
//                coachingOverlay.goal = .verticalPlane
//            case .horizontalAndVertical:
//                coachingOverlay.goal = .anyPlane
//        }
//        arView.addSubview(coachingOverlay)

//        // Set debug options
//        #if DEBUG
//        arView.debugOptions = [.showFeaturePoints, .showAnchorOrigins, .showAnchorGeometry, .showPhysics]
//        #endif
        
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
