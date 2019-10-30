//
//  Professor.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 24/09/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public struct Professor: Codable, Displayable {
    public var displayName: String {
        return name ?? ""
    }
    let id: Int
    let name: String
    let lastName: String
    let username: String
    let dateOfBirth: String
}
