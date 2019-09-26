//
//  ServerManager.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 24/09/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public class ServerManager {

    // MARK: Properties
    public private(set) var usuario: Usuario?
    public private(set) var admins: [Admin] = []
    public private(set) var professores: [Professor] = []
    public private(set) var disciplinas: [Disciplina] = []
    public private(set) var turmas: [Turma] = []
    public private(set) var alunos: [Aluno] = []

    // MARK: Login
    public func authenticateLogin(username: String, completionHandler: (LoginAnswer) -> Void) {
        guard let user = usuario else {
            completionHandler(.fail)
            return
        }
        completionHandler(.successful(user))
    }

    /// MARK: Fetchs

    // MARK: Singleton Properties
    private init() {
    }

    class func shared() -> ServerManager {
        return sharedServerManager
    }

    private static var sharedServerManager: ServerManager = {
        let manager = ServerManager()
        manager.mockDatabase()
        return manager
    }()

    // MARK: Mockup
    private func mockDatabase() {
        let instituicao = Instituicao()
        let user = Usuario(nome: "Pedro", username: "31734391")
        let admin = Admin(instituicao: instituicao, usuario: user)
        admins.append(admin)
        usuario = admin

        let aluno = Aluno(instituicao: instituicao, nome: "Rafael", username: "12345")
        alunos.append(aluno)
        let professor = Professor(instituicao: instituicao, nome: "Artur", username: "54321")
        professores.append(professor)
        let disciplina = Disciplina(instituicao: instituicao, nome: "Matemágica")
        disciplinas.append(disciplina)
        let turma = Turma(disciplina: disciplina, professor: professor, periodo: .noturno)
        turmas.append(turma)
    }
}
