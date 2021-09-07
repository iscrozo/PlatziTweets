//
//  TweetTableViewCell.swift
//  PlatziTweets
//
//  Created by Camilo Rozo on 6/09/21.
//

import UIKit
import Kingfisher

class TweetTableViewCell: UITableViewCell {
    
    // MARK: -IBOulets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCellWith(post: Post) {
        nameLabel.text = post.author.names
        nicknameLabel.text = post.author.nickname
        messageLabel.text = post.text
        if post.hasImage {
            // configurar imagen
            tweetImageView.kf.setImage(with: URL(string: post.imageUrl))
        } else {
            // desaparecer imagen
            tweetImageView.isHidden = true
        }
        dateLabel.text = post.createdAt
        
    }
}
