//
//  CompleteStudent.swift
//  CGIA
//
//  Created by Rafael Galdino on 03/11/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public struct CompleteStudent: Codable, Displayable {
    public var displayName: String {
        return name ?? ""
    }
    var id: Int?
    var userID: Int?
    var name: String?
    var lastName: String?
    var dateOfBirth: String?
    var classrooms: [Classroom]?
    var grades: [Grade]?
}
