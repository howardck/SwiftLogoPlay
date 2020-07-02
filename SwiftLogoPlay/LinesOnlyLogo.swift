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

    //@State var vector = CGPointVector(values: Path(SourceLogo.TEST_BEZIER.cgPath).verticesOnly())
    @ObservedObject var model = LinesOnlyModel(source: SourceLogo.sourceBezier)
    
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
            
//            LinesOnlyLogo(vector: self.model.vector,
//                          bezierType: .lineSegments)
//                .fill(Color.blue)
            
            LinesOnlyLogo(vector: self.model.vector,
                          bezierType: .markers,
                          radius: 12)
                .fill(Color.black)
            //                .stroke(Color.red, lineWidth: 3)
            
            LinesOnlyLogo(vector: self.model.vector,
                          bezierType: .markers,
                          radius: 10)
                .fill(Color.orange)
            
        }
        .background(Color.init(white: 0.9))
        .onTapGesture {
            print("TAP")
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                self.model.advanceVerticesToNextPosition()
//                self.model.movePointsInward(by: 60)
            }
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
                    print("LinesOnlyLogo.path()[MARKERS]. [\(ix)]")
                    path.move(to: pt)
                    path.addMarker(radius: radius)
                }
            }
            path.closeSubpath()
        }
    }
}
