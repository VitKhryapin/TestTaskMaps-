//
//  Alert.swift
//  TestVigram
//
//  Created by Vitaly Khryapin on 08.08.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlertLocation(title: String, message: String?, url: URL?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Настройки", style: .default) { (alert) in
            if let url = url {
                UIApplication.shared.open(url)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}
