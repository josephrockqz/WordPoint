//
//  ARView.swift
//  WordPoint
//
//  Created by Joseph Rock on 12/11/22.
//

//import ARKit
import RealityKit
import SwiftUI
//import FocusEntity

struct ARDisplayView : View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    // MARK: Properties
    
    // this will have to be dynamic based on stored value
//    private var planePreference = PlanePreference.vertical
    
    // MARK: UIView Functions
    
    func makeUIView(context: Context) -> ARView {
        
        return DataModel.shared.arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
//    func makeCoordinator() -> Coordinator {
//        Coordinator()
//    }
//
//    class Coordinator: NSObject, ARSessionDelegate {
//        weak var view: ARView?
//        var focusEntity: FocusEntity?
//
//        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
//            guard let view = self.view else { return }
////            debugPrint("Anchors added to the scene: ", anchors)
//            self.focusEntity = FocusEntity(on: view, style: .classic(color: .yellow))
//        }
//
//        @objc func handleTap() {
//            guard let view = self.view, let focusEntity = self.focusEntity else { return }
//
//            // Create a new anchor to add content to
//            let anchor = AnchorEntity()
//
//            view.scene.anchors.append(anchor)
//
//            // Add a dice entity
//            let diceEntity = try! ModelEntity.loadModel(named: "Dice")
//            diceEntity.scale = [0.1, 0.1, 0.1]
//            diceEntity.position = focusEntity.position
//            let size = diceEntity.visualBounds(relativeTo: diceEntity).extents
//            let boxShape = ShapeResource.generateBox(size: size)
//            diceEntity.collision = CollisionComponent(shapes: [boxShape])
//            diceEntity.physicsBody = PhysicsBodyComponent(
//                massProperties: .init(shape: boxShape, mass: 50),
//                material: nil,
//                mode: .dynamic
//            )
//            anchor.addChild(diceEntity)
//
//            // Create a plane below the dice
//            let planeMesh = MeshResource.generatePlane(width: 2, depth: 2)
//            let material = SimpleMaterial(color: .init(white: 1.0, alpha: 0.1), isMetallic: false)
//            let planeEntity = ModelEntity(mesh: planeMesh, materials: [material])
//            planeEntity.position = focusEntity.position
//            planeEntity.physicsBody = PhysicsBodyComponent(massProperties: .default, material: nil, mode: .static)
//            planeEntity.collision = CollisionComponent(shapes: [.generateBox(width: 2, height: 0.001, depth: 2)])
//            planeEntity.position = focusEntity.position
//            anchor.addChild(planeEntity)
//
//            diceEntity.addForce([0, 2, 0], relativeTo: nil)
//            diceEntity.addTorque([Float.random(in: 0 ... 0.4), Float.random(in: 0 ... 0.4), Float.random(in: 0 ... 0.4)], relativeTo: nil)
//        }
//    }
    
}

#if DEBUG
struct ARDisplayView_Previews : PreviewProvider {
    static var previews: some View {
        ARDisplayView()
    }
}
#endif
