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

            LinesOnlyLogo(vector: model.initialVector,
                          bezierType: .lineSegments)
                .fill(Color.init(white: 0.8))
            
            LinesOnlyLogo(vector: model.initialVector,
                          bezierType: .lineSegments)
                .stroke(Color.black, lineWidth: 1)
            
            LinesOnlyLogo(vector: model.vector,
                          bezierType: .markers,
                          radius: 10)
                .fill(Color.black)
            
            LinesOnlyLogo(vector: model.vector,
                          bezierType: .markers,
                          radius: 9)
                .fill(Color.green)
            
            LinesOnlyLogo(vector: model.vector,
                          bezierType: .markers,
                          radius: 2)
                .fill(Color.white)
            
        }
        .background(Color.init(white: 0.9))
        .onTapGesture {
            withAnimation(Animation.easeIn(duration: 1.5)) {
                self.model.advanceVerticesToNextPosition()
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
                case .markers :
                    path.move(to: pt)
                    path.addMarker(radius: radius)
                }
            }
            path.closeSubpath()
        }
    }
}
