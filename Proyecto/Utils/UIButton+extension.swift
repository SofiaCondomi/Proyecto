//
//  UIButton+extension.swift
//  Proyecto
//
//  Created by Sofia Condomi on 25/11/2021.
//

import Foundation
import UIKit
import TransitionButton

extension UIButton {
    func boton1() {
        
        layer.cornerRadius = self.frame.size.height / 2
        backgroundColor = UIColor(named: "Color")
        tintColor = .white
        titleLabel?.textColor = UIColor.white
        clipsToBounds = true
        
        
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
        layer.masksToBounds = false
    }
    
    func boton2() {
        layer.cornerRadius = self.frame.size.height / 2
        backgroundColor = UIColor(named: "Color")
        tintColor = .white
        titleLabel?.textColor = UIColor.white
        clipsToBounds = true
        
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
        layer.masksToBounds = false
        
    }
}
