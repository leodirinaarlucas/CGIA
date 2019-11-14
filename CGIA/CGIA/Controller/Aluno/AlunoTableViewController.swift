//
//  AlunoTableViewController.swift
//  CGIA
//
//  Created by Rafael Galdino on 24/09/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class AlunoTableViewController: UITableViewController {

    var classrooms: [Classroom] = []
    var grades: [[Grade]] = []
    var student: CompleteStudent? {
        didSet {
            self.tableView.reloadData()
        }
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(AlunoTableViewCell.self, forCellReuseIdentifier: "materiaCell")
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
//        return classrooms.count
        return 4
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
//        return grades[section - 1].count
        return 6
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "materiaCell",
                                                       for: indexPath) as? AlunoTableViewCell else {
                                                        fatalError("failed to dequeue reusable Table View Cell")
        }
        cell.nome?.text = "Práticas avançadas de placeholder" + String(indexPath.row)
        cell.nota?.text = String(10.99)
        return cell
    }

    override func tableView(_ tableView: UITableView,
                            canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension AlunoTableViewController {
    func updateSubjects() {
        guard let classes = student?.classrooms else {
            classrooms = []
            return
        }
        classrooms = classes
    }
    func sortGrades() {
        grades = []
        guard let safeStudent = student else {
            return
        }
        for classroom in 0...classrooms.count - 1 {
            grades.append([])
            if let grade = safeStudent.grades {
                grades[classroom] = grade.filter { (singleGrade) -> Bool in
                    return (singleGrade.classroomID ?? -2) == (classrooms[classroom].id ?? -1)
                }

            }
        }
    }
}
