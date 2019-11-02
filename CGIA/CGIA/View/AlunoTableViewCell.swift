//
//  AlunoTableViewCell.swift
//  CGIA
//
//  Created by Rafael Galdino on 31/10/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class AlunoTableViewCell: UITableViewCell {

    var nome: UILabel?
    var nota: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        nome = UILabel()
        nota = UILabel()

        guard let safeNome = nome else {
            fatalError("Aluno Name Label not Initialized")
        }
        guard let safeNota = nota else {
            fatalError("Aluno Nota Label not Initialized")
        }

        self.addSubview(safeNome)
        self.addSubview(safeNota)

        safeNome.translatesAutoresizingMaskIntoConstraints = false
        var horizontalConstraint = safeNome.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                                     constant: 5)
        var verticalConstraint = safeNome.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        var widthConstraint = safeNome.widthAnchor.constraint(equalTo: self.widthAnchor,
                                                              multiplier: 0.49)
        var heightConstraint = safeNome.heightAnchor.constraint(equalTo: self.heightAnchor,
                                                                multiplier: 0.49)
        safeNome.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])

        safeNota.translatesAutoresizingMaskIntoConstraints = false
        horizontalConstraint = safeNome.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                                     constant: 5)
        verticalConstraint = safeNome.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        widthConstraint = safeNome.widthAnchor.constraint(equalTo: self.widthAnchor,
                                                              multiplier: 0.49)
        heightConstraint = safeNome.heightAnchor.constraint(equalTo: self.heightAnchor,
                                                                multiplier: 0.49)
        safeNome.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
