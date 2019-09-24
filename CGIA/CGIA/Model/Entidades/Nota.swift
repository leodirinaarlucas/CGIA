//
//  Nota.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 24/09/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public class Notas {
    public private(set) var notas: [Double] = []

    public private(set) var turma: Turma
    public private(set) var aluno: Aluno

    public init(aluno: Aluno, turma: Turma) {
        self.turma = turma
        self.aluno = aluno
    }
}
