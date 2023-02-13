//
//  HomeProviderMock.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 14/07/22.
//

import Foundation


class HomeProviderMock : HomeProviderProtocol{
    var throwError: Bool = false
    func getVideos(searchString: String, channelId: String) async throws -> VideoModel {
        if throwError {
            throw NetworkError.generic
        }
        guard let model = Utils.parseJson(jsonName: "SearchVideos", model: VideoModel.self) else{
            throw NetworkError.jsonDecoder
        }
        return model
    }
    
    func getChannel(channelId: String) async throws -> ChannelModel {
        guard let model = Utils.parseJson(jsonName: "Channel", model: ChannelModel.self) else{
            throw NetworkError.jsonDecoder
        }
        return model
    }
    
    func getPlaylists(channelId: String) async throws -> PlaylistModel {
        if throwError {
            throw NetworkError.generic
        }
        guard let model = Utils.parseJson(jsonName: "Playlists", model: PlaylistModel.self) else{
            throw NetworkError.jsonDecoder
            
          //Playlists
        }
        return model
    }
    
    func getPlaylistItems(playlistId: String) async throws -> PlaylistitemsModel {
        if throwError {
            throw NetworkError.generic
        }
        guard let model = Utils.parseJson(jsonName: "PlaylistItems", model: PlaylistitemsModel.self) else{
            throw NetworkError.jsonDecoder
        }
        return model
    }
    
    
}
