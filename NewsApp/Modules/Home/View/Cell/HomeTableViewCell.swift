//
//  HomeTableViewCell.swift
//  NewsApp
//
//  Created by Adam on 09/05/2023.
//

import UIKit
import SDWebImage

class HomeTableViewCell: UITableViewCell {

    //MARK: - Outlet Connections
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleDescriptionLabel: UILabel!
    
    /*=========================================*/
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 15, bottom: 20, right: 15))
    }
    
/*=========================================*/
    //MARK: - Services Functions
    ///This function responsible for set the data to cell components
    func configure(article: Article) {
        dateLabel.text = String(describing: article.publishedAt) 
        articleTitleLabel.text = article.title
        articleDescriptionLabel.text = article.description
        let url = article.urlToImage ?? "apple"
        switch url {
        case "apple":
            articleImageView.image = UIImage(named: url)
        default:
            let imageUrl = URL(string: url)
            articleImageView.sd_setImage(with: imageUrl, completed: nil)
        }
    }
    
    ///This function responsible for every thing related with UI
    func updateUi() {
        self.contentView.layer.cornerRadius = 8
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.15)
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = true
        articleImageView.layer.cornerRadius = 8
    }
}
