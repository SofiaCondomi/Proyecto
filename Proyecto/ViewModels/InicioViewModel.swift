//
//  InicioViewModel.swift
//  Proyecto
//
//  Created by Sofia Condomi on 02/12/2021.
//

import Foundation
import UIKit

class InicioViewModel: UIViewController  {
    
    func IrAPantallaPrincipal(sender: InicioViewController) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            sender.performSegue(withIdentifier: "Ir", sender: sender)
       }
    }
    
}
