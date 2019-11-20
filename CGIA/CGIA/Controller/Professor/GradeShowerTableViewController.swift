//
//  GradeShowerTableViewController.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 17/11/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class GradeShowerTableViewController: UITableViewController {
    var grade: Grade?

    public override func viewDidLoad() {
        tableView.tableFooterView = UIView()
    }

    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let grades = grade?.grades else {
            return 0
        }
        return grades.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let grades = grade?.grades else {
            fatalError("Não há notas")
        }
        cell.textLabel?.text = String(grades[indexPath.row])
        return cell
    }

}
