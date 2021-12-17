//
//  TracksTableViewController.swift
//  Proyecto
//
//  Created by Sofia Condomi on 03/11/2021.
//

import UIKit
import Network

class TracksTableViewController: UITableViewController {

    var _misTracks = [Track]()
    var estadomusica:Bool = false
    var estadocancion:Bool = false
    
    var notfound: UIImageView = {
        let loveURL = Bundle.main.url(forResource: "nada", withExtension: ".gif")
        let loveGIF = UIImage.animatedImage(withAnimatedGIFURL: loveURL!)
        let imgContainer = UIImageView(image: loveGIF)
        return imgContainer
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints=false
        label.autoresizingMask = .flexibleWidth
        return label
    }()
    
    var vista: UIView = {
        let v1 = UIView()
        v1.translatesAutoresizingMaskIntoConstraints=false
        v1.autoresizingMask = .flexibleWidth
        return v1
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Carga la vista:
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
        
        // MARK: Constrains gif
        
        
        vista.backgroundColor = .white .withAlphaComponent(0)
        vista.isHidden = true
        vista.layer.cornerRadius = 20
        self.view.addSubview(vista)
        vista.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        vista.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        vista.heightAnchor.constraint(equalToConstant: 200).isActive = true
        vista.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        label.alpha = 0
        label.isHidden = true
        self.view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -80).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        notfound.alpha = 0
        notfound.isHidden = true
        notfound.autoresizingMask = .flexibleWidth
        notfound.translatesAutoresizingMaskIntoConstraints=false
        
        self.view.addSubview(notfound)
        notfound.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        notfound.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        notfound.heightAnchor.constraint(equalToConstant: 140).isActive = true
        notfound.widthAnchor.constraint(equalToConstant: 130).isActive = true
        
        
        
     
    }

    func checkconexion() {
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            //Animaciones.alertaconexion(vista: self.vista, texto: "No hay internet", gif: self.notfound, label: self.label)
        }else{
            print("Internet Connection not Available!")
            Animaciones.alertaconexion(vista: self.vista, texto: "No hay internet", gif: self.notfound, label: self.label)
        }
    }
    
    @objc func changeIcon(_ notification: Notification) {
            guard let mysong = notification.object as? Bool else {
                print("holis")
                return}
                print("ESTO ES OBSERVER TVCONTROLER true")
                estadocancion = mysong
                if mysong {
                
                } else {
                print("ESTO ES OBSERVER TVCONTROLER false")
        
                }
    
    }
    
    @objc func updateTable(_ notification: Notification) {
            
            //misTracks.append(Track(title: "Nueva cancion", artist: "Nuevo artista", album: "Nuevo album", song_id: "0", genre: ""))
            //tableView.reloadData()
        }

    // MARK: Seteo de elementos de la tabla:
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return misTracks.count
    }
   
    // MARK: Seteo de Celdas:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TrackTableViewCell
        let elTrack = misTracks[indexPath.row]
        cell.titulo.text = elTrack.title
        cell.artista.text = elTrack.artist
        cell.imageView?.image = (UIImage(named: "imagen"))
        cell.track = elTrack
        cell.parent = self
        cell.botonPlay.isPlaying = estadomusica
        cell.backgroundColor = UIColor(patternImage: UIImage(named: "fondo.png")!)
        cell.textLabel?.textColor = .black
        cell.botonPlay.performTwoStateSelection()
        if estadocancion {
            
            
        }

        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
                //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TrackTableViewCell
        //cell.botonPlay.performTwoStateSelection()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TrackTableViewCell
  
    }
    override func viewDidAppear(_ animated: Bool) {
        checkconexion()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if estadocancion {
    
        }
        tableView.reloadData()
        
       
    }

}
// MARK: Protocolo ButtonOnCell
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
