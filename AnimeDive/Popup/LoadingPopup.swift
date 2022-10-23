//
//  LoadingPopup.swift
//  AnimeDive
//
//  Created by Robert B on 19/10/2022.
//

import Foundation
import UIKit

protocol DataFromRequestProtocol {
    func dataFromRequest(data: SingleAnime)
}

class LoadingPopup: NSObject {
    
    static let shared = LoadingPopup()
    var delegate: DataFromRequestProtocol? = nil
    
    func createLoadingPopup(view: UIViewController, index: Int) {
        
        let popup = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        popup.isSpringLoaded = true
        popup.view?.layer.cornerRadius = 8
        popup.view.backgroundColor = .clear
        
        let loadingIndicator: UIActivityIndicatorView =
        UIActivityIndicatorView(frame: CGRect(x: 10,                                                                                   y: 5,
                                              width: 50,
                                              height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating()
        popup.view.addSubview(loadingIndicator)
        view.present(popup, animated: true) {
            Services.shared.getSingleAnime(endpoint: .singleAnime(id: index + 1),
                                           completion: { result in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let result):
                        self.delegate?.dataFromRequest(data: result)
                    }
                }
            })
        }
        view.dismiss(animated: true)
    }
}
