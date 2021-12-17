//
//  TrackTableViewCell.swift
//  Proyecto
//
//  Created by Sofia Condomi on 05/11/2021.
//

import UIKit

class TrackTableViewCell: UITableViewCell {
    var track:Track?
    var parent:ButtonOnCellDelegate?
    var estadocancion:Bool = false
    
    
    
    
    var icono: UIImageView = {
        
        // Instancia los objetos de la vista
        
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "cancion")
        imgView.backgroundColor = UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 0.5)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    var titulo: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 1)
        lbl.text = "titulo"
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var artista: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 1)
        lbl.text = "artista"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var botonPlay: BotonDestacado = {
        let btn = BotonDestacado()
        let config = UIImage.SymbolConfiguration(pointSize: 200, weight: .bold)
        btn.icon = UIImage(systemName: "play.circle.fill", withConfiguration: config)
        btn.secondIcon = UIImage(systemName: "pause.circle.fill", withConfiguration: config)
        btn.performTwoStateSelection()
        //btn.backgroundColor = UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 0.5)
        btn.tintColor = UIColor(named: "Color")
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 25
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    // Quitar la celda seleccionada
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Setea constrains y agrega a la vista los elementos
        
        addSubview(icono)
        NSLayoutConstraint.activate([
            icono.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            icono.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            icono.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            icono.widthAnchor.constraint(equalTo: icono.safeAreaLayoutGuide.heightAnchor)
        ])
        
        botonPlay.addTarget(self, action: #selector(callButtom), for: .touchUpInside)
        self.contentView.addSubview(botonPlay)
                NSLayoutConstraint.activate([
            botonPlay.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            botonPlay.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -15),
            botonPlay.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            botonPlay.widthAnchor.constraint(equalTo: botonPlay.safeAreaLayoutGuide.heightAnchor)
        ])
        
        addSubview(titulo)
        NSLayoutConstraint.activate([
            titulo.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            titulo.heightAnchor.constraint(equalToConstant: 20),
            titulo.leadingAnchor.constraint(equalTo: icono.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            titulo.trailingAnchor.constraint(equalTo: botonPlay.safeAreaLayoutGuide.leadingAnchor, constant: -5)
        ])
        
        addSubview(artista)
        NSLayoutConstraint.activate([
            artista.heightAnchor.constraint(equalToConstant: 20),
            artista.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            artista.leadingAnchor.constraint(equalTo: icono.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            artista.trailingAnchor.constraint(equalTo: botonPlay.safeAreaLayoutGuide.leadingAnchor, constant: -5)
        ])
    }
    
    @objc func callButtom(_ sender:UIButton!) {
            botonPlay.performTwoStateSelection()
            if parent != nil {
                parent?.buttonTouchedOnCell(celda: self)
            }
        NotificationCenter.default.addObserver(self,
                                                       selector: #selector(self.changeIcon(_:)),
                                                       name: NSNotification.Name(rawValue: "changeButtonIcon"),
                                                       object: nil)
        }
    
    @objc func changeIcon(_ notification: NSNotification){
        print(notification)
        guard let mysong = notification.object as? Bool else {
                print("ESTO ES IS PLAYING TV CELL NO LLEGA NADA")
                return}
                    if mysong {
                        print("ESTO ES IS PLAYING TV CELL \(mysong)")
                        estadocancion = mysong
                    } else {
                        print("ESTO ES IS PLAYING TV CELL \(mysong)")
                    }
            //addTrack(addedTrack: mysong)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


