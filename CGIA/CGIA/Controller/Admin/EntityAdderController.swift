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
    private var textFields: [String: UITextField] = [:]

    public override func viewDidLoad() {
        guard let type = profile else {
            fatalError("Não havia um tipo")
        }

        switch type {
        case is Admin.Type, is CompleteInstructor.Type, is CompleteStudent.Type:
            _ = makeLabel("Nome de usuário")
            textFields["username"] = makeTextField()

            _ = makeLabel("Senha")
            let txtSenha = makeTextField()
            txtSenha.isSecureTextEntry = true
            textFields["password"] = txtSenha

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

    @IBAction func createUser() {
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

        guard let postData = getPostData() else {
            return
        }

        if let type = type {
            ServerManager.shared().addUser(type: type, postData: postData)
        } else {
            APIRequests.postRequest(url: endpoint.rawValue, params: postData) { (answer) in
                switch answer {
                case .result:
                    ServerManager.shared().refreshData()
                    DispatchQueue.main.async {
                        self.showAlert(withTitle: "Sucesso!", andBody: "Elemento adicionado.")
                    }
                case .error(let error):
                    DispatchQueue.main.async {
                        self.showAlert(withTitle: "Erro...", andBody: "Verifique os dados informados.", true)
                    }
                    print(error.localizedDescription)
                }
            }
        }
    }

    func showAlert(withTitle title: String, andBody body: String, _ error: Bool = false) {
        let alertVC = UIAlertController(title: title, message: body, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { (_) in
            if !error {
                self.dismiss(animated: true, completion: nil)
            }
        }
        alertVC.addAction(okAction)
        self.navigationController?.present(alertVC, animated: true, completion: nil)
    }

    func getPostData() -> [String: Any]? {
        var postData: [String: Any] = [:]
        for dicEntry in textFields {
            if dicEntry.value.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                showAlert(withTitle: "Erro...", andBody: "Verifique os dados informados.", true)
                return nil
            }

            if dicEntry.key != "subjectIDs" {
                postData[dicEntry.key] = dicEntry.value.text
            } else if let ids = dicEntry.value.text?.trimmingCharacters(in:
                .whitespacesAndNewlines).components(separatedBy: ",") {
                postData[dicEntry.key] = ids
                postData["active"] = true
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
