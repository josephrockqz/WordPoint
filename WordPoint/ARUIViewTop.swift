//
//  ARUIView.swift
//  WordPoint
//
//  Created by Joseph Rock on 12/21/22.
//

import SwiftUI

struct ARUIViewTop: View {
    
    @EnvironmentObject var data: DataModel
    
    var body: some View {
        Button(action: {
            data.enableAR = !data.enableAR
        }) {
            Text("AR")
        }
        .frame(height: CGFloat(50))
    }
}

struct ARUIViewTop_Previews: PreviewProvider {
    static var previews: some View {
        ARUIViewTop()
            .environmentObject(DataModel.shared)
    }
}
