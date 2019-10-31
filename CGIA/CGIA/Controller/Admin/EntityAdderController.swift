//
//  EntityAdderController.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 23/10/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class EntityAdderController: UIViewController {
    public var type: Any?
    private var textFields: [String: UITextField] = [:]

    public override func viewDidLoad() {
        guard let type = type else {
            fatalError("Não havia um tipo")
        }

        switch type {
        case is Admin.Type, is Instructor.Type, is Student.Type:
            _ = makeLabel("Usuário")
            textFields["userID"] = makeTextField()

            _ = makeLabel("Nome")
            textFields["name"] = makeTextField()

            _ = makeLabel("Sobrenome")
            textFields["surname"] = makeTextField()

            _ = makeLabel("Data de nascimento")
            textFields["dateOfBirth"] = makeTextField()
        case is Subject.Type:
            _ = makeLabel("Nome")
            textFields["name"] = makeTextField()

            _ = makeLabel("IDs de classes separados por ','")
            textFields["classroom"] = makeTextField()
        case is Classroom.Type:
            _ = makeLabel("Nome")
            textFields["name"] =  makeTextField()

            _ = makeLabel("ID de matéria")
            textFields["subjectID"] = makeTextField()

            _ = makeLabel("ID de instrutor")
            textFields["instructorID"] = makeTextField()

            _ = makeLabel("IDs de estudantes separados por ','")
            textFields["subjectID"] = makeTextField()
        default:
            fatalError("Tipagem não prevista")
        }
    }

    func getPostData() -> [String: Any] {
        var postData: [String: Any] = [:]
        for dicEntry in textFields {
            postData[dicEntry.key] = dicEntry.value.text
        }

        return postData
    }

    private var lastView: UIView?
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

    func makeTextField() -> UITextField {
        let txt = UITextField()
        txt.borderStyle = .roundedRect
        view.addSubview(txt)
        txt.translatesAutoresizingMaskIntoConstraints = false
        makeUpperConstraint(to: txt)
        makeMiddleConstraint(to: txt)
        makeWidthConstraint(to: txt)
        makeHeigthConstraint(to: txt)
        lastView = txt
        return txt
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
                                       constant: self.view.frame.size.width/2)
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
