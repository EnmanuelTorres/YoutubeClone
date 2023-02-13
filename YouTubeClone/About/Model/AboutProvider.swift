//
//  AboutProvider.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 26/01/23.
//

import Foundation

protocol AboutProviderProtocol{
    func getChanell(channelId : String) async throws -> ChannelModel
}
class AboutProvider : AboutProviderProtocol {
    func getChanell(channelId: String) async throws -> ChannelModel {
        
    let queryParams : [String:String] = ["id": channelId ,"part":"snippet,statistics"]
        
//        if !channelId.isEmpty{
//            queryParams["channelId"] = channelId
//            //queryParams["channels"] = channelId
//        }
        
        let requestModel = RequestModel(endpoint: .channels, queryItems: queryParams)
        do{
            let model = try await ServiceLayer.callService(requestModel, ChannelModel.self)
            return model
        }catch{
            print("Error: ", error)
            throw error
        }
    }
    
    
}
