//
//  CompleteInstructor.swift
//  CGIA
//
//  Created by Lucas Fernandez Nicolau on 31/10/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public struct CompleteInstructor: Codable, Displayable {
    public var displayName: String {
        return name ?? ""
    }
    let id: Int?
    var userID: Int?
    let name: String?
    let lastName: String?
    let dateOfBirth: String?
    var classrooms: [Classroom]?
}
