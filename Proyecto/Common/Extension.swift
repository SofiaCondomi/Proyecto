//
//  Extension.swift
//  Proyecto
//
//  Created by Sofia Condomi on 06/12/2021.
//

import Foundation

extension UIViewController {
    func showSimpleAlert(Mensaje mensaje:String, Titulo titulo:String) {
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
   
    }
    
    func alertOK(title: String, message: String, action: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { _ in }))
        self.present(alert, animated: true, completion: nil)
    }
}
