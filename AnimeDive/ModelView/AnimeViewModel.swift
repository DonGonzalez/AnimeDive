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
                    self.messageError!(error.description, .red)
                case .success(let result):
                    // print(result)
                    print("fetch complited")
                    self.messageError!("Fetch complited", .green)
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


//enum MessageErrorType {
//case success(String)
//case failure(String)
//
//var backgroundColor: UIColor {
//switch self {
//case .success:  return .green
//case .failure:     return .red
//}
//}
//}
//Krzysztof Banaczyk19:49
//errorType: MessageErrorType
//w Message View ->
//self.backgroundColor = errorType.backgroundColor
