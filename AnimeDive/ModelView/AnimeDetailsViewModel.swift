//
//  AnimeDetailsViewController.swift
//  AnimeDive
//
//  Created by Robert B on 17/10/2022.
//

import Foundation
import UIKit

class AnimeDetailsViewModel {
    
    let navigator: UINavigationController
    var data: SingleAnime
    
    init (navigator: UINavigationController, data: SingleAnime) {
        self.navigator = navigator
        self.data = data
    }
}

//Mark: Interactor
//interactor - API handler
extension AnimeDetailsViewModel {
    
}
//Mark: Router
//router - navigation between screen, show models
extension AnimeDetailsViewModel {
    
    static func pushIn(navigator: UINavigationController, data: SingleAnime) {
        
        let viewModel = AnimeDetailsViewModel(navigator: navigator, data: data)
        let vc = AnimeDetailsViewController()
        vc.assignDependencies(viewModel: viewModel)
        vc.title = "Details"
        vc.view.backgroundColor = .white
        navigator.pushViewController(vc, animated: true)
    }
}


