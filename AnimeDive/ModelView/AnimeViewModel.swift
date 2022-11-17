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
    init (navigator: UINavigationController) {
        self.navigator = navigator
    }
}
//Mark: Interactor
//interactor - API handler
extension AnimeViewModel {
    
    func getDataFromBeckend () {
        Services.shared.getAnime(endpoint: .allAnime, completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self?.messageError?(.failure(error.description))
                case .success(let result):
                    self?.dataAPI?(result)
                    self?.messageError?(.success("Fetch complited"))
                }
            }
        })
    }
    
    func getSingleData (index: Int) {
        Services.shared.getSingleAnime(endpoint: .singleAnime(id: index + 1),
                                       completion: { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let result):
                //send data to new view controller
                self?.singleDataAPI?(result)
                print("single data complided")
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
        vc.title = "Anime"
        vc.view.backgroundColor = .white
        navigator.setViewControllers([vc], animated: false)
        return navigator
    }
}
