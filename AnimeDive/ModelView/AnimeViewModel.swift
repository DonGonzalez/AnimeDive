//
//  ViewModel.swift
//  AnimeDive
//
//  Created by Robert B on 25/06/2022.
//

import Foundation
import UIKit

class AnimeViewModel {
    //view model - logic
    let navigator: UINavigationController
    var isloading: Bool
    var errorMessage: String? = nil
    
    init (navigator: UINavigationController) {
        self.navigator = navigator
        self.isloading = false
        
    }
}

//Mark: Interactor
extension AnimeViewModel{
    //interactor - question to beckend, API
    
    func getDataFromBeckend () {
        //    isloading = true
        //
        //    Service.shered.fetch(Episodes.self, endpoint: Endpoint.allAnime.url) {result in
        //        switch result{
        //        case .failure(let error):
        //            print(error.description)
        //            //  print(error)
        //        case .success(let result):
        //            return print(result)
        //        }
        //    }
        Services.shered.getSingleAnime(endpoint: Endpoint.singleAnime(id: 3), complition: {result in
        switch result{
        case .failure(let error):
            print(error.description)
            //  print(error)
        case .success(let result):
            return print(result)
        }
        })
        Services.shered.getAnime(endpoint: Endpoint.episodes, complition: { result in
            switch result{
            case .failure(let error):
                print(error.description)
                //  print(error)
            case .success(let result):
                return print(result)
            }
        })
    }
}

//Mark: Router
extension AnimeViewModel{
    //router - navigation between screen, show models
    static func create() -> UIViewController {
        
        let navigator = UINavigationController()
        let viewModel = AnimeViewModel(navigator: navigator)
        let vc = ViewController()
        vc.assignDependencies(viewModel: viewModel)
        vc.title = "Menu"
        vc.view.backgroundColor = .white
        navigator.setViewControllers([vc], animated: false)
        return navigator
    }
}


