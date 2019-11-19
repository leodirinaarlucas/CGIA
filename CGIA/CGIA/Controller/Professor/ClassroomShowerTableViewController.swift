//
//  ClassroomSeerTableViewController.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 06/11/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import UIKit

public class ClassroomShowerTableViewController: UITableViewController {

    var data: [CompleteClassroom] = ServerManager.shared().turmas
    var selectedClassroom: CompleteClassroom?

    public override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name:
            Notification.Name("dataUpdated"), object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func updateData() {
        DispatchQueue.main.async {
            self.data = ServerManager.shared().turmas
            self.tableView.reloadData()
        }
    }

    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = data[indexPath.row].name
        return cell
    }

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedClassroom = data[indexPath.row]
        performSegue(withIdentifier: "selected", sender: self)
    }

    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let info = segue.destination as? ClassroomInfoController {
            info.classroom = selectedClassroom
        }
    }
}
