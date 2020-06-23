//
//  File.swift
//  
//
//  Created by Anderson Alencar on 14/06/20.
//

import Foundation
import Fluent
import Vapor

final class Adventure: Model, Content {
    // Name of the table or collection.
    static let schema = "adventures"
    
    // Unique identifier for this Place.
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "photoActivity")
    var photoActivity: Data
    
    @Field(key: "activityName")
    var activityName: String
    
    @Field(key: "location")
    var location: [String]
    
    @Field(key: "category")
    var category: Int
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "status")
    var status: Bool
    
    @Field(key: "care")
    var care: [String]
    
    @Field(key: "phoneNumber")
    var phoneNumber: String

    @Field(key: "address")
    var address: String
    
    @Parent(key: "place_id")
    var place: Place // relacão com o place
    
    init() { }

    init(id: UUID? = nil, photoActivity: Data, activityName: String, location: [String], category: Int, description: String, status: Bool, care: [String], phoneNumber: String, address: String, placeID: UUID) {
        self.id = id
        self.photoActivity = photoActivity
        self.activityName = activityName
        self.location = location
        self.category = category
        self.description = description
        self.status = status
        self.care = care
        self.phoneNumber = phoneNumber
        self.address = address
        self.$place.id = placeID
    }
}
