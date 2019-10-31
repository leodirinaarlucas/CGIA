//
//  EntitySelectionTableViewController.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 24/09/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class EntitySelectionTableViewController: UITableViewController {
    private var type: Any?

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            type = Instructor.self
        case 1:
            type = Subject.self
        case 2:
            type = Classroom.self
        case 3:
            type = Student.self
        case 4:
            type = Subject.self
        case 5:
            type = Classroom.self
        default:
            fatalError("Foi selecionada uma opção não prevista")
        }
        self.performSegue(withIdentifier: "disclosure", sender: self)
    }

    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cont = segue.destination as? EntityShowerTableViewController {
            cont.type = type
        }
    }
}
