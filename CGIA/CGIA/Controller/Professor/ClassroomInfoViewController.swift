//
//  ClassroomSelectedViewController.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 06/11/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import UIKit

public class ClassroomInfoController: UIViewController {
    var classroom: CompleteClassroom?
    var student: CompleteStudent?

    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var lblInstructor: UILabel!

    public override func viewDidLoad() {
        lblSubject.text = classroom?.subject?.displayName
        lblInstructor.text = classroom?.instructor?.displayName
    }

    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? StudentShowerTableViewController {
            dest.classroom = classroom
            dest.controller = self
        } else if let dest = segue.destination as? StudentGradeSetterController {
            dest.classroom = classroom
            dest.student = student
        }
    }
}
