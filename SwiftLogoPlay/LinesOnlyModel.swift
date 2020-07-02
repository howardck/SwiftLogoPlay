//
//  LinesOnlyModel.swift
//  SwiftLogoPlay
//
//  Created by Howard Katz on 2020-07-01.
//  Copyright © 2020 Howard Katz. All rights reserved.
//

import SwiftUI

class LinesOnlyModel: ObservableObject {
    
    init(source: UIBezierPath) {
        self.source = source
        vector = CGPointVector(values: Path(source.cgPath).verticesOnly())
    }
    
    var source: UIBezierPath
    @Published var vector : CGPointVector
//
//    let source : UIBezierPath
//    init(source: UIBezierPath) {
//        self.source = source
//        vector = CGPointVector(values: Path(source.cgPath).verticesOnly())
//        print("")
//    }
    
    func updateBounds(newBounds: CGRect) {
        
        print("LineOnlyModel.updateBounds(): " +
            "\n   oldBounds: {\(source.bounds)} " +
            "\n   newBounds: {\(newBounds)}")
        
        let scaleX = newBounds.width/source.bounds.width
        let scaleY = newBounds.height/source.bounds.height
        let scale = min(scaleX, scaleY)
        
        let points = vector.values.map {
            $0.applying(CGAffineTransform(scaleX: scale, y: scale))
        }
        self.vector = CGPointVector(values: points)
    }
    
    func movePointsInward(by delta: CGFloat) {
        print("Model.movePointsInward(). vector BEFORE:")

        var points = [CGPoint]()
        for i in 0..<vector.values.count {
            var pt = vector.values[i]
            switch (i) {
            case 0:
                pt.x += delta
                pt.y += delta
            case 1:
                pt.x -= delta
                pt.y += delta
            case 2:
                pt.x -= delta
                pt.y -= delta
            case 3:
                pt.x += delta
                pt.y -= delta
            default :
                pt.x = 0
            }
            points.append(pt)
        }
        self.vector = CGPointVector(values: points)
        print("(Model.movePointsInward(). vector AFTER:")
        print("")
    }
    
    func advanceVerticesToNextPosition() {
        print("Model.advanceVerticesToNextPosition(). vector BEFORE:")
        print("\(self.vector.values)")
        
        //self.vector = CGPointVector(count: vector.values.count )
        
        var points = self.vector.values
        let firstPt = points.first!
        for index in 0..<points.count - 1 {
            points[index] = points[index + 1]
        }
        points[points.count - 1] = firstPt
        
        print("Model.advanceVerticesToNextPosition(). vector AFTER:")
        print("\(points)")
        
        self.vector = CGPointVector(values: points)
    }
}
