//
//  CustomLaser.swift
//  WordPoint
//
//  Created by Joseph Rock on 12/23/22.
//

import RealityKit
import SwiftUI

class CustomLaser: Entity, HasModel, HasAnchoring, HasPhysicsBody, HasCollision, HasPhysicsMotion {
    
    required init() {
        super.init()
        self.components[ModelComponent.self] = ModelComponent(
            mesh: .generateBox(width: 0.01, height: 0.01, depth: 2, cornerRadius: 0.04),
            materials: [
                SimpleMaterial(
                    color: .red,
                    isMetallic: false
                )
            ]
        )
        self.components[PhysicsBodyComponent.self] = PhysicsBodyComponent(
            shapes: [.generateBox(width: 0.01, height: 0.01, depth: 2)], density: 1
        )
        self.components[CollisionComponent.self] = CollisionComponent(
            shapes: [.generateBox(width: 0.01, height: 0.01, depth: 2)]
        )
        self.components[PhysicsMotionComponent.self] = PhysicsMotionComponent(
            linearVelocity: [0, 0, -10]
        )
    }
    
}
