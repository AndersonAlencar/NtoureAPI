import Vapor

func routes(_ app: Application) throws {
    
    app.group("place") { place in
        place.get("allReducePlaces") { req in
            return RoutesController.getReducePlace(req: req)
        }
        
        place.get("informations",":placeID") { req in
            return RoutesController.getPlaceInformation(req: req)
        }
        
        place.get("allPlacesWithAdventures") { req in
            Place.query(on: req.db).with(\.$adventures).all()
        }
        
        place.get("allPlaces") { req in
            return Place.query(on: req.db).all()
        }
        
        place.post("newPlace") { req in
            return try RoutesController.newPlace(req: req).unwrap(or: HTTPResponseStatus.badRequest as! Error)
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
            return try RoutesController.newAdventure(req: req).unwrap(or: HTTPResponseStatus.badRequest as! Error)
        }
        
        adventure.delete("delete") { req -> Adventure in
            RoutesController.delete(req: req)
            return Adventure()
        }
        
    }
}
