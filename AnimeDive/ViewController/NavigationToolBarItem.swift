//
//  NavigationToolBarItem.swift
//  AnimeDive
//
//  Created by Robert B on 06/12/2022.
//

import Foundation
import UIKit

extension AnimeViewController {
    
     func createNavigationBarButtons() {
        
        let sortBT = UIBarButtonItem(barButtonSystemItem: .search,
                                     target: self,
                                     action: #selector(sortActionBT))
        
        let filterBT = UIBarButtonItem(image: UIImage(named: "FilterIcon"),
                                       style: .plain, target: self,
                                       action: #selector(filterActionBT))
        
        sortBT.customView?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        navigationItem.setRightBarButtonItems([sortBT, filterBT], animated: true)
    }
    
    @objc private func filterActionBT () {
        self.toolBarItemDidTap(type: .filter)
        self.searchBar.searchTextField.isUserInteractionEnabled = false
    }
    
    @objc private func sortActionBT () {
        self.toolBarItemDidTap(type: .sort)
        self.searchBar.searchTextField.isUserInteractionEnabled = false
    }
}
// Create and present ModalVC
extension AnimeViewController: ModalViewControllerOptionDelegate{
    func toolBarItemDidTap(type: ModalViewController.UserFilterOption) {
        
        if type == .sort {
            let modalCV = self.viewModel?.createModalViewController(modalType: type, sortSelect: sortDataToSend, filterSelect: filterDataToSend)
            self.present(modalCV!, animated: true)
        }
        if type == .filter {
            let modalCV = self.viewModel?.createModalViewController(modalType: type, sortSelect: sortDataToSend, filterSelect: filterDataToSend )
            self.present(modalCV!, animated: true)
        }
    }
}
