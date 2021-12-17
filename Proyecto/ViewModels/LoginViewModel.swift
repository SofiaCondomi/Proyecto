//
//  LoginViewModel.swift
//  Proyecto
//
//  Created by Sofia Condomi on 14/12/2021.
//

import Foundation
import UIKit
import CoreData

class LoginViewModel: ViewController {
    let model: Registered = Registered()
    var validUser = false
    let caracteresPass = 10
    
    
    func botonLoginTouch(user:String?, pass:String?, alerta:UIView, textoalerta:UILabel) {
        //------ Desempaquetado Username -------------
        
        guard let user = user, !user.isEmpty else {
            //typeError = 1
            let texto = "Por favor, ingrese un usuario"
            DispatchQueue.main.asyncAfter(deadline: .now()+0.6) {
            Animaciones.alertaanimada(alerta: alerta, textoalerta: textoalerta, texto: texto)
            }
            return
        }
        
        //----- Desempaquetado Password -------------
        guard let pass = pass, !pass.isEmpty else {
            //typeError = 3
            let texto = "Por favor, ingrese un password"
            DispatchQueue.main.asyncAfter(deadline: .now()+0.6) {
            Animaciones.alertaanimada(alerta: alerta, textoalerta: textoalerta, texto: texto)
            }
            return
            }
        
        //----- Validacion final ----------------------
        let resultadomail: Bool = chequeoMail(mailIngresado : user)
        let resultadopass: Bool = chequeoPass(passIngresado : pass)
        
        let model: Registered = Registered()
        
        // Verifica y trae los datos de las canciones:
        if resultadomail == true, resultadopass == true {
            if model.user1.user == user && model.user1.pass == pass {
                print("Permitir ingreso")
                //usernameOk = true
                //passwordOk = true
                validUser = true
                
                //downloadTracks()
                savedData()
                } else {
                        print("Los datos ingresados no son correctos")
                        let texto = "Los datos ingresados no son correctos"
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.6) {
                        Animaciones.alertaanimada(alerta: alerta, textoalerta: textoalerta, texto: texto)
                        }
                        return
                        }
                } else {
                    print("Formato de email o password incorrecto")
                    let texto = "Formato de email o password incorrecto"
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.6) {
                    Animaciones.alertaanimada(alerta: alerta, textoalerta: textoalerta, texto: texto)
                    }
                    return
                    }
    

        //----- Validacion de Mail ---------------
    
        func chequeoMail (mailIngresado: String) -> Bool {
            let patron = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let regExp = try! NSRegularExpression(pattern: patron, options: [])
            let coincidencias = regExp.matches(in: mailIngresado, options: [], range: NSRange(location: 0, length: mailIngresado.count))
            if coincidencias.count == 1 {
                print ("Formato de email correcto")
                return true
            }
            else {
                print ("No es un email correcto")
                //typeError = 2
                return false
            }
        }

        //----- Validacion de Password ---------------
    
        func chequeoPass (passIngresado: String) -> Bool {
            if caracteresPass < passIngresado.count {
                print("Formato de password correcto")
                return true
        
            } else  {
                //typeError = 4
                print("Formato de password incorrecto")
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
        
        //----- Descargar listado de canciones ---------------
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
}
