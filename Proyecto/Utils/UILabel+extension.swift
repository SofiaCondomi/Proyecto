//
//  UILabel+extension.swift
//  Proyecto
//
//  Created by Sofia Condomi on 25/11/2021.
//

import Foundation
import UIKit

public extension UILabel {
    
    func colortexto() {
        tintColor = UIColor(named: "Color")
        textColor = UIColor(named: "Color")
        
    }
    
    /*
    var activateGradientColor: Bool {
        set {
            if newValue == true {
                textColor = gradientColor(bounds: self.bounds, gradientLayer: getGradientLayer(bounds: self.bounds))
            }
        }
        get {
            return true
        }
    }

    private func getGradientLayer(bounds : CGRect) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.blue.cgColor,UIColor.yellow.cgColor, UIColor.blue.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradient
    }
    
    private func gradientColor(bounds: CGRect, gradientLayer :CAGradientLayer) -> UIColor? {
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIColor(patternImage: image!)
    }
     */
}
