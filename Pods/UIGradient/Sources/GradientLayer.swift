//
//  GradientLayer.swift
//  UIGradient
//
//  Created by Dinh Quang Hieu on 12/7/17.
//  Copyright © 2017 Dinh Quang Hieu. All rights reserved.
//

import UIKit

public enum GradientDirection {
    case topToBottom
    case bottomToTop
    case leftToRight
    case rightToLeft
    case topLeftToBottomRight
    case topRightToBottomLeft
    case bottomLeftToTopRight
    case bottomRightToTopLeft
}

open class GradientLayer: CAGradientLayer {
    
    private var direction: GradientDirection = .bottomLeftToTopRight
    
    public init(direction: GradientDirection, colors: [UIColor], cornerRadius: CGFloat = 0) {
        super.init()
        self.direction = direction
        self.needsDisplayOnBoundsChange = true
        self.colors = colors.map { $0.cgColor as Any }
        let (startPoint, endPoint) = GradientKitHelper.getStartEndPointOf(direction)
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.cornerRadius = cornerRadius
    }
    
    public override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init()
    }
    
    public final func clone() -> GradientLayer {
        if let colors = self.colors {
            return GradientLayer(direction: self.direction, colors: colors.map { UIColor.init(cgColor: $0 as! CGColor) }, cornerRadius: self.cornerRadius)
        }
        return GradientLayer(direction: self.direction, colors: [], cornerRadius: self.cornerRadius)
    }
}

public extension GradientLayer {
    public static var oceanBlue: GradientLayer {
        return GradientLayer(direction: .bottomLeftToTopRight, colors: [UIColor.hex("2E3192"), UIColor.hex("1BFFFF")])
    }
    
    public static var sanguine: GradientLayer {
        return GradientLayer(direction: .bottomLeftToTopRight , colors: [UIColor.hex("D4145A"), UIColor.hex("FBB03B")])
    }
    
    public static var lusciousLime: GradientLayer {
        return GradientLayer(direction: .bottomLeftToTopRight , colors: [UIColor.hex("009245"), UIColor.hex("FCEE21")])
    }
    
    public static var purpleLake: GradientLayer {
        return GradientLayer(direction: .bottomLeftToTopRight , colors: [UIColor.hex("662D8C"), UIColor.hex("ED1E79")])
    }
    
    public static var freshPapaya: GradientLayer {
        return GradientLayer(direction: .bottomLeftToTopRight , colors: [UIColor.hex("ED1C24"), UIColor.hex("FCEE21")])
    }
    
    public static var ultramarine: GradientLayer {
        return GradientLayer(direction: .bottomLeftToTopRight , colors: [UIColor.hex("00A8C5"), UIColor.hex("FFFF7E")])
    }
    
    public static var pinkSugar: GradientLayer {
        return GradientLayer(direction: .bottomLeftToTopRight , colors: [UIColor.hex("D74177"), UIColor.hex("FFE98A")])
    }
    
    public static var lemonDrizzle: GradientLayer {
        return GradientLayer(direction: .bottomLeftToTopRight , colors: [UIColor.hex("FB872B"), UIColor.hex("D9E021")])
    }
    
    public static var victoriaPurple: GradientLayer {
        return GradientLayer(direction: .bottomLeftToTopRight , colors: [UIColor.hex("312A6C"), UIColor.hex("852D91")])
    }
    
    public static var springGreens: GradientLayer {
        return GradientLayer(direction: .bottomLeftToTopRight , colors: [UIColor.hex("009E00"), UIColor.hex("FFFF96")])
    }
    
    public static var mysticMauve: GradientLayer {
        return GradientLayer(direction: .bottomLeftToTopRight , colors: [UIColor.hex("B066FE"), UIColor.hex("63E2FF")])
    }
    
    public static var reflexSilver: GradientLayer {
        return GradientLayer(direction: .bottomLeftToTopRight , colors: [UIColor.hex("808080"), UIColor.hex("E6E6E6")])
    }
    
    public static var neonGlow: GradientLayer {
        return GradientLayer(direction: .bottomLeftToTopRight , colors: [UIColor.hex("00FFA1"), UIColor.hex("00FFFF")])
    }
    
    public static var berrySmoothie: GradientLayer {
        return GradientLayer(direction: .bottomLeftToTopRight , colors: [UIColor.hex("8E78FF"), UIColor.hex("FC7D7B")])
    }
    
    public static var newLeaf: GradientLayer {
        return GradientLayer(direction: .bottomLeftToTopRight , colors: [UIColor.hex("00537E"), UIColor.hex("3AA17E")])
    }
    
    public static var cottonCandy: GradientLayer {
        return GradientLayer(direction: .bottomLeftToTopRight , colors: [UIColor.hex("FCA5F1"), UIColor.hex("B5FFFF")])
    }
    
    public static var pixieDust: GradientLayer {
        return GradientLayer(direction: .bottomLeftToTopRight , colors: [UIColor.hex("D585FF"), UIColor.hex("00FFEE")])
    }
    
    public static var fizzyPeach: GradientLayer {
        return GradientLayer(direction: .bottomLeftToTopRight , colors: [UIColor.hex("F24645"), UIColor.hex("EBC08D")])
    }
    
    public static var sweetDream: GradientLayer {
        return GradientLayer(direction: .bottomLeftToTopRight , colors: [UIColor.hex("3A3897"), UIColor.hex("A3A1FF")])
    }
    
    public static var firebrick: GradientLayer {
        return GradientLayer(direction: .bottomLeftToTopRight , colors: [UIColor.hex("45145A"), UIColor.hex("FF5300")])
    }
    
    public static var wroughtIron: GradientLayer {
        return GradientLayer(direction: .bottomLeftToTopRight , colors: [UIColor.hex("333333"), UIColor.hex("5A5454")])
    }
    
    public static var deepSea: GradientLayer {
        return GradientLayer(direction: .bottomLeftToTopRight , colors: [UIColor.hex("4F00BC"), UIColor.hex("29ABE2")])
    }
    
    public static var coastalBreeze: GradientLayer {
        return GradientLayer(direction: .bottomLeftToTopRight , colors: [UIColor.hex("00B7FF"), UIColor.hex("FFFFC7")])
    }
    
    public static var eveningDelight: GradientLayer {
        return GradientLayer(direction: .bottomLeftToTopRight , colors: [UIColor.hex("93278F"), UIColor.hex("00A99D")])
    }
}
