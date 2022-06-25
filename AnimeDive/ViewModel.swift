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
        init (navigator: UINavigationController) {
            self.navigator = navigator

        }
    
}
//Mark: Interactor
extension MyViewModel{
    //interactor - question to beckend, API
    
}


//Mark: Router
extension MyViewModel{
    //router - navigation between screen, show modals
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
