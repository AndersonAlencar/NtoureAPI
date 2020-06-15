//
//  File.swift
//  
//
//  Created by Anderson Alencar on 14/06/20.
//

import Foundation
import Vapor

class RouterManager {
    
    let dataBase = DataBase()
    
    func getReduceLocations(req: Request) -> [ReducePlace]? {
        let reducePlaces = dataBase.places.map { (place) -> ReducePlace in
            let place = ReducePlace(placeID: place.Id, photo: place.coverPhoto, name: place.namePlace, distance: place.distance)
            return place
        }
        
        return reducePlaces.isEmpty ? nil:reducePlaces
    }
    
    func getPlaceInformation(req: Request) -> Place? {
        
        let id = Int(req.parameters.get("placeID")!)!
        
        let place = dataBase.places.filter { (place) -> Bool in
            return id == place.Id
        }
        
        if place.isEmpty {
            return nil
        }
        return place.first!
    }
    
    func getAllAdventures(req: Request) -> [Adventure]? {
        let id = Int(req.parameters.get("placeID")!)!
        
        let adventures = dataBase.adventures.filter { (adventure) -> Bool in
            return adventure.placeID == id
        }
        return adventures.isEmpty ? nil:adventures
    }
    
    func getStandardAdventures(req: Request) -> [Adventure]? {
        let id = Int(req.parameters.get("placeID")!)!
        
        var adventures = dataBase.adventures.filter { (adventure) -> Bool in
            return adventure.placeID == id
        }
        adventures = Array(adventures.prefix(3))
        return adventures.isEmpty ? nil:adventures
    }
}
