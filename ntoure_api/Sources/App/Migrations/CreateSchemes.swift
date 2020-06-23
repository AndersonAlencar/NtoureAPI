//
//  File.swift
//  
//
//  Created by Anderson Alencar on 21/06/20.
//

import Fluent

struct CreatePlace: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("places")
            .id()
            .field("namePlace", .string)
            .field("description", .string)
            .field("coverPhoto", .data)
            .field("presentationPhotos", .array(of: .data), .required) //required não permite valores nil
            .field("location", .array(of: .string)) // array
            .field("distance", .string)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("places").delete()
    }
}


struct CreateAdventure: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("adventures")
            .id()
            .field("photoActivity",.data)
            .field("activityName", .string)
            .field("location", .array(of: .string))
            .field("category", .int)
            .field("description", .string)
            .field("status", .bool)
            .field("care", .array(of: .string))
            .field("phoneNumber", .string)
            .field("address", .string)
            .field("place_id", .uuid, .references("places", "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("adventures").delete()
    }
}
