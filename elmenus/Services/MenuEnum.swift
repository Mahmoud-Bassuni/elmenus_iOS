//
//  MenuEnum.swift
//  elmenus
//
//  Created by Bassuni on 6/20/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//
import Foundation
import Moya
enum MenuEnum{
    case getMenuData
}
extension MenuEnum: TargetType{
    var baseURL: URL {
        switch self{
        case .getMenuData:
            return URL(string: EndPoint.baseUrl.rawValue)!
        }
    }
    var path: String {
        switch self{
        case .getMenuData: return EndPoint.menuUrl.rawValue
        }
    }
    var method: Moya.Method {
        switch self {
        case .getMenuData:  return .get
        }
    }
    var sampleData: Data {
        return Data()
    }
    var task: Task {
        switch self {
        case .getMenuData:
            return .requestPlain
        }
    }
    var headers: [String : String]?{
        switch self {
        case .getMenuData:
            return ["Content-Type" : "application/json"]
        }
    }
}
