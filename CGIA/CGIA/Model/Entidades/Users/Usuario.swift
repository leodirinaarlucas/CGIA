//
//  Usuario.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 24/09/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public class Usuario: Displayable {
    public var displayName: String {
        return nome
    }

    public private(set) var nome: String
    public private(set) var username: String

    public init(nome: String, username: String) {
        self.nome = nome
        self.username = username
    }
}
