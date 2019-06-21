//
//  MenuServiceTest.swift
//  elmenusTests
//
//  Created by Bassuni on 6/21/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//

import XCTest
@testable import elmenus
class MenuServiceTests: XCTestCase {
    var service: NetworkAdapter<MenuEnum>!
    override func setUp() {
        service = NetworkAdapter<MenuEnum>()
    }
    override func tearDown() {
        service = nil
    }
    func test_Fetch_Repositories_Data() {
        service.request(target: .getMenuData, success: { Response in
            do
            {
                let decoder = JSONDecoder()
                let getData = try! decoder.decode(MenuModelCodable.self,from: Response.data)
                XCTAssertNotNil(getData)
            }
        }, error: { error in }, failure: { error in })
    }
}
