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
        
        GeometryReader { gr in
            LogosStack(size: gr.size)
        }
    }
}

class LinesOnlyModel: ObservableObject {
    
    @Published var points: [CGPoint]
    var bounds: CGRect
    
    init(source: UIBezierPath) {
        bounds = source.bounds
        points = Path(source.cgPath).verticesOnly()
        
        print("LinesOnlyModel.init(). bounds: {\(bounds)}")
    }
    
    func updateBounds(newBounds: CGRect) {
        
        print("LineOnlyModel.update(): " +
            "\n   oldBounds: {\(self.bounds)} " +
            "\n   newBounds: {\(newBounds)}")
        
        self.points = points.map {
            let scaleX = newBounds.width/self.bounds.width
            let y = newBounds.height/self.bounds.height
            let scale = min(scaleX, y)
            return $0.applying(CGAffineTransform(scaleX: scale, y: scale))
        }
    }
}

struct LogosStack : View {
    
    var model: LinesOnlyModel = LinesOnlyModel(source: SourceLogo.sourceBezier)
    
    init(size: CGSize) {
        model.updateBounds(newBounds: CGRect(origin: .zero, size: size))
    }
    
    var body: some View {
        ZStack {
            SourceLogo()
                .fill(Color.orange)
            LineOnlyLogo(model: model)
                .fill(Color.init(white: 0.8))
            LineOnlyLogo(model: model, bezierType: .lineSegments)
                .stroke(Color.black, lineWidth: 1)
            LineOnlyLogo(model: model, bezierType: .markers, radius: 5)
                .fill(Color.red)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
