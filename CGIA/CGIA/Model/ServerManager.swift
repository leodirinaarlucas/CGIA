//
//  ServerManager.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 24/09/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public enum NotifName: String {
    case studentsUpdated
    case gradesUpdated
    case instructorsUpdated
    case classroomsUpdated
    case subjectsUpdated
    case adminsUpdated
    case dataUpdated
}

public enum Endpoint: String {
    case getStudents = "https://cgia.herokuapp.com/api/students"
    case getInstructors = "https://cgia.herokuapp.com/api/instructors"
    case getAdmins = "https://cgia.herokuapp.com/api/admins"
    case getUsers = "https://cgia.herokuapp.com/api/users"
    case getGrades = "https://cgia.herokuapp.com/api/grades"
    case getClassrooms = "https://cgia.herokuapp.com/api/classrooms"
    case getSubjects = "https://cgia.herokuapp.com/api/subjects"
}

public class ServerManager {

    // MARK: Properties
    public private(set) var usuario: User?
    public private(set) var admins: [Admin] = []
    public private(set) var professores: [Instructor] = []
    public private(set) var disciplinas: [Subject] = []
    public private(set) var turmas: [Classroom] = []
    public private(set) var alunos: [Student] = []
    public private(set) var notas: [Grade] = []

    // MARK: Login
    public func authenticateLogin(username: String, completionHandler: (LoginAnswer) -> Void) {
        guard let user = usuario else {
            completionHandler(.fail)
            return
        }
        completionHandler(.successful(user))
    }

    /// MARK: Fetch
    public func fetch<T: Codable>(url: String, model: T.Type) {
        APIRequests.getRequest(url: url, decodableType: model) { (answer) in
            switch answer {
            case .result(let retorno):

                if let result = retorno as? [Student] {
                    self.alunos = result
                } else if let result = retorno as? [Instructor] {
                    self.professores = result
                } else if let result = retorno as? [Subject] {
                    self.disciplinas = result
                } else if let result = retorno as? [Classroom] {
                    self.turmas = result
                } else if let result = retorno as? [Admin] {
                    self.admins = result
                }
                self.notify(.dataUpdated)

            case .error(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
    /// Notifications
    public func notify(_ name: NotifName) {
        NotificationCenter.default.post(name: Notification.Name(name.rawValue), object: nil)
    }

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

        usuario = User(id: 54319, username: "54319", password: "ohYeah", profile: UserType.admin.rawValue)
    }
}
