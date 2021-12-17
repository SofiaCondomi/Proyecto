//
//  PlayListDetailControllerTableViewController.swift
//  Proyecto
//
//  Created by Sofia Condomi on 29/11/2021.
//

import UIKit

class PlayListDetailControllerTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    // Variables
    var playlist : [Track] = []
    let tv = UITableView()
    
    
    
    
    // Seteo de objetos en la vista
    var BotonAgregar: UIButton = {
        let b1 = UIButton(type: .roundedRect)
        let b1Image = UIImage(named: "add.png")
        b1.setImage(b1Image, for: .normal)
        b1.autoresizingMask = .flexibleWidth
        b1.translatesAutoresizingMaskIntoConstraints=false
        b1.autoresizingMask = .flexibleWidth
        b1.addTarget(self, action: #selector(presentar), for: .touchUpInside)
        return b1
    }()
    
    var campotexto: UITextField = {
        let campo = UITextField()
        campo.text = "Playlist"
        campo.font = UIFont.systemFont(ofSize: 30)
        campo.textColor = UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 1)
        campo.translatesAutoresizingMaskIntoConstraints = false
        campo.textAlignment = .center
        campo.autoresizingMask = .flexibleWidth
        return campo
    }()
    
    // Funcion presentar picker
    @objc func presentar() {
        let trv = TracksPickerView (frame: CGRect(x: 0, y: self.view.frame.height/2, width: self.view.frame.width, height: self.view.frame.height/2))
            trv.backgroundColor = .clear
            trv.delegadodos = self
            print(tracksArray)
            self.view.addSubview(trv)
    }
    override func viewDidAppear(_ animated: Bool) {
        tv.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tv.reloadData()
        //let tabla = AudioPlayerViewController()
        //tabla.delegado = self
        guard let fondo = UIImage(named: "fondo.png") else { return }
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo.png")!)
        self.view.backgroundColor = UIColor(patternImage: fondo)

        // Seteo TextField:
        
        self.view.addSubview(campotexto)
        campotexto.backgroundColor = .white.withAlphaComponent(0.7)
        campotexto.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        campotexto.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive     = true
        campotexto.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -80).isActive  = true
        
        // Seteo TableView
        tv.backgroundColor = .white.withAlphaComponent(0.7)
        tv.tintColor = UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 1)
        tv.frame = self.view.frame.insetBy(dx: 20, dy:100)
        self.view.addSubview(tv)
        tv.separatorStyle = .singleLine
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "track")
        tv.dataSource = self
        tv.delegate = self
        
        
        // Seteo botones:
        BotonAgregar.frame=CGRect(x: 350, y: 50, width: 50, height: 50)
        BotonAgregar.tintColor=UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 1)
        BotonAgregar.translatesAutoresizingMaskIntoConstraints=true
        BotonAgregar.autoresizingMask = .flexibleLeftMargin
        self.view.addSubview(BotonAgregar)
        /*
        BotonAgregar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        BotonAgregar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -30).isActive     = true
        BotonAgregar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 350).isActive  = true
        //BotonAgregar.autoresizingMask = .flexibleLeftMargin
        //BotonAgregar.autoresizingMask = .flexibleRightMargin
         */
       
    }
    

    // Llenado de TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "track", for: indexPath)
                 let track = tracksArray[indexPath.row]
                 cell.textLabel?.text = track.title
                cell.backgroundColor = .clear
                cell.textLabel?.textColor = UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 1)
                 return cell
    }
    
    // Desselecionar fila
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.view.endEditing(true)
}
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func tableview( _ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle{
            return .delete
        }

    func tableView( _ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
            if editingStyle == .delete{
                tableView.beginUpdates()

                //esto esta bien?
                let track = tracksArray.remove(at: indexPath.row)
                tracks.remove(track)

                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
            }
        }

    
}

// Implementacion del protocolo
extension PlayListDetailControllerTableViewController: TracksPickerDelegate {
    func addTrack(track: Track) {
       // print(track)
           tracks.insert(track)
           tracksArray = Array(tracks)
           tv.reloadData()
       }
    
}

extension PlayListDetailControllerTableViewController: TracksDelegate {
    func estadoPlayer(estado: Bool) {
        print("player")
    }
    
    func estadoPlayer() {
        print("player")
    }
    
    func addTrackto(track: Track) {
        print("ESTOY VIVA")
        print(track)
           tracks.insert(track)
           tracksArray = Array(tracks)
       // print(tracksArray)
           tv.reloadData()
       }

}
