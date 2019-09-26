//
//  Admin.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 24/09/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public class Admin: Usuario {
    public private(set) var instituicao: Instituicao

    public init(instituicao: Instituicao, nome: String, username: String) {
        self.instituicao = instituicao
        super.init(nome: nome, username: username)
    }

    public init(instituicao: Instituicao, usuario: Usuario) {
        self.instituicao = instituicao
        super.init(nome: usuario.nome, username: usuario.username)
    }
}
