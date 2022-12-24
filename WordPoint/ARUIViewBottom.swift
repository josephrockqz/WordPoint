//
//  ARUIViewBottom.swift
//  WordPoint
//
//  Created by Joseph Rock on 12/23/22.
//

import SwiftUI

struct ARUIViewBottom: View {
    
    @EnvironmentObject var data: DataModel
    
    var body: some View {
        Button(action: {
            data.arView.fireSphere()
        }) {
            Text("START")
        }
        .frame(height: CGFloat(50))
    }
}

struct ARUIViewBottom_Previews: PreviewProvider {
    static var previews: some View {
        ARUIViewBottom()
            .environmentObject(DataModel.shared)
    }
}
