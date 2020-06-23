import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    
    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        username: Environment.get("DATABASE_USERNAME") ?? "admin_ntoure",
        password: Environment.get("DATABASE_PASSWORD") ?? "233421",
        database: Environment.get("DATABASE_NAME") ?? "ntoureDB"
    ), as: .psql)
    
    app.migrations.add(CreatePlace())
    app.migrations.add(CreateAdventure())

    // register routes
    try routes(app)
}
