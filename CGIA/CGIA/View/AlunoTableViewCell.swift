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
        safeNome.text = "Estudos avançados de Placeholder III"
        safeNota.text = "5.0"

        self.addSubview(safeNome)
        self.addSubview(safeNota)

        safeNome.translatesAutoresizingMaskIntoConstraints = false
        safeNota.translatesAutoresizingMaskIntoConstraints = false

        safeNome.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12).isActive = true
        safeNome.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        safeNome.heightAnchor.constraint(equalToConstant: self.contentView.frame.height - 10).isActive = true
        safeNome.widthAnchor.constraint(equalToConstant: (self.contentView.frame.height * 0.8) - 10).isActive = true
        safeNota.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12).isActive = true
        safeNota.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        safeNota.heightAnchor.constraint(equalToConstant: self.contentView.frame.height - 10).isActive = true
        safeNota.widthAnchor.constraint(equalToConstant: (self.contentView.frame.height * 0.2) - 10).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
