//
//  VideosProviderMock.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 25/07/22.
//

import Foundation

class VideosProviderMock : VideosProviderProtocol{
    
        func getVideos(channelId: String) async throws -> VideoModel {
            guard let model = Utils.parseJson(jsonName: "VideoList", model: VideoModel.self) else{
                throw NetworkError.jsonDecoder
            }
            return model
        }
    
}
