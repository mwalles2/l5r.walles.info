//
//  File.swift
//  
//
//  Created by Micah A. Walles on 10/14/20.
//

import Foundation
import Vapor
import RollAndKeepSystem

final class DiceRollController {
	private let title = "L5R Dice Roller"

	func index(_ req: Request) throws -> EventLoopFuture<View> {
		return req.view.render("index", DiceRollContent(title: title,
														error: false,
														roll: nil,
														keep: nil,
														bonus: nil,
														calledRasies: nil,
														freeRasies: nil,
														emphasis: false,
														explode9: false,
														description: nil))
	}

	func roll(_ req: Request) throws -> EventLoopFuture<View> {
		let diceRoll = try req.content.decode(DiceRoll.self)

		let error: Bool
		let description: RollDescription?

		let shouldRollEmpasis = diceRoll.emphasis == "checked"
		let shouldExplode9 = diceRoll.explode9 == "checked"
		if let roll = Int(diceRoll.roll),
		   let keep = Int(diceRoll.keep),
		   let bonus = toInt(diceRoll.bonus),
		   roll > keep {
			error = false
			let rollValue = RollAndKeepRoll(name: "Unnamed",
											 roll: roll,
											 keep: keep,
											 bonus: bonus,
											 explodeOn9: shouldExplode9,
											 emphasis: shouldRollEmpasis)
			let result = rollValue.roll()
			description = RollDescription(rollValue: result.total,
										  rollExplanation: result.result,
										  diceRolled: result.diceRolled)
		} else {
			error = true
			description = nil
		}

		return req.view.render("index", DiceRollContent(title: title,
														error: error,
														roll: diceRoll.roll,
														keep: diceRoll.keep,
														bonus: diceRoll.bonus,
														calledRasies: nil,
														freeRasies: nil,
														emphasis: shouldRollEmpasis,
														explode9: shouldExplode9,
														description: description))
	}

	private func toInt(_ value: String) -> Int? {
		guard !value.isEmpty else {
			return 0
		}
		return Int(value)
	}
}

struct RollDescription: Content {
	/// The total that was rolled
	let rollValue: Int

	/// What dice where rolled and what there values are
	let rollExplanation: String

	/// Exactly how many dice are rolled and what modifiers where added to it
	let diceRolled: String
}
