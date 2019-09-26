//
//  Disciplina.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 24/09/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public class Disciplina: Displayable {
    public var displayName: String {
        return nome
    }
    public private(set) var nome: String

    public private(set) var instituicao: Instituicao
    public private(set) var turmas: [Turma] = []

    public init(instituicao: Instituicao, nome: String) {
        self.instituicao = instituicao
        self.nome = nome
    }
}
