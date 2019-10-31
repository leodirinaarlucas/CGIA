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

    public func fetchInstructors() {
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
        fetchInstructors()
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

        usuario = User(id: 54319, username: "54319", password: "ohYeah", profile: UserType.admin.rawValue)
    }
}
