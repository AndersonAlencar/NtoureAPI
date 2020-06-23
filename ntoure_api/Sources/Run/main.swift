import App
import Vapor

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)
app.routes.defaultMaxBodySize = "1000kb"
defer { app.shutdown() }
try configure(app)
try app.run()
