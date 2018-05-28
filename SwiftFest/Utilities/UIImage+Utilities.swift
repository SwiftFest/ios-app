//
//  UIImage+Utilities.swift
//  SwiftFest
//
//  Created by Zev Eisenberg on 5/28/18.
//  Copyright © 2018 Sean Olszewski. All rights reserved.
//

import UIKit

extension UIImage {

    static func from(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        defer { UIGraphicsEndImageContext() }
        let context = UIGraphicsGetCurrentContext()!

        context.setFillColor(color.cgColor)
        context.fill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        return image
    }

}
