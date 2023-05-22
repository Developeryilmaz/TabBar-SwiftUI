//
//  TabShape.swift
//  TabBar
//
//  Created by YILMAZ ER on 22.05.2023.
//

import SwiftUI

struct TabShape: Shape {
    var midpoint: CGFloat
    
    /// Adding Shape Animation
    var animatableData: CGFloat {
        get { midpoint }
        set {
            midpoint = newValue
        }
    }
    func path(in rect: CGRect) -> Path {
        return Path { path in
            /// First Drawing the Rectangle Shape
            path.addPath(Rectangle().path(in: rect))
            /// Now Drawing Upward Curve Shape
            path.move(to: .init(x: midpoint - 60, y: 0))
            
            let to1 = CGPoint(x: midpoint, y: -25)
            let control1 = CGPoint(x:midpoint - 25, y: 0)
            let control2 = CGPoint(x: midpoint - 25, y: -25)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            
            let to2 = CGPoint(x: midpoint + 60, y: 0)
            let control3 = CGPoint(x:midpoint + 25, y: -25)
            let control4 = CGPoint(x: midpoint + 25, y: 0)
            
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}
