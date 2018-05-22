//
//  SwiftLogoView.swift
//  SwiftFest
//
//  Created by Bryan Ryczek on 5/22/18.
//  Copyright © 2018 Sean Olszewski. All rights reserved.
//

import SnapKit
import UIKit

class SwiftLogoView: UIView {

    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var viewTwo: UIView!
    @IBOutlet weak var viewThree: UIView!
    @IBOutlet weak var viewFour: UIView!
    @IBOutlet weak var viewFive: UIView!
    @IBOutlet weak var viewSix: UIView!
    @IBOutlet weak var viewSeven: UIView!
    @IBOutlet weak var viewEight: UIView!
    @IBOutlet weak var viewNine: UIView!
    @IBOutlet weak var viewTen: UIView!
    
    var views: [UIView] = []
    var shapes: [UIBezierPath] = []
    
    func setup() {
        views = [viewOne, viewTwo, viewThree, viewFour, viewFive, viewSix, viewSeven, viewEight, viewNine, viewTen]
        shapes = [shapeOne, shapeTwo, shapeThree, shapeFour, shapeFive, shapeSix, shapeSeven, shapeEight, shapeNine, shapeTen]
        for (index, view) in views.enumerated() {
            let shapeLayer = CAShapeLayer()
            shapeLayer.backgroundColor = UIColor.black.cgColor
            shapeLayer.path = shapes[index].cgPath
            view.layer.addSublayer(shapeLayer)
        }
    }

    var shapeOne: UIBezierPath {
        //// Color Declarations
        let strokeColor = UIColor(red: 0.134, green: 0.118, blue: 0.122, alpha: 1.000)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 1.31, y: 8.09))
        bezierPath.addCurve(to: CGPoint(x: 2.62, y: 9.47), controlPoint1: CGPoint(x: 2.04, y: 8.09), controlPoint2: CGPoint(x: 2.62, y: 8.72))
        bezierPath.addLine(to: CGPoint(x: 2.63, y: 17.44))
        bezierPath.addCurve(to: CGPoint(x: 1.32, y: 18.82), controlPoint1: CGPoint(x: 2.63, y: 18.2), controlPoint2: CGPoint(x: 2.05, y: 18.82))
        bezierPath.addCurve(to: CGPoint(x: 0, y: 17.44), controlPoint1: CGPoint(x: 0.59, y: 18.82), controlPoint2: CGPoint(x: 0.01, y: 18.2))
        bezierPath.addLine(to: CGPoint(x: 0, y: 9.47))
        bezierPath.addCurve(to: CGPoint(x: 1.31, y: 8.09), controlPoint1: CGPoint(x: 0, y: 8.71), controlPoint2: CGPoint(x: 0.58, y: 8.09))
        bezierPath.addLine(to: CGPoint(x: 1.31, y: 8.09))
        bezierPath.close()
        strokeColor.setStroke()
        bezierPath.lineWidth = 0.1
        bezierPath.stroke()
        return bezierPath
    }

    var shapeTwo: UIBezierPath {
        //// Color Declarations
        let strokeColor = UIColor(red: 0.134, green: 0.118, blue: 0.122, alpha: 1.000)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 1.31, y: 13.48))
        bezierPath.addCurve(to: CGPoint(x: 2.62, y: 14.86), controlPoint1: CGPoint(x: 2.04, y: 13.48), controlPoint2: CGPoint(x: 2.62, y: 14.1))
        bezierPath.addLine(to: CGPoint(x: 2.63, y: 22.83))
        bezierPath.addCurve(to: CGPoint(x: 1.32, y: 24.21), controlPoint1: CGPoint(x: 2.63, y: 23.59), controlPoint2: CGPoint(x: 2.05, y: 24.21))
        bezierPath.addCurve(to: CGPoint(x: 0, y: 22.83), controlPoint1: CGPoint(x: 0.59, y: 24.21), controlPoint2: CGPoint(x: 0.01, y: 23.59))
        bezierPath.addLine(to: CGPoint(x: 0, y: 14.86))
        bezierPath.addCurve(to: CGPoint(x: 1.31, y: 13.48), controlPoint1: CGPoint(x: 0, y: 14.1), controlPoint2: CGPoint(x: 0.58, y: 13.48))
        bezierPath.addLine(to: CGPoint(x: 1.31, y: 13.48))
        bezierPath.close()
        strokeColor.setStroke()
        bezierPath.lineWidth = 0.1
        bezierPath.stroke()

        return bezierPath
    }
    
    var shapeThree: UIBezierPath {
        //// Color Declarations
        let strokeColor = UIColor(red: 0.134, green: 0.118, blue: 0.122, alpha: 1.000)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 1.31, y: 17.41))
        bezierPath.addCurve(to: CGPoint(x: 2.62, y: 18.79), controlPoint1: CGPoint(x: 2.04, y: 17.41), controlPoint2: CGPoint(x: 2.62, y: 18.03))
        bezierPath.addLine(to: CGPoint(x: 2.63, y: 26.76))
        bezierPath.addCurve(to: CGPoint(x: 1.32, y: 28.14), controlPoint1: CGPoint(x: 2.63, y: 27.52), controlPoint2: CGPoint(x: 2.05, y: 28.14))
        bezierPath.addCurve(to: CGPoint(x: 0, y: 26.76), controlPoint1: CGPoint(x: 0.59, y: 28.14), controlPoint2: CGPoint(x: 0.01, y: 27.52))
        bezierPath.addLine(to: CGPoint(x: 0, y: 18.79))
        bezierPath.addCurve(to: CGPoint(x: 1.31, y: 17.41), controlPoint1: CGPoint(x: -0, y: 18.03), controlPoint2: CGPoint(x: 0.58, y: 17.41))
        bezierPath.close()
        strokeColor.setStroke()
        bezierPath.lineWidth = 0.1
        bezierPath.stroke()

        return bezierPath
    }
    var shapeFour: UIBezierPath {
        //// Color Declarations
        let strokeColor = UIColor(red: 0.134, green: 0.118, blue: 0.122, alpha: 1.000)
        
        //// Clip Clip
        let clipPath = UIBezierPath(rect: CGRect(x: 0, y: 19.75, width: 3, height: 10.85))
        clipPath.addClip()
        
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 1.36, y: 19.8))
        bezierPath.addCurve(to: CGPoint(x: 2.67, y: 21.18), controlPoint1: CGPoint(x: 2.09, y: 19.79), controlPoint2: CGPoint(x: 2.67, y: 20.42))
        bezierPath.addLine(to: CGPoint(x: 2.68, y: 29.14))
        bezierPath.addCurve(to: CGPoint(x: 1.37, y: 30.53), controlPoint1: CGPoint(x: 2.68, y: 29.91), controlPoint2: CGPoint(x: 2.1, y: 30.53))
        bezierPath.addCurve(to: CGPoint(x: 0.05, y: 29.15), controlPoint1: CGPoint(x: 0.64, y: 30.52), controlPoint2: CGPoint(x: 0.06, y: 29.91))
        bezierPath.addLine(to: CGPoint(x: 0.05, y: 21.18))
        bezierPath.addCurve(to: CGPoint(x: 1.36, y: 19.8), controlPoint1: CGPoint(x: 0.05, y: 20.41), controlPoint2: CGPoint(x: 0.63, y: 19.8))
        bezierPath.addLine(to: CGPoint(x: 1.36, y: 19.8))
        bezierPath.close()
        strokeColor.setStroke()
        bezierPath.lineWidth = 0.1
        bezierPath.stroke()

        return bezierPath
    }
    var shapeFive: UIBezierPath {
        //// Color Declarations
        let strokeColor = UIColor(red: 0.134, green: 0.118, blue: 0.122, alpha: 1.000)
        
        //// Clip Clip
        let clipPath = UIBezierPath()
        clipPath.move(to: CGPoint(x: 0, y: 0.05))
        clipPath.addLine(to: CGPoint(x: 3, y: 0.05))
        clipPath.addLine(to: CGPoint(x: 3, y: 32.16))
        clipPath.addLine(to: CGPoint(x: 0, y: 32.16))
        clipPath.addLine(to: CGPoint(x: 0, y: 0.05))
        clipPath.close()
        clipPath.addClip()
        
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 1.36, y: 0.1))
        bezierPath.addCurve(to: CGPoint(x: 2.29, y: 0.5), controlPoint1: CGPoint(x: 1.71, y: 0.1), controlPoint2: CGPoint(x: 2.04, y: 0.24))
        bezierPath.addCurve(to: CGPoint(x: 2.67, y: 1.47), controlPoint1: CGPoint(x: 2.54, y: 0.76), controlPoint2: CGPoint(x: 2.67, y: 1.11))
        bezierPath.addLine(to: CGPoint(x: 2.69, y: 30.73))
        bezierPath.addCurve(to: CGPoint(x: 2.3, y: 31.71), controlPoint1: CGPoint(x: 2.69, y: 31.1), controlPoint2: CGPoint(x: 2.55, y: 31.45))
        bezierPath.addCurve(to: CGPoint(x: 1.38, y: 32.11), controlPoint1: CGPoint(x: 2.06, y: 31.97), controlPoint2: CGPoint(x: 1.72, y: 32.11))
        bezierPath.addCurve(to: CGPoint(x: 0.45, y: 31.71), controlPoint1: CGPoint(x: 1.03, y: 32.11), controlPoint2: CGPoint(x: 0.69, y: 31.96))
        bezierPath.addCurve(to: CGPoint(x: 0.06, y: 30.74), controlPoint1: CGPoint(x: 0.2, y: 31.45), controlPoint2: CGPoint(x: 0.06, y: 31.1))
        bezierPath.addLine(to: CGPoint(x: 0.05, y: 1.47))
        bezierPath.addCurve(to: CGPoint(x: 0.43, y: 0.5), controlPoint1: CGPoint(x: 0.05, y: 1.11), controlPoint2: CGPoint(x: 0.19, y: 0.76))
        bezierPath.addCurve(to: CGPoint(x: 1.36, y: 0.1), controlPoint1: CGPoint(x: 0.68, y: 0.24), controlPoint2: CGPoint(x: 1.01, y: 0.1))
        bezierPath.close()
        strokeColor.setStroke()
        bezierPath.lineWidth = 0.1
        bezierPath.stroke()
        
        return bezierPath
    }
    var shapeSix: UIBezierPath {
        //// Color Declarations
        let strokeColor = UIColor(red: 0.134, green: 0.118, blue: 0.122, alpha: 1.000)
        
        //// Clip Clip
        let clipPath = UIBezierPath()
        clipPath.move(to: CGPoint(x: 0, y: 3.07))
        clipPath.addLine(to: CGPoint(x: 3, y: 3.07))
        clipPath.addLine(to: CGPoint(x: 3, y: 39.47))
        clipPath.addLine(to: CGPoint(x: 0, y: 39.47))
        clipPath.addLine(to: CGPoint(x: 0, y: 3.07))
        clipPath.close()
        clipPath.addClip()
        
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 1.36, y: 3.12))
        bezierPath.addCurve(to: CGPoint(x: 2.67, y: 4.5), controlPoint1: CGPoint(x: 2.09, y: 3.12), controlPoint2: CGPoint(x: 2.67, y: 3.73))
        bezierPath.addLine(to: CGPoint(x: 2.69, y: 38.04))
        bezierPath.addCurve(to: CGPoint(x: 1.38, y: 39.42), controlPoint1: CGPoint(x: 2.69, y: 38.8), controlPoint2: CGPoint(x: 2.11, y: 39.42))
        bezierPath.addCurve(to: CGPoint(x: 0.45, y: 39.01), controlPoint1: CGPoint(x: 1.03, y: 39.42), controlPoint2: CGPoint(x: 0.7, y: 39.27))
        bezierPath.addCurve(to: CGPoint(x: 0.07, y: 38.04), controlPoint1: CGPoint(x: 0.2, y: 38.75), controlPoint2: CGPoint(x: 0.07, y: 38.4))
        bezierPath.addLine(to: CGPoint(x: 0.05, y: 4.5))
        bezierPath.addCurve(to: CGPoint(x: 1.36, y: 3.12), controlPoint1: CGPoint(x: 0.05, y: 3.74), controlPoint2: CGPoint(x: 0.63, y: 3.12))
        bezierPath.close()
        strokeColor.setStroke()
        bezierPath.lineWidth = 0.1
        bezierPath.stroke()

        return bezierPath
    }
    var shapeSeven: UIBezierPath {
        //// Color Declarations
        let strokeColor = UIColor(red: 0.134, green: 0.118, blue: 0.122, alpha: 1.000)
        
        //// Clip Clip
        let clipPath = UIBezierPath(rect: CGRect(x: 0, y: 16.65, width: 3, height: 18.95))
        clipPath.addClip()
        
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 0.05, y: 16.7, width: 2.6, height: 18.85), cornerRadius: 1.3)
        strokeColor.setStroke()
        rectanglePath.lineWidth = 0.1
        rectanglePath.stroke()
        
        return rectanglePath
    }
    var shapeEight: UIBezierPath {
        //// Color Declarations
        let strokeColor = UIColor(red: 0.134, green: 0.118, blue: 0.122, alpha: 1.000)
        
        //// Clip Clip
        let clipPath = UIBezierPath(rect: CGRect(x: 0, y: 19.74, width: 3, height: 10.85))
        clipPath.addClip()
        
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 1.36, y: 19.79))
        bezierPath.addCurve(to: CGPoint(x: 2.67, y: 21.16), controlPoint1: CGPoint(x: 2.08, y: 19.78), controlPoint2: CGPoint(x: 2.67, y: 20.41))
        bezierPath.addLine(to: CGPoint(x: 2.68, y: 29.13))
        bezierPath.addCurve(to: CGPoint(x: 1.37, y: 30.51), controlPoint1: CGPoint(x: 2.68, y: 29.89), controlPoint2: CGPoint(x: 2.1, y: 30.51))
        bezierPath.addCurve(to: CGPoint(x: 0.05, y: 29.13), controlPoint1: CGPoint(x: 0.64, y: 30.51), controlPoint2: CGPoint(x: 0.05, y: 29.89))
        bezierPath.addLine(to: CGPoint(x: 0.05, y: 21.17))
        bezierPath.addCurve(to: CGPoint(x: 1.36, y: 19.79), controlPoint1: CGPoint(x: 0.05, y: 20.4), controlPoint2: CGPoint(x: 0.63, y: 19.78))
        bezierPath.close()
        strokeColor.setStroke()
        bezierPath.lineWidth = 0.1
        bezierPath.stroke()
        
        return bezierPath
    }
    var shapeNine: UIBezierPath {
        //// Color Declarations
        let strokeColor = UIColor(red: 0.134, green: 0.118, blue: 0.122, alpha: 1.000)
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 13.47, width: 2.6, height: 10.7), cornerRadius: 1.3)
        strokeColor.setStroke()
        rectanglePath.lineWidth = 0.1
        rectanglePath.stroke()

        return rectanglePath
    }
    var shapeTen: UIBezierPath {
        //// Color Declarations
        let strokeColor = UIColor(red: 0.134, green: 0.118, blue: 0.122, alpha: 1.000)
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 9.01, width: 2.6, height: 10.7), cornerRadius: 1.3)
        strokeColor.setStroke()
        rectanglePath.lineWidth = 0.1
        rectanglePath.stroke()

        return rectanglePath
    }
}
