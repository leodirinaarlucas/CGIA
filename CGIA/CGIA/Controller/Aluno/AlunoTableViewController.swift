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
    var grades: [[Double]] = []
    var student: CompleteStudent?
    private var dateCellExpanded: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        student = ServerManager.shared().alunos.first(where: { (aluno) -> Bool in
            return aluno.id ?? -1 == ServerManager.shared().usuario?.id ?? -2
        })
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        self.tableView.tableFooterView = UIView()
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name:
        Notification.Name(NotifName.dataUpdated.rawValue), object: nil)
    }

    @objc func updateData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.student = ServerManager.shared().alunos.first(where: { (aluno) -> Bool in
                return aluno.id ?? -1 == ServerManager.shared().usuario?.id ?? -2
            })
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let safeStudent = student else {
            return 0
        }
        classrooms = safeStudent.classrooms ?? []
        return classrooms.count
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        guard let safeStudent = student else {
            return 0
        }
        guard let notas = student?.grades else {
            return 0
        }
        for turma in 0...classrooms.count-1 {
            let grade = notas.filter({ (grade) -> Bool in
                return grade.classroomID ?? -1 == classrooms[turma].id ?? -2
            }).filter({ (grade) -> Bool in
                return grade.studentID ?? -1 == safeStudent.id ?? -2
            })
            grades = grade.map({ (grade) -> [Double] in
                return (grade.grades ?? [])
            })
            if let first = grade.first {
                grades[turma].append(first.finalGrade ?? 99.9)
            }
        }
        return grades[section].count
    }

    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        var title: String = classrooms[section].displayName
        let subs = ServerManager.shared().disciplinas
        let sub = subs.first { (disciplina) -> Bool in
            return disciplina.id ?? -1 == classrooms[section].subjectID ?? -2
        }
        title += " - " + (sub?.displayName ?? "")
        return title
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "materiaCell",
                                                       for: indexPath) as? AlunoTableViewCell else {
                                                        fatalError("failed to dequeue reusable Table View Cell")
        }
        if indexPath.row == grades[indexPath.section].count - 1 {
            cell.nomeLabel.text = "Média Geral"
        } else {
            cell.nomeLabel.text = "N" + String(indexPath.row)
        }
        cell.notaLabel.text = String(grades[indexPath.section][indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView,
                            canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
