//
//  VideosProvider.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 25/07/22.
//

import Foundation

protocol VideosProviderProtocol{
    func getVideos(channelId : String) async throws -> VideoModel
}


class VideosProvider : VideosProviderProtocol{
    func getVideos(channelId: String) async throws -> VideoModel {
        var queryParams :[String:String] = ["part":"snippet", "type": "video", "maxResults" : "50"]
        
        if !channelId.isEmpty{
            queryParams["channelId"] = channelId
            //queryParams["channels"] = channelId
        }
        
        
        let requestModel = RequestModel(endpoint: .search, queryItems: queryParams)
        
        
        do{
            let model = try await ServiceLayer.callService(requestModel, VideoModel.self)
            return model
        }catch{
            print(error)
            throw error
        }
    }
    
    
}
