//
//  EntityTableViewController.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 24/09/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class EntityShowerTableViewController: UITableViewController {
    public var profile: Any?
    private var data: [Displayable] = []
    private var selected: Displayable?

    public override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name:
            Notification.Name("dataUpdated"), object: nil)
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        switch profile {
        case is Instructor.Type:
            ServerManager.shared().fetchInstructors()
        case is Subject.Type:
            break
        case is Classroom.Type:
            break
        case is Student.Type:
            ServerManager.shared().fetchStudents()
        case is Subject.Type:
            break
        case is Classroom.Type:
            break
        default:
            fatalError("Não houve uma tipagem esperada para mostrar os dados")
        }
    }

    @objc func updateData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let profile = profile else {
            fatalError("Tipo era nulo")
        }
        switch profile {
        case is Instructor.Type:
            data = ServerManager.shared().professores
        case is Subject.Type:
            data = ServerManager.shared().disciplinas
        case is Classroom.Type:
            data = ServerManager.shared().turmas
        case is Student.Type:
            data = ServerManager.shared().alunos
        case is Subject.Type:
            data = ServerManager.shared().disciplinas
        case is Classroom.Type:
            data = ServerManager.shared().turmas
        default:
            fatalError("Não houve uma tipagem esperada para mostrar os dados")
        }
        return data.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = data[indexPath.row].displayName

        return cell
    }

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = data[indexPath.row]
        performSegue(withIdentifier: "selected", sender: self)
    }

    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cont = segue.destination as? EntityInfoController {
            guard let selected = selected else {
                fatalError("Não havia uma entidade selecionada")
            }
            cont.entity = selected
        } else if let navCont = segue.destination as? UINavigationController,
            let cont = navCont.topViewController as? EntityAdderController {
            cont.profile = self.profile
        }
    }
}
