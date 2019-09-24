//
//  Turma.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 24/09/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public class Turma {
    public private(set) var identificador: String

    public private(set) var instituicao: Instituicao
    public private(set) var disciplina: Disciplina
    public private(set) var professor: Professor
    public private(set) var alunos: [Aluno] = []
    public private(set) var notas: [Notas] = []
    public private(set) var periodo: Periodo

    public init(disciplina: Disciplina, professor: Professor, periodo: Periodo) {
        self.disciplina = disciplina
        self.instituicao = disciplina.instituicao
        self.professor = professor
        self.periodo = periodo
        identificador = "2019/2"
    }
}
