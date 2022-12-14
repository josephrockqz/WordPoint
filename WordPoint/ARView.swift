//
//  ARView.swift
//  WordPoint
//
//  Created by Joseph Rock on 12/11/22.
//

import ARKit
import RealityKit
import SwiftUI
import FocusEntity

struct ARViewContainer: UIViewRepresentable {
    
    // MARK: Properties
    
    // this will have to be dynamic based on stored value
    private var planePreference = PlanePreference.horizontal
    
    // MARK: UIView Functions
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
//        arView.automaticallyConfigureSession = false
        
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
//        config.environmentTexture = .automatic
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
//        arView.debugOptions = [.showFeaturePoints, .showAnchorOrigins, .showAnchorGeometry, .showPhysics]
        #endif
        
        // Load the "Laser" scene from the "Experience" Reality File
        let laserAnchor = try! Experience.loadLaser()
        // Add the laser anchor to the scene
        arView.scene.anchors.append(laserAnchor)
        
        // Handle ARSession events via delegate
        context.coordinator.view = arView
        session.delegate = context.coordinator
        
        // Handle taps
        arView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: context.coordinator,
                action: #selector(Coordinator.handleTap)
            )
        )
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, ARSessionDelegate {
        weak var view: ARView?
        var focusEntity: FocusEntity?

        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard let view = self.view else { return }
//            debugPrint("Anchors added to the scene: ", anchors)
            self.focusEntity = FocusEntity(on: view, style: .classic(color: .yellow))
        }
        
        @objc func handleTap() {
            guard let view = self.view, let focusEntity = self.focusEntity else { return }

            // Create a new anchor to add content to
            let anchor = AnchorEntity()

            view.scene.anchors.append(anchor)

            // Add a dice entity
            let diceEntity = try! ModelEntity.loadModel(named: "Dice")
            diceEntity.scale = [0.1, 0.1, 0.1]
            diceEntity.position = focusEntity.position
            let size = diceEntity.visualBounds(relativeTo: diceEntity).extents
            let boxShape = ShapeResource.generateBox(size: size)
            diceEntity.collision = CollisionComponent(shapes: [boxShape])
            diceEntity.physicsBody = PhysicsBodyComponent(
                massProperties: .init(shape: boxShape, mass: 50),
                material: nil,
                mode: .dynamic
            )
            anchor.addChild(diceEntity)
            
            // Create a plane below the dice
            let planeMesh = MeshResource.generatePlane(width: 2, depth: 2)
            let material = SimpleMaterial(color: .init(white: 1.0, alpha: 0.1), isMetallic: false)
            let planeEntity = ModelEntity(mesh: planeMesh, materials: [material])
            planeEntity.position = focusEntity.position
            planeEntity.physicsBody = PhysicsBodyComponent(massProperties: .default, material: nil, mode: .static)
            planeEntity.collision = CollisionComponent(shapes: [.generateBox(width: 2, height: 0.001, depth: 2)])
            planeEntity.position = focusEntity.position
            anchor.addChild(planeEntity)
            
            diceEntity.addForce([0, 2, 0], relativeTo: nil)
            diceEntity.addTorque([Float.random(in: 0 ... 0.4), Float.random(in: 0 ... 0.4), Float.random(in: 0 ... 0.4)], relativeTo: nil)
        }
    }
    
}
