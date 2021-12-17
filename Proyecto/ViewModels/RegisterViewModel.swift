//
//  RegisterViewModel.swift
//  Proyecto
//
//  Created by Sofia Condomi on 17/12/2021.
//

import Foundation
import UIKit

class RegisterViewModel: ViewController {
    let model: Registered = Registered()
    var validUser = false
    
    
    
    
    //, alerta:UIView, textoalerta:UILabel
    func botonLoginTouch(email:String?) {
        
        //Desempaquetado Mail -------------------------
        guard let user = email, !user.isEmpty else {
            let texto = "Ingresar Email o Username"
            DispatchQueue.main.asyncAfter(deadline: .now()+0.6) {
                //self.alertaanimada(alerta: alerta, textoalerta: textoalerta, texto: texto)
            }
            return
            }
        let model: Registered = Registered()
//        if user = model.user1.user {
//            validacion = false
//        }
        //Registro ----------------------------------
        let resultadomail: Bool = chequeoMail(mailIngresado: user)
        if resultadomail == true && user != model.user1.user {
            print ("Registrar mail")
            validUser = true
            let callBack: ([Track]?, Error?) -> () = { canciones, error in
                if error != nil {
                    print("no se pudo obtener canciones")
    
                }
                else {
                    misTracks = canciones ?? []
                    
                }
                
            }
            
            //DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
               // DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                    //self.button.stopAnimation(animationStyle: .expand)
                //}
               // DispatchQueue.main.asyncAfter(deadline: .now()+0.6) {
               // self.goToMainViewController()
               // }
            //}
        } else {
            
            //typeError = 2
            print("Formato de mail incorrecto")
            
        }
        
    }

//--Validacion de Mail ---------------
        
    func chequeoMail (mailIngresado: String) -> Bool {
        let patron = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let regExp = try! NSRegularExpression(pattern: patron, options: [])
        let coincidencias = regExp.matches(in: mailIngresado, options: [], range: NSRange(location: 0, length: mailIngresado.count))
        if coincidencias.count == 1 {
                return true
        }
        else {
                return false
        }
    }
}
