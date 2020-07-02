//
//  CGPointVector.swift
//  SwiftLogoPlay
//
//  Created by Howard Katz on 2020-06-20.
//  Copyright © 2020 Howard Katz. All rights reserved.

//  originally titled AnimatableCGPointVector
//  from https://gist.github.com/mecid

import SwiftUI

struct CGPointVector: VectorArithmetic {
    
    var values: [CGPoint]
    
//    init(values: [CGPoint]) {
//        self.values = values
//    }
    
//    init(count: Int = 0) {
//        values = [CGPoint](repeating: CGPoint.zero, count: count)
//    }

    static var zero = CGPointVector(values: [.zero])

    static func - (lhs: CGPointVector, rhs: CGPointVector) -> CGPointVector {
        let values = zip(lhs.values, rhs.values)
            .map { lhs, rhs in lhs.animatableData - rhs.animatableData }
            .map { CGPoint(x: $0.first, y: $0.second) }
        return CGPointVector(values: values)
    }

    static func -= (lhs: inout CGPointVector, rhs: CGPointVector) {
        for i in 0..<min(lhs.values.count, rhs.values.count) {
            lhs.values[i].animatableData -= rhs.values[i].animatableData
        }
    }

    static func + (lhs: CGPointVector, rhs: CGPointVector) -> CGPointVector {
        let values = zip(lhs.values, rhs.values)
            .map { lhs, rhs in lhs.animatableData + rhs.animatableData }
            .map { CGPoint(x: $0.first, y: $0.second) }
        return CGPointVector(values: values)
    }

    static func += (lhs: inout CGPointVector, rhs: CGPointVector) {
        for i in 0..<min(lhs.values.count, rhs.values.count) {
            lhs.values[i].animatableData += rhs.values[i].animatableData
        }
    }
    
    mutating func scale(by rhs: Double) {
        print("CGPointVector.scale()")
        
        for i in 0..<values.count {
            values[i].animatableData.scale(by: rhs)
        }
    }

    var magnitudeSquared: Double {
        print(".map.reduce()ing CGPoint data ...")
        return
            values
            .map { $0.animatableData.magnitudeSquared }
            .reduce(0.0, +)
    }
}


