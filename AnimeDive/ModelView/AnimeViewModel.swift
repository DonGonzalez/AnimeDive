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
    var APIData: [Decodable] = []
    
    init (navigator: UINavigationController) {
        self.navigator = navigator
    }
}
//Mark: Interactor
//interactor - API handler
extension AnimeViewModel {
    
    func getDataFromBeckend () {
        
        Services.shared.getAnime(endpoint: .allAnime, completion: { result in
            switch result {
            case .failure(let error):
                print(error.description)
                self.messageError!(.failure(error.description))
            case .success(let result):
                self.APIData = [result]
                print(self.APIData)
                print("fetch complited")
                self.messageError!(.success("Fetch complited"))
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
