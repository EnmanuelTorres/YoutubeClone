//
//  PlaylistsViewController.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 21/06/22.
//

import UIKit

class PlaylistsViewController: UIViewController {

    @IBOutlet weak var tableViewPlaylists: UITableView!
    lazy var  presenter = PlaylistsPresenter(delegate: self)
    var playlistsList : [PlaylistModel.Item] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        
        Task {
            await presenter.getPlaylists()
        }

    }


    func configTableView(){
        
        let nibPlaylists = UINib(nibName: "\(PlaylistCell.self)", bundle: nil)
        tableViewPlaylists.register(nibPlaylists, forCellReuseIdentifier: "\(PlaylistCell.self)")
        
        tableViewPlaylists.separatorColor = .clear
        tableViewPlaylists.delegate = self
        tableViewPlaylists.dataSource = self
    }
    

}
extension PlaylistsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playlistsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let playlist = playlistsList [indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(PlaylistCell.self)", for: indexPath) as? PlaylistCell else {
            return UITableViewCell()
        }
        
        cell.didTapDotsButton = {[weak self] in
               self?.configButtonSheet()
        }
        
        cell.configCell(model: playlist)
        return cell
        }
    
    
    func configButtonSheet(){
        let vc = BottomSheetViewController()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
}

extension PlaylistsViewController : PlaylistViewProtocol {
    func getPlaylists(playlistsList: [PlaylistModel.Item]) {
        self.playlistsList = playlistsList
        tableViewPlaylists.reloadData()
    }
    
    
}
