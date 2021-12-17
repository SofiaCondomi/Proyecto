//
//  RegisterViewController.swift
//  Proyecto
//
//  Created by Sofia Condomi on 27/10/2021.
//

import UIKit
import TransitionButton
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
        vista.isHidden = true
        label.alpha = 0
        //alerta.alpha = 0
        vista.backgroundColor = UIColor(named: "Color")? .withAlphaComponent(0)
        
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints=false
        
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        button.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -20).isActive = true
//        button.trailingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
//        button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
//        button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        
        
        
        //buttomstop.frame=CGRect(x: 200, y: 340, width: 80, height: 80)
        button.tintColor=UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 1)
        
        
        
        
        button.addTarget(self, action: #selector(Register(_:)), for: .touchUpInside)
        
        bindViewModel()
    }
    
    let button: TransitionButton = {
        let boton = TransitionButton()
        boton.backgroundColor = UIColor(named: "Color")
        boton.setTitle("Register", for: .normal)
        boton.cornerRadius = 10
        boton.spinnerColor = .white
        boton.autoresizingMask = .flexibleWidth
        boton.translatesAutoresizingMaskIntoConstraints=false
        return boton
    }()
    
    // Variables y constantes --------------------
    var viewModel: RegisterViewModel?
    var counter: Int = 1
    let numberofcolors: Int = 2
    var typeError = 0
    
    func bindViewModel() {
        viewModel = RegisterViewModel()
        //self.goToTab()
    }
    
    // Outlets
    @IBOutlet weak var EnterEmail: UITextField!
    @IBOutlet weak var SingUp: UILabel!
    @IBOutlet weak var enter: UILabel!
    @IBOutlet weak var OrEnter: UILabel!
    @IBOutlet weak var buttom: UIButton!
    @IBOutlet weak var Register: UIButton!
    @IBOutlet weak var Dismiss: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var vista: UIView!
    
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
        
        button.startAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            // pass: self.Password.text, alerta: self.alerta, textoalerta: self.textoalerta
            self.viewModel?.botonLoginTouch(email: self.EnterEmail.text, alerta: self.vista, textoalerta: self.label)
        guard let valid = self.viewModel?.validUser else { return }

            if valid {
                self.button.stopAnimation(animationStyle: .expand)
                print(valid)
                print("El usuario es valido")
                DispatchQueue.main.asyncAfter(deadline: .now()+0.4) {
                self.goToMainViewController()
                self.viewModel?.validUser = false
                }
                //button.stopAnimation()
            } else {
                //DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.button.stopAnimation(animationStyle: .shake)
                //}
            }
        }
        
//
//        //Desempaquetado Mail -------------------------
//        guard let user = EnterEmail.text, !user.isEmpty else {
//            typeError = 2
//            print("Ingresar Email o Username")
//            self.button.stopAnimation(animationStyle: .shake)
//            return
//            }
//
//        //Registro ----------------------------------
//        let resultadomail: Bool = chequeoMail(mailIngresado: user)
//        if resultadomail == true {
//            print ("Registrar mail")
//            let callBack: ([Track]?, Error?) -> () = { canciones, error in
//                if error != nil {
//                    print("no se pudo obtener canciones")
//
//                }
//                else {
//                    misTracks = canciones ?? []
//
//                }
//
//            }
//
//            //DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
//               // DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
//                    self.button.stopAnimation(animationStyle: .expand)
//                //}
//               // DispatchQueue.main.asyncAfter(deadline: .now()+0.6) {
//               // self.goToMainViewController()
//               // }
//            //}
//        } else {
//
//            typeError = 2
//            print("Formato de mail incorrecto")
//
//        }
//
   }
   
    @IBAction func Dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SingFace(_ sender: Any) {
        self.showSimpleAlert(Mensaje: "No se tiene coneccion a Facebook", Titulo: "Facebook")
    }

//--Validacion de Mail ---------------
//
//    func chequeoMail (mailIngresado: String) -> Bool {
//        let patron = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        let regExp = try! NSRegularExpression(pattern: patron, options: [])
//        let coincidencias = regExp.matches(in: mailIngresado, options: [], range: NSRange(location: 0, length: mailIngresado.count))
//        if coincidencias.count == 1 {
//                return true
//        }
//        else {
//                return false
//        }
//    }

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
