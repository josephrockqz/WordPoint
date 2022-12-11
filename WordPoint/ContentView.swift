//
//  ContentView.swift
//  WordPoint
//
//  Created by Joseph Rock on 12/11/22.
//

import SwiftUI

struct ContentView : View {
    @State var page = "Home"
    
    var body: some View {
        VStack {
            if page == "Home" {
                Button("Play Game") {
                    self.page = "ARView"
                }
            } else if page == "ARView" {
                ARViewContainer().edgesIgnoringSafeArea(.all)
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
