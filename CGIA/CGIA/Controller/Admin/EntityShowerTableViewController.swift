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
    private var filteredData: [Displayable] = []
    private var selected: Displayable?
    var resultSearchController = UISearchController()

    public override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name:
            Notification.Name(NotifName.dataUpdated.rawValue), object: nil)
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.searchBar.sizeToFit()
            controller.obscuresBackgroundDuringPresentation = false
            definesPresentationContext = true
            tableView.tableHeaderView = controller.searchBar
            return controller
        })()
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
        var retorno: Int = 0
        if resultSearchController.isActive {
            retorno = filteredData.count
        } else {
            switch profile {
            case is CompleteInstructor.Type:
                data = ServerManager.shared().professores
            case is CompleteSubject.Type:
                data = ServerManager.shared().disciplinas
            case is CompleteClassroom.Type:
                data = ServerManager.shared().turmas
            case is CompleteStudent.Type:
                data = ServerManager.shared().alunos
            default:
                fatalError("Não houve uma tipagem esperada para mostrar os dados")
            }
            retorno = data.count
        }
        return retorno
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if resultSearchController.isActive {
            cell.textLabel?.text = filteredData[indexPath.row].displayName
        } else {
            cell.textLabel?.text = data[indexPath.row].displayName
        }
        return cell
    }

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if resultSearchController.isActive {
            selected = filteredData[indexPath.row]
        } else {
            selected = data[indexPath.row]
        }
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

extension EntityShowerTableViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        filteredData.removeAll(keepingCapacity: false)
        filteredData = data.filter({ (entry) -> Bool in
            return entry.displayName.lowercased().contains((searchController.searchBar.text ?? "").lowercased())
        })
        self.tableView.reloadData()
    }
}
