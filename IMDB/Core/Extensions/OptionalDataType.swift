//
//  OptionalDataType.swift
//  IMDB
//
//  Created by Abhishek Shukla on 09/05/25.
//

import Foundation

enum OptionalDataType {
    case intValue(Int)
    case double(Double)
    case stringValue(String)
    case boolValue(Bool)
}

extension OptionalDataType: Decodable {
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        
        if let intValue = try? container.decode(Int.self) {
            self = .intValue(intValue)
            return
        }
        
        if let doubleValue = try? container.decode(Double.self) {
            self = .double(doubleValue)
            return
        }
        
        if let stringValue = try? container.decode(String.self) {
            self = .stringValue(stringValue)
            return
        }
        
        if let boolValue = try? container.decode(Bool.self) {
            self = .boolValue(boolValue)
            return
        }
        
        throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid JSON format"))
    }
}

extension OptionalDataType: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .intValue(let intValue):
            try container.encode(intValue)
        case .double(let doubleValue):
            try container.encode(doubleValue)
        case .stringValue(let stringValue):
            try container.encode(stringValue)
        case .boolValue(let boolValue):
            try container.encode(boolValue)
        }
    }
}

extension OptionalDataType: Hashable {
    
    
}

extension OptionalDataType {
    func getStringValue() -> String {
        switch self {
        case .intValue(let intValue):
            return String(intValue)
        case .double(let doubleValue):
            return String(doubleValue)
        case .stringValue(let stringValue):
            return stringValue
        case .boolValue(let boolValue):
            if boolValue { return "true" }
            return "false"
        }
    }
    func getDoubleValue() -> Double {
        switch self {
        case .intValue(let intValue):
            return Double(intValue)
        case .double(let doubleValue):
            return doubleValue
        case .stringValue(let stringValue):
            return Double(stringValue) ?? 0.0
        case .boolValue:
            return 0.0
        }
    }
}
