//
//  MessageErrorType.swift
//  AnimeDive
//
//  Created by Robert B on 01/10/2022.
//

import Foundation
import UIKit

enum MessageErrorType {
    case success (String)
    case failure (String)
    
    var backgroundColor: UIColor {
        switch self {
        case .success:     return .systemGreen
        case .failure:     return .systemRed
        }
    }
    var message: String {
        switch self{
        case .success(let message):
            return message
        case .failure(let message):
            return message
        }
    }
}
