//
//  RegisterViewModel.swift
//  Proyecto
//
//  Created by Sofia Condomi on 17/12/2021.
//

import Foundation
import UIKit
import CoreData

class RegisterViewModel: UIViewController {
    let model: Registered = Registered()
    var validUser = false
    
    
    
    
    //, alerta:UIView, textoalerta:UILabel
    func botonLoginTouch(email:String?, alerta:UIView, textoalerta:UILabel) {
        
        //Desempaquetado Mail -------------------------
        guard let user = email, !user.isEmpty else {
            let texto = "Ingresar Email o Username"
            DispatchQueue.main.asyncAfter(deadline: .now()+0.6) {
                Animaciones.alertaanimada(alerta: alerta, textoalerta: textoalerta, texto: texto)
            }
            return
            }
        let model: Registered = Registered()
//        if user = model.user1.user {
//            validacion = false
//        }
        //Registro ----------------------------------
        let resultadomail: Bool = chequeoMail(mailIngresado: user)
        
        
        
        if resultadomail == true && user != model.user1.user {
            print ("Registrar mail")
            validUser = true
            savedData()
            let callBack: ([Track]?, Error?) -> () = { canciones, error in
                if error != nil {
                    print("no se pudo obtener canciones")
    
                }
                else {
                    misTracks = canciones ?? []
                    
                }
                
            }
           
        } else {
            
            print("Formato de mail incorrecto")
            
            if user == model.user1.user {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.6) {
                    let texto = "Usuario ya registrado"
            Animaciones.alertaanimada(alerta: alerta, textoalerta: textoalerta, texto: texto)
                }
            } else {
            let texto = "Formato de mail incorrecto"
            Animaciones.alertaanimada(alerta: alerta, textoalerta: textoalerta, texto: texto)
            }
        }
        
    }

//--Validacion de Mail ---------------
        
    func chequeoMail (mailIngresado: String) -> Bool {
        let patron = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let regExp = try! NSRegularExpression(pattern: patron, options: [])
        let coincidencias = regExp.matches(in: mailIngresado, options: [], range: NSRange(location: 0, length: mailIngresado.count))
        if coincidencias.count == 1 {
                return true
        }
        else {
                return false
        }
    }
    
    func savedData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.managedObjectContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tracklist")
        request.returnsDistinctResults = false
        
        do {
            let result = try context!.fetch(request)
            misTracks = [Track]()
            
            for data in result as! [NSManagedObject] {
                let title = data.value(forKey: "title") as? String
                let artist = data.value(forKey: "artist") as? String
                let album = data.value(forKey: "album") as? String
                let genre = data.value(forKey: "genre") as? String
                let songId = data.value(forKey: "song_id") as? String
                
                let track = Track(title: title ?? "",
                                  artist: artist ?? "",
                                  album: album ?? "",
                                  song_id: songId ?? "",
                                  genre: genre ?? "",
                                  isPlaying: false)
                misTracks.append(track)
                
                
            }
            
        } catch {
            print("Fallo al obtener info de la BD, \(error), \(error.localizedDescription)")
        }
        
        downloadTracks()
        if false {// Poner la validacion de si hay o no internet
            //
        }
    }
    
    func downloadTracks() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.managedObjectContext
        
        RestServiceManager.shared.getToServer(responseType: [Track].self, method: .get, endpoint: "songs") {
            status, data in
            misTracks = [Track]()
            if let _data = data {
                misTracks = _data
                
                // CORE DATA
                if let _context = context {
                    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Tracklist")
                    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                    
                    do {
                        try  appDelegate.persistentStoreCoordinator?.execute(deleteRequest, with: _context)
                    } catch {
                        print(error)
                    }
                    
                    // Agregar contenido
                    for item in _data {
                        guard let tracksEntity = NSEntityDescription.insertNewObject(forEntityName: "Tracklist", into: _context) as? NSManagedObject else {
                            return
                        }
                        tracksEntity.setValue(item.artist, forKey: "artist")
                        tracksEntity.setValue(item.genre, forKey: "genre")
                        tracksEntity.setValue(item.album, forKey: "album")
                        tracksEntity.setValue(item.song_id, forKey: "song_id")
                        tracksEntity.setValue(item.title, forKey: "title")
                        tracksEntity.setValue(item.isPlaying , forKey: "isPlaying")
                        do {
                            try _context.save()
                        } catch {
                            print("No se guardo la info \(error), \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    }
}
