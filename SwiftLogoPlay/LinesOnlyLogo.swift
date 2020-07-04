//
//  LinesOnlyLogo.swift
//  SwiftLogoPlay
//
//  Created by Howard Katz on 2020-06-15.
//  Copyright © 2020 Howard Katz. All rights reserved.
//

import SwiftUI

extension Int {
    func isEven() -> Bool
    {
        return self % 2 == 0
    }
}

enum BezierType {
    case lineSegments
    case all_markers
    case even_numbered_markers
    case odd_numbered_markers
}

struct LogosStackView : View {

    @ObservedObject var model = LinesOnlyModel(source: SourceLogo.SOURCE_LOGO)
    
    init(size: CGSize) {
        model.scaleVectors(to: size)
    }
    
    var body: some View {
        ZStack {
            
            Group {
                SourceLogo()
                    .fill(Color.orange)
                SourceLogo()
                    .stroke(Color.black, lineWidth: 0.6)
            }
            
            Group { // non-animating
                LinesOnlyLogo(vector: model.initialVector,
                              bezierType: .lineSegments)
                    .fill(Color.init(white: 0.88))
                
                LinesOnlyLogo(vector: model.initialVector,
                              bezierType: .lineSegments)
                    .stroke(Color.black, lineWidth: 1)
                
                LinesOnlyLogo(vector: model.initialVector,
                              bezierType: .all_markers,
                              radius: 6)
                    .fill(Color(UIColor.white))
                
                LinesOnlyLogo(vector: model.initialVector,
                              bezierType: .all_markers,
                              radius: 5)
                    .fill(Color.blue)
            }

            // ---------------------------------------

            LinesOnlyLogo(vector: model.vector,
                          bezierType: .all_markers,
                          radius: 11.5)
                .fill(Color.black)

            LinesOnlyLogo(vector: model.vector,
                          bezierType: .all_markers,
                          radius: 11)
                .fill(Color.green)
            
            LinesOnlyLogo(vector: model.vector,
                          bezierType: .all_markers,
                          radius: 1.5)
                .fill(Color.white)
            
            // ---------------------------------------

//            LinesOnlyLogo(vector: model.vector,
//                          bezierType: .odd_numbered_markers,
//                          radius: 9)
//                .fill(Color.black)
//
//            LinesOnlyLogo(vector: model.vector,
//                          bezierType: .odd_numbered_markers,
//                          radius: 8.5)
//                .fill(Color.yellow)
//
//            LinesOnlyLogo(vector: model.vector,
//                          bezierType: .odd_numbered_markers,
//                          radius: 2)
//                .fill(Color.white)
        }
//            .background(Color.init(white: 0.15))
            .background(Color(UIColor.lightGray))
            
        .onTapGesture(count: 2) {
            withAnimation(Animation.easeIn(duration: 2)) {
                self.model.advanceVerticesToNextPosition()
            }
        }
        .onTapGesture(count: 1) {
            withAnimation(Animation.easeIn(duration: 1.5)) {
                self.model.advanceVerticesToNextPosition()
            }
        }
    }
}

 //see above: this is a NO-OP
struct EvenNumberedVertices : View {
    
    var model: LinesOnlyModel

    var body: some View {
                
        Group {
            LinesOnlyLogo(vector: model.vector,
                          bezierType: .even_numbered_markers,
                          radius: 10)
                .fill(Color.black)
            
            LinesOnlyLogo(vector: model.vector,
                          bezierType: .even_numbered_markers,
                          radius: 9)
                .fill(Color.green)
            
            LinesOnlyLogo(vector: model.vector,
                          bezierType: .even_numbered_markers,
                          radius: 2)
                .fill(Color.white)
        }
    }
}
