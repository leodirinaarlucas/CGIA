//
//  Student.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 09/10/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public struct Student: Codable, Displayable  {
    public var displayName: String {
        return name ?? ""
    }
    
    var id: Int?
    var name: String?
}
