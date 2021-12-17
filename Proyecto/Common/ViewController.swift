//
//  ViewController.swift
//  Proyecto
//
//  Created by Sofia Condomi on 22/10/2021.
//

import UIKit
import TransitionButton

class ViewController: UIViewController {
/*
//viewDidLoad ------------------------------
    let button = TransitionButton(frame: CGRect(x: 100, y: 100, width: 100, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Colores y fondo -------------------------
        
        Boton1.boton1()
        Boton2.boton2()
        label.colortexto()
        enter.colortexto()
        Username.text = "sofia@gmail.com"
        Password.text = "12345678910"
        alerta.isHidden = true
        textoalerta.alpha = 0
        //alerta.alpha = 0
        alerta.backgroundColor = UIColor(named: "Color")? .withAlphaComponent(0)
       // label.textColor = UIColor(named: "Color")
       // enter.textColor = UIColor(named: "ColorSecundario")
        guard let fondo = UIImage(named: "fondo.png") else { return }
        self.view.backgroundColor = UIColor(patternImage: fondo)
        
        self.view.addSubview(button)
                
                button.backgroundColor = .red
                button.setTitle("button", for: .normal)
                button.cornerRadius = 20
                button.spinnerColor = .white
                button.addTarget(self, action: #selector(`continue`(_:)), for: .touchUpInside)
    }
    
// Variables -------------------------------
    var typeError: Int = 0
    let caracteresPass = 10
    var timer = Timer()
    
// Outlets ---------------------------------
    
    @IBOutlet weak var Boton2: UIButton!
    @IBOutlet weak var Boton1: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var enter: UILabel!
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var alerta: UIView!
    
    @IBOutlet weak var textoalerta: UILabel!
    

// Action Sign Up --------------------------------
    
    @IBAction func singUp(_ sender: Any) {
    }

// Action Continue --------------------------------
    
    @IBAction func `continue`(_ sender: Any) {
        
        view.endEditing(true)
        button.startAnimation()
        //------ Desempaquetado Username -------------
        
        guard let user = Username.text, !user.isEmpty else {
            typeError = 1
            let texto = "Por favor, ingrese un usuario"
            alertaanimada(alerta: alerta, textoalerta: textoalerta, texto: texto)
            
            return
        }
        
        //----- Desempaquetado Password -------------
        guard let pass = Password.text, !pass.isEmpty else {
            typeError = 3
            let texto = "Por favor, ingrese un password"
            alertaanimada(alerta: alerta, textoalerta: textoalerta, texto: texto)
            return
            }
        
        //----- Validacion final ----------------------
        let resultadomail: Bool = chequeoMail(mailIngresado : user)
        let resultadopass: Bool = chequeoPass(passIngresado : pass)
        
        let model: Registered = Registered()
        
        // Verifica y trae los datos de las canciones:
        if resultadomail == true, resultadopass == true {
            if model.user1.user == user && model.user1.pass == pass {
                print("Permitir ingreso")
                /*
                let callBack: ([Track]?, Error?) -> () = { canciones, error in
                    if error != nil {
                        print("no se pudo obtener canciones")
                    }
                        else {
                            misTracks = canciones ?? []
                        }
                    }
                */
                RestServiceManager.shared.getToServer(responseType: [Track].self, method: .get, endpoint: "songs") { status, data in
                           misTracks = [Track]()
                           if let _data = data {
                               misTracks = _data
                               
                               //self.tableView.reloadData()
                           }
                       }
                //let api = APIManager()
                //api.getMusic(completion: callBack)
                goToTab()
                
                    } else {
                            print("Los datos ingresados no son correctos")
                        let texto = "Los datos ingresados no son correctos"
                        alertaanimada(alerta: alerta, textoalerta: textoalerta, texto: texto)
                        return
                            }
                } else {
                    print("Formato de email o password incorrecto")
                    let texto = "Formato de email o password incorrecto"
                    alertaanimada(alerta: alerta, textoalerta: textoalerta, texto: texto)
                    return
                    }*/
}

//----- Validacion de Mail ---------------
 /*
func chequeoMail (mailIngresado: String) -> Bool {
    let patron = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let regExp = try! NSRegularExpression(pattern: patron, options: [])
    let coincidencias = regExp.matches(in: mailIngresado, options: [], range: NSRange(location: 0, length: mailIngresado.count))
    if coincidencias.count == 1 {
            print ("Formato de email correcto")
            return true
    }
    else {
            print ("No es un email correcto")
            typeError = 2
            return false
    }
}

//----- Validacion de Password ---------------
    
func chequeoPass (passIngresado: String) -> Bool {
    if caracteresPass < passIngresado.count {
        print("Formato de password correcto")
        return true
        
    } else  {
            typeError = 4
            print("Formato de password incorrecto")
            return false
            }
    }
  
// Bajar el teclado --------------------------------
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.view.endEditing(true)
}
    
// Ir a pantalla de bienvenida ------------------
    
    func goToTab() {
      let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabController") as? UITabBarController
      vc!.modalPresentationStyle = .fullScreen
      self.present(vc!, animated: true)
        print("Type error = ", typeError)
    }
  */


