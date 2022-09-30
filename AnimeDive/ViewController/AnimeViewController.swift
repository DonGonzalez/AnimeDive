//
//  ViewController.swift
//  AnimeDive
//
//  Created by Robert B on 25/06/2022.
//

import UIKit

class AnimeViewController: UIViewController {
    // grafic shell + button action
    var viewModel: AnimeViewModel?
    // funkcja, ktora uruchamiasz po stworzenie instancji view controllera
    func assignDependencies(viewModel: AnimeViewModel) {
        self.viewModel = viewModel
    }    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.viewModel?.messageError = {
            messageText, color in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let messageView = MessageView()
                messageView.configure()
                messageView.messageLabel.text = messageText
                messageView.stackView.backgroundColor = color
                self.view.addSubview(messageView)
                messageView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    messageView.heightAnchor.constraint(equalToConstant: 80),
                    messageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -10),
                    messageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                    messageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -5)
                ])
                messageView.perform(#selector(messageView.delay), with: nil, afterDelay: 3)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.viewModel?.getDataFromBeckend()
        }
    }
}



