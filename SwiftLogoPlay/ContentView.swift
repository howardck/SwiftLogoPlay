//
//  ContentView.swift
//  SwiftLogoPlay
//
//  Created by Howard Katz on 2020-06-15.
//  Copyright © 2020 Howard Katz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            logoStack
            Color.blue
        }
    }
    
    private var logoStack : some View {
        ZStack {
            SourceLogo()
                .fill(Color.orange)
            LineOnlyLogo()
                .fill(Color.init(white: 0.8))
            LineOnlyLogo(bezierType: .lineSegments)
                .stroke(Color.black, lineWidth: 1)
            LineOnlyLogo(bezierType: .markers, radius: 5)
                .fill(Color.red)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
