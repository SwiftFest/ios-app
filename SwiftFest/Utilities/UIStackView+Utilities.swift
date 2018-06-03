//
//  UIStackView+Utilities.swift
//  SwiftFest
//
//  Created by Zev Eisenberg on 6/3/18.
//  Copyright © 2018 Sean Olszewski. All rights reserved.
//

import UIKit

extension UIStackView {

    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }

}
