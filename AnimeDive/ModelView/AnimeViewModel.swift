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
   
    // Data from ModelVC
    var selectedFilterMemory = ""
    var selectedSortMemory = ""
    var selectedSearchMemory = ""
    var sortDataToSend: [ModalViewController.SortType] = []
    var filterDataToSend: ModalViewController.FilterType = .emptyEnum
    
    let navigator: UINavigationController
    init (navigator: UINavigationController) {
        self.navigator = navigator
    }
}

//MARK: Interactor
//interactor - API handler
extension AnimeViewModel {
    
    func getDataFromAnime(offset: Int, sort: String, filter: String, search: String) {
        Services.shared.getAnime(endpoint: .moreAnime(offset: offset, sort: sort, filter: filter ,search: search), completion: { [weak self] result in
            DispatchQueue.main.async { [self] in
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
    
    func getMoreDataFromAnime(offset: Int, sort: String, filter: String, search: String) {
        Services.shared.getAnime(endpoint: .moreAnime(offset: offset, sort: sort, filter: filter ,search: search), completion: { [weak self] result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .failure(let error):
                    self?.messageError?(.failure(error.description))
                case .success(let result):
                    self?.additionalDataAPI?(result)
                }
            }
        })
    }
    
    func getSingleDataFromAnime (index: Int) {
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
        viewModel.getDefaultAnime()
        let vc = AnimeViewController()
        vc.assignDependencies(viewModel: viewModel)
        vc.title = "Anime"
        vc.view.backgroundColor = .white
        navigator.setViewControllers([vc], animated: false)
        return navigator
    }
    
    func createDetailsViewController(data: SingleAnime) {
        AnimeDetailsViewModel.pushIn(navigator: navigator, data: data )
    }
    
    func createUserFiltringMenu(modalType: ModalViewController.UserFilterOption, sortSelect: [ModalViewController.SortType], filterSelect: ModalViewController.FilterType) -> UIViewController {
        
        let modalVC = ModalViewController(modalType: modalType, sortSelect: sortSelect, filterSelect: filterSelect)
        
        modalVC.modalTransitionStyle = .flipHorizontal
        modalVC.modalPresentationStyle = .custom
        modalVC.view.backgroundColor = .white
        modalVC.view.layer.cornerRadius = 8
        modalVC.sortDelegate = self
        modalVC.filterDelegate = self
        return modalVC
    }
  
        
    
    func singleAnimeData(index: Int){
      getSingleDataFromAnime(index: index)
    }
    
    func scrollAnimeData(offset: Int) {
        getMoreDataFromAnime(offset: offset, sort: self.selectedSortMemory, filter: self.selectedFilterMemory, search: self.selectedSearchMemory)
    }
    
    func filterAnimeData(filter:ModalViewController.FilterType){
          self.filterDataToSend = filter
        self.selectedFilterMemory = filter.filterValue
        getDataFromAnime(offset: 0, sort: self.selectedSortMemory, filter: self.selectedFilterMemory, search: self.selectedSearchMemory)
    }
    
    func sortAnimeData(sort: [ModalViewController.SortType]){
        var sortContener: [String] = []
        var i = 0
        while i <= sort.count - 1 {
            sortContener.append(sort[i].sortValue)
            i += 1
        }
        self.sortDataToSend = sort
        if sortContener != []{
            self.selectedSortMemory = ("&sort=\(sortContener.joined(separator: ","))")
            getDataFromAnime(offset: 0, sort: self.selectedSortMemory , filter: self.selectedFilterMemory, search: self.selectedSearchMemory)
        } else {
            self.selectedSortMemory = sortContener.joined(separator: ",")
            getDataFromAnime(offset: 0, sort: self.selectedSortMemory , filter: self.selectedFilterMemory, search: self.selectedSearchMemory)
        }
       
    }
    
    func searchAnime(convertedText: String){
        
        self.selectedSearchMemory = convertedText
        if (14...17).contains(convertedText.count) {
            // standard request
            getDataFromAnime(offset: 0, sort: selectedSortMemory,filter: selectedFilterMemory, search: "")
        } else {
            // search request
            getDataFromAnime(offset: 0, sort: selectedSortMemory, filter: selectedFilterMemory, search: selectedSearchMemory)
        }
    }
    
    func getDefaultAnime(){
        getDataFromAnime(offset: 0, sort: selectedSortMemory, filter: selectedFilterMemory, search: selectedSearchMemory)
    }
}

extension AnimeViewModel: SaveSortValueProtocol{
    func saveSortValue(value: [ModalViewController.SortType]) {
        sortAnimeData(sort: value)
    }
}

extension AnimeViewModel: SaveFilterValueProtocol{
    func saveFilterValue(value: ModalViewController.FilterType) {
        filterAnimeData(filter: value)
    }
}

