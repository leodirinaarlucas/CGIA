//
//  EntityAdderController.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 23/10/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class EntityAdderController: UIViewController {
    public var profile: Any?
    private var type: UserType?
    public var currentInstance: Displayable?
    private var textFields: [String: UITextField] = [:]
    private var editingID = -1
    private var editingUserID = -1

    public override func viewDidLoad() {

        handleProfile()

        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white]
        if currentInstance != nil {
            let updateButton = UIBarButtonItem(title: "Atualizar", style: .plain, target:
                self, action: #selector(update))
            navigationItem.rightBarButtonItem = updateButton
            handleCurrentInstance()
            navigationItem.title = "Editar"
        } else {
            let addButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(createUser))
            navigationItem.rightBarButtonItem = addButton
            navigationItem.title = "Adicionar"
        }
    }

    func handleCurrentInstance() {
        if let student = currentInstance as? CompleteStudent {
            textFields["name"]?.text = student.name
            textFields["lastName"]?.text = student.lastName
            textFields["dateOfBirth"]?.text = student.dateOfBirth
            editingID = student.id ?? -1
            editingUserID = student.userID ?? -1

        } else if let instructor = currentInstance as? CompleteInstructor {
            textFields["name"]?.text = instructor.name
            textFields["lastName"]?.text = instructor.lastName
            textFields["dateOfBirth"]?.text = instructor.dateOfBirth
            editingID = instructor.id ?? -1
            editingUserID = instructor.userID ?? -1

        } else if let subject = currentInstance as? CompleteSubject {
            textFields["name"]?.text = subject.name
            editingID = subject.id ?? -1

        } else if let classroom = currentInstance as? CompleteClassroom {
            textFields["name"]?.text = classroom.name
            textFields["subjectID"]?.text = "\(classroom.subjectID ?? 0)"
            textFields["instructorID"]?.text = "\(classroom.instructorID ?? 0)"

            let ids = classroom.students?.map({ (student) -> Int in
                (student.id ?? 0)
            })
            textFields["subjectIDs"]?.text = "\(ids ?? [])"
            editingID = classroom.id ?? -1
        }
    }

    func handleProfile() {
        guard let profile = profile else {
            fatalError("Não havia um tipo")
        }

        switch profile {
        case is Admin.Type, is CompleteInstructor.Type, is CompleteStudent.Type:
            if currentInstance == nil {
                _ = makeLabel("Nome de usuário")
                textFields["username"] = makeTextField()

                _ = makeLabel("Senha")
                let txtSenha = makeTextField()
                txtSenha.isSecureTextEntry = true
                textFields["password"] = txtSenha
            }

            _ = makeLabel("Nome")
            textFields["name"] = makeTextField()

            _ = makeLabel("Sobrenome")
            textFields["lastName"] = makeTextField()

            _ = makeLabel("Data de nascimento")
            textFields["dateOfBirth"] = makeTextField()
        case is CompleteSubject.Type:
            _ = makeLabel("Nome")
            textFields["name"] = makeTextField()
        case is CompleteClassroom.Type:
            _ = makeLabel("Nome")
            textFields["name"] =  makeTextField()

            _ = makeLabel("ID de matéria")
            textFields["subjectID"] = makeTextField()

            _ = makeLabel("ID de instrutor")
            textFields["instructorID"] = makeTextField()

            let idsLabel = makeLabel("IDs de estudantes separados por ','")
            idsLabel.numberOfLines = 0
            textFields["subjectIDs"] = makeTextField()
        default:
            fatalError("Tipagem não prevista")
        }
    }

    @objc func createUser() {
        var endpoint: Endpoint = .getUsers

        switch profile {
        case is Admin.Type:
            type = .admin
        case is CompleteInstructor.Type:
            type = .instructor
        case is CompleteStudent.Type:
            type = .student
        case is CompleteSubject.Type:
            endpoint = .getSubjects
        case is CompleteClassroom.Type:
            endpoint = .getClassrooms
        default:
            fatalError("Tipagem não prevista")
        }

        guard var postData = getPostData() else {
            return
        }

        if let type = type {
            postData["profile"] = type.rawValue
            ServerManager.shared().addUser(type: type, postData: postData)
        } else {
            APIRequests.postRequest(url: endpoint.rawValue, params: postData) { (answer) in
                switch answer {
                case .result:
                    ServerManager.shared().refreshData()
                    DispatchQueue.main.async {
                        Helper.showAlert(on: self.navigationController, withTitle: "Sucesso!",
                                       andBody: "Elemento adicionado.")
                    }
                case .error(let error):
                    DispatchQueue.main.async {
                        Helper.showAlert(on: self.navigationController, withTitle: "Erro...",
                                       andBody: "Verifique os dados informados.", true)
                    }
                    print(error.localizedDescription)
                }
            }
        }
    }

    @objc func update() {

        guard var postData = getPostData() else {
            return
        }

        var endpoint: Endpoint = .getUsers

        switch profile {
        case is CompleteInstructor.Type:
            postData["userID"] = editingUserID
            endpoint = .getInstructors
        case is CompleteStudent.Type:
            postData["userID"] = editingUserID
            endpoint = .getStudents
        case is CompleteSubject.Type:
            endpoint = .getSubjects
        case is CompleteClassroom.Type:
            endpoint = .getClassrooms
        default:
            fatalError("Tipagem não prevista")
        }

        var headers = [String: String]()
        headers["Content-Type"] = "application/json"

        APIRequests.postRequest(url: "\(endpoint.rawValue)/\(editingID)",
        params: postData, method: .patch, header: headers,
        decodableType: NilCodable.self, profile: profile) { (answer) in

            switch answer {
            case .result(let result):
                print(result)
                ServerManager.shared().refreshData()
                DispatchQueue.main.async {
                    Helper.showAlert(on: self.navigationController, withTitle: "Sucesso!",
                                     andBody: "Elemento atualizado.", shouldPop: true)
                }
            case .error(let error):
                DispatchQueue.main.async {
                    Helper.showAlert(on: self.navigationController, withTitle: "Erro...",
                                     andBody: "Verifique os dados informados.", shouldPop: true, true)
                }
                print(error.localizedDescription)
            }
        }
    }

    func getPostData() -> [String: Any]? {
        var postData: [String: Any] = [:]
        for dicEntry in textFields {
            if dicEntry.value.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                Helper.showAlert(on: self.navigationController, withTitle: "Erro...",
                                 andBody: "Verifique os dados informados.", true)
                return nil
            }

            if dicEntry.key != "subjectIDs" {
                postData[dicEntry.key] = dicEntry.value.text
            } else if let ids = dicEntry.value.text?.trimmingCharacters(in:
                .whitespacesAndNewlines).components(separatedBy: ",") {
                postData["active"] = true
                for id in ids {
                    if let id = Int(id), let classroom = currentInstance as? CompleteClassroom,
                        let classID = classroom.id {
                        let params: [String: Int] = ["classroomID": classID, "studentID": id]
                        APIRequests.postRequest(
                            url: Endpoint.getStudentClassroom.rawValue,
                            params: params, method: .post, header: nil,
                            decodableType: NilCodable.self, profile: nil) { (_) in
                                let grade: [String: Any] = ["grades": [], "finalGrade": 0,
                                                            "studentID": id, "classroomID": classID]
                                APIRequests.postRequest(url: Endpoint.getGrades.rawValue, params: grade,
                                                        method: .post, header: nil, decodableType: NilCodable.self,
                                                        profile: nil) { (_) in
                                }
                        }
                    }
                }

            }
        }

        return postData
    }

    private var lastView: UIView?
    func makeLabel(_ text: String? = nil) -> UILabel {
        let lbl = UILabel()
        lbl.text = text
        view.addSubview(lbl)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        makeUpperConstraint(to: lbl)
        makeMiddleConstraint(to: lbl)
        makeWidthConstraint(to: lbl)
        makeHeigthConstraint(to: lbl)
        lastView = lbl
        return lbl
    }

    func makeTextField() -> UITextField {
        let txt = UITextField()
        txt.borderStyle = .roundedRect
        view.addSubview(txt)
        txt.translatesAutoresizingMaskIntoConstraints = false
        makeUpperConstraint(to: txt)
        makeMiddleConstraint(to: txt)
        makeWidthConstraint(to: txt)
        makeHeigthConstraint(to: txt)
        lastView = txt
        return txt
    }

    func makeMiddleConstraint(to view: UIView) {
        let const = NSLayoutConstraint(item: view,
                                       attribute: .centerX,
                                       relatedBy: .equal,
                                       toItem: self.view,
                                       attribute: .centerX,
                                       multiplier: 1,
                                       constant: 1)
        const.isActive = true
    }
    func makeUpperConstraint(to view: UIView) {
        if let lastView = lastView {
            let const = NSLayoutConstraint(item: view,
                                           attribute: .centerY,
                                           relatedBy: .equal,
                                           toItem: lastView,
                                           attribute: .centerY,
                                           multiplier: 1,
                                           constant: 30)
            const.isActive = true
        } else {
            let const = NSLayoutConstraint(item: view,
                                           attribute: .centerY,
                                           relatedBy: .equal,
                                           toItem: self.view,
                                           attribute: .top,
                                           multiplier: 1,
                                           constant: 80)
            const.isActive = true
        }
    }
    func makeWidthConstraint(to view: UIView) {
        let const = NSLayoutConstraint(item: view,
                                       attribute: .width,
                                       relatedBy: .equal,
                                       toItem: nil,
                                       attribute: .width,
                                       multiplier: 1,
                                       constant: view is UITextField ?
                                                self.view.frame.size.width/2
                                                : self.view.frame.size.width)
        const.isActive = true
    }
    func makeHeigthConstraint(to view: UIView) {
        let const = NSLayoutConstraint(item: view,
                                       attribute: .height,
                                       relatedBy: .equal,
                                       toItem: nil,
                                       attribute: .height,
                                       multiplier: 1,
                                       constant: 30)
        const.isActive = true
    }
}
