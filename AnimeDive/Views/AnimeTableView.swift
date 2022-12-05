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
    var data: Anime?
    var imageApi: UIImage?
    
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
        self.data = data as? Anime
        self.reloadData()
    }
    
    func appendData (newData: Anime) {
        data?.data.append(contentsOf: newData.data)
        self.reloadData()
    }
}

extension AnimeTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: identifier,
                                            for: indexPath) as! TableViewCell
        cell.config(title: self.data?.data[indexPath.row].attributes.canonicalTitle ?? "Title missing",
                    numberOfSeason: data?.data[indexPath.row].attributes.episodeCount ?? 0,
                    imageUrl: URL(string: (data?.data[indexPath.row].attributes.posterImage.tiny)!)!)
        return cell
    }
}




