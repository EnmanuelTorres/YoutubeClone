//
//  VideoCell.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 19/07/22.
//

import UIKit

class VideoCell: UITableViewCell {

    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var videoName: UILabel!
    @IBOutlet weak var channelName: UILabel!
    @IBOutlet weak var viewsCountLabel: UILabel!
    @IBOutlet weak var dotsImage: UIImageView!
    
    @IBOutlet weak var dotsButton: UIButton!
    
    var didTapDostsButton : (()-> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }

    private func configView(){
        selectionStyle = .none
    }
    
    @IBAction func dotsButtonTapped(_ sender: Any) {
        if let tap = didTapDostsButton{
            tap()
        }
        
    }
    func configCell(model : Any){
        dotsImage.image = UIImage (named: "dots")?.withRenderingMode(.alwaysTemplate)
        dotsImage.tintColor = UIColor (named: "whiteColor")
        
        if let video = model as? VideoModel.Item {
            
            
           if let imageUrl = video.snippet?.thumbnails.medium?.url, let url = URL(string: imageUrl){
                videoImage.kf.setImage(with: url)
            }
            videoName.text = video.snippet?.title ?? ""
            channelName.text = video.snippet?.channelTitle ?? ""
            viewsCountLabel.text = "\(video.statistics?.viewCount ?? "0") views · 3 moths ago"
            
            
            
            
        } else if let playlistItem = model as? PlaylistitemsModel.Item{
            //Playlist items
            
            if let imageUrl = playlistItem.snippet.thumbnails.medium?.url, let url = URL(string: imageUrl){
                 videoImage.kf.setImage(with: url)
             }
             videoName.text = playlistItem.snippet.title
             channelName.text = playlistItem.snippet.channelTitle
             viewsCountLabel.text =  "33 views • 3 moths ago"
        }
        
    }
    
    
    
}
