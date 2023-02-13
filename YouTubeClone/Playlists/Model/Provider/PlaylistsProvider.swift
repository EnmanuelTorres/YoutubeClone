//
//  PlaylistsProvider.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 28/07/22.
//

import Foundation
protocol PlaylistsProviderProtocol{
    func getPlaylists(channelId : String) async throws -> PlaylistModel
}

class PlaylistsProvider :PlaylistsProviderProtocol {
    
    func getPlaylists(channelId: String) async throws -> PlaylistModel {
        
        let queryParams :[String:String] = ["part":"snippet,contentDetails", "channelId": channelId]
        
        
        let requestModel = RequestModel(endpoint: .playlists, queryItems: queryParams)
        
        
        do{
            let model = try await ServiceLayer.callService(requestModel, PlaylistModel.self)
            return model
        }catch{
            print(error)
            throw error
        }
    }
    
    
}
