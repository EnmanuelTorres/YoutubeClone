//
//  HomePresenter.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 2/07/22.
//

import Foundation

protocol HomeViewProtocol: AnyObject,BaseViewProtocol {
    func getData(list :[[Any]], sectionTitleList :[String])
}


@MainActor class HomePresenter{
    
    var provider: HomeProviderProtocol
    weak var delegate : HomeViewProtocol?
    private var objectList : [[Any]] = []
    private var sectionTitleList : [String] = []
    
    init (delegate : HomeViewProtocol, provider: HomeProviderProtocol = HomeProvider()){
       self.provider = provider
       self.delegate = delegate
        
        #if DEBUG
        if MockManager.shared.runAppwithMock{
        self.provider = HomeProviderMock()
        }
        #endif
        
        
    }
    
    
    func getHomeObjcts() async{
        objectList.removeAll()
        sectionTitleList.removeAll()
        delegate?.loadingView(.show)
        async let channel = try await provider.getChannel(channelId: Constants.channelId).items
        async let playlist = try await provider.getPlaylists(channelId: Constants.channelId).items
        async let videos = try  await provider.getVideos(searchString: "", channelId: Constants.channelId).items
        
        
        
        do{
            defer {
                delegate?.loadingView(.hide)
            }
            let (responseChannel, responsePlaylist, responseVideos) = await (try channel, try playlist, try videos)
            // Index 0
            objectList.append(responseChannel)
            sectionTitleList.append("")
              
            if let playlistId = responsePlaylist.first?.id, let playlistItems = await getPlaylistItems(playlistId: playlistId){
                // Index 1
                objectList.append(playlistItems.items.filter({$0.snippet.title != "Private video"}))
                sectionTitleList.append(responsePlaylist.first?.snippet.title ?? "0")
            }
            
            // Index 2
             objectList.append(responseVideos)
            sectionTitleList.append("Uploads")
            
            // Index 3
             objectList.append(responsePlaylist)
            sectionTitleList.append("Created Playlists")
            
            delegate?.getData(list: objectList, sectionTitleList: sectionTitleList)
            
        }catch {
            delegate?.showError(error.localizedDescription, callback: {
                Task{ [weak self] in
                    await self?.getHomeObjcts()
                }
            })
        }
    }
    
    func getPlaylistItems(playlistId: String) async -> PlaylistitemsModel?{
        do{
             let playlistItems = try await provider.getPlaylistItems(playlistId: playlistId)
            return playlistItems
        }catch{
            delegate?.showError(error.localizedDescription, callback: {
                Task{ [weak self] in
                    await self?.getHomeObjcts()
                }
            })
            return nil
        }
        
    }
}
