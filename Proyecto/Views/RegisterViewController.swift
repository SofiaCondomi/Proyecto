//
//  RegisterViewController.swift
//  Proyecto
//
//  Created by Sofia Condomi on 27/10/2021.
//

import UIKit

class RegisterViewController: UIViewController {

    //viewDidLoad ------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Colores
        SingUp.textColor = UIColor(named: "Color")
        enter.textColor = UIColor(named: "Color")
        enter.tintColor = UIColor(named: "Color")
        Register.tintColor = UIColor(named: "Color")
        Dismiss.tintColor = UIColor(named: "Color")
        OrEnter.textColor = UIColor(named: "Color")
        guard let fondo = UIImage(named: "fondo.png") else { return }
        self.view.backgroundColor = UIColor(patternImage: fondo)
        
    }
    
    // Variables y constantes --------------------
    var counter: Int = 1
    let numberofcolors: Int = 2
    var typeError = 0
    
    // Outlets
    @IBOutlet weak var EnterEmail: UITextField!
    @IBOutlet weak var SingUp: UILabel!
    @IBOutlet weak var enter: UILabel!
    @IBOutlet weak var OrEnter: UILabel!
    @IBOutlet weak var buttom: UIButton!
    @IBOutlet weak var Register: UIButton!
    @IBOutlet weak var Dismiss: UIButton!
    
    // Actions -----------------------------------
    
    @IBAction func SignUpFace(_ sender: Any) {
       
        // Cambiar colores boton-------------------
        let color: String = "Color"
        let colorname: String = color+"\(counter)"
        counter += 1
        buttom.backgroundColor = UIColor(named: colorname)
        print(colorname)
        if counter > numberofcolors {
            counter = 1
            
        }
    }
    
    @IBAction func Register(_ sender: Any) {
        
        //Desempaquetado Mail -------------------------
        guard let user = EnterEmail.text, !user.isEmpty else {
            typeError = 2
            print("Ingresar Email o Username")
            return
            }
        
        //Registro ----------------------------------
        let resultadomail: Bool = chequeoMail(mailIngresado: user)
        if resultadomail == true {
            print ("Registrar mail")
            let callBack: ([Track]?, Error?) -> () = { canciones, error in
                if error != nil {
                    print("no se pudo obtener canciones")
    
                }
                else {
                    misTracks = canciones ?? []
                    
                }
                
            }
            //let api = APIManager()
            //api.getMusic(completion: callBack)
            goToMainViewController()
        } else {
            typeError = 2
            print("Formato de mail incorrecto")
        }
        
    }
    
    @IBAction func Dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SingFace(_ sender: Any) {
        self.showSimpleAlert(Mensaje: "No se tiene coneccion a Facebook", Titulo: "Facebook")
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

// Ir a pantalla de bienvenida ------------------
    
    func goToMainViewController() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabController") as? UITabBarController
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    
// Bajar el teclado --------------------------------
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.view.endEditing(true)
    }

}
