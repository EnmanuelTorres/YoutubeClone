//
//  HomeViewController.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 21/06/22.
//

import UIKit
import FloatingPanel

class HomeViewController: BaseViewController {
  
    @IBOutlet weak var tableViewHome: UITableView!
    lazy var presenter = HomePresenter(delegate: self)
    private var objectList : [[Any]] = []
    private var sectionTitleList : [String] = []
    var fpc : FloatingPanelController?
    var floatingPanelIsPresented : Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configFloaringPanel()
        
        Task{
            await presenter.getHomeObjcts()
        }
    }

    func configTableView(){
        let nibChannel = UINib(nibName: "\(ChannelCell.self)", bundle: nil)
        tableViewHome.register(nibChannel, forCellReuseIdentifier: "\(ChannelCell.self)")
        
        let nibVideo = UINib(nibName: "\(VideoCell.self)", bundle: nil)
        tableViewHome.register(nibVideo, forCellReuseIdentifier: "\(VideoCell.self)")
        
        let nibPlaylist = UINib(nibName: "\(PlaylistCell.self)", bundle: nil)
        tableViewHome.register(nibPlaylist, forCellReuseIdentifier: "\(PlaylistCell.self)")
        
        tableViewHome.register(SectionTitleView.self, forHeaderFooterViewReuseIdentifier: "\(SectionTitleView.self)")
                    
        
        tableViewHome.delegate = self
        tableViewHome.dataSource = self
        tableViewHome.separatorColor = .clear
        tableViewHome.contentInset = UIEdgeInsets(top: -15, left: 0, bottom: -80, right: 0)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pan = scrollView.panGestureRecognizer
        let velocity = pan.velocity(in: scrollView).y
        if velocity < -5 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else if velocity > 5 {
            navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }
}
extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectList[section].count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return objectList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = objectList[indexPath.section]
        if let channel = item as? [ChannelModel.Items] {
        let channelCell = tableView.dequeueReusableCell(for: ChannelCell.self, for: indexPath)
        channelCell.configCell(model: channel[indexPath.row])
        return channelCell
            
        } else if let playlistItems = item as? [PlaylistitemsModel.Item] {
           
            guard let playlistItemsCell = tableView.dequeueReusableCell(withIdentifier: "\(VideoCell.self)", for: indexPath) as? VideoCell else {
                return UITableViewCell()
                
            }
            playlistItemsCell.configCell(model: playlistItems[indexPath.row])
            playlistItemsCell.didTapDostsButton = { [weak self] in
                self?.configButtonSheet()
            }
            //recien agregado
            //playlistItemsCell.configCell(model: playlistItems[indexPath.row])
            return playlistItemsCell
        }else if let videos = item as? [VideoModel.Item] {
            
            guard let videoCell = tableView.dequeueReusableCell(withIdentifier: "\(VideoCell.self)", for: indexPath) as? VideoCell else {
                return UITableViewCell()
                
            }
            videoCell.didTapDostsButton = { [weak self] in
                self?.configButtonSheet()
            }
            // recien agregado
            videoCell.configCell(model: videos[indexPath.row])
            return videoCell
        }else if let playlist = item as? [PlaylistModel.Item] {
            
            guard let playlistCell = tableView.dequeueReusableCell(withIdentifier: "\(PlaylistCell.self)", for: indexPath) as? PlaylistCell else {
                return UITableViewCell()
                
            }
            playlistCell.configCell(model: playlist[indexPath.row])
            playlistCell.didTapDotsButton = {[weak self] in
                self?.configButtonSheet()
            }
            // recien agregado
           // playlistCell.configCell(model: playlist[indexPath.row])
            return playlistCell
        }
        
        return UITableViewCell()
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 || indexPath.section == 2{
            return 95.0
        }
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "\(SectionTitleView.self)") as? SectionTitleView else{
            return nil
        }
        sectionView.title.text = sectionTitleList[section]
        sectionView.configView()
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = objectList[indexPath.section]
        var videoId : String = ""
        
        if let playlisItem = item as? [PlaylistitemsModel.Item]{
            videoId.removeAll()
            videoId = playlisItem[indexPath.row].contentDetails?.videoID ?? ""
        } else if let videos = item as? [VideoModel.Item]{
            videoId.removeAll()
           videoId = videos[indexPath.row].id ?? ""
           
        }
        if floatingPanelIsPresented {
            fpc?.willMove(toParent: nil)
            fpc?.hide(animated: true, completion: {[weak self] in
                guard let self = self else {return}
                // Remove the floaring panel view from your controller's view.
                self.fpc?.view.removeFromSuperview()
                //Remove the floaring panel controller from the controller hierarchy.
                self.fpc?.removeFromParent()
                
                self.dismiss(animated: true,completion: {
                    self.presentViewPanel(videoId)
                })

            })
        }
        else {
            presentViewPanel(videoId)
        }

    }
    
    
    func configButtonSheet(){
        let vc = BottomSheetViewController()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    }

extension HomeViewController : HomeViewProtocol{
    func getData(list: [[Any]], sectionTitleList : [String]) {
        objectList = list
        self.sectionTitleList = sectionTitleList
        tableViewHome.reloadData()
    }
}

extension HomeViewController : FloatingPanelControllerDelegate {
   func presentViewPanel(_ videoID : String){
        let contentVC = PlayVideoViewController()
        contentVC.videoId = videoID
       
       
       contentVC.goingToBecollapsed = {[weak self] goingToBecollapsed in
           guard let self = self else {return}
           if goingToBecollapsed{
               self.fpc?.move(to: .tip, animated: true)
               NotificationCenter.default.post(name: .viewPosition, object: ["position": "bottom"])
               self.fpc?.surfaceView.contentPadding = .init(top: 0, left: 0, bottom: 0, right: 0)
           }else{
               self.fpc?.move(to: .full, animated: true)
               NotificationCenter.default.post(name: .viewPosition, object: ["position": "top"])
               self.fpc?.surfaceView.contentPadding = .init(top: -48, left: 0, bottom: -48, right: 0)
           }
       }
       
       contentVC.isClosedVideo = {[weak self] in
           self?.floatingPanelIsPresented = false
           
       }
       
        fpc?.set(contentViewController: contentVC)
       fpc?.track(scrollView: contentVC.tableViewVideos)
        if let fpc = fpc {
            floatingPanelIsPresented = true
            present(fpc, animated: true)
        }
       
    }
    func configFloaringPanel(){
        fpc = FloatingPanelController(delegate: self)
        fpc?.isRemovalInteractionEnabled = true
        fpc?.surfaceView.grabberHandle.isHidden = true
        fpc?.layout = MyFloatingPanelLayout()
        fpc?.surfaceView.contentPadding = .init(top: -48, left: 0, bottom: -48, right: 0)
    }

    
    func floatingPanelDidRemove (_ fpc : FloatingPanelController){
        self.floatingPanelIsPresented = false
    }
    
    func floatingPanelWillEndDragging(_ fpc: FloatingPanelController, withVelocity velocity: CGPoint, targetState: UnsafeMutablePointer<FloatingPanelState>) {
        if targetState.pointee != .full {
            NotificationCenter.default.post(name: .viewPosition, object: ["position": "bottom"])
            fpc.surfaceView.contentPadding = .init(top: 0, left: 0, bottom: 0, right: 0)
        }else{
            NotificationCenter.default.post(name: .viewPosition, object: ["position": "top"])
            fpc.surfaceView.contentPadding = .init(top: -48, left: 0, bottom: -48, right: 0)
        }
    }
}

extension NSNotification.Name{
    static let viewPosition = Notification.Name("viewPosition")
    static let expand = Notification.Name("expand")
}
    
    class MyFloatingPanelLayout: FloatingPanelLayout {
        let position: FloatingPanelPosition = .bottom
        let initialState: FloatingPanelState = .full
        var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
            return [
                .full: FloatingPanelLayoutAnchor(absoluteInset: 0.0, edge: .top, referenceGuide: .safeArea),
                .tip: FloatingPanelLayoutAnchor(absoluteInset: 60.0, edge: .bottom, referenceGuide: .safeArea),
            ]
        }
    }

