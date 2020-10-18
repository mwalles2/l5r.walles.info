//
//  DiceRoll.swift
//  
//
//  Created by Micah A. Walles on 10/13/20.
//

import Foundation
import Vapor

struct DiceRoll: Content {
	let roll: String
	let keep: String
	let bonus: String
	let emphasis: String?
	let explode9: String?
}
