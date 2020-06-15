import Vapor

func routes(_ app: Application) throws {
    
    let manager = RouterManager()
    
    app.group("place") { place in
        place.get("allReducePlaces") { req -> [ReducePlace] in
            guard let places = manager.getReduceLocations(req: req) else{
                throw Abort(.badRequest)
            }
            return places
        }

        place.get("placeInformations", ":placeID") { req -> Place in
            guard let place = manager.getPlaceInformation(req: req) else {
                throw Abort(.badRequest)
            }
            return place
        }
    }
    
    app.group("adventure") { adventure in
        
        adventure.get("all",":placeID") { req -> [Adventure] in
            guard let adventures = manager.getAllAdventures(req: req) else {
                throw Abort(.badRequest)
            }
            return adventures
        }
        
        adventure.get("standard",":placeID") { req -> [Adventure] in
            guard let adventures = manager.getStandardAdventures(req: req) else {
                throw Abort(.badRequest)
            }
            return adventures
        }
    }
    
    
    
}
