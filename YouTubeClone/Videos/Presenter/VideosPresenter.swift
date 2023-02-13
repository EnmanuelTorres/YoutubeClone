//
//  VideoPresenter.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 25/07/22.
//

import Foundation

protocol VideosViewProtocol : AnyObject{
    func getVideos(videoList : [VideoModel.Item])
}


@MainActor class VideosPresenter{
    private weak var delegate : VideosViewProtocol?
    private var provider : VideosProviderProtocol
    
    init(delegate : VideosViewProtocol, provider : VideosProviderProtocol = VideosProvider()){
        self.provider = provider
        self.delegate = delegate
        #if DEBUG
        if MockManager.shared.runAppwithMock{
            self.provider = VideosProviderMock()
        }
        #endif
    }
    
    
    func getVideos() async{
        
        do{
            let videos = try await provider.getVideos(channelId: Constants.channelId).items
            delegate?.getVideos(videoList: videos)
            
        }catch {
            debugPrint(error.localizedDescription)
        }
        
        
    }
    
}
