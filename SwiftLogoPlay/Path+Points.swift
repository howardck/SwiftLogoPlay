//
//  Path+Points.swift
//  SwiftLogoPlay
//
//  Created by Howard Katz on 2020-06-09.
//  Copyright © 2020 Howard Katz. All rights reserved.
//

import SwiftUI

extension CGFloat {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

extension Path {
    func scaled(toFit rect: CGRect) -> Path {
        let scaleW = rect.width/boundingRect.width
        let scaleH = rect.height/boundingRect.height
        let scaleFactor = min(scaleW, scaleH)
        return applying(CGAffineTransform(scaleX: scaleFactor, y: scaleFactor))
    }
    
    mutating func addMarker(radius r: CGFloat) {
        let rect = CGRect(origin: self.currentPoint!,
                          size: CGSize(width: 2*r, height: 2*r))
        self.addEllipse(in: rect.offsetBy(dx: -r, dy: -r))
    }
    
    func verticesOnly() -> [CGPoint] {
        var points = [CGPoint]()
        self.forEach { element in
            switch element {
            case .closeSubpath:
                break
            case .curve(let to, _, _) :
                points.append(to)
            case .line(let to) :
                points.append(to)
            case .move(let to) :
                points.append(to)
            case .quadCurve(let to, _) :
                points.append(to)
            }
        }
        print("\nextension Path.verticesOnly(): {\(points.count)} points")
        print("boundingRect: {\(self.boundingRect)}")
        for (ix, pt) in points.enumerated() {
            print("[\(ix)]: {" +
                "x: \(pt.x.format(f: ".4")) " +
                "y: \(pt.y.format(f: ".4"))}")
            
        }
        return points
    }
}
