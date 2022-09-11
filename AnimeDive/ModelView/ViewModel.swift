//
//  ViewModel.swift
//  AnimeDive
//
//  Created by Robert B on 25/06/2022.
//

import Foundation
import UIKit



class MyViewModel {
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
extension MyViewModel{
    //interactor - question to beckend, API

    
    func uploadDataFromBeckend () {
    let service = Service()
        isloading = true
        service.fetchRequest(expecting: Service.Episodes.self, endpoint: endpoint.episodes.url) {result in
            switch result{
            case .failure(let error):
                print(error.description)
              //  print(error)
            case .success(let result):
               return print(result)
            }
        }
    }
}



//Mark: Router
extension MyViewModel{
    //router - navigation between screen, show models
        static func create() -> UIViewController {

            let navigator = UINavigationController()
            let viewModel = MyViewModel(navigator: navigator)
            let vc = ViewController()
            vc.assignDependencies(viewModel: viewModel)
            vc.title = "Menu"
            vc.view.backgroundColor = .white
            navigator.setViewControllers([vc], animated: false)
            
            return navigator
        
    }
}


