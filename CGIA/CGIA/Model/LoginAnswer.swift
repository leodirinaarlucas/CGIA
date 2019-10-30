//
//  LoginAnswer.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 24/09/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public enum UserType: String {
    case student
    case instructor
    case admin
}

public enum LoginAnswer {
    case successful(User)
    case fail
}
