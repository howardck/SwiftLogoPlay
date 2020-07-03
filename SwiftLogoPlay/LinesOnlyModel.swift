//
//  LinesOnlyModel.swift
//  SwiftLogoPlay
//
//  Created by Howard Katz on 2020-07-01.
//  Copyright © 2020 Howard Katz. All rights reserved.
//

import SwiftUI

class LinesOnlyModel: ObservableObject {
    
    @Published var vector : CGPointVector
    static let DEBUG = true
    
    init(source: UIBezierPath) {
        self.source = source
        // pass this in when we don't want animation
        initialVector = CGPointVector(values: Path(source.cgPath).verticesOnly())
        vector = CGPointVector(values: Path(source.cgPath).verticesOnly())
    }
    
    var source: UIBezierPath
    var initialVector : CGPointVector
    
    func scaleVectors(to size: CGSize) {
        
        if LinesOnlyModel.DEBUG {
            print("LineOnlyModel.updateBounds(): " +
                "\n   oldBounds: {\(source.bounds)} " +
                "\n   newBounds: {\(size)}")
        }
        
        let scaleX = size.width/source.bounds.width
        let scaleY = size.height/source.bounds.height
        let scale = min(scaleX, scaleY)
        
        let points = vector.values.map {
            $0.applying(CGAffineTransform(scaleX: scale, y: scale))
        }
        self.vector = CGPointVector(values: points)
        self.initialVector = CGPointVector(values: points)
    }
    
    func advanceVerticesToNextPosition() {
        
        let first = vector.values.removeFirst()
        vector.values.append(first)
    }
}
