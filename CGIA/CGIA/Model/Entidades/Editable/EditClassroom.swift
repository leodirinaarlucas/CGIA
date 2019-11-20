//
//  EditClassroom.swift
//  CGIA
//
//  Created by Lucas Fernandez Nicolau on 18/11/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public struct EditClassroom: Codable {
    var name: String
    var subjectID: Int
    var instructorID: Int
    var active: Bool
}
