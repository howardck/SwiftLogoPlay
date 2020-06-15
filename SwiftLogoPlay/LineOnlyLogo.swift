//
//  LineOnlyLogo.swift
//  SwiftLogoPlay
//
//  Created by Howard Katz on 2020-06-15.
//  Copyright © 2020 Howard Katz. All rights reserved.
//

import SwiftUI

enum BezierType {
    case markers
    case lineSegments
}

struct LineOnlyLogo : Shape {
    
    var bezierType : BezierType
    //var vertices: [CGPoint]
    var radius : CGFloat   // iff type == .markers; kludgy?

    init(bezierType: BezierType = .lineSegments,
         //vertices: [CGPoint],
         radius: CGFloat = 5) {
        
        self.bezierType = bezierType
        //self.vertices = vertices
        self.radius = radius
    }
    
    func path(in rect: CGRect) -> Path {

        let points = SourceLogo().path(in: rect).verticesOnly()
        
        return Path { path in
            for (ix, pt) in points.enumerated() {
                switch(bezierType) {
                case .lineSegments :
                    ix == 0 ?
                        path.move(to: pt) :
                        path.addLine(to: pt)
                case .markers :
                    path.move(to: pt)
                    path.addMarker(radius: radius)
                }
            }
        }
    }
}

struct LineOnlyLogo_Previews: PreviewProvider {
    static var previews: some View {
        LineOnlyLogo()
    }
}
