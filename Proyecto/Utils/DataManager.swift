//
//  DataManager.swift
//  Proyecto
//
//  Created by Sofia Condomi on 18/11/2021.
//

import Foundation


class DataManager {
    
    static func cancionesPorGenero(tracks:[Track]) -> [Track] {
        return tracks.filter { i in
            i.genre != nil
        }
    }
}
