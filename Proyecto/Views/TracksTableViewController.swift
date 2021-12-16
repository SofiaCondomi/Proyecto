//
//  TracksTableViewController.swift
//  Proyecto
//
//  Created by Sofia Condomi on 03/11/2021.
//

import UIKit


class TracksTableViewController: UITableViewController {

    var _misTracks = [Track]()
    var estadocancion:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Carga la vista:
        guard let fondo = UIImage(named: "fondo.png") else { return }
        self.view.backgroundColor = UIColor(patternImage: fondo)
        self.tableView.rowHeight = 80
        //self.tableView.separatorStyle = .none
        self.tableView.register(TrackTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        //DownloadManager.shared.startDownload(url: URL(string: "https://speed.hetzner.de/100MB.bin")!)
        NotificationCenter.default.addObserver(self,
                                                       selector: #selector(self.changeIcon(_:)),
                                                       name: NSNotification.Name(rawValue: "changeButtonIcon"),
                                                       object: nil)
        
        
        //_misTracks = misTracks
        
        NotificationCenter.default.addObserver(self,
                                                selector: #selector(updateTable(_:)),
                                                name: NSNotification.Name("updateTable"),
                                                object: nil)
                
                let _ = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { timer in
                    print("Timer fired!")
                    NotificationCenter.default.post(name: NSNotification.Name("updateTable"), object: nil)
                }
     
    }
    
    @objc func changeIcon(_ notification: Notification) {
            guard let mysong = notification.object as? Bool else {
                print("ESTO NO FUNCIONA")
                return}
                print("ACA ESTA EL ESTADO DE LA CANCION")
                print(mysong)
                if mysong {
                print("CAMBIO DE ESTADO BOTON")
                } else {
                    //estadocancion = mysong
        //print("No soy igual.")
                }
    //addTrack(addedTrack: mysong)
    }
    
    @objc func updateTable(_ notification: Notification) {
            
            //misTracks.append(Track(title: "Nueva cancion", artist: "Nuevo artista", album: "Nuevo album", song_id: "0", genre: ""))
            //tableView.reloadData()
        }

    // Seteo de elementos de la tabla:
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return misTracks.count
    }
    /*
    override func viewWillAppear(_ animated: Bool) {
        print(misTracks)
        tableView.reloadData()
    }
     */
    // Seteo de Celdas:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TrackTableViewCell
        let elTrack = misTracks[indexPath.row]
        cell.titulo.text = elTrack.title
        cell.artista.text = elTrack.artist
        cell.track = elTrack
        cell.parent = self
        //print("ESTADO CANCION")
        //print(estadocancion)
        cell.botonPlay.isPlaying = estadocancion
        
        cell.backgroundColor = UIColor(patternImage: UIImage(named: "fondo.png")!)
        cell.textLabel?.textColor = .black
        cell.botonPlay.performTwoStateSelection()

        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TrackTableViewCell
        cell.botonPlay.performTwoStateSelection()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
       
    }

}

extension TracksTableViewController: ButtonOnCellDelegate {
    func buttonTouchedOnCell(celda: UITableViewCell) {
        view.endEditing(true)
        self.view.endEditing(true)
        
        let apvc = AudioPlayerViewController()
        guard let index = tableView.indexPath(for: celda) else { return}
        
        let mySound = misTracks[index.item]
        apvc.titleName = mySound
        print("MY SOUND")
        print(mySound)
        
        apvc.modalPresentationStyle = .fullScreen
        self.present(apvc,animated: true, completion: nil)
    }
}
