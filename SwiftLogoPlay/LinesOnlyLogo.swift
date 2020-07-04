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
            
            SourceLogo()
                .fill(Color.orange)
            SourceLogo()
                .stroke(Color.black, lineWidth: 0.6)
            
            // ---------------------------------------
            
            LinesOnlyLogo(vector: model.initialVector,
                          bezierType: .lineSegments)
                .fill(Color.init(white: 0.88))
            
            LinesOnlyLogo(vector: model.initialVector,
                          bezierType: .lineSegments)
                .stroke(Color.black, lineWidth: 1)

            // ---------------------------------------

            LinesOnlyLogo(vector: model.vector,
                          bezierType: .even_numbered_markers,
                          radius: 11)
                .fill(Color.black)

            LinesOnlyLogo(vector: model.vector,
                          bezierType: .even_numbered_markers,
                          radius: 10.5)
                .fill(Color.green)
            
            LinesOnlyLogo(vector: model.vector,
                          bezierType: .even_numbered_markers,
                          radius: 1.5)
                .fill(Color.white)
            
            // ---------------------------------------

            LinesOnlyLogo(vector: model.vector,
                          bezierType: .odd_numbered_markers,
                          radius: 9)
                .fill(Color.black)

            LinesOnlyLogo(vector: model.vector,
                          bezierType: .odd_numbered_markers,
                          radius: 8.5)
                .fill(Color.red)

            LinesOnlyLogo(vector: model.vector,
                          bezierType: .odd_numbered_markers,
                          radius: 1.5)
                .fill(Color.white)
        }
            .background(Color.init(white: 0.15))
            
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

struct LinesOnlyLogo : Shape {
    
    var vector: CGPointVector
    var animatableData: CGPointVector {
        get { vector }
        set { vector = newValue }
    }
    //MARK: TODO: make an enum with .markers(let radius)
    //MARK: TODO: and radius is hardwired platform-dependent
    var bezierType : BezierType = .lineSegments
    var radius : CGFloat = 5
    var animate = true

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
