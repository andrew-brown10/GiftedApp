//
//  RequestModels.swift
//  GiftedApp
//
//  Created by Andrew Brown on 1/15/25.
//

import Foundation

struct CreateUserRequestModel: Codable {
    var Id: String
    var FirstName: String
    var LastName: String
    var Email: String
}
