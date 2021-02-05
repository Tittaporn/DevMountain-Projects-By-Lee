//
//  YakError.swift
//  YikyYak
//
//  Created by Lee McCormick on 2/4/21.
//

import Foundation

enum YakError: LocalizedError {
    case ckError(Error)
    case couldNotUpwrap
    
    var errorDescription: String? {
        switch self {
        case .ckError(let error):
            return "Error in the CloudKit : \(error.localizedDescription) \n---\n \(error)"
        case .couldNotUpwrap:
            return "There was an error unwraping Yak data from the CloudKit."
        }
    }
}
