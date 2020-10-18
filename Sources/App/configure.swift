import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) throws {
	// Serves files from `Public/` directory
	app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

	// Configure Leaf
	app.views.use(.leaf)
	app.leaf.cache.isEnabled = app.environment.isRelease

	app.http.server.configuration.port = 7777
    // register routes
    try routes(app)
}
