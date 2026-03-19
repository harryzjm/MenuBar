//
//  ContentView.swift
//  MenuBar
//
//  Created by Hares on 19/03/2026.
//

import SwiftUI

struct ContentView: View {
    let loader = Loader()

    var body: some View {
        VStack {
            Text("Loading…")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 150, height: 40))
    }
}

