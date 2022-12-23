//
//  ARView.swift
//  WordPoint
//
//  Created by Joseph Rock on 12/11/22.
//

import RealityKit
import SwiftUI

struct ARDisplayView : View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    // MARK: UIView Functions
    
    func makeUIView(context: Context) -> ARView {
        
        return DataModel.shared.arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ARDisplayView_Previews : PreviewProvider {
    static var previews: some View {
        ARDisplayView()
    }
}
#endif
