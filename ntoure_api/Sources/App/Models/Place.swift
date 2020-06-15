//
//  File.swift
//  
//
//  Created by Anderson Alencar on 14/06/20.
//

import Foundation
import Vapor

struct Place: Content {
    let Id: Int
    var namePlace: String
    var description: String
    var coverPhoto: Data
    var presetationPhotos: [Data]
    var location: String // Por enquanto
    var distance: String
}


struct ReducePlace: Content {
    var placeID: Int
    var photo: Data
    var name: String
    var distance: String
}
