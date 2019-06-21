//
//  MenuVMDelegate.swift
//  elmenus
//
//  Created by Bassuni on 6/20/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//

import Foundation
protocol MenuVMDelegate{
    func showLoading()
    func hideLoading()
    func showAlert(messgae : String)
    func dataBind()
}
