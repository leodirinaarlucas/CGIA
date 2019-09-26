//
//  Instituicao.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 24/09/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public class Instituicao {
    public private(set) var nome: String

    public private(set) var admins: [Admin] = []
    public private(set) var professores: [Professor] = []
    public private(set) var alunos: [Aluno] = []

    public private(set) var disciplinas: [Disciplina] = []

    public init() {
        nome = "Colégio Angélica"
    }
}
