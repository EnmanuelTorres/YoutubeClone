//
//  PlaylistCell.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 19/07/22.
//

import UIKit

class PlaylistCell: UITableViewCell {

    
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoCountOverlay: UILabel!
    @IBOutlet weak var videoCount: UILabel!
    @IBOutlet weak var dotsImage: UIImageView!
    
    var didTapDotsButton : (()-> Void)?
    
    override func awakeFromNib() {
//super.awakeFromNib()
        configView()
    }
    
    
    private func configView(){
        selectionStyle = .none
        dotsImage.image = UIImage (named: "dots")?.withRenderingMode(.alwaysTemplate)
        dotsImage.tintColor = UIColor (named: "whiteColor")
    }
    
    @IBAction func dotsButtonTapped(_ sender: Any) {
        
        if let tap = didTapDotsButton {
            tap()
        }
        
    }
    
    
    
    
    func configCell(model: PlaylistModel.Item){
        
        videoTitle.text = model.snippet.title
        videoCount.text = String (model.contentDetails.itemCount)+" videos"
        videoCountOverlay.text = String(model.contentDetails.itemCount)
        
        
        let imageUrl = model.snippet.thumbnails.medium.url
        
        if let url = URL(string: imageUrl){
            videoImage.kf.setImage(with: url)
        }
    }
}
