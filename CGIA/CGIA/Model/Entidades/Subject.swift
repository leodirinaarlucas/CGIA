//
//  Disciplina.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 24/09/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public struct Subject: Codable, Displayable {
    public var displayName: String {
        return name ?? ""
    }
    let id: Int?
    let name: String?
    var classrooms: [Classroom]?
}
