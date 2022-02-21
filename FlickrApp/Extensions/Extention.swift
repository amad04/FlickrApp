//
//  Extension.swift
//  FlickrApp
//
//  Created by Amad WALID on 2022-02-20.
//

import Foundation
import UIKit

extension ViewController {
    func alert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
