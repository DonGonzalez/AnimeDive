//
//  AnimeDetailsViewController.swift
//  AnimeDive
//
//  Created by Robert B on 17/10/2022.
//

import Foundation
import UIKit

class AnimeDetailsViewController: UIViewController, UINavigationControllerDelegate {
    
    var viewModel: AnimeDetailsViewModel?
    func assignDependencies(viewModel: AnimeDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.scrollViewConfig()
    }
    
    func scrollViewConfig() {
        let scrollView = DetailAnimeScrollView(data: viewModel!.data)
        scrollView.contentSize = self.view.bounds.size
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}
