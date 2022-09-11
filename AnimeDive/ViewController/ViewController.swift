//
//  ViewController.swift
//  AnimeDive
//
//  Created by Robert B on 25/06/2022.
//

import UIKit

class ViewController: UIViewController {
// grafic shell + button action
    
    
    var viewModel: MyViewModel?
    // funkcja, ktora uruchamiasz po stworzenie instancji view controllera
    func assignDependencies(viewModel: MyViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel?.uploadDataFromBeckend()
       
    }
   

}

