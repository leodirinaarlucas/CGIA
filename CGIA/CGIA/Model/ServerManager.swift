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
    public private(set) var alunos: [Student] = []

    // MARK: Login
    public func authenticateLogin(username: String, completionHandler: (LoginAnswer) -> Void) {
        guard let user = usuario else {
            completionHandler(.fail)
            return
        }
        completionHandler(.successful(user))
    }

    /// MARK: Fetchs
    public func fetchStudents() {
        APIRequests.getRequest(url: "https://cgia.herokuapp.com/api/students", decodableType: [Student].self) { (answer) in
            switch answer {
            case .result(let retorno):
                guard let retorno = retorno as? [Student] else {
                    fatalError("Não foi possível dar fetch nos alunos")
                }
                self.alunos = retorno
            case .error(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
    public func fetchProfessors() {
        APIRequests.getRequest(url: "https://cgia.herokuapp.com/api/instructors", decodableType: [Professor].self) { (answer) in
            switch answer {
            case .result(let retorno):
                guard let retorno = retorno as? [Professor] else {
                    fatalError("Não foi possível dar fetch nos professores")
                }
                self.professores = retorno
            case .error(let error):
                fatalError(error.localizedDescription)
            }
        }
    }

    // MARK: Singleton Properties
    private init() {
        fetchStudents()
        fetchProfessors()
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

        let professor = Professor(instituicao: instituicao, nome: "Artur", username: "54321")
        professores.append(professor)
        let disciplina = Disciplina(instituicao: instituicao, nome: "Matemágica")
        disciplinas.append(disciplina)
        let turma = Turma(disciplina: disciplina, professor: professor, periodo: .noturno)
        turmas.append(turma)
    }
}
