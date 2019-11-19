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

    @IBOutlet weak var lblNotaFinal: UILabel!

    public override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = student?.name
        guard let student = student,
            let grades = student.grades,
            let first = grades.first(where: { (grade) -> Bool in
            return grade.classroomID == classroom?.id
        }),
            let final = first.finalGrade else {
                fatalError("Algo de errado não está certo")
        }
        dest?.grade = first
        dest?.tableView.reloadData()
        lblNotaFinal.text = "Nota Final: \(final)"
    }

    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? GradeShowerTableViewController {
            self.dest = dest
        }
    }
}
