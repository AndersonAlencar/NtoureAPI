import Vapor

func routes(_ app: Application) throws {
    
    app.group("place") { place in
        place.get("allReducePlaces") { req in
            return RoutesController.getReducePlace(req: req)
        }
        
        place.get("informations",":placeID") { req in
            return RoutesController.getPlaceInformation(req: req)
        }
        
        place.get("allAdventures") { req in
            Place.query(on: req.db).with(\.$adventures).all()
        }
        
        place.post("newPlace") { req -> EventLoopFuture<Place> in
            let place = try req.content.decode(Place.self)
            return place.create(on: req.db)
                .map { place }
        }
    }
    
    app.group("adventure") { adventure in
        adventure.get("allAdventures") { req in
            Adventure.query(on: req.db).all()
        }
        
        adventure.get("standard",":placeID") { req in
            return RoutesController.getStandardAdventures(req: req)
        }
        
        adventure.get("all",":placeID") { req in
            return RoutesController.getAllAdventures(req: req)
        }
        adventure.post("newAdventure") { req in
            return RoutesController.newAdventure(req: req)
        }
    }
}
