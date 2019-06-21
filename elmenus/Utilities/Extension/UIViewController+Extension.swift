//
//  UIViewController+Extension.swift
//  elmenus
//
//  Created by Bassuni on 6/21/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//
import Foundation
import UIKit
extension UIViewController {
    func alert(title : String, message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
