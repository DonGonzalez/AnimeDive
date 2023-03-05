//
//  ViewController.swift
//  AnimeDive
//
//  Created by Robert B on 25/06/2022.
//

import UIKit

protocol ModalViewControllerOptionDelegate {
    func toolBarItemDidTap (type: ModalViewController.UserFilterOption)
}

// grafic shell + button action
// funkcja, ktora uruchamiasz po stworzenie instancji view controllera
class AnimeViewController: UIViewController {
    // MARK: Variabe
    var viewModel: AnimeViewModel?
    let animeTableView = AnimeTableView()
    // let delegate: ModalViewControllerOptionDelegate? = nil
    let searchBar = UISearchBar()
    
    
    func assignDependencies(viewModel: AnimeViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.tableViewConfigure()
        self.pushInVC()
        self.getSingleData()
        self.createNavigationBarButtons()
        self.configureSearchBar()
        self.createAnimeTableView()
        self.showAlert()
    }
    
    private func configureSearchBar() {
        self.view.addSubview(searchBar)
        self.searchBar.showsCancelButton = true
        self.searchBar.showsScopeBar = true
        self.searchBar.delegate = self
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 60),
            searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func createAnimeTableView() {
        self.view.addSubview(animeTableView)
        animeTableView.delegate = self
        animeTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animeTableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
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
    // Function/ clause init when user use searchBar
    private func tableViewConfigure() {
        self.viewModel?.dataAPI = { [weak self]
            dataAPI in
            print(dataAPI)
            self?.animeTableView.addData(data: dataAPI)
        }
    }
    private func showAlert(){
        self.animeTableView.tableViewStatus = {
            [weak self] status in
            if status == 0 {
                self?.showAlert(view: self!)
            }
            else {
            }
        }
    }
    // Push VC when program recieve data for single Anime
    private func pushInVC() {
        self.viewModel?.singleDataAPI = { [weak self] data in
            DispatchQueue.main.async {
                    LoadingPopup.shared.removeFromSuperview()
                    self?.viewModel?.createDetailsViewController(data: data as! SingleAnime)
                    self?.view.isUserInteractionEnabled = true
                    self?.searchBar.searchTextField.isUserInteractionEnabled = false
            }
        }
    }
    
    // Show Popup and send request for single Anime
    private func getSingleData() {
        LoadingPopup.shared.popupPresented = { [weak self]
            index in
            self?.viewModel?.singleAnimeData(index: index)
            self?.searchBar.searchTextField.isUserInteractionEnabled = false
        }
    }
}

extension AnimeViewController: UITableViewDelegate, UIWindowSceneDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.isUserInteractionEnabled = false
        let applicationDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        let selectedIndexCell = Int((self.animeTableView.animeDetails?[indexPath.row].id ) ?? "0")
        applicationDelegate.window!.rootViewController?.view.addSubview(LoadingPopup.shared.createLoadingPopup(view: self, index:  selectedIndexCell! - 1))
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let totalNumberOfCell = tableView.numberOfRows(inSection: 0)
        let lastDetectCell = indexPath.last
        // Check when create request and add new data to TableView
        if lastDetectCell ==  totalNumberOfCell - 3 {
            //send to model view information for request
            self.viewModel?.scrollAnimeData(offset: indexPath.last!)
            self.viewModel?.additionalDataAPI = { [weak self] addData in
                self?.animeTableView.appendData(newData: addData)
            }
        }else {
        }
    }
}

extension AnimeViewController: UIAlertViewDelegate {
    func showAlert(view: UIViewController){
        let alert = UIAlertController(title: nil,
                                      message: "Sorry, but no anime searched",
                                      preferredStyle: .alert)
        view.present(alert, animated: true, completion: {
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                view.dismiss(animated: true)
            }
        })
    }
}

extension AnimeViewController: UISearchBarDelegate {
    
    func  searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchBar.searchTextField.isUserInteractionEnabled = true
        self.searchBar.isUserInteractionEnabled = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let userText = searchBar.searchTextField.text
        else {
            return _ = " "
        }
        let convertedUserText = "&filter[text]=\(userText.convertUserText)"
        // send searchtext to vc
        viewModel?.searchAnime(convertedText: convertedUserText)
        searchBar.searchTextField.isUserInteractionEnabled = false
        print("Seartch Button Clicked: \(convertedUserText)")
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.isUserInteractionEnabled = false
        searchBar.searchTextField.isUserInteractionEnabled = false
        viewModel?.selectedSearchMemory = ""
        viewModel?.getDefaultAnime()
    }
}
extension String {
    // computed value
    var convertUserText: String {
        let trimSpace = self.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let removeSpace = trimSpace.replacingOccurrences(of: " ", with: "")
        return removeSpace
    }
}
