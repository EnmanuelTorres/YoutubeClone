//
//  PlayVideoProvider.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 8/08/22.
//

import Foundation

protocol PlayVideoProviderProtocol{
    func getVideo(_ videoId : String) async throws -> VideoModel
    func getRelatedVideos(_ relatedToVideoId : String) async throws -> VideoModel
    func getChannel(_ channelId : String) async throws -> ChannelModel

}


class PlayVideoProvider : PlayVideoProviderProtocol{
    func getVideo(_ videoId: String) async throws -> VideoModel {
        
        let quaryItems = ["id": videoId, "part": "snippet,contentDetails,status,statistics"]
        let request = RequestModel(endpoint: .videos, queryItems: quaryItems)
        do{
           let model = try await ServiceLayer.callService(request, VideoModel.self)
            debugPrint(model)
            return model
        }catch{
      
            throw error
        }
    }
    
    
    func getRelatedVideos(_ relatedToVideoId: String) async throws -> VideoModel {
        
        let quaryItems = ["relatedToVideoId" : relatedToVideoId, "part": "snippet", "maxResults": "50", "type": "video"]
        let request = RequestModel(endpoint: .search, queryItems: quaryItems)
        
        do {
            let model = try await ServiceLayer.callService(request, VideoModel.self)
            return model
        }catch{
           
            throw error
        }
    }
 
    func getChannel(_ channelId: String) async throws -> ChannelModel {
        
        let quaryItems = ["id" : channelId, "part": "snippet,statistics" ]
        let request = RequestModel(endpoint: .channels, queryItems: quaryItems)
        
        do{
            let model = try await ServiceLayer.callService(request, ChannelModel.self)
            return model
        }catch {
           
            throw error
        }
        
    }
    
}
