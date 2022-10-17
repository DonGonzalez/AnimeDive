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
    var data: Anime!
    var imageApi: UIImage?
    
    init(data: Anime) {
        super.init(frame: .zero, style: .plain)
        self.data = data
        self.delegate = self
        self.dataSource = self
        self.register(UINib(nibName: identifier,
                            bundle: nil),
                      forCellReuseIdentifier: identifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
}

extension AnimeTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension AnimeTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: identifier,
                                            for: indexPath) as! TableViewCell
        cell.config(title: self.data.data[indexPath.row].attributes.canonicalTitle,
                    numberOfSeason: data.data[indexPath.row].attributes.episodeCount,
                    imageUrl: URL(string: data.data[indexPath.row].attributes.posterImage.tiny)!)
        return cell
    }
}
