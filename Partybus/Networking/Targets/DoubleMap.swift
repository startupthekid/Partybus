//
//  DoubleMap.swift
//  Partybus
//
//  Created by Brendan Conron on 11/16/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import Foundation
import Moya

public enum DoubleMap {
    case routes
    case buses
    case stops
    case announcements
    case eta(stop: Int)
}

extension DoubleMap: TargetType {

    public var baseURL: URL { return URL(string: "https://tufts.doublemap.com/map/v2")! }

    public var path: String {
        switch self {
        case .routes: return "/routes"
        case .buses: return "/buses"
        case .stops: return "/stops"
        case .announcements: return "/announcements"
        case .eta: return "/eta"
        }
    }

    public var method: Moya.Method {
        return .get
    }

    public var parameters: [String: Any]? {
        switch self {
            case let .eta(stop): return ["stop": stop]
            default: return nil
        }
    }

    public var sampleData: Data {
        switch self {
        case .routes:
            guard let path = Bundle.main.path(forResource: "routes", ofType: "json") else { return Data() }
            return try! Data(contentsOf: URL(fileURLWithPath: path))
        case .stops:
            guard let path = Bundle.main.path(forResource: "stops", ofType: "json") else { return Data() }
            return try! Data(contentsOf: URL(fileURLWithPath: path))
        case .buses:
            guard let path = Bundle.main.path(forResource: "buses", ofType: "json") else { return Data() }
            return try! Data(contentsOf: URL(fileURLWithPath: path))
        default: return Data()
        }
    }

    public var task: Task {
        return .request
    }

}
