//
//  Usuario.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 24/09/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public struct User: Codable {
    var id: Int?
    var username: String?
    var password: String?
    var profile: String?
}
