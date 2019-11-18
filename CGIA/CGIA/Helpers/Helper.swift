//
//  Helpers.swift
//  CGIA
//
//  Created by Lucas Fernandez Nicolau on 17/11/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class Helper {
    static func showAlert(on navController: UINavigationController?, withTitle title: String,
                          andBody body: String, shouldPop: Bool = false, _ error: Bool = false) {

        let alertVC = UIAlertController(title: title, message: body, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { (_) in
            if !error {
                if shouldPop {
                    navController?.popViewController(animated: true)
                } else {
                    navController?.dismiss(animated: true, completion: nil)
                }
            }
        }
        alertVC.addAction(okAction)
        navController?.present(alertVC, animated: true, completion: nil)
    }
}
