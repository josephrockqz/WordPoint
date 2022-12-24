//
//  CustomLaser.swift
//  WordPoint
//
//  Created by Joseph Rock on 12/23/22.
//

import RealityKit
import SwiftUI

class CustomSphere: Entity, HasModel, HasAnchoring, HasPhysicsBody, HasCollision, HasPhysicsMotion {
    
    required init() {
        super.init()
        
        self.components[ModelComponent.self] = ModelComponent(
            mesh: .generateSphere(radius: 0.2),
            materials: [
                SimpleMaterial(
                    color: .red,
                    isMetallic: false
                )
            ]
        )
        self.components[PhysicsBodyComponent.self] = PhysicsBodyComponent(
            shapes: [.generateBox(width: 0.01, height: 0.01, depth: 2)], density: 0.01
        )
        self.components[CollisionComponent.self] = CollisionComponent(
            shapes: [.generateBox(width: 0.01, height: 0.01, depth: 2)]
        )
        self.components[PhysicsMotionComponent.self] = PhysicsMotionComponent(
            linearVelocity: [0, 0, -10]
        )
        
        self.transform.translation = [0, 0, 0.5]
    }
    
}
