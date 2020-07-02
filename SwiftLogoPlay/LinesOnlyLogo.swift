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

struct LogosStackView : View {
    
    //@State vector =
    @ObservedObject var model = LinesOnlyModel(source: SourceLogo.TEST_BEZIER)
    
    
    var body: some View {
        ZStack {
            
//            SourceLogo()
//                .fill(Color.orange)
//            SourceLogo()
//                .stroke(Color.black, lineWidth: 0.4)
//
//            LinesOnlyLogo(model: model)
//                .fill(Color.init(white: 0.85))
//            LinesOnlyLogo(vector: model.vector, bezierType: .lineSegments)
//                .stroke(Color.black, lineWidth: 1)
            
            LinesOnlyLogo(vector: self.model.vector,
                          bezierType: .markers,
                          radius: 8)
                .fill(Color.red)
//                .stroke(Color.red, lineWidth: 2)
        }
        .background(Color.init(white: 0.9))
        .onTapGesture {
            print("TAP")
            
            //self.model.advanceVerticesToNextPosition()
            self.model.movePointsInward(by: 20)
        }
    }
}

struct LinesOnlyLogo : Shape {
    
    var vector: CGPointVector
    var animatableData: CGPointVector {
        get { vector }
        set { vector = newValue }
    }
    var bezierType : BezierType = .lineSegments
    var radius : CGFloat = 5  // iff type == .markers; kludgy?

    func path(in rect: CGRect) -> Path {
        print("LinesOnlyLogo.path()")

        return Path { path in
            for (ix, pt) in vector.values.enumerated() {
                switch(bezierType) {
                case .lineSegments :
                    ix == 0 ?
                        path.move(to: pt) :
                        path.addLine(to: pt)
                case .markers :
                    print("LinesOnlyLogo.path(). [\(ix)]")
                    path.move(to: pt)
                    path.addMarker(radius: radius)
                }
            }
        }
    }
}
