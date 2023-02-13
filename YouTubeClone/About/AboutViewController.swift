//
//  AboutViewController.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 21/06/22.
//

import UIKit

class AboutViewController: UIViewController{
 
    
    @IBOutlet weak var infoLabel: UILabel!
    lazy var presenter = AboutPresenter(delegate: self)
    var channelList : [ChannelModel.Items] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await presenter.getChannel()
        }
       
    }
  
}
extension AboutViewController : AboutViewProtocol{
    func getChannel(ChannelList: [ChannelModel.Items]) {
       
        infoLabel.text = ChannelList.first?.snippet.description
    }

}
