//
//  AnimatableVector.swift
//  SwiftLogoPlay
//
//  Created by Howard Katz on 2020-06-15.
//  Copyright © 2020 Howard Katz. All rights reserved.
//

import SwiftUI

struct AnimatableVector {
    var vertices : [CGPoint]
    
    init(with points: [CGPoint]) {
        vertices = points
    }
    init(count : Int = 0) {
        vertices = [CGPoint](repeating: CGPoint.zero, count: count)
    }
}

extension AnimatableVector : VectorArithmetic {
    var magnitudeSquared: Double { 0 }
    
    mutating func scale(by: Double) {
        for i in 0..<vertices.count {
            vertices[i].x *= CGFloat(by)
            vertices[i].y *= CGFloat(by)
        }
    }
    
    static var zero : AnimatableVector {
        return AnimatableVector()
    }
    static func - (lhs: AnimatableVector, rhs: AnimatableVector) -> AnimatableVector {
        var ret = [CGPoint]()
        for i in 0..<min(lhs.vertices.count, rhs.vertices.count) {
            ret.append(CGPoint(x: lhs.vertices[i].x - rhs.vertices[i].x, y: lhs.vertices[i].y - rhs.vertices[i].y))
        }
        return AnimatableVector(with: ret)
    }
    static func + (lhs: AnimatableVector, rhs: AnimatableVector) -> AnimatableVector {
        var ret = [CGPoint]()
        for i in 0..<min(lhs.vertices.count, rhs.vertices.count) {
            ret.append(CGPoint(x: lhs.vertices[i].x + rhs.vertices[i].x, y: lhs.vertices[i].y + rhs.vertices[i].y))
        }
        return AnimatableVector(with: ret)
    }
    static func -= (lhs: inout AnimatableVector, rhs: AnimatableVector) {
        lhs = lhs - rhs
    }
    static func += (lhs: inout AnimatableVector, rhs: AnimatableVector) {
        lhs = lhs + rhs
    }
    
}
