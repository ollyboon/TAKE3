//
//  UIColor+Extension.swift
//  Folding
//
//  Created by Hallam John Ager on 11/05/2016.
//  Copyright © 2016 Kyle Goslan. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(redX: Int, greenX: Int, blueX: Int, alphaX: CGFloat) {
        let r = CGFloat(redX)/255
        let g = CGFloat(greenX)/255
        let b = CGFloat(blueX)/255
        self.init(red: r, green: g, blue: b, alpha: alphaX)
    }
}