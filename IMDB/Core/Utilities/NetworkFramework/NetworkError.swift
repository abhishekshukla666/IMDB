//
//  Untitled.swift
//  IMDB
//
//  Created by Abhishek Shukla on 05/05/25.
//

import Foundation

public enum NetworkError: LocalizedError, Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        lhs.errorDescription == rhs.errorDescription
    }
    
    case decode(error: Error)
    case invalidURL
    case noResponse
    case unknown
    case sessionExpired
    case unexpectedStatusCode
    case unauthorized
    case custom(error: Error)
    
    public var errorDescription: String? {
        switch self {
        case .decode:
            return "Decode error"
        case .invalidURL:
            return "Invalid URL"
        case .noResponse:
            return "No response"
        case .unknown:
            return "Unknown error"
        case .sessionExpired:
            return "Session expired"
        case .unexpectedStatusCode:
            return "Unexpected status code"
        case .unauthorized:
            return "Unauthorized"
        case .custom(let error):
            return error.localizedDescription
        }
    }
}

extension DecodingError {
    var prettyDescription: String {
        switch self {
        case let .typeMismatch(type, context):
            "DecodingError.typeMismatch \(type), value \(context.prettyDescription) @ ERROR: \(localizedDescription)"
        case let .valueNotFound(type, context):
            "DecodingError.valueNotFound \(type), value \(context.prettyDescription) @ ERROR: \(localizedDescription)"
        case let .keyNotFound(key, context):
            "DecodingError.keyNotFound \(key), value \(context.prettyDescription) @ ERROR: \(localizedDescription)"
        case let .dataCorrupted(context):
            "DecodingError.dataCorrupted \(context.prettyDescription), @ ERROR: \(localizedDescription)"
        default:
            "DecodingError: \(localizedDescription)"
        }
    }
}

extension DecodingError.Context {
    var prettyDescription: String {
        var result = ""
        if !codingPath.isEmpty {
            result.append(codingPath.map(\.stringValue).joined(separator: "."))
            result.append(": ")
        }
        result.append(debugDescription)
        if
            let nsError = underlyingError as? NSError,
            let description = nsError.userInfo["NSDebugDescription"] as? String
        {
            result.append(description)
        }
        return result
    }
}
