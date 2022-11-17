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
    var animationEnd = false
    
    func assignDependencies(viewModel: AnimeViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configure()
        self.viewModel?.getDataFromBeckend()
        self.tableViewConfigure()
        self.pushInVC()
        self.getSingleData()
        
    }
    
    private func configure() {
        self.viewModel?.messageError = { data in
            PopupAlert.shared.createAlert(view: self,
                                          title: "Message",
                                          errorData: data)
        }
    }
    private func tableViewConfigure() {
        self.viewModel?.dataAPI = { [weak self]
            dataAPI in
            let animeTableView = AnimeTableView(data: dataAPI as! Anime)
            self?.view.addSubview(animeTableView)
            animeTableView.delegate = self
            animeTableView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                animeTableView.topAnchor.constraint(equalTo: self!.view.safeAreaLayoutGuide.topAnchor),
                animeTableView.bottomAnchor.constraint(equalTo: self!.view.safeAreaLayoutGuide.bottomAnchor),
                animeTableView.leftAnchor.constraint(equalTo: self!.view.safeAreaLayoutGuide.leftAnchor),
                animeTableView.rightAnchor.constraint(equalTo: self!.view.safeAreaLayoutGuide.rightAnchor)
            ])
        }
    }
    
    func pushInVC(){
        self.viewModel?.singleDataAPI = { data in
            DispatchQueue.main.async {
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                    LoadingPopup.shared.removeFromSuperview()
                    AnimeDetailsViewModel.pushIn(navigator: self.viewModel!.navigator, data: data as! SingleAnime)
                }
            }
        }
    }
    
    func getSingleData() {
        LoadingPopup.shared.popupPresented = { [weak self]
            index in
            self?.viewModel?.getSingleData(index: index)
        }
    }
}

extension AnimeViewController: UITableViewDelegate, UIWindowSceneDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Loading popup start")
        let applicationDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        applicationDelegate.window!.rootViewController?.view.addSubview(LoadingPopup.shared.createLoadingPopup(view: self, index: indexPath.row))
    }
}



