//
//  LinesOnlyLogo.swift
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

struct LinesOnlyLogo : Shape {
    var model : LinesOnlyModel
    
    var bezierType : BezierType = .lineSegments
    //var vertices: [CGPoint]
    var radius : CGFloat = 5  // iff type == .markers; kludgy?

    func path(in rect: CGRect) -> Path {
        
        return Path { path in
            for (ix, pt) in model.points.enumerated() {
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
        LinesOnlyLogo(model: LinesOnlyModel(source: SourceLogo.sourceBezier))
            .fill(Color.init(white: 0.7))
    }
}
