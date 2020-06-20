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

struct LogosStack : View {
    
    @ObservedObject var model: LinesOnlyModel
        = LinesOnlyModel(source: SourceLogo.sourceBezier)
    
    init(size: CGSize) {
        model.updateBounds(newBounds: CGRect(origin: .zero, size: size))
    }
    
    var body: some View {
        ZStack {
            
            SourceLogo()
                .fill(Color.orange)
            SourceLogo()
                .stroke(Color.black, lineWidth: 0.4)
            
            LinesOnlyLogo(model: model)
                .fill(Color.init(white: 0.75))
            LinesOnlyLogo(model: model, bezierType: .lineSegments)
                .stroke(Color.black, lineWidth: 1)
            LinesOnlyLogo(model: model, bezierType: .markers, radius: 5)
                .fill(Color.red)
        }
        .background(Color.init(white: 0.9))
        .onTapGesture {
            print("TAPPED!")
            
            self.model.points.removeAll(keepingCapacity: false)
            
        }
    }
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
