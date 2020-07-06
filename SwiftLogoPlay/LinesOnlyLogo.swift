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
    case origin_marker
}

struct LogosStackView : View {

    @ObservedObject var model = LinesOnlyModel(source: SourceLogo.SOURCE_LOGO)
    
    init(size: CGSize) {
        model.scaleVectors(to: size)
    }
    
    var body: some View {
        ZStack {
            
            originalSwiftLogoAsBackground

            nonAnimatingSectionOfLogoStack(initialVector: model.initialVector)
            
            animatingSectionOfLogoStack(vector: model.vector)
        }
        .background(Color(UIColor.lightGray))
            
        .onTapGesture(count: 1) {
            withAnimation(Animation.easeIn(duration: 1.6)) {
                self.model.advanceVerticesToNextPosition()
            }
        }
    }
    
    private var originalSwiftLogoAsBackground : some View {
        Group {
            SourceLogo()
                .fill(Color.orange)
            SourceLogo()
                .stroke(Color.black, lineWidth: 0.6)
        }
    }
    
    private func nonAnimatingSectionOfLogoStack(initialVector: CGPointVector) -> some View {

        Group {
            LinesOnlyLogo(vector: initialVector,
                            bezierType: .lineSegments)
                  .fill(Color.init(white: 0.88))
              
              LinesOnlyLogo(vector: initialVector,
                            bezierType: .lineSegments)
                  .stroke(Color.black, lineWidth: 1)
              
              LinesOnlyLogo(vector: initialVector,
                            bezierType: .all_markers,
                            radius: 6.5)
                  .fill(Color(UIColor.white))
              
              LinesOnlyLogo(vector: initialVector,
                            bezierType: .all_markers,
                            radius: 6)
                  .fill(Color.red)
        }
    }
    
    // all vertices "orbit" the periphery of the
    // straight-line rendering of the bezier
    private func animatingSectionOfLogoStack(vector: CGPointVector) -> some View {

        Group {
            LinesOnlyLogo(vector: vector,
                          bezierType: .all_markers,
                          radius: 11.5)
                .fill(Color.black)
            
            LinesOnlyLogo(vector: vector,
                          bezierType: .all_markers,
                          radius: 11)
                .fill(Color.green)
            
            LinesOnlyLogo(vector: vector,
                          bezierType: .all_markers,
                          radius: 1.5)
                .fill(Color.white)
            
            // one marker  to keep track of our starting point
            LinesOnlyLogo(vector: vector,
                          bezierType: .origin_marker,
                          radius: 10.5)
                .fill(Color.black)
            
            LinesOnlyLogo(vector: vector,
                          bezierType: .origin_marker,
                          radius: 10)
                .fill(Color.blue)
            
            LinesOnlyLogo(vector: vector,
                          bezierType: .origin_marker,
                          radius: 2)
                .fill(Color.white)
        }
    }
}
