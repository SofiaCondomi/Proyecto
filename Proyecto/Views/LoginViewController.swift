//
//  LoginViewController.swift
//  Proyecto
//
//  Created by Sofia Condomi on 14/12/2021.
//

import UIKit
import TransitionButton

class LoginViewController: UIViewController {

    let caracteresPass = 10
    var timer = Timer()
    // Variable de coneccion con viewModel
    var viewModel: LoginViewModel?
 
    // Outlets ---------------------------------
    let button: TransitionButton = {
        let boton = TransitionButton()
        boton.backgroundColor = UIColor(named: "Color")
        boton.setTitle("Continue", for: .normal)
        boton.cornerRadius = 20
        boton.spinnerColor = .white
        boton.autoresizingMask = .flexibleWidth
        boton.translatesAutoresizingMaskIntoConstraints=false
        return boton
    }()
    //= TransitionButton() //(frame: CGRect(x: 155, y: 400, width: 100, height: 40))
    
        @IBOutlet weak var Boton2: UIButton!
        @IBOutlet weak var Boton1: UIButton!
        @IBOutlet weak var label: UILabel!
        @IBOutlet weak var Password: UITextField!
        @IBOutlet weak var enter: UILabel!
        @IBOutlet weak var Username: UITextField!
        @IBOutlet weak var alerta: UIView!
        @IBOutlet weak var textoalerta: UILabel!
    
    @IBAction func `continue`(_ sender: Any) {
        
        view.endEditing(true)
        button.startAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            self.viewModel?.botonLoginTouch(user: self.Username.text, pass: self.Password.text, alerta: self.alerta, textoalerta: self.textoalerta)
            guard let valid = self.viewModel?.validUser else { return }
 
                    if valid {
                        self.button.stopAnimation(animationStyle: .expand)
                        print(valid)
                        print("El usuario es valido")
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.4) {
                        self.goToTab()
                        self.viewModel?.validUser = false
                        }
                        //button.stopAnimation()
                    } else {
                        //DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        self.button.stopAnimation(animationStyle: .shake)
                        //}
                    }
            
        }
        
        
    }
    
    @IBAction func signup(_ sender: Any) {
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Username.text = "sofia@gmail.com"
        Password.text = "12345678910"
        //Boton1.boton1()
        Boton2.boton2()
        label.colortexto()
        enter.colortexto()
        alerta.isHidden = true
        textoalerta.alpha = 0
        //alerta.alpha = 0
        alerta.backgroundColor = UIColor(named: "Color")? .withAlphaComponent(0)
       // label.textColor = UIColor(named: "Color")
       // enter.textColor = UIColor(named: "ColorSecundario")
        guard let fondo = UIImage(named: "fondo.png") else { return }
        self.view.backgroundColor = UIColor(patternImage: fondo)
        
        //button.frame(forAlignmentRect: CGRect(x: 155, y: 400, width: 100, height: 40))
        //button.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        //button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        //button.heightAnchor.constraint(equalToConstant: 10).isActive = true
        //button.widthAnchor.constraint(equalToConstant: 10).isActive = true
//        button.backgroundColor = UIColor(named: "Color")
//        button.setTitle("Continue", for: .normal)
//        button.cornerRadius = 20
//        button.spinnerColor = .white
        self.view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        //button.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: Boton2.topAnchor, constant: -20).isActive = true
        button.topAnchor.constraint(equalTo: Password.bottomAnchor, constant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 90).isActive = true
        //button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        
        
        
        button.addTarget(self, action: #selector(`continue`(_:)), for: .touchUpInside)
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel = LoginViewModel()
        //self.goToTab()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Username.text = ""
        //Password.text = ""
    }
    
    func goToTab() {
      let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabController") as? UITabBarController
      vc!.modalPresentationStyle = .fullScreen
      self.present(vc!, animated: true)
        //print("Type error = ", typeError)
    }
}
