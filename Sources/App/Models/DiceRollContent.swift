//
//  File.swift
//  
//
//  Created by Micah A. Walles on 10/15/20.
//

import Foundation
import Vapor

struct DiceRollContent: Encodable {
	let title: String
	let error: Bool
	let roll: String?
	let keep: String?
	let bonus: String?
	let calledRasies: String?
	let freeRasies: String?
	let emphasis: Bool
	let explode9: Bool
	let description: RollDescription?
}
