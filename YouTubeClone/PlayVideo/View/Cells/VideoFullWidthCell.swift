//
//  VideoFullWidthCell.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 9/08/22.
//

import UIKit

class VideoFullWidthCell: UITableViewCell {

    
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var videoTittle: UILabel!
    @IBOutlet weak var statistics: UILabel!
    @IBOutlet weak var imageProfile: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell (model : VideoModel.Item, channelModel : ChannelModel.Items?){
        
        videoTittle.text = model.snippet?.title
        videoTittle.textColor = UIColor (named: "whiteColor")
        
        imageProfile.layer.cornerRadius = 40/2
        
        if let ImageProfil = model.snippet?.thumbnails.medium?.url, let url = URL(string: ImageProfil){
            imageProfile.kf.setImage(with: url)
        }
     
        
        let channelTitle = model.snippet?.channelTitle ?? ""
        //let pusblished = model.snippet?.publishedDateFriendly ?? ""
        let randInt = Int.random(in: 200..<999)
        
        statistics.text = "\(channelTitle) · \(randInt) views · 3 days ago"
        
        
        guard let imageUrl = model.snippet?.thumbnails.medium?.url, let url = URL(string: imageUrl) else{
            videoImage.image = UIImage(named: "maxresdefault")
            return
        }
        
        videoImage.kf.setImage(with: url)
    }
    
}
