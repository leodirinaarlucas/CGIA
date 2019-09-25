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
        }
        ale.addAction(act)
        return ale
    }()

    @IBOutlet weak var txtUsername: UITextField!
    
    @IBAction func loginTap(_ sender: UIButton) {
        guard let txt = txtUsername.text, txt != "" else {
            self.present(alertFail, animated: true)
            return
        }
        ServerManager.shared().authenticateLogin(username: txt, completionHandler: {(authenticated) in
            switch authenticated {
            case .fail:
                self.present(alertFail, animated: true)
            case .successful(let user):
                var identifier: String = ""
                switch user {
                case is Aluno:
                    identifier = "aluno"
                case is Professor:
                    identifier = "professor"
                case is Admin:
                    identifier = "admin"
                default:
                    fatalError()
                }
                self.performSegue(withIdentifier: identifier, sender: self)
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

