//
//  ContentView.swift
//  WordPoint
//
//  Created by Joseph Rock on 12/11/22.
//

import SwiftUI

struct ContentView : View {
    
    @EnvironmentObject var data: DataModel
    
    var body: some View {
        VStack {
//            ARUIViewTop()
            if data.enableAR {
                ARDisplayView()
            }
            else {
                Spacer()
            }
            ARUIViewBottom()
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataModel.shared)
    }
}
#endif
