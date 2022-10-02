//
//  ViewController.swift
//  AnimeDive
//
//  Created by Robert B on 25/06/2022.
//

import UIKit
// grafic shell + button action
// funkcja, ktora uruchamiasz po stworzenie instancji view controllera
class AnimeViewController: UIViewController {

    var viewModel: AnimeViewModel?
    func assignDependencies(viewModel: AnimeViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewModel?.messageError = {
            data in
            PopupAlert.shared.createAlert(view: self, title: "Message", errorData: data)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.viewModel?.getDataFromBeckend()
        }
    }
}



