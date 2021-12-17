//
//  BienvenidaViewController.swift
//  Proyecto
//
//  Created by Sofia Condomi on 29/10/2021.
//

import UIKit

class BienvenidaViewController: UIViewController {
        
    @IBOutlet weak var imagenLogo: UIImageView!
    @IBOutlet weak var welcome: UILabel!
    
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            welcome.textColor = UIColor(named: "Color")
            guard let fondo = UIImage(named: "fondo.png") else { return }
            self.view.backgroundColor = UIColor(patternImage: fondo)
            
            agregarGestosImagen()
            
            
        }
        
        
        
        @IBAction func logout(_ sender: Any) {
            dismiss(animated: true, completion: nil)
        }
        
    func agregarGestosImagen(){
            self.imagenLogo.isUserInteractionEnabled = true
            let gestureTap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            self.imagenLogo.addGestureRecognizer(gestureTap)

            let gesturePinch = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
            self.imagenLogo.addGestureRecognizer(gesturePinch)
        }

        @objc func handleTap(_ sender: UITapGestureRecognizer){
            let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
            let compilado = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
            let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""

            //Pop up
            alertOK(title: "INFO", message: "Version: \(version)\n Compilado: \(compilado)\n \(appName)", action: "OK")
        }

        @objc func didPinch(_ sender: UIPinchGestureRecognizer){
            if let scale = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)) {
                       guard scale.a > 1.0 else { return }
                       guard scale.d > 1.0 else { return }
                        sender.view?.transform = scale
                       sender.scale = 1.0
            }
        }



}

//extension UIViewController {
//    func alertOK(title: String, message: String, action: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: action, style: .default, handler: { _ in }))
//        self.present(alert, animated: true, completion: nil)
//    }
//}
