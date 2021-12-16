//
//  InicioViewController.swift
//  Proyecto
//
//  Created by Sofia Condomi on 17/11/2021.
//

import UIKit

class InicioViewController: UIViewController {

    var viewModel: InicioViewModel?
    var imageView : UIImageView!
    
    var imagen: UIImageView = {
        
        // Instancia los objetos de la vista
        
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "Image.png")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
     
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setea Gif de fondo
        if let laURL = Bundle.main.url(forResource: "fondo", withExtension: ".gif") {
        let elGIF = UIImage.animatedImage(withAnimatedGIFURL: laURL)
        let imgContainer = UIImageView(image: elGIF)
        imgContainer.autoresizingMask = .flexibleWidth
        imgContainer.translatesAutoresizingMaskIntoConstraints=true
        imgContainer.frame=CGRect(x: 0, y: 0, width: 1050, height: 1000)
        self.view.addSubview(imgContainer)
        
        //imagen.frame=CGRect(x: 105, y: 345, width: 200, height: 200)
        imagen.translatesAutoresizingMaskIntoConstraints=false
        imagen.autoresizingMask = .flexibleLeftMargin
        imagen.sizeToFit()
        
        self.view.addSubview(imagen)
            imagen.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
            
            imagen.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
            //imagen.bottomAnchor.constraint(equalTo: imagen.topAnchor, constant: -20).isActive = true
            //imagen.topAnchor.constraint(equalTo: imagen.bottomAnchor, constant: 30).isActive = true
            imagen.heightAnchor.constraint(equalToConstant: 200).isActive = true
            imagen.widthAnchor.constraint(equalToConstant: 200).isActive = true
            
            
        // Seteo Nombre
        let label1 = UILabel()
        label1.text = "TransMusic"
        label1.font = UIFont.systemFont(ofSize: 30)
        label1.textColor = UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 1)
        label1.font = UIFont.boldSystemFont(ofSize: 40)
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.textAlignment = .center
        self.view.addSubview(label1)
            
        label1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        label1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive     = true
        label1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive  = true
       
        }
        bindViewModel()
        viewModel?.IrAPantallaPrincipal(sender: self)
        
    }
    
    func bindViewModel() {
        viewModel = InicioViewModel()
        
    }
    
    override func viewWillLayoutSubviews() {
    }
    

}
