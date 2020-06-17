//
//  AnimatableVector.swift
//  SwiftLogoPlay
//
//  Created by Howard Katz on 2020-06-15.
//  Copyright © 2020 Howard Katz. All rights reserved.
//

import SwiftUI

struct PointVector {
    var vertices : [CGPoint]
    
    init(with points: [CGPoint]) {
        vertices = points
    }
    init(count : Int = 0) {
        vertices = [CGPoint](repeating: CGPoint.zero, count: count)
    }
}

extension PointVector : VectorArithmetic {
    var magnitudeSquared: Double { 0 }
    
    mutating func scale(by: Double) {
        for i in 0..<vertices.count {
            vertices[i].x *= CGFloat(by)
            vertices[i].y *= CGFloat(by)
        }
    }
    
    static var zero : PointVector {
        return PointVector()
    }
    static func - (lhs: PointVector, rhs: PointVector) -> PointVector {
        var ret = [CGPoint]()
        for i in 0..<min(lhs.vertices.count, rhs.vertices.count) {
            ret.append(CGPoint(x: lhs.vertices[i].x - rhs.vertices[i].x, y: lhs.vertices[i].y - rhs.vertices[i].y))
        }
        return PointVector(with: ret)
    }
    static func + (lhs: PointVector, rhs: PointVector) -> PointVector {
        var ret = [CGPoint]()
        for i in 0..<min(lhs.vertices.count, rhs.vertices.count) {
            ret.append(CGPoint(x: lhs.vertices[i].x + rhs.vertices[i].x, y: lhs.vertices[i].y + rhs.vertices[i].y))
        }
        return PointVector(with: ret)
    }
    static func -= (lhs: inout PointVector, rhs: PointVector) {
        lhs = lhs - rhs
    }
    static func += (lhs: inout PointVector, rhs: PointVector) {
        lhs = lhs + rhs
    }
    
}
