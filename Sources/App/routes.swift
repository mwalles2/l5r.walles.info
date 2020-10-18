import Vapor

func routes(_ app: Application) throws {

	let rollController = DiceRollController()
	app.get("", use: rollController.index)
	app.post("", use: rollController.roll)
}
