//
//  PlaylistsPresenter.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 28/07/22.
//

import Foundation
import MapKit

protocol PlaylistViewProtocol : AnyObject{
    func getPlaylists(playlistsList : [PlaylistModel.Item])
}

class PlaylistsPresenter{
    private weak var delegate : PlaylistViewProtocol?
    private var provider : PlaylistsProviderProtocol
    
    init(delegate : PlaylistViewProtocol, provider : PlaylistsProviderProtocol = PlaylistsProvider()){
        self.provider = provider
        self.delegate = delegate
        #if DEBUG
        if MockManager.shared.runAppwithMock{
            self.provider = PlaylistsProviderMock()
        }
        #endif
    }
    @MainActor
    func  getPlaylists() async{
        do{
            let playlists = try await provider.getPlaylists(channelId: Constants.channelId).items
            delegate?.getPlaylists(playlistsList: playlists)

        }catch{
            print(error.localizedDescription)
        }
    }
}
