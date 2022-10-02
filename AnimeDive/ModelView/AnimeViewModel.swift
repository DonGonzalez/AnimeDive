//
//  ViewModel.swift
//  AnimeDive
//
//  Created by Robert B on 25/06/2022.
//

import Foundation
import UIKit
//view model - logic

class AnimeViewModel: GeneralViewModel {
    let navigator: UINavigationController
    var id: Int = 6
    
    init (navigator: UINavigationController) {
        self.navigator = navigator
    }
}
//Mark: Interactor
//interactor - API handler
extension AnimeViewModel {
    
    func getDataFromBeckend () {
        Services.shared.getAnime(endpoint: .allAnime, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error.description)
                    self.messageError!(MessageErrorType.failure(error.description))
                case .success(let result):
                    // print(result)
                    print("fetch complited")
                    self.messageError!(MessageErrorType.success("Fetch complited"))
                }
            }
        })
    }
}
//Mark: Router
//router - navigation between screen, show models
extension AnimeViewModel {
    static func create() -> UIViewController {
        let navigator = UINavigationController()
        let viewModel = AnimeViewModel(navigator: navigator)
        let vc = AnimeViewController()
        vc.assignDependencies(viewModel: viewModel)
        vc.title = "Menu"
        vc.view.backgroundColor = .white
        navigator.setViewControllers([vc], animated: false)
        return navigator
    }
}
