//
//  EntityInfoController.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 22/10/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class EntityInfoController: UIViewController {
    public var entity: Displayable?

    public override func viewDidLoad() {
        guard let entity = entity else {
            fatalError("Não havia um tipo e/ou entidade")
        }
        navigationItem.title = entity.displayName
        if let aluno = entity as? CompleteStudent {
            _ = makeLabel("\(aluno.id ?? 0)")
            _ = makeLabel("\(aluno.displayName) \(aluno.lastName ?? "")")
            _ = makeLabel(aluno.dateOfBirth)
            for classroom in aluno.classrooms ?? [] {
                _ = makeLabel(classroom.displayName)
            }
            for grade in aluno.grades ?? [] {
                _ = makeLabel("\(grade.grades ?? [])")
            }

        } else if let instrutor = entity as? CompleteInstructor {
            _ = makeLabel("\(instrutor.id ?? 0)")
            _ = makeLabel("\(instrutor.displayName) \(instrutor.lastName ?? "")")
            _ = makeLabel(instrutor.dateOfBirth)
            for classroom in instrutor.classrooms ?? [] {
                _ = makeLabel(classroom.displayName)
            }

        } else if let admin = entity as? Admin {
            _ = makeLabel(admin.lastName)
            _ = makeLabel(admin.dateOfBirth)
        } else if let subject = entity as? CompleteSubject {
            _ = makeLabel(subject.displayName)
            for classroom in subject.classrooms ?? [] {
                _ = makeLabel(classroom.displayName)
            }
        } else if let classroom = entity as? CompleteClassroom {
            _ = makeLabel(classroom.subject?.displayName)
            _ = makeLabel(classroom.instructor?.displayName)
            guard let students = classroom.students else {
                return
            }
            for student in students {
                _ = makeLabel(student.displayName)
            }
        }
    }

    var lastView: UIView?
    func makeLabel(_ text: String? = nil) -> UILabel {
        let lbl = UILabel()
        lbl.text = text
        view.addSubview(lbl)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        makeUpperConstraint(to: lbl)
        makeMiddleConstraint(to: lbl)
        makeWidthConstraint(to: lbl)
        makeHeigthConstraint(to: lbl)
        lastView = lbl
        return lbl
    }

    func makeMiddleConstraint(to view: UIView) {
        let const = NSLayoutConstraint(item: view,
                                       attribute: .centerX,
                                       relatedBy: .equal,
                                       toItem: self.view,
                                       attribute: .centerX,
                                       multiplier: 1,
                                       constant: 1)
        const.isActive = true
    }
    func makeUpperConstraint(to view: UIView) {
        if let lastView = lastView {
            let const = NSLayoutConstraint(item: view,
                                           attribute: .centerY,
                                           relatedBy: .equal,
                                           toItem: lastView,
                                           attribute: .centerY,
                                           multiplier: 1,
                                           constant: 30)
            const.isActive = true
        } else {
            let const = NSLayoutConstraint(item: view,
                                           attribute: .centerY,
                                           relatedBy: .equal,
                                           toItem: self.view,
                                           attribute: .top,
                                           multiplier: 1,
                                           constant: 80)
            const.isActive = true
        }
    }
    func makeWidthConstraint(to view: UIView) {
        let const = NSLayoutConstraint(item: view,
                                       attribute: .width,
                                       relatedBy: .equal,
                                       toItem: nil,
                                       attribute: .width,
                                       multiplier: 1,
                                       constant: self.view.frame.size.width)
        const.isActive = true
    }
    func makeHeigthConstraint(to view: UIView) {
        let const = NSLayoutConstraint(item: view,
                                       attribute: .height,
                                       relatedBy: .equal,
                                       toItem: nil,
                                       attribute: .height,
                                       multiplier: 1,
                                       constant: 30)
        const.isActive = true
    }
}
