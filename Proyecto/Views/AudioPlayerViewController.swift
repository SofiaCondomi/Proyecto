//
//  AudioPlayerViewController.swift
//  Proyecto
//
//  Created by Sofia Condomi on 05/11/2021.
//

import UIKit
import AudioPlayer

class AudioPlayerViewController: ViewController {
    
    // Variables
    var tracksTableViewController: TracksTableViewController?
    var isPlaying = false
    var mySound:AudioPlayer?
    var timeActual: Any? = 0
    var myTimer = Timer()
    var titleName: Track?
    var delegado:TracksDelegate?
    var delegadoPlayer:TracksDelegate?
    var indexDelTrack: Int?
    
    
    // Seteo de objetos en la vista
    
    var imagencancion: UIImage = {
        let img = UIImage()
        return img
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints=false
        label.autoresizingMask = .flexibleWidth
        return label
    }()
    
    var Gif: UIImageView = {
        let loveURL = Bundle.main.url(forResource: "heart", withExtension: ".gif")
        let loveGIF = UIImage.animatedImage(withAnimatedGIFURL: loveURL!)
        let imgContainer = UIImageView(image: loveGIF)
        return imgContainer
    }()
    
    var vista: UIView = {
        let v1 = UIView()
        v1.translatesAutoresizingMaskIntoConstraints=false
        v1.autoresizingMask = .flexibleWidth
        return v1
    }()
    
    var buttommenu: UIButton = {
        let b1 = UIButton(type: .roundedRect)
        let labelImage = UIImage(systemName: "line.3.horizontal")
        b1.setImage(labelImage, for: .normal)
        b1.autoresizingMask = .flexibleWidth
        b1.translatesAutoresizingMaskIntoConstraints=true
        //b1.addTarget(self, action: #selector(manu), for: .touchUpInside)
        return b1
        
    }()
    
    var buttomplay: UIButton = {
        let b1 = UIButton(type: .roundedRect)
        let labelImage = UIImage(systemName: "play.circle.fill")
        b1.setImage(labelImage, for: .normal)
        b1.autoresizingMask = .flexibleWidth
        b1.translatesAutoresizingMaskIntoConstraints=true
        b1.addTarget(self, action: #selector(play), for: .touchUpInside)
        return b1
        
    }()
    var imagen: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "cancion.jpg")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    var buttomstop: UIButton = {
        let b2 = UIButton(type: .roundedRect)
        let labelImage = UIImage(systemName: "stop.circle.fill")
        b2.setImage(labelImage, for: .normal)
        b2.autoresizingMask = .flexibleWidth
        b2.translatesAutoresizingMaskIntoConstraints=true
        b2.addTarget(self, action: #selector(stop), for: .touchUpInside)
        return b2
        
    }()
    
    
     var buttomdismiss: UIButton = {
         let b3 = UIButton(type: .roundedRect)
         let labelImage = UIImage(systemName: "chevron.backward")
         b3.setImage(labelImage, for: .normal)
         b3.autoresizingMask = .flexibleWidth
         b3.translatesAutoresizingMaskIntoConstraints=true
         b3.addTarget(self, action: #selector(salir), for: .touchUpInside)
         return b3
         
     }()
     
     
    
    var slider: UISlider = {
        let s2 = UISlider()
        s2.autoresizingMask = .flexibleWidth
        s2.translatesAutoresizingMaskIntoConstraints=true
        s2.addTarget(self, action: #selector(slider2(_:)), for: .valueChanged)
        return s2
    } ()
    
    var Songslider: UISlider = {
        let s1 = UISlider()
        s1.autoresizingMask = .flexibleWidth
        s1.translatesAutoresizingMaskIntoConstraints=true
        s1.addTarget(self, action: #selector(sliderSongChange(_:)), for: .valueChanged)
        return s1
    } ()
    
    // Funciones del reproductor
    
    @objc func menu() {
        
    }
    
    @objc func play() {
        mySound?.play()
        isPlaying = true
        
    }
    
    @objc func stop() {
        mySound?.stop()
        isPlaying = false
        //print(titleName?.isPlaying)
        //self.delegadoPlayer?.estadoPlayer(estado: false)
        
    }
    
    
     @objc func salir() {
         dismiss(animated: true, completion: nil)
         
     }
     
    
    @objc func slider2(_ sender:UISlider!) {
        mySound?.volume = slider.value
    }
    
    
    @objc func sliderSongChange(_ sender:UISlider!) {
               self.timeActual = mySound?.currentTime
               self.mySound?.currentTime = TimeInterval((Songslider.value))
       }

       @objc func updateSlider(){
           self.Songslider.value = Float(mySound!.currentTime)
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indexDelTrack = misTracks.firstIndex(of: titleName!)
        
        // Fondo
        guard let fondo = UIImage(named: "fondo.png") else { return }
        self.view.backgroundColor = UIColor(patternImage: fondo)
        
        
        // Encontrar y reproducir cancion
        do {
            mySound = try AudioPlayer(fileName: "cancion01.mp3")
            mySound?.volume = 1.0
            myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
            mySound?.play()
            isPlaying = true
            //isPlaying = ((titleName?.isPlaying) != nil)
            titleName?.isPlaying = isPlaying
            print("ESTO ES IS PLAYING \(titleName?.isPlaying) del play")
                            } catch {
                                print("Sound initialization failed")
                            }
        
        // Seteo label Audioplayer
        let label1 = UILabel()
        label1.text = titleName?.title
        label1.font = UIFont.systemFont(ofSize: 30)
        label1.textColor = UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 1)
        label1.backgroundColor = UIColor(red: 255.0, green: 100, blue: 225.0, alpha: 0.7)
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.textAlignment = .center
        label1.autoresizingMask = .flexibleWidth
        self.view.addSubview(label1)
        label1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        label1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive     = true
        label1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive  = true
        
        //imagencancion.setIm
        
        
   
        
         let label2 = UILabel()
         label2.text = titleName?.artist
         label2.font = UIFont.systemFont(ofSize: 15)
         label2.textColor = UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 1)
         label2.backgroundColor = UIColor(red: 255.0, green: 100, blue: 225.0, alpha: 0.7)
         label2.translatesAutoresizingMaskIntoConstraints = false
         label2.textAlignment = .center
         label2.autoresizingMask = .flexibleWidth
         self.view.addSubview(label2)
        
         label2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 285).isActive = true
         label2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100).isActive     = true
         label2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -105).isActive  = true
         
        
        // Seteo label Volumen
        let label3 = UILabel()
        label3.text = "Volumen"
        label3.font = UIFont.systemFont(ofSize: 15)
        label3.autoresizingMask = .flexibleWidth
        label3.translatesAutoresizingMaskIntoConstraints = true
        label3.textColor = UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 1)
        
        label3.frame = CGRect (x: 30, y: 440, width: self.view.frame.width, height: 50)
        label3.textAlignment = .left
        self.view.addSubview(label3)
        
        // Seteo botones:
        
        //buttomplay.frame=CGRect(x: 130, y: 340, width: 80, height: 80)
        buttomplay.tintColor=UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 1)
        buttomplay.translatesAutoresizingMaskIntoConstraints=false
        buttomplay.autoresizingMask = .flexibleLeftMargin
        self.view.addSubview(buttomplay)
        buttomplay.trailingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 178).isActive = true
        buttomplay.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -180).isActive = true
        buttomplay.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        
        //buttommenu.frame=CGRect(x: 165, y: 340, width: 40, height: 40)
        buttommenu.tintColor=UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 1)
        buttommenu.translatesAutoresizingMaskIntoConstraints=false
        buttommenu.autoresizingMask = .flexibleLeftMargin
        
        buttommenu.addAction(UIAction(title: "", handler: { (_) in
            print("Default Action")
        }), for: .touchUpInside)
        buttommenu.menu = addMenuItems()
        self.view.addSubview(buttommenu)
        buttommenu.trailingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 218).isActive = true
        buttommenu.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -180).isActive = true
        buttommenu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        
        
        //buttomstop.frame=CGRect(x: 200, y: 340, width: 80, height: 80)
        buttomstop.tintColor=UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 1)
        buttomstop.translatesAutoresizingMaskIntoConstraints=false
        //buttomstop.autoresizingMask = .flexibleRightMargin
        
        self.view.addSubview(buttomstop)
        //buttomstop.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: -30).isActive = true
        buttomstop.trailingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 255).isActive = true
        buttomstop.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -180).isActive = true
        //buttomstop.leadingAnchor.constraint(equalTo: buttommenu.trailingAnchor, constant: 10)
        //buttomstop.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        buttomstop.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        
       
         buttomdismiss.frame=CGRect(x: 5, y: 40, width: 80, height: 80)
         buttomdismiss.tintColor=UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 1)
         buttomdismiss.translatesAutoresizingMaskIntoConstraints=true
         buttomdismiss.autoresizingMask = .flexibleRightMargin
         self.view.addSubview(buttomdismiss)
         buttomdismiss.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 160).isActive = true
        
        
        
        
        // Seteo imagen
        imagen.frame=CGRect(x: 105, y: 115, width: 200, height: 200)
        imagen.translatesAutoresizingMaskIntoConstraints=true
        imagen.autoresizingMask = .flexibleLeftMargin
        self.view.addSubview(imagen)
    
        // Seteo slider 1:
        Songslider.maximumValue = Float(mySound!.duration)
        Songslider.tintColor=UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 1)
        Songslider.thumbTintColor=UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 1)
        //Songslider.frame=CGRect(x: 20, y: 370, width: self.view.frame.width-40, height: 50)
        Songslider.frame=CGRect(x: 20, y: 390, width: self.view.frame.width-40, height: 50)
        self.view.addSubview(Songslider)
        
        // Seteo slider 2:
        slider.frame=CGRect(x: 20, y: 470, width: self.view.frame.width-250, height: 50)
        slider.tintColor=UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 1)
        slider.thumbTintColor=UIColor(red: 255.0, green: 0, blue: 225.0, alpha: 1)
        self.view.addSubview(slider)
        slider.value = 1

        
        // buscar gif
        guard let laURL = Bundle.main.url(forResource: "WAVE-1s", withExtension: ".gif") else {return}
        let elGIF = UIImage.animatedImage(withAnimatedGIFURL: laURL)
        let imgContainer = UIImageView(image: elGIF)
            
        // Seteo del gif
        imgContainer.autoresizingMask = .flexibleWidth
        imgContainer.translatesAutoresizingMaskIntoConstraints=true
        imgContainer.frame=CGRect(x: 0, y: 520, width: self.view.frame.width, height: 150)
        self.view.addSubview(imgContainer)
        
        
        vista.backgroundColor = .white .withAlphaComponent(0)//UIColor(named: "Color")? .withAlphaComponent(0.4)
        vista.isHidden = true
        vista.layer.cornerRadius = 20
        self.view.addSubview(vista)
        vista.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        vista.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        vista.heightAnchor.constraint(equalToConstant: 200).isActive = true
        vista.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        Gif.alpha = 0
        Gif.isHidden = true
        // Seteo del gif
        Gif.autoresizingMask = .flexibleWidth
        Gif.translatesAutoresizingMaskIntoConstraints=false
        
        self.view.addSubview(Gif)
        Gif.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        Gif.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        //Gif.widthAnchor.constraint(equalToConstant: 200).isActive = true
        Gif.heightAnchor.constraint(equalToConstant: 200).isActive = true
        Gif.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        label.alpha = 0
        label.isHidden = true
        self.view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -65).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        
        
        
    }
    func agregarcancion() {
       // delegado = self
       //delegado = self as? TracksDelegate
        let playlist = PlayListDetailControllerTableViewController()
        self.delegado = playlist.self
        if delegado != nil {
                            let track = misTracks.firstIndex(of: self.titleName!)
                            let track2 = misTracks[indexDelTrack!]
                            self.delegado?.addTrackto(track: track2)
                            //self.delegado?.estadoPlayer(estado: false, cell: cell)
            
            playlist.tv.reloadData()
            //print(track)
            //print(track2)
        }
    }
    
    func addMenuItems() -> UIMenu {
        
        let menuItems = UIMenu(title: "", options: .displayInline, children: [
            UIAction(title: "Delete from Library", image: UIImage(systemName: "trash"), handler: { (_) in
                misTracks.remove(at: self.indexDelTrack!)
            }),
            
            UIAction(title: "Dowload", image: UIImage(systemName: "arrow.down.circle"), handler: { (_) in
                DownloadManager.shared.startDownload(url: URL(string: "https://speed.hetzner.de/100MB.bin")!)
                
            }),
            
            UIAction(title: "Add to Playlist...", image: UIImage(systemName: "text.badge.plus"), handler: { (_) in
            
                self.agregarcancion()
            
            }),
            
            UIAction(title: "Shere Song...", image: UIImage(systemName: "square.and.arrow.up"), handler: { (_) in
                let song = [self.titleName?.artist, self.titleName?.title]
                                                let ac = UIActivityViewController(activityItems: song as [Any], applicationActivities: nil)
                                                ac.popoverPresentationController?.sourceView = self.view
                                                self.present(ac, animated: true)
            }),
            
            UIAction(title: "View Full Lyrics", image: UIImage(systemName: "music.note.list"), handler: { (_) in
                self.showSimpleAlert(Mensaje: "Letra de la cancion", Titulo: "Letra")
            }),
            
            UIAction(title: "Share Lyrics...", image: UIImage(systemName: "shareplay"), handler: { (_) in
                let song = [self.titleName?.artist, self.titleName?.title]
                                                let ac = UIActivityViewController(activityItems: song as [Any], applicationActivities: nil)
                                                ac.popoverPresentationController?.sourceView = self.view
                                                self.present(ac, animated: true)
            }),
            
            UIAction(title: "Show Album", image: UIImage(systemName: "music.note"), handler: { (_) in
                print("Copy")
            }),
            
            UIAction(title: "Create Station", image: UIImage(systemName: "badge.plus.radiowaves.right"), handler: { (_) in
                print("Copy")
            }),
            
            UIAction(title: "Love", image: UIImage(systemName: "heart"), handler: { (_) in
                self.vistaCustom(vista: self.vista, texto: "hola", gif: self.Gif, label: self.label)
            }),
            
            UIAction(title: "Suggest Less Like This", image: UIImage(systemName: "hand.thumbsdown.fill"), handler: { (_) in
                print("Copy")
            })
        ])
        
        return menuItems
        
    }
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
        titleName?.isPlaying = isPlaying
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeButtonIcon")
                                        ,object: self.titleName?.isPlaying)
        
        
        
        //mySound?.stop()
        //let repro = BotonDestacado()
        //repro.setImage(icon: UIImage(named: "play.png"))
        //let botoncito = BotonDestacado()
        //self.delegadoPlayer = botoncito.self
        //let player = isPlaying
        //if delegadoPlayer != nil {
        //self.delegadoPlayer?.estadoPlayer(estado: player)
        //}
        }
    
    // Funcionalidad Shake:
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if isPlaying {
            //isPlaying = false
            
            mySound?.play()
        } else {
            //isPlaying = true
            mySound?.fadeOut()
            }
        }
 }



