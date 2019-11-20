//
//  StudentGradeSetterController.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 17/11/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class StudentGradeSetterController: UIViewController {
    var classroom: CompleteClassroom?
    var student: CompleteStudent?
    var dest: GradeShowerTableViewController?
    var grade: Grade?

    private var invalidAlert: UIAlertController = {
        let alert = UIAlertController(
            title: "Oops!",
            message: "Não foi digitado uma nota válida.",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        return alert
    }()

    private var postedAlert: UIAlertController = {
        let alert = UIAlertController(
            title: "Sucesso",
            message: "A nota foi adicionada!",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        return alert
    }()

    private lazy var appendAlert: UIAlertController = {
        let alert = UIAlertController(
            title: "Qual a nota que você deseja atribuir?",
            message: nil,
            preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Atribuir", style: .default, handler: { (_) in
            if let txtField = alert.textFields?.first,
                let text = txtField.text,
                let grade = Double(text) {
                self.appendGrade(value: grade)
            } else {
                self.present(self.invalidAlert, animated: true)
            }
        }))

        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))

        alert.addTextField { (txtField) in
            txtField.placeholder = "10"
        }
        return alert
    }()

    func appendGrade(value: Double) {
        guard let gradeSystem = self.grade else {
            fatalError("Não havia um sistema de notas.")
        }
        ServerManager.shared().addValueTo(gradeSystem, value: value) {
            DispatchQueue.main.sync {
                self.present(self.postedAlert, animated: true)
                ServerManager.shared().refreshData()
            }
        }
    }

    @IBOutlet weak var lblNotaFinal: UILabel!

    public override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = student?.name
        updateData()
    }

    @objc func updateData() {
        guard let student = student,
            let grades = student.grades,
            let first = grades.first(where: { (grade) -> Bool in
                return grade.classroomID == classroom?.id
            }),
            let final = first.finalGrade else {
                fatalError("Algo de errado não está certo")
        }
        self.grade = first
        dest?.grade = first
        DispatchQueue.main.async {
            self.dest?.tableView.reloadData()
            self.lblNotaFinal.text = "Nota Final: \(final)"
        }
    }

    @IBAction func addGrade(_ sender: UIBarButtonItem) {
        present(appendAlert, animated: true)
    }

    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? GradeShowerTableViewController {
            self.dest = dest
        }
    }
}

extension ServerManager {
    func addValueTo(_ grade: Grade, value: Double, completionHandler: @escaping () -> Void) {
        var grade = grade
        guard var grades = grade.grades, let gradeID = grade.id else {
            fatalError("Não havia notas")
        }
        grades.append(value)
        let sum = grades.reduce(0, +)
        let final = sum/Double(grades.count)
        grade.finalGrade = Double(round(100*final)/100)

        let params: [String: Any] = ["grades": grades, "finalGrade": grade.finalGrade as Any,
                                     "studentID": grade.studentID as Any, "classroomID": grade.classroomID as Any ]
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        APIRequests.postRequest(url: Endpoint.getGrades.rawValue + "/\(gradeID)", params: params,
                                method: .patch, header: headers, decodableType: NilCodable.self,
                                profile: Grade.self) { (answer) in
                                    print(answer)
                                    completionHandler()
        }
    }
}

struct GradePatch: Codable {
    var grades: [Double]?
    var finalGrade: Double?
    var studentID: Int?
    var classroomID: Int?
}
