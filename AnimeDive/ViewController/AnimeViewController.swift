//
//  ViewController.swift
//  AnimeDive
//
//  Created by Robert B on 25/06/2022.
//

import UIKit
// grafic shell + button action
// funkcja, ktora uruchamiasz po stworzenie instancji view controllera
class AnimeViewController: UIViewController, UINavigationControllerDelegate {
    
    var viewModel: AnimeViewModel?
    func assignDependencies(viewModel: AnimeViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.configure()
            LoadingPopup.shared.delegate = self
            self.viewModel?.getDataFromBeckend()
            self.tableViewConfigure()
        }
    }
    private func configure() {
        self.viewModel?.messageError = { data in
            PopupAlert.shared.createAlert(view: self,
                                          title: "Message",
                                          errorData: data)
        }
    }
    private func tableViewConfigure() {
        self.viewModel?.dataAPI = {
            dataAPI in
            let animeTableView = AnimeTableView(data: dataAPI as! Anime)
            self.view.addSubview(animeTableView)
            animeTableView.delegate = self
            animeTableView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                animeTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                animeTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                animeTableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
                animeTableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
            ])
        }
    }
}
extension AnimeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        LoadingPopup.shared.createLoadingPopup(view: self, index: indexPath.row)
    }
}
extension AnimeViewController: DataFromRequestProtocol {
    
    func dataFromRequest(data: SingleAnime) {
        AnimeDetailsViewModel.pushIn(navigator: viewModel!.navigator, data: data)
        
    }
}


