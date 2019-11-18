//
//  EditStudent.swift
//  CGIA
//
//  Created by Lucas Fernandez Nicolau on 17/11/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public struct EditStudent: Codable {
    var userID: Int
    var name: String
    var lastName: String
    var dateOfBirth: String

//    init(userID: Int, name: String, lastName: String, dateOfBirth: String) {
//        self.userID = userID
//        self.name = name
//        self.lastName = lastName
//        self.dateOfBirth = dateOfBirth
//        super.init()
//    }
//
//    required init(from decoder: Decoder) throws {
//        fatalError("init(from:) has not been implemented")
//    }
}
