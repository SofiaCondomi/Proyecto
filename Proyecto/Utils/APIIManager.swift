//
//  APIIManager.swift
//  Proyecto
//
//  Created by Sofia Condomi on 18/11/2021.
//

import Foundation
import Network
import WebKit
//import SystemConfiguration

class APIManager: ViewController {
    let baseURL = "https://raw.githubusercontent.com/beduExpert/Swift-Proyecto/main/API/db.json"
    
    static let shared = APIManager()
    static let getMusicEndpoint = "songs/"
    
    var monitor: NWPathMonitor!
    var webView : WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { Path in
                    var internetEstatus = 1 //Variable para chequear que hacer si hay o no internet
                    if Path.status == .satisfied { // Pregunta si hay internet
                        if Path.isExpensive { // Pregusta si es con datos
                            internetEstatus = 0 //Le da un valor a Internet Estatus para no descargar
                        }
                        else {
                            // Si hay conexión a internet por WiFi, entonces que descargue los datos
                            //self.descargarInfo()
                        }
                    }
                    else {
                        internetEstatus = -1 // No hay internet
                    }
                    if internetEstatus != 1 { // No hay internet o es solo celular
                        DispatchQueue.main.async {  // ES INDISPENSABLE regresar al hilo principal para poder presentar el alert, porque implica un cambio en la UI
                            let alert = UIAlertController(title:"Internet Status", message:"", preferredStyle: .alert)
                            var boton1:UIAlertAction
                            if internetEstatus == 0 {
                                alert.message = "Conexion a internet disponible por datos celulares, desea descargar la info?"
                                boton1 = UIAlertAction(title:"cancelar", style:.destructive, handler: nil)
                                let boton2 = UIAlertAction(title: "adelante", style: .default, handler:{ elAlert in
                                    //self.descargarInfo()
                                })
                                alert.addAction(boton2)
                            }
                            else {
                                alert.message = "Conexion a internet NO disponible"
                                boton1 = UIAlertAction(title:"enterado", style: .default, handler: nil)
                            }
                            alert.addAction(boton1)
                            self.present(alert, animated: true, completion: nil)
                        
                        }
                    } else {
                        DispatchQueue.main.async {
                            //self.descargarInfo()
                            //self.descargaInfoAsync()
                            //self.descargarDocumento()
                        }
                        }
                    }
                 // closure: bloque de código, que se puede usar como una variable
                let elKiu = DispatchQueue (label: "NetworkMonitor")
                monitor.start(queue: elKiu)
    }
    
    func getMusic(completion: @escaping ([Track]?, Error?) -> ()){
        let url : String = baseURL //+ APIManager.getMusicEndpoint
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if error != nil {
                completion(nil, error!)
            } else {
                if let data = data {
                    do {
                        let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [ String : Any ]
                        let songs = dict ["songs"] as! [[String:Any]]
                                                        let songsData = try JSONSerialization.data(withJSONObject: songs, options: .fragmentsAllowed)
                        let result = try JSONDecoder().decode([Track].self, from: songsData)
                        completion(result, nil)
                    }
                    catch {
                            print(String(describing: error))
                    }
            }
        }
    }
        task.resume()
    }
    
    
    
    func descargarInfo() {
        // https://i.pinimg.com/564x/02/b3/38/02b338c73f3470219a6287206dbe9137.jpg
        if let path = URL(string: "http://janzelaznog.com/DDAM/iOS/hojas.jpg") {
            do {
                let bytes = try Data(contentsOf: path)
                let imagen = UIImage(data: bytes)
                let imgView = UIImageView(image: imagen)
                imgView.frame = self.view.frame
                imgView.contentMode = .scaleAspectFit
                self.view.addSubview(imgView)
            }
            catch {
                print ("ocurrio un error al decargar la info " + error.localizedDescription)
                
            }
            
        }
        
    }
    
    func checkConnectivity()-> Int{
                ///Internet Status = 1 --> Hay conexion a Internet
                ///Internet Status = 0 --> Hay conexion a Internet pero es de Datos Moviles
                ///Internet Status = -1 --> No hay conexion a Internet
                var monitor:NWPathMonitor!
                monitor = NWPathMonitor()
                var internetEstatus = 1
                monitor.pathUpdateHandler = { Path in

                    if Path.status == .satisfied {
                        if Path.isExpensive { internetEstatus = 0 }
                    }
                    else {
                        internetEstatus = -1
                    }
                }
                return internetEstatus
            }

}

