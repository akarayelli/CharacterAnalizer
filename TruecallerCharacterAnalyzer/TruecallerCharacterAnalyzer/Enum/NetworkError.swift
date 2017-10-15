//
//  NetworkError.swift
//  TruecallerCharacterAnalyzer
//
//  Created by Alican Karayelli on 15.10.2017.
//  Copyright © 2017 Alican Karayelli. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case http
    case invalidData
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .http:
            return NSLocalizedString("NetworkProblem", comment: "")
        case .invalidData:
            return NSLocalizedString("NetworkErrorInvalidData", comment: "")
        }
    }
}
