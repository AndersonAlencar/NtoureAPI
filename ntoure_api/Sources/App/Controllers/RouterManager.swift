//
//  File.swift
//  
//
//  Created by Anderson Alencar on 14/06/20.
//

import Foundation
import Fluent
import Vapor

//class RouterManager {
//
//    
//    let dataBase = DataBase()
//    
//    func getReduceLocations(req: Request) -> [ReducePlace]? {
//        let reducePlaces = dataBase.places.map { (place) -> ReducePlace in
//            let place = ReducePlace(placeID: place.Id, photo: place.coverPhoto, name: place.namePlace, distance: place.distance)
//            return place
//        }
//        
//        return reducePlaces.isEmpty ? nil:reducePlaces
//    }
//    
//    func getPlaceInformation(req: Request) -> Place? {
//        
//        let id = Int(req.parameters.get("placeID")!)!
//        
//        let place = dataBase.places.filter { (place) -> Bool in
//            return id == place.Id
//        }
//        
//        if place.isEmpty {
//            return nil
//        }
//        return place.first!
//    }
//    
//    func getAllAdventures(req: Request) -> [Adventure]? {
//        let id = Int(req.parameters.get("placeID")!)!
//        
//        let adventures = dataBase.adventures.filter { (adventure) -> Bool in
//            return adventure.placeID == id
//        }
//        return adventures.isEmpty ? nil:adventures
//    }
//    
//    func getStandardAdventures(req: Request) -> [Adventure]? {
//        let id = Int(req.parameters.get("placeID")!)!
//        
//        var adventures = dataBase.adventures.filter { (adventure) -> Bool in
//            return adventure.placeID == id
//        }
//        adventures = Array(adventures.prefix(3))
//        return adventures.isEmpty ? nil:adventures
//    }
//}
//


class RoutesController {
    
    static func newPlace(req: Request) throws -> EventLoopFuture<Place?>{
        var place = Place()
        do {
            place = try req.content.decode(Place.self)
        } catch {
            print(error.localizedDescription)
            throw(Abort(.badRequest))
        }
        return place.create(on: req.db)
            .map { place }
    }
    
    static func getReducePlace(req: Request) -> EventLoopFuture<[ReducePlace]> {
        return Place.query(on: req.db).all().mapEach { (place) -> ReducePlace in
            ReducePlace(placeID: place.id!, photo: place.coverPhoto, name: place.namePlace, distance: place.distance)
        }
    }
    
    static func getPlaceInformation(req: Request) -> EventLoopFuture<Place> {
        let id = UUID(req.parameters.get("placeID")!)!
        return Place.query(on: req.db).filter(\.$id == id).first().unwrap(or: HTTPResponseStatus.notFound as! Error)
        
    }
    
    static func getAllAdventures(req: Request) -> EventLoopFuture<[Adventure]> {
        let id = UUID(req.parameters.get("placeID")!)!
        return Adventure.query(on: req.db).filter(\.$place.$id == id).all()
        
    }
    
    static func getStandardAdventures(req: Request) -> EventLoopFuture<[Adventure]> {
        let id = UUID(req.parameters.get("placeID")!)!
        return Adventure.query(on: req.db).filter(\.$place.$id == id).range(..<2).all()
    }
    
    static func newAdventure(req: Request) throws -> EventLoopFuture<Adventure?> {
        var adventure = Adventure()
        do {
            adventure = try req.content.decode(Adventure.self)
        } catch {
            print(error.localizedDescription)
            throw(Abort(HTTPResponseStatus.badRequest))
        }
        return adventure.create(on: req.db)
        .map { adventure }
        
    }
    
    static func delete(req: Request) -> EventLoopFuture<Void> {
        return Adventure.query(on: req.db).filter(\.$activityName == "Parapente").delete()
    }
    
    
}

