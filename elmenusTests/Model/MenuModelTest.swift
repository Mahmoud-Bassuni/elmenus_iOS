//
//  MenuModelTest.swift
//  elmenusTests
//
//  Created by Bassuni on 6/21/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//

import XCTest
class MenuModelTest: XCTestCase {

    func test_Successful_Init_Menu_Model() {
        let testSuccessfulJSON: JSON = ["id": 80877,
                                        "name": "Appetizers",
                                        "items": [CategoryCodable(id: 11,
                                                                 name: "French Fries",
                                                                 items: [], itemDescription: "Custom premium cut by farm frites. Add melted cheese for 7LE - chili con carne for 9LE",
                                                                 isExpanded: false)],
                                        "itemDescription" : "",
                                        "isExpanded" : false]
        XCTAssertNotNil(CategoryCodable(json: testSuccessfulJSON))
    }
}
private extension CategoryCodable {
    init?(json: JSON) {
        guard let name = json["name"] as? String,
            let id = json["id"] as? Int,
            let itemDescription = json["itemDescription"] as? String,
            let isExpanded = json["isExpanded"] as? Bool,
            let items = json["items"] as? [CategoryCodable]
            else {
                return nil
        }
        self.items = items
        self.name = name
        self.id = id
        self.itemDescription = itemDescription
        self.isExpanded = isExpanded
    }
}
typealias JSON = Dictionary<String, Any>
