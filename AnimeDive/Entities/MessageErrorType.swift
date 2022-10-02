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
case .success:  return .green
case .failure:     return .red
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

//Krzysztof Banaczyk19:49
//errorType: MessageErrorType
//w Message View ->
//self.backgroundColor = errorType.backgroundColor
