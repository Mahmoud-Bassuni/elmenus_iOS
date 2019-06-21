//
//  MenuVMTest.swift
//  elmenusTests
//
//  Created by Bassuni on 6/21/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//
import XCTest
@testable import elmenus
class MenuVMTest: XCTestCase {
    var menuVM:  MenuVM!
   var service:  NetworkAdapter<MenuEnum>!
    override func setUp() {
       service = NetworkAdapter<MenuEnum>()
    }
    override func tearDown() {
        menuVM = nil
        service = nil
    }
    func test_fetch_data_from_ViewModel_to_bind_it_in_tableview()
    {
        menuVM = MenuVM(_serviceAdapter: service)
        menuVM.delegate = self
    }
}
extension MenuVMTest : MenuVMDelegate
{
    // call back after fetch data
    func dataBind() {
        guard  (menuVM.numberOfSections > 0) else {
            XCTFail()
            return
        }
    }
    func showLoading() {
    }
    func hideLoading() {
    }
    func showAlert(messgae: String) {
        print(messgae)
    }
}
