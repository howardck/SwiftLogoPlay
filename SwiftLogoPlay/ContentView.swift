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
        
//        print("LineOnlyModel.updateBounds(): " +
//            "\n   oldBounds: {\(self.bounds)} " +
//            "\n   newBounds: {\(newBounds)}")
        
        let scaleX = newBounds.width/self.bounds.width
        let scaleY = newBounds.height/self.bounds.height
        let scale = min(scaleX, scaleY)
        
        self.points = points.map {
            $0.applying(CGAffineTransform(scaleX: scale, y: scale))
        }
    }
}

struct LogosStack : View {
    
    @ObservedObject var model: LinesOnlyModel
        = LinesOnlyModel(source: SourceLogo.sourceBezier)
    
    init(size: CGSize) {
        print("LogosStack.init() -------------------------------------")
        model.updateBounds(newBounds: CGRect(origin: .zero, size: size))
    }
    
    var body: some View {
        ZStack {
            SourceLogo()
                .fill(Color.orange)
            SourceLogo()
                .stroke(Color.black, lineWidth: 0.4)
            LineOnlyLogo(model: model)
                .fill(Color.init(white: 0.75))
            LineOnlyLogo(model: model, bezierType: .lineSegments)
                .stroke(Color.black, lineWidth: 1)
            LineOnlyLogo(model: model, bezierType: .markers, radius: 5)
                .fill(Color.red)
        }
        .background(Color.init(white: 0.9))
        .onTapGesture {
            print("TAPPED!")
            
            self.model.points.removeAll(keepingCapacity: false)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
