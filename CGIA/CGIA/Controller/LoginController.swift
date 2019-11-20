//
//  ViewController.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 24/09/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    private lazy var alertFail: UIAlertController = {
        let ale = UIAlertController(title: "Usuário inválido!",
        message: "Se você tiver certeza que este é seu usuário, notifique um administrador do sistema.",
        preferredStyle: .alert)

        let act = UIAlertAction(title: "Ok", style: .cancel) { (_) in
            self.txtUsername.text = ""
            self.txtPassword.text = ""
        }
        ale.addAction(act)
        return ale
    }()

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!

    @IBAction func loginTap(_ sender: UIButton) {
        guard let username = txtUsername.text?.trimmingCharacters(in: .whitespacesAndNewlines), username != "",
            let pass = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines), pass != "" else {
            self.present(alertFail, animated: true)
            return
        }

        ServerManager.shared().authenticateLogin(username: username,
                                                 password: pass,
                                                 completionHandler: {(authenticated) in
            switch authenticated {
            case .fail:
                DispatchQueue.main.sync {
                    self.present(self.alertFail, animated: true)
                }
            case .successful(let user):
                var identifier: String = ""
                switch user.profile {
                case UserType.student.rawValue:
                    identifier = "aluno"
                case UserType.instructor.rawValue:
                    identifier = "professor"
                case UserType.admin.rawValue:
                    identifier = "admin"
                default:
                    fatalError("No existe")
                }

                DispatchQueue.main.sync {
                    ServerManager.shared().refreshData()
                    self.performSegue(withIdentifier: identifier, sender: self)
                }
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
