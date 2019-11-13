//
//  CompleteClassroom.swift
//  CGIA
//
//  Created by Lucas Fernandez Nicolau on 06/11/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public struct CompleteClassroom: Codable, Displayable {
    public var displayName: String {
        return name ?? ""
    }
    let id: Int?
    let name: String?
    let subjectID: Int?
    let instructorID: Int?
    var grades: [Grade]?
    var instructor: Instructor?
    var subject: Subject?
    var students: [Student]?
}
