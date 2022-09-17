//
//  ViewController.swift
//  AnimeDive
//
//  Created by Robert B on 25/06/2022.
//

import UIKit

class ViewController: UIViewController {
    // grafic shell + button action
    
    var viewModel: AnimeViewModel?
    // funkcja, ktora uruchamiasz po stworzenie instancji view controllera
    func assignDependencies(viewModel: AnimeViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel?.getDataFromBeckend()
    }
}

