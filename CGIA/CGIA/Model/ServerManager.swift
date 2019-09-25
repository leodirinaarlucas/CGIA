//
//  ServerManager.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 24/09/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public class ServerManager {

    // MARK: Login
    public func AuthenticateLogin(username: String, completionHandler: (LoginAnswer) -> Void) {
        completionHandler(.successful(Admin(instituicao: Instituicao())))
    }

    // MARK: Fetchs

    // MARK: Singleton Properties
    private init() {
    }

    class func shared() -> ServerManager {
        return sharedServerManager
    }

    private static var sharedServerManager: ServerManager = {
        let manager = ServerManager()
        
        return manager
    }()
}
