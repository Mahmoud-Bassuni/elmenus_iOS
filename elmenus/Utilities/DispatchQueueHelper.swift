//
//  DispatchQueueHelper.swift
//  elmenus
//
//  Created by Bassuni on 6/20/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//

import Foundation
class DispatchQueueHelper {
    fileprivate init() {}
    public static func delay(bySeconds seconds: Double, dispatchLevel: DispatchLevel = .main, completion: @escaping () -> ()) {
        let dispatchTime = DispatchTime.now() + seconds
        dispatchLevel.dispatchQueue.asyncAfter(deadline: dispatchTime, execute: completion)
    }
    public enum DispatchLevel {
        case main, userInteractive, userInitiated, utility, background
        var dispatchQueue: DispatchQueue {
            switch self {
            case .main:                 return DispatchQueue.main
            case .userInteractive:      return DispatchQueue.global(qos: .userInteractive)
            case .userInitiated:        return DispatchQueue.global(qos: .userInitiated)
            case .utility:              return DispatchQueue.global(qos: .utility)
            case .background:           return DispatchQueue.global(qos: .background)
            }
        }
    }
}
