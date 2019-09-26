//
//  Admin.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 24/09/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public class Admin: Usuario {
    public private(set) var instituicao: Instituicao

    public init(instituicao: Instituicao) {
        self.instituicao = instituicao
        super.init()
    }
}
