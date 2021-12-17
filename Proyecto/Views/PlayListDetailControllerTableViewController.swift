//
//  PlayListDetailControllerTableViewController.swift
//  Proyecto
//
//  Created by Sofia Condomi on 29/11/2021.
//

import UIKit

class PlayListDetailControllerTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    // MARK: Variables
    var playlist : [Track] = []
    let tv = UITableView()

    // MARK: Seteo de objetos en la vista
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
    
    // MARK: Funcion presentar picker
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
        guard let fondo = UIImage(named: "fondo.png") else { return }
        self.view.backgroundColor = UIColor(patternImage: fondo)

        // MARK: Seteo TextField:
        
        self.view.addSubview(campotexto)
        campotexto.backgroundColor = .white.withAlphaComponent(0.7)
        campotexto.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        campotexto.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive     = true
        campotexto.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -80).isActive  = true
        
        // MARK: Seteo TableView
        tv.backgroundColor = .white.withAlphaComponent(0.7)
        tv.tintColor = UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 1)
        tv.frame = self.view.frame.insetBy(dx: 20, dy:100)
        self.view.addSubview(tv)
        tv.separatorStyle = .singleLine
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "track")
        tv.dataSource = self
        tv.delegate = self
        
        
        // MARK: Seteo botones:
        BotonAgregar.frame=CGRect(x: 350, y: 50, width: 50, height: 50)
        BotonAgregar.tintColor=UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 1)
        BotonAgregar.translatesAutoresizingMaskIntoConstraints=true
        BotonAgregar.autoresizingMask = .flexibleLeftMargin
        self.view.addSubview(BotonAgregar)
       
    }
    

    // MARK: Llenado de TableView
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
    
    // MARK: Desselecionar fila
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.view.endEditing(true)
}
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    // MARK: Delet
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

// MARK: Implementacion del protocolo
extension PlayListDetailControllerTableViewController: TracksPickerDelegate {
    func addTrack(track: Track) {
       // print(track)
           tracks.insert(track)
           tracksArray = Array(tracks)
           tv.reloadData()
       }
    
}

// MARK: Implementacion de protocolo
extension PlayListDetailControllerTableViewController: TracksDelegate {
    func estadoPlayer(estado: Bool) {
        print("player")
    }
    
    func estadoPlayer() {
        print("player")
    }
    
    func addTrackto(track: Track) {
        print(track)
           tracks.insert(track)
           tracksArray = Array(tracks)
           tv.reloadData()
       }

}
