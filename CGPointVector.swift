//
//  CGPointVector.swift
//  SwiftLogoPlay
//
//  Created by Howard Katz on 2020-06-20.
//  Copyright © 2020 Howard Katz. All rights reserved.

//  originally titled AnimatableCGPointVector
//  from https://gist.github.com/mecid

import SwiftUI

struct AnimatableCGPointVector: VectorArithmetic {
    static var zero = AnimatableCGPointVector(values: [.zero])

    static func - (lhs: AnimatableCGPointVector, rhs: AnimatableCGPointVector) -> AnimatableCGPointVector {
        let values = zip(lhs.values, rhs.values)
            .map { lhs, rhs in lhs.animatableData - rhs.animatableData }
            .map { CGPoint(x: $0.first, y: $0.second) }
        return AnimatableCGPointVector(values: values)
    }

    static func -= (lhs: inout AnimatableCGPointVector, rhs: AnimatableCGPointVector) {
        for i in 0..<min(lhs.values.count, rhs.values.count) {
            lhs.values[i].animatableData -= rhs.values[i].animatableData
        }
    }

    static func + (lhs: AnimatableCGPointVector, rhs: AnimatableCGPointVector) -> AnimatableCGPointVector {
        let values = zip(lhs.values, rhs.values)
            .map { lhs, rhs in lhs.animatableData + rhs.animatableData }
            .map { CGPoint(x: $0.first, y: $0.second) }
        return AnimatableCGPointVector(values: values)
    }

    static func += (lhs: inout AnimatableCGPointVector, rhs: AnimatableCGPointVector) {
        for i in 0..<min(lhs.values.count, rhs.values.count) {
            lhs.values[i].animatableData += rhs.values[i].animatableData
        }
    }

    var values: [CGPoint]

    mutating func scale(by rhs: Double) {
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


