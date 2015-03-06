//
//  DesignableView.swift
//  Desafio1
//
//  Created by Rafael Fernandes de Oliveira Carvalho on 3/4/15.
//  Copyright (c) 2015 Rafael Fernandes de Oliveira Carvalho. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor {
        get {
            return UIColor(CGColor: layer.borderColor)
        }
        set {
            layer.borderColor = newValue.CGColor
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var clipping: Bool {
        get {
            return clipsToBounds
        }
        set {
            clipsToBounds = newValue
        }
    }
}