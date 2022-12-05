//
//  ViewModel.swift
//  AnimeDive
//
//  Created by Robert B on 25/06/2022.
//

import Foundation
import UIKit

//MARK: Logic
class AnimeViewModel: GeneralViewModel {
    
    let navigator: UINavigationController
    init (navigator: UINavigationController) {
        self.navigator = navigator
    }
}
//MARK: Interactor
//interactor - API handler
extension AnimeViewModel {
    
    func getDataFromBeckend (element: Int) {
        Services.shared.getAnime(endpoint: .moreAnime(offset: element), completion: { [weak self] result in
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
    
    func getAdditionalDataFromBeckend(offset: Int) {
        Services.shared.getNextAnime(endpoint: .moreAnime(offset: offset), completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self?.messageError?(.failure(error.description))
                    print(error)
                case .success(let result):
                    print(result)
                    self?.moreDataAPI?(result)
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
                self?.messageError?(.failure(error.description))
            case .success(let result):
                //send data to new view controller
                self?.singleDataAPI?(result)
                print("single data complided")
            }
        })
    }
}

//MARK: Router
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
