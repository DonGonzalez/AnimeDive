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
    var animationEnd = false
    let animeTableView = AnimeTableView()
    let delegate: ModalViewControllerOptionDelegate? = nil
    var infinitiveScroll: Bool?
    let searchBar = UISearchBar()
    var searchText: String?
    var sortDataToSend: [ModalViewController.SortType] = []
    var filterDataToSend: ModalViewController.FilterType = .emptyEnum
    // Data from ModelVC
    var selectedFilterMemory = ""
    var selectedSortMemory = ""
    var selectedSearchMemory = ""
    
    func assignDependencies(viewModel: AnimeViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.viewModel?.getDataFromBeckend(element: 0, sort: selectedSortMemory, filter: selectedFilterMemory, search: selectedSearchMemory)
        self.tableViewConfigure()
        self.pushInVC()
        self.getSingleData()
        self.createNavigationBarButtons()
        self.sendSeartchText()
        self.configureSearchBar()
        self.createAnimeTableView()
        self.sortValue()
        self.filterValue()
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
    // Function/ clause init when user use searchBar
    private func sendSeartchText() {
        self.viewModel?.searchDataAPI = { [weak self]
            searchData in
            self?.animeTableView.addData(data: searchData)
            self?.infinitiveScroll = false
            let data = searchData as! Anime
            if data.data.count == 0 {
                let alert = UIAlertController(title: nil,
                                              message: "Sorry, but no anime searched",
                                              preferredStyle: .alert)
                self?.present(alert, animated: true, completion: {
                    Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                        self?.dismiss(animated: true)
                    }
                })
            }
        }
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
            self?.animeTableView.addData(data: dataAPI)
            self?.infinitiveScroll = true
            
        }
    }
    // Push VC when program recieve data for single Anime
    private func pushInVC() {
        self.viewModel?.singleDataAPI = { data in
            DispatchQueue.main.async {
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                    LoadingPopup.shared.removeFromSuperview()
                    AnimeDetailsViewModel.pushIn(navigator: self.viewModel!.navigator, data: data as! SingleAnime)
                    self.view.isUserInteractionEnabled = true
                    self.searchBar.searchTextField.isUserInteractionEnabled = false
                }
            }
        }
    }
    // Prepare endpoint and create request when close ModalVC
    private func sortValue() {
        self.viewModel?.sortValue = { [weak self]
            value in
            self?.sortDataToSend = value
            var sortContener: [String] = []
            var i = 0
            while i <= value.count - 1 {
                sortContener.append(value[i].sortValue)
                i += 1
            }
            if sortContener != []{
                self?.selectedSortMemory = ("/users?sort=\(sortContener.joined(separator: ","))")
            } else {
                self?.selectedSortMemory = sortContener.joined(separator: ",")
            }
            self?.viewModel?.getDataFromBeckend(element: 0, sort: self?.selectedSortMemory ?? "", filter: self?.selectedFilterMemory ?? "", search: self?.selectedSearchMemory ?? "")
        }
    }
    // Prepare endpoint and create request when close ModalVC
    private func filterValue(){
        self.viewModel?.filterValue = { [weak self]
            value in
            self?.filterDataToSend = value
            self?.selectedFilterMemory = value.filterValue
            self?.viewModel?.getDataFromBeckend(element: 0, sort: self?.selectedSortMemory ?? "", filter: self?.selectedFilterMemory ?? "", search: self?.selectedSearchMemory ?? "")
        }
    }
    // Show Popup and send request for single Anime
    private func getSingleData() {
        LoadingPopup.shared.popupPresented = { [weak self]
            index in
            // to change not index mus be id from API
            self?.viewModel?.getSingleData(index: index)
            self?.searchBar.searchTextField.isUserInteractionEnabled = false
        }
    }
}

extension AnimeViewController: UITableViewDelegate, UIWindowSceneDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.isUserInteractionEnabled = false
        let applicationDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        let selectedIndexCell = Int((self.animeTableView.data?.data[indexPath.row].id)!) ?? 0
        applicationDelegate.window!.rootViewController?.view.addSubview(LoadingPopup.shared.createLoadingPopup(view: self, index:  selectedIndexCell - 1))
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if self.infinitiveScroll == true {
            let totalNumberOfCell = tableView.numberOfRows(inSection: 0)
            let lastDetectCell = indexPath.last
            // Check when create request and add new data to TableView
            if lastDetectCell ==  totalNumberOfCell - 3 {
                //send to model view information for request
                DispatchQueue.main.async {
                    self.viewModel?.getAdditionalDataFromBeckend(offset: totalNumberOfCell,sort: self.selectedSortMemory,filter: self.selectedFilterMemory,search: self.selectedSearchMemory)
                    self.viewModel?.moreDataAPI = { [weak self]
                        newInfo in
                        self?.animeTableView.appendData(newData: newInfo as! Anime)
                    }
                }
            }
        } else {
            print("scroll deactivated")
        }
    }
}

extension AnimeViewController: UISearchBarDelegate {
    
    func  searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchBar.searchTextField.isUserInteractionEnabled = true
        self.searchBar.isUserInteractionEnabled = true
    }
    
    func convertUserText(text: String) -> String {
        let trimSpace = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let removeSpace = trimSpace.replacingOccurrences(of: " ", with: "")
        return removeSpace
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let userText = searchBar.searchTextField.text
        else {
            return _ = " "
        }
        let convertetUserText = "/anime?filter[text]=\(self.convertUserText(text: userText))"
        self.selectedSearchMemory = convertetUserText
        print(convertetUserText)
        print(convertetUserText.count)
        if (0...3).contains(convertetUserText.count) {
            // standard request
            self.viewModel?.getDataFromBeckend(element: 0, sort: selectedSortMemory,filter: selectedFilterMemory, search: selectedSearchMemory)
        } else {
            // search request
            self.viewModel?.getSeartchedDataFromBeckend(seartchText: convertetUserText, sort: selectedSortMemory, filter: selectedFilterMemory)
        }
        searchBar.searchTextField.isUserInteractionEnabled = false
        print("Seartch Button Clicked: \(convertetUserText)")
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.isUserInteractionEnabled = false
        searchBar.searchTextField.isUserInteractionEnabled = false
        viewModel?.getDataFromBeckend(element: 0, sort: selectedSortMemory, filter: selectedFilterMemory, search: selectedSearchMemory)
    }
}
