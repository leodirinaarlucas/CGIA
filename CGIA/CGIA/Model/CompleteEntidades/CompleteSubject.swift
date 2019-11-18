//
//  CompleteSubject.swift
//  CGIA
//
//  Created by Lucas Fernandez Nicolau on 31/10/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public struct CompleteSubject: Codable, Displayable {
    public var displayName: String {
        return name ?? ""
    }
    let id: Int?
    let name: String?
    var classrooms: [Classroom]?
}
