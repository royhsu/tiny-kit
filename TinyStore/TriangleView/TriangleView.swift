//
//  TriangleView.swift
//  NextBook
//
//  Created by Roy Hsu on 10/08/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - TriangleView

import UIKit

public class TriangleView: UIView {
    
    public var triangleColor: UIColor = .white {
    
        didSet { setNeedsDisplay() }
        
    }
    
    // MARK: Draw
    
    public override func draw(_ rect: CGRect) {
        
        guard
            let context = UIGraphicsGetCurrentContext()
        else { return }
        
        context.beginPath()
        
        context.move(
            to: CGPoint(
                x: rect.minX,
                y: rect.maxY
            )
        )
        
        context.addLine(
            to: CGPoint(
                x: rect.maxX,
                y: rect.maxY
            )
        )
        
        context.addLine(
            to: CGPoint(
                x: rect.maxX,
                y: rect.minY
            )
        )
        
        context.closePath()
        
        context.setFillColor(triangleColor.cgColor)
        
        context.fillPath()
        
    }
    
}
