//
//  ChannelCell.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 19/07/22.
//

import UIKit
import Kingfisher

class ChannelCell: UITableViewCell {

    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var channelTitle: UILabel!
    @IBOutlet weak var bellImage: UIImageView!
    @IBOutlet weak var subscribeLabel: UILabel!
    @IBOutlet weak var subscribersNumbers: UILabel!
    @IBOutlet weak var channelInfo: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configView()
       
    }
    private func configView() {
        selectionStyle = .none
        bellImage.image = UIImage(named: "bell")?.withRenderingMode(.alwaysTemplate)
        bellImage.tintColor = UIColor (named: "grayColor")
        profileImage.layer.cornerRadius = 51/2
    }
    func configCell(model : ChannelModel.Items){
        channelInfo.text = model.snippet.description
        channelTitle.text = model.snippet.title
        subscribersNumbers.text = "\(model.statistics?.subscriberCount ?? "0") subscribers - \(model.statistics?.subscriberCount ?? "") videos"
        
        
        if let bannerURL = model.brandingSettings?.image.bannerExternalURL, let url = URL(string: bannerURL)  {
            bannerImage.kf.setImage(with: url)
        }
        let imageURL = model.snippet.thumbnails.medium.url
        guard let url = URL(string: imageURL) else {
            return
        }
        profileImage.kf.setImage(with: url)
    }
    
}
