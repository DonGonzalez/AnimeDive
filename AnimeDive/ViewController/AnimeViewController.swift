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
    let animeTableView = AnimeTableView()
    
    func assignDependencies(viewModel: AnimeViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configure()
        self.viewModel?.getDataFromBeckend(element: 0)
        self.tableViewConfigure()
        self.pushInVC()
        self.getSingleData()
        
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
    
    private func configure() {
        self.viewModel?.messageError = { data in
            PopupAlert.shared.createAlert(view: self,
                                          title: "Message",
                                          errorData: data)
            LoadingPopup.shared.removeFromSuperview()
        }
    }
    
    private func tableViewConfigure() {
        self.viewModel?.dataAPI = { [weak self]
            dataAPI in
            print("dataAPI")
            self?.animeTableView.addData(data: dataAPI)
        }
    }
    
    func pushInVC() {
        self.viewModel?.singleDataAPI = { data in
            DispatchQueue.main.async {
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                    LoadingPopup.shared.removeFromSuperview()
                    AnimeDetailsViewModel.pushIn(navigator: self.viewModel!.navigator, data: data as! SingleAnime)
                    self.view.isUserInteractionEnabled = false
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
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let totalNumberOfCell = tableView.numberOfRows(inSection: 0)
        let lastDetectCell = indexPath.last
        
        // Check when create request and add new data to TableView
        if lastDetectCell ==  totalNumberOfCell - 3 {
            //send to model view information for request
            DispatchQueue.main.async {
                self.viewModel?.getAdditionalDataFromBeckend(offset: totalNumberOfCell)
                self.viewModel?.moreDataAPI = { [weak self]
                    newInfo in
                    self?.animeTableView.appendData(newData: newInfo as! Anime)
                }
            }
        }
    }
}



