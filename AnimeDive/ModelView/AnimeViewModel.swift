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
    
    func getSeartchedDataFromBeckend(seartchText: String, sort: String, filter: String){
        print(seartchText)
        Services.shared.getAnime(endpoint: .searchAnime(searchText: seartchText, sort: sort, filter: filter.description), completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self?.messageError?(.failure(error.description))
                case .success(let result):
                    self?.searchDataAPI?(result)
                    self?.messageError?(.success("Fetch complited"))
                    if result.data.count == 0 {
                    }
                }
            }
        })
    }
    
    func getDataFromBeckend (element: Int, sort: String, filter: String, search: String) {
        Services.shared.getAnime(endpoint: .moreAnime(offset: element, sort: sort, filter: filter.description ,search: search), completion: { [weak self] result in
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
    
    func getAdditionalDataFromBeckend(offset: Int, sort: String, filter: String, search: String) {
        Services.shared.getNextAnime(endpoint: .moreAnime(offset: offset, sort: sort, filter: filter, search: search), completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self?.messageError?(.failure(error.description))
                    print(error)
                case .success(let result):
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
                self?.messageError?(.failure(error.description))
            case .success(let result):
                //send data to new view controller
                self?.singleDataAPI?(result)
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
    
    func createModalViewController(modalType: ModalViewController.UserFilterOption, sortSelect: [ModalViewController.SortType], filterSelect: ModalViewController.FilterType) -> UIViewController {
        
        let modalVC = ModalViewController(modalType: modalType, sortSelect: sortSelect, filterSelect: filterSelect)
        modalVC.title = ("\(modalType.self)")
        modalVC.modalTransitionStyle = .flipHorizontal
        modalVC.modalPresentationStyle = .custom
        modalVC.view.backgroundColor = .white
        modalVC.view.layer.cornerRadius = 8
        modalVC.sortDelegate = self
        modalVC.filterDelegate = self
        return modalVC
    }
}

extension AnimeViewModel: SaveSortValueProtocol{
    func saveSortValue(value: [ModalViewController.SortType]) {
        self.sortValue?(value)
    }
}

extension AnimeViewModel: SaveFilterValueProtocol{
    func saveFilterValue(value: ModalViewController.FilterType) {
        self.filterValue?(value)
    }
}



