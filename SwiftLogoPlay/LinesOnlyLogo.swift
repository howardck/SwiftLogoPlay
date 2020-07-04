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
    
    // a subview as a PROPERTY (just exploring)
    
    private var sourceLogoView : some View {
        Group {
            SourceLogo()
                .fill(Color.orange)
            SourceLogo()
                .stroke(Color.black, lineWidth: 0.6)
        }
    }
    
    // a subview as a FUNCTION
    
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
                            radius: 7)
                  .fill(Color(UIColor.white))
              
              LinesOnlyLogo(vector: initialVector,
                            bezierType: .all_markers,
                            radius: 6)
                  .fill(Color.red)
        }
    }
    
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
        }
    }
    
    var body: some View {
        ZStack {
            
            sourceLogoView

            nonAnimatingSectionOfLogoStack(initialVector: model.initialVector)
            
            animatingSectionOfLogoStack(vector: model.vector)
        }
        .background(Color(UIColor.lightGray))
            
        .onTapGesture(count: 2) {
            withAnimation(Animation.easeIn(duration: 3)) {
                self.model.advanceVerticesToNextPosition()
            }
        }
        .onTapGesture(count: 1) {
            withAnimation(Animation.easeIn(duration: 2.0)) {
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
