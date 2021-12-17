//
//  animaciones.swift
//  Proyecto
//
//  Created by Sofia Condomi on 10/12/2021.
//

import Foundation
import UIKit

public class Animaciones {
    
   class func alertaanimada(alerta: UIView, textoalerta: UILabel, texto: String) {
        var timer = Timer()

        UIView.animate(withDuration: 2, delay: 0, animations:   {
            alerta.alpha = 1
            textoalerta.alpha = 1
            textoalerta.tintColor = UIColor(named: "Color")
            textoalerta.textColor = UIColor(named: "Color")
            alerta.backgroundColor = .white .withAlphaComponent(1)
            alerta.isHidden = false
            alerta.center.y += 100
            textoalerta.text = texto
            textoalerta.alpha = 1
            
            print("no se puede ingresar")
        
            }) { _ in
                
                UIView.animate(withDuration: 0, delay: 0) {
                    timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { (timer) in
                        alerta.isHidden = true
                        alerta.alpha = 0
                        textoalerta.alpha = 0
                        
                        
                })
                    
            }
                           
        }
        return
        
    }
    
   class func vistaCustom(vista: UIView, texto: String, gif: UIImageView, label: UILabel) {
        var timer = Timer()
        
        UIView.animate(withDuration: 1, delay: 0, animations:   {
            
            vista.backgroundColor = .white
            vista.isHidden = false
            gif.isHidden = false
            vista.alpha = 1
            gif.alpha = 1
            label.alpha = 1
            label.isHidden = false
            label.backgroundColor = .clear
            label.text = texto
            label.textAlignment = .center
            label.textColor = UIColor(named: "Color")
            
            print("no se puede ingresar")
        
            }) { _ in
                
                UIView.animate(withDuration: 0, delay: 0) {
                    timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (timer) in
                        
                        vista.alpha = 0
                        gif.alpha = 0
                        label.alpha = 0
                        label.isHidden = true
                        vista.isHidden = true
                        gif.isHidden = true
                        
                        
                })
                    
            }
                           
        }
        return
        
    }
    
    class func alertaconexion(vista: UIView, texto: String, gif: UIImageView, label: UILabel) {
         var timer = Timer()
         //alerta.alpha = 1
         //textoalerta.alpha = 1
         UIView.animate(withDuration: 3, delay: 0, animations:   {
             
             //vista.backgroundColor = UIColor(named: "Color")? .withAlphaComponent(0.7)
             vista.backgroundColor = .white
             vista.isHidden = false
             gif.isHidden = false
             vista.alpha = 1
             gif.alpha = 1
             label.alpha = 1
             label.isHidden = false
             label.backgroundColor = .clear
             label.text = texto
             label.textAlignment = .center
             label.textColor = UIColor(named: "Color")
             
            })
         return
         
     }
}
