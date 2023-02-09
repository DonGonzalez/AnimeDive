//
//  GeneralModelView.swift
//  AnimeDive
//
//  Created by Robert B on 27/09/2022.
//

import Foundation
import UIKit

class GeneralViewModel {
  
    var messageError: ((MessageErrorType) -> Void)?
    var dataAPI: ((Decodable) -> Void)?
    var singleDataAPI: ((Decodable) -> Void)?
    var moreDataAPI: ((Decodable) -> Void)?
    var searchDataAPI: ((Decodable) -> Void)?
    var text: ((String) -> String)?
    var sortValue: (([ModalViewController.SortType]) -> Void)?
    var filterValue: ((ModalViewController.FilterType) -> Void)?
}
