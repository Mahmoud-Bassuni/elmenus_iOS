//
//  MenuModelCodable.swift
//  elmenus
//
//  Created by Bassuni on 6/20/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//

import Foundation
struct MenuModelCodable: Codable {
    let categories: [CategoryCodable]!
}
struct CategoryCodable: Codable {
    let id: Int!
    let name: String!
    let items: [CategoryCodable]!
    let categoryDescription: String!
    var isOpen: Bool!
    enum CodingKeys: String, CodingKey {
        case id, name, items , isOpen
        case categoryDescription = "description"
    }
}
