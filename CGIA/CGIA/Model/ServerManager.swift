//
//  ServerManager.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 24/09/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public enum NotifName: String {
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
    case getStudentClassroom = "https://cgia.herokuapp.com/api/studentsClassrooms"
}

public class ServerManager {

    // MARK: Properties
    public private(set) var usuario: User?
    public private(set) var admins: [Admin] = []
    public private(set) var professores: [CompleteInstructor] = []
    public private(set) var disciplinas: [CompleteSubject] = []
    public private(set) var turmas: [CompleteClassroom] = []
    public private(set) var alunos: [CompleteStudent] = []
    public private(set) var notas: [Grade] = []

    // MARK: Login
    public func authenticateLogin(username: String, password: String, completionHandler: @escaping (LoginAnswer) -> Void) {

        let loginString = "\(username):\(password)"
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()

        var headers = [String: String]()
        headers["Authorization"] = "Basic \(base64LoginString)"

        APIRequests.getRequest(url: "\(Endpoint.getUsers.rawValue)/\(username)", header: headers) { (answer) in

            switch answer {
            case .result(let result):
                if let dict = result as? [String: Any] {
                    if dict["error"] as? Int == 1 {
                        completionHandler(.fail)

                    } else {
                        guard let id = dict["id"] as? Int,
                            let username = dict["username"] as? String,
                            let profile = dict["profile"] as? String else { return }

                        let user = User(id: id, username: username, profile: profile)
                        completionHandler(.successful(user))
                    }

                } else {
                    completionHandler(.fail)
                }
            case .error(let error):
                print(error.localizedDescription)
                completionHandler(.fail)
            }
        }
    }

    // MARK: Fetch
    public func fetch<T: Codable>(url: String, model: T.Type) {
        APIRequests.getRequest(url: url, decodableType: model) { (answer) in

            switch answer {
            case .result(let retorno):

                if let result = retorno as? [Student] {
                    for student in result {
                        self.fetchCompleteEntities(url: .getStudents,
                                                   id: student.id ?? 0,
                                                   userID: student.userID ?? 0,
                                                   model: CompleteStudent.self)
                    }

                } else if let result = retorno as? [Instructor] {
                    for instructor in result {
                        self.fetchCompleteEntities(url: .getInstructors,
                                                   id: instructor.id ?? 0,
                                                   userID: instructor.userID ?? 0,
                                                   model: CompleteInstructor.self)
                    }

                } else if let result = retorno as? [Subject] {
                    for subject in result {
                        self.fetchCompleteEntities(url: .getSubjects,
                                                   id: subject.id ?? 0,
                                                   model: CompleteSubject.self)
                    }

                } else if let result = retorno as? [Classroom] {
                    for classroom in result {
                        self.fetchCompleteEntities(url: .getClassrooms,
                                                   id: classroom.id ?? 0,
                                                   model: CompleteClassroom.self)
                    }

                } else if let result = retorno as? [Grade] {
                    self.notas = result
                } else if let result = retorno as? [Admin] {
                    self.admins = result
                }

                self.notify(.dataUpdated)

            case .error(let error):
                fatalError(error.localizedDescription)
            }
        }
    }

    public func fetchCompleteEntities<T: Codable>(url: Endpoint, id: Int, userID: Int = -1, model: T.Type) {
        APIRequests.getRequest(url: "\(url.rawValue)/\(id)", decodableType: model) { (answer) in

            switch answer {
            case .result(let retorno):
                if var result = retorno as? CompleteStudent {
                    result.userID = userID
                    self.alunos.append(result)
                } else if var result = retorno as? CompleteInstructor {
                    result.userID = userID
                    self.professores.append(result)
                } else if let result = retorno as? CompleteSubject {
                    self.disciplinas.append(result)
                } else if let result = retorno as? CompleteClassroom {
                    self.turmas.append(result)
                }

                self.notify(.dataUpdated)

            case .error(let error):
                fatalError(error.localizedDescription)
            }
        }
    }

    // MARK: Post
    public func addUser(type: UserType, postData: [String: Any]) {
        let url = "https://cgia.herokuapp.com/api/users"
        APIRequests.postRequest(url: url, params: postData, decodableType: User.self) { (answer) in
            switch answer {
            case .result(let data as User):
                var finalData = [String: Any]()
                finalData["userID"] = data.id
                finalData["username"] = data.username
                finalData["password"] = postData["password"]
                finalData["name"] = postData["name"]
                finalData["lastName"] = postData["lastName"]
                finalData["dateOfBirth"] = postData["dateOfBirth"]
                APIRequests.postRequest(url: "https://cgia.herokuapp.com/api/\(type.rawValue)s", params: finalData) { (_) in
                    self.refreshData()
                }
            default:
                return
            }
        }
    }

    // MARK: Notifications
    public func notify(_ name: NotifName) {
        NotificationCenter.default.post(name: Notification.Name(name.rawValue), object: nil)
    }

    public func refreshData() {
        professores = []
        alunos = []
        disciplinas = []
        turmas = []

        fetch(url: Endpoint.getInstructors.rawValue,
              model: [Instructor].self)

        fetch(url: Endpoint.getSubjects.rawValue,
              model: [Subject].self)

        fetch(url: Endpoint.getStudents.rawValue,
              model: [Student].self)

        fetch(url: Endpoint.getClassrooms.rawValue,
              model: [Classroom].self)

        fetch(url: Endpoint.getGrades.rawValue,
              model: [Grade].self)
    }

    // MARK: Singleton Properties
    private init() {
    }

    class func shared() -> ServerManager {
        return sharedServerManager
    }

    private static var sharedServerManager: ServerManager = {
        let manager = ServerManager()
        return manager
    }()
}
