//
//  ARUIView.swift
//  WordPoint
//
//  Created by Joseph Rock on 12/21/22.
//

import SwiftUI

struct ARUIView: View {
    
    @EnvironmentObject var data: DataModel
    
    var body: some View {
        List {
            Toggle(isOn: $data.enableAR) {
                Text("AR")
            }
            Text("Blahahaha")
            Text("gratatata")
        }
        .frame(width: CGFloat(150))
    }
}

struct ARView_Previews: PreviewProvider {
    static var previews: some View {
        ARUIView()
            .environmentObject(DataModel.shared)
    }
}
