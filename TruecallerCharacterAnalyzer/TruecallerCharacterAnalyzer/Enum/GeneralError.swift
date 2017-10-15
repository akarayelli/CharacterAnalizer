//
//  GeneralError.swift
//  TruecallerCharacterAnalyzer
//
//  Created by Alican Karayelli on 15.10.2017.
//  Copyright © 2017 Alican Karayelli. All rights reserved.
//

import Foundation

enum GeneralError: Error {
    case programatic
}

extension GeneralError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .programatic:
            return NSLocalizedString("ProgramaticError", comment: "")
        
        }
    }
}
