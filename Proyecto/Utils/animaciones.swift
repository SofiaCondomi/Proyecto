//
//  animaciones.swift
//  Proyecto
//
//  Created by Sofia Condomi on 10/12/2021.
//

import Foundation
import UIKit

extension ViewController {
    func alertaanimada(alerta: UIView, textoalerta: UILabel, texto: String) {
        var timer = Timer()
        //alerta.alpha = 1
        //textoalerta.alpha = 1
        UIView.animate(withDuration: 2, delay: 0, animations:   {
            alerta.alpha = 1
            textoalerta.alpha = 1
            textoalerta.tintColor = UIColor(named: "Color")
            textoalerta.textColor = UIColor(named: "Color")
            alerta.backgroundColor = .white .withAlphaComponent(1)
            //alerta.backgroundColor?.withAlphaComponent(0.5)
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
    
    func vistaCustom(vista: UIView, texto: String, gif: UIImageView) {
        var timer = Timer()
        //alerta.alpha = 1
        //textoalerta.alpha = 1
        UIView.animate(withDuration: 1, delay: 0, animations:   {
            
            vista.backgroundColor = UIColor(named: "Color")? .withAlphaComponent(0.7)
            vista.isHidden = false
            gif.isHidden = false
            //vista.layer.cornerRadius = 100
            vista.alpha = 0.7
            gif.alpha = 1
//            textovista.alpha = 1
//            textovista.tintColor = UIColor(named: "Color")
//            textovista.textColor = UIColor(named: "Color")
//            vista.backgroundColor = .white .withAlphaComponent(1)
//            //alerta.backgroundColor?.withAlphaComponent(0.5)
//            vista.isHidden = false
//            vista.center.y += 300
//            textovista.text = texto
//            textovista.alpha = 1
            
            print("no se puede ingresar")
        
            }) { _ in
                
                UIView.animate(withDuration: 1, delay: 0) {
                    timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
                        
                        vista.alpha = 0
                        gif.alpha = 0
                        vista.isHidden = true
                        gif.isHidden = true
                        //textovista.alpha = 0
                        
                        
                })
                    
            }
                           
        }
        return
        
    }
}
