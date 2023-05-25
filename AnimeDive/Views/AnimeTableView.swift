//
//  MainAnimeTableView.swift
//  AnimeDive
//
//  Created by Robert B on 05/10/2022.
//

import Foundation
import UIKit

class AnimeTableView: UITableView {
    
    private let identifier = "TableViewCell"
    
    var animeData: Anime?
    var imageApi: UIImage?
    var animeDetails: [AnimeData]?
    var tableViewStatus: ((Int) -> Void)?
    
    init() {
        super.init(frame: .zero, style: .plain)
        self.dataSource = self
        self.register(UINib(nibName: identifier,
                            bundle: nil),
                      forCellReuseIdentifier: identifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    func addData(data: Decodable){
        self.animeData = data as? Anime
        self.animeDetails = animeData?.data
        self.reloadData()
    }
    
    func appendData (newData: Decodable) {
        self.animeData = newData as? Anime
        self.animeDetails?.append(contentsOf: animeData!.data)
        self.reloadData()
    }
}

extension AnimeTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.animeDetails?.count == 0 {
            tableViewStatus?(self.animeDetails?.count ?? 0)
        }
        return self.animeDetails?.count ?? 0 
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: identifier,
                                            for: indexPath) as! TableViewCell
        cell.config(title: self.animeDetails?[indexPath.row].attributes.canonicalTitle ?? "Title missing",
                    numberOfSeason: self.animeDetails?[indexPath.row].attributes.episodeCount ?? 0,
                    imageUrl: URL(string: (self.animeDetails?[indexPath.row].attributes.posterImage.tiny)!)!)
        return cell
    }
}




