//
//  VideoHeaderCell.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 9/08/22.
//

import UIKit

class VideoHeaderCell: UITableViewCell {

    
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoStatistics: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var channelName: UILabel!
    @IBOutlet weak var subscriberCount: UILabel!
    @IBOutlet weak var subscriberLabel: UILabel!
    @IBOutlet weak var bellIcon: UIImageView!
    @IBOutlet weak var commentTitle: UILabel!
    @IBOutlet weak var commentProfileImage: UIImageView!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var seeAllCommentsButton: UIButton!
    @IBOutlet weak var buttonIconListView: ButtonsIconList!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    
    func configHorizontalButtons(_ videoModel : VideoModel.Item){
        let options = [
            VideoButtonIcon(title: videoModel.statistics?.likeCount ?? "-", icon: .like),
            VideoButtonIcon(title: "Dislike", icon: .dislike),
            VideoButtonIcon(title: "Share", icon: .share),
            VideoButtonIcon(title: "Download", icon: .download),
            VideoButtonIcon(title: "Save", icon: .save),
            VideoButtonIcon(title: "Airplay", icon: .airplay),
        ]
        buttonIconListView.buttonIconList = options
        buttonIconListView.delegate = self
        buttonIconListView.buildView()
        
    }
    
    func configCell(videoModel : VideoModel.Item, channelModel : ChannelModel.Items?){
       
        configHorizontalButtons(videoModel)
        
        commentConfig()
        
        videoTitle.text = videoModel.snippet?.title
      
        videoTitle.textColor = UIColor (named: "whiteColor")
        
        let viewCount = videoModel.statistics?.viewCount ?? "0"
        let viewPlural = (Int(viewCount)!) > 0 ? "views" : "view"
        var tags = ""
        if let tagsArray = videoModel.snippet?.tags?.enumerated().filter({$0.offset<3}).map({"#"+$0.element}){
            tags = tagsArray.joined(separator: " ")
        }
        let published = "2 weeks ago"//videoModel.snippet?.publishedDateFriendly ?? ""
        let wholeString = "\(viewCount) \(viewPlural) · \(published) \(tags)"
        
        videoStatistics.text = wholeString

        videoStatistics.textColor = UIColor (named: "grayColor")
        videoStatistics.highlight(searchedText: tags, color: .systemBlue)
                                  
        channelDetails(videoModel, channelModel)

    }
    private func channelDetails(_ videoModel : VideoModel.Item, _ channelModel : ChannelModel.Items?){
        channelName.text = videoModel.snippet?.channelTitle
        channelName.textColor = UIColor (named: "whiteColor")
        
        subscriberLabel.text = "SUBSCRIBED"
        subscriberLabel.textColor = UIColor (named: "grayColor")
        
        bellIcon.image = UIImage(named: "bell")?.withRenderingMode(.alwaysTemplate)
        bellIcon.tintColor = UIColor (named: "grayColor")
        
        subscriberCount.text = "\(channelModel?.statistics?.subscriberCount ?? "") subscribers"
        subscriberCount.textColor = UIColor (named: "grayColor")
        
        guard let imageUrl = channelModel?.snippet.thumbnails.medium.url, let url = URL(string: imageUrl) else{ return }
        profileImage.kf.setImage(with: url)
        profileImage.layer.cornerRadius = 20.0
    }
    
    private func commentConfig(){
        let randomInt = Int.random(in: 100..<1000)
        commentTitle.text = "Comments \(randomInt)"
        //commentProfileImage.image = UIImage.personc
        commentProfileImage.tintColor = UIColor (named: "whiteColor")
        comment.text = "Excelente información. Gracias."
    }
    
    
}

extension VideoHeaderCell : ButtonIconListProtocol{
    func didSelectOption(tag: Int) {
        print("Tag selected: \(tag)")
    }
    
    
}
