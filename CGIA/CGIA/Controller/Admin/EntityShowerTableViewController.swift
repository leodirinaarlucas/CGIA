//
//  EntityTableViewController.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 24/09/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class EntityShowerTableViewController: UITableViewController {
    public var type: Any?
    private var data: [Displayable] = []
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let type = type else {
            fatalError("Tipo era nulo")
        }
        switch type {
        case is Professor.Type:
            data = ServerManager.shared().professores
        case is Disciplina.Type:
            data = ServerManager.shared().disciplinas
        case is Turma.Type:
            data = ServerManager.shared().turmas
        case is Aluno.Type:
            data = ServerManager.shared().alunos
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
}