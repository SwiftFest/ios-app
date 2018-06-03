//
//  MultiImageView.swift
//  SwiftFest
//
//  Created by Zev Eisenberg on 6/3/18.
//  Copyright © 2018 Sean Olszewski. All rights reserved.
//

import SnapKit
import UIKit

@IBDesignable
final class MultiImageView: UIView {

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = -15
        return stackView
    }()

    var images: [UIImage] = [] {
        didSet {
            updateLayout()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedSetup()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        images = [
            Asset.Speakers.ishShabazz,
            Asset.Speakers.andyyHope,
            ].map { $0.image }
    }

}

private extension MultiImageView {

    enum Constants {
        static let imageSize: CGFloat = 60
    }

    func sharedSetup() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func updateLayout() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let viewsToAdd: [UIView] = images.map { image in
            let imageView = UIImageView(image: image)

            let circleView = CircleView()
            circleView.layer.borderColor = Color.white.color.cgColor
            circleView.layer.borderWidth = 2
            circleView.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.width.equalTo(Constants.imageSize)
                make.edges.equalToSuperview()
            }
            imageView.contentMode = .scaleAspectFill

            let shadowView = circleView.wrappedInShadowContainer

            return shadowView
        }
        stackView.addArrangedSubviews(viewsToAdd)
    }

}

private extension UIView {

    var wrappedInShadowContainer: UIView {
        let shadowView = UIView()
        shadowView.addSubview(self)
        snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        shadowView.layer.shadowRadius = 1
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.15
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 2)

        return shadowView
    }

}
