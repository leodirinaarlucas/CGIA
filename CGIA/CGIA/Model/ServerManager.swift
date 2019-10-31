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
    public private(set) var usuario: User?
    public private(set) var admins: [Admin] = []
    public private(set) var professores: [Instructor] = []
    public private(set) var disciplinas: [Subject] = []
    public private(set) var turmas: [Classroom] = []
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
        APIRequests.getRequest(url: "https://cgia.herokuapp.com/api/instructors", decodableType: [Instructor].self) { (answer) in
            switch answer {
            case .result(let retorno):
                guard let retorno = retorno as? [Instructor] else {
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

        usuario = User(id: 54319, username: "54319", password: "ohYeah", type: UserType.admin.rawValue)

        let admin = Admin(id: 54320, name: "Admin", lastName: "istrador", username: "54320", dateOfBirth: "1981-05-21")
        admins.append(admin)

        let professor = Instructor(id: 54321, name: "Artur", lastName:
            "Carneiro", username: "54321", dateOfBirth: "1993-01-08")
        professores.append(professor)

        let disciplina = Subject(id: 54322, name: "Matemágica", classrooms: turmas)
        disciplinas.append(disciplina)

        let turma = Classroom(id: 54323, name: "06N", subjectID:
            disciplina.id, instructorID: professor.id, instructor:
            professor, students: alunos)
        turmas.append(turma)

        let aluno = Student(id: 54324, username: "54324", name: "Pedro", lastName: "Shun", dateOfBirth: "1998-01-02")
        alunos.append(aluno)
    }
}
