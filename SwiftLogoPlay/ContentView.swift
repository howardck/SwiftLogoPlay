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
    
    var sourceBounds: CGRect
    
    init(source: UIBezierPath) {
        sourceBounds = source.bounds
        points = Path(source.cgPath).verticesOnly()
        
        print("LinesOnlyModel.init(). sourceBounds: {\(sourceBounds)}")
    }
    
    // we've now determined our actual playing field;
    // update our points array to match
    func updateBounds(newBounds: CGRect) {
        
//        print("LineOnlyModel.updateBounds(): " +
//            "\n   oldBounds: {\(self.bounds)} " +
//            "\n   newBounds: {\(newBounds)}")
        
        let scaleX = newBounds.width/self.sourceBounds.width
        let scaleY = newBounds.height/self.sourceBounds.height
        let scale = min(scaleX, scaleY)
        
        self.points = self.points.map {
            $0.applying(CGAffineTransform(scaleX: scale, y: scale))
        }
    }
    
    func advanceVerticesToNextPosition() {
        print("Model.advanceVerticesToNextPosition()")
        let firstPt = points.first!
        for index in 0..<points.count - 1 {
            points[index] = points[index + 1]
        }
        points[points.count - 1] = firstPt
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
