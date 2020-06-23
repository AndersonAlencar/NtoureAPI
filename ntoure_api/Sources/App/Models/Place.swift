//
//  File.swift
//  
//
//  Created by Anderson Alencar on 14/06/20.
//

import Foundation
import Fluent
import Vapor

final class Place: Model, Content {
    // Name of the table or collection.
    static let schema = "places"

    // Unique identifier for this Place.
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "namePlace")
    var namePlace: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "coverPhoto")
    var coverPhoto: Data
    
    @Field(key: "presentationPhotos")
    var presentationPhotos: [Data]
    
    @Field(key: "location")
    var location: [String]
    
    @Field(key: "distance")
    var distance: String
    
    @Children(for: \.$place)
    var adventures: [Adventure]
    
    init() { }
    
    init(id: UUID? = nil, namePlace: String, description: String, coverPhoto: Data, presentationPhotos: [Data], location: [String], distance: String) {
        self.id = id
        self.namePlace = namePlace
        self.description = description
        self.coverPhoto = coverPhoto
        self.presentationPhotos = presentationPhotos
        self.location = location
        self.distance = distance
    }
}


struct ReducePlace: Content {
    var placeID: UUID
    var photo: Data
    var name: String
    var distance: String
}
