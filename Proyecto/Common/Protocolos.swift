//
//  Protocolos.swift
//  Proyecto
//
//  Created by Sofia Condomi on 14/12/2021.
//

import Foundation
import UIKit

protocol ButtonOnCellDelegate  {
    func buttonTouchedOnCell(celda: UITableViewCell)
}

protocol TracksPickerDelegate {
    func addTrack (track:Track)
}

protocol TracksDelegate {
    func addTrackto (track:Track)
    
    func estadoPlayer(estado:Bool)
}

