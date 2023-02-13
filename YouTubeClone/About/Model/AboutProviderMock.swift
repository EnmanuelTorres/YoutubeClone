//
//  AboutProviderMock.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 26/01/23.
//

import Foundation

class AboutProviderMock : AboutProviderProtocol {
    func getChanell(channelId: String) async throws -> ChannelModel {
        guard let model = Utils.parseJson(jsonName: "Channel", model: ChannelModel.self) else{
            throw NetworkError.jsonDecoder
        }
        return model
    }
    
    
}
