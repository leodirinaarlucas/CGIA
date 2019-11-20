//
//  StudentTableViewController.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 13/11/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class StudentShowerTableViewController: UITableViewController {
    var controller: ClassroomInfoController?
    var classroom: CompleteClassroom?
    lazy var data: [Student] = classroom?.students ?? []

    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name:
            Notification.Name("dataUpdated"), object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func updateData() {
        if let classroom = classroom, let students = classroom.students {
            data = students
        }
        DispatchQueue.main.sync {
            tableView.reloadData()
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
        cell.textLabel?.text = data[indexPath.row].displayName
        return cell
    }

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = data[indexPath.row].id
        if let stud = ServerManager.shared().alunos.first(where: { (stud) -> Bool in
            return stud.id == id}) {
            controller?.student = stud
            controller?.performSegue(withIdentifier: "studentSelected", sender: controller)
        }
    }
}
