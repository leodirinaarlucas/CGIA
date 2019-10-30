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
        if let aluno = entity as? Student {
            let lblLastName = makeLabel()
            lblLastName.text = aluno.lastName
            let lblDateOfBirth = makeLabel()
            lblDateOfBirth.text = aluno.dateOfBirth
        } else if entity is Instructor {

        } else if entity is Admin {

        }
    }

    var lastView: UIView?
    func makeLabel() -> UILabel {
        let lbl = UILabel()
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
