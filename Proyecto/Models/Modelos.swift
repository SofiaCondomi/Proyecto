//
//  Modelos.swift
//  Proyecto
//
//  Created by Sofia Condomi on 29/10/2021.
//

import Foundation


struct Acounts {
    let user: String
    let pass: String
}

struct Registered {
  let user1: Acounts = Acounts(user: "sofia@gmail.com", pass: "12345678910")
}

struct Track: Codable, Hashable {
    let title: String?
    let artist: String?
    let album: String?
    let song_id: String?
    let genre: String?
    var isPlaying: Bool = false
    //let duration: String?
    
    enum CodingKeys: String, CodingKey {
        case artist
        case title = "name"
        case album
        //case duration
        case genre
        case song_id = "song_id"
    }
}


enum Genero: String, Codable {
    case Rock
    case Pop
    case Otros
    case vacio = ""
}
/*
enum PlayerStates {
    case play
    case pause
    case next
    case previous
}
*/

var tracks = Set<Track>()
var tracksArray = [Track]()
var misTracks = [Track]()
/*
let misTracks = [     Track(title:"Like A Rolling Stone", artist:"Bob Dylan", album:"", song_id: "", genre: "", duration: ""),
                          Track(title:"Walk On The Wild Side", artist:"Lou Reed", album:"", song_id: "", genre: "", duration: ""),
                          Track(title:"Take It Or Leave It ", artist:"Cage The Elpehant", album:"", song_id: "", genre: "", duration: ""),
                          Track(title:"Blackbird", artist:"The Beatles", album:"", song_id: "", genre: "", duration: ""),
                          Track(title:"Show Must Go On", artist:"Queen", album:"", song_id: "", genre: "", duration: ""),
                          Track(title:"Loco En El Desierto", artist:"Conociendo Rusia", album:"", song_id: "", genre: "", duration: ""),
                        ]
*/
