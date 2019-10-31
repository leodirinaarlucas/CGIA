//
//  CompleteInstructor.swift
//  CGIA
//
//  Created by Lucas Fernandez Nicolau on 31/10/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

struct CompleteInstructor: Codable {
    let id: Int?
    let name: String?
    let lastName: String?
    let dateOfBirth: String?
    var classrooms: [Classroom]?
    var userID: Int?
}
