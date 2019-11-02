//
//  AlunoTableViewController.swift
//  CGIA
//
//  Created by Rafael Galdino on 24/09/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class AlunoTableViewController: UITableViewController {

    var myGrades: [[Grade]] = []
    var mySubjects: [Subject] = []
    var myStudent: Student

    init() {
        guard let student = ServerManager.shared().alunos.first(where: { (aluno) -> Bool in
            if aluno.id ?? 0 == ServerManager.shared().usuario?.id {
                return true
            }
            return false
        }) else {
            fatalError("Student Not Found")
        }
        self.myStudent = student
        self.mySubjects =  ServerManager.shared().disciplinas
        self.myGrades = []
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    private var dateCellExpanded: Bool = false

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if dateCellExpanded {
                dateCellExpanded = false
            } else {
                dateCellExpanded = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return mySubjects.count
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return myGrades[section - 1].count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "materiaCell",
                                                 for: indexPath)
        cell.textLabel?.text = String(indexPath.row + 1)
        return cell
    }

    override func tableView(_ tableView: UITableView,
                            canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

}
