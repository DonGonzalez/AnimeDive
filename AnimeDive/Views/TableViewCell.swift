//
//  TableViewCell.swift
//  AnimeDive
//
//  Created by Robert B on 10/10/2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var animeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func config(title: String, numberOfSeason: Int, imageUrl: URL) {
        titleLabel.text = title
        seasonLabel.text = "Seasone: \(numberOfSeason)"
        self.contentView.backgroundColor = .systemGray5
        animeImage.downloaded(from: imageUrl)
    }
}
