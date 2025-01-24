//
//  GiftRecipient.swift
//  GiftedApp
//
//  Created by Zach Stevens-Lindsey on 1/22/25.
//

import Foundation
import SwiftData

struct GiftRecipientData {
    var relationshipToUser: String
    var name: String
    var age: Int
    var occasion: String
    var hobbies: String
    var priceRange: ClosedRange<Int>
}
