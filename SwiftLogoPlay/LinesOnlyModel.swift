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

        initialVector = CGPointVector(values: Path(source.cgPath).verticesOnly())
        vector = initialVector
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

struct LinesOnlyLogo : Shape {
    
    var vector: CGPointVector
    //MARK: TODO: make an enum with .markers(let radius)
    //MARK: TODO: and radius is hardwired platform-dependent
    var bezierType : BezierType = .lineSegments
    var radius : CGFloat = 5
    
    var animatableData: CGPointVector {
        get { vector }
        set { vector = newValue }
    }

    func path(in rect: CGRect) -> Path {
        
        return Path { path in
            for (ix, pt) in vector.values.enumerated() {
                switch(bezierType) {
                case .lineSegments :
                    ix == 0 ?
                        path.move(to: pt) :
                        path.addLine(to: pt)
                case .all_markers :
                    path.move(to: pt)
                    path.addMarker(radius: radius)
                case .even_numbered_markers :
                    path.move(to: pt)
                    if ix.isEven() {
                        path.addMarker(radius: radius)
                    }
                case .odd_numbered_markers :
                    path.move(to: pt)
                    if !ix.isEven() {
                        path.addMarker(radius: radius)
                    }
                }
            }
            path.closeSubpath()
        }
    }
}
