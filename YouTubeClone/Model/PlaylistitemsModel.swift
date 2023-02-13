//
//  PlaylistItemsModel.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 21/06/22.
//

import Foundation

// MARK: - PlaylistitemsModel
struct PlaylistitemsModel: Decodable {
    let kind, etag: String
    let items: [Item]
    let pageInfo: PageInfo
    
    // MARK: - Item
    struct Item: Decodable {
        let kind, etag, id: String
        //let snippet: VideoModel.Item.Snippet
        let snippet: Snippet
        let contentDetails: ContentDetails?
        
        // MARK: - ContentDetails
        struct ContentDetails: Decodable {
            let videoID: String?
            let videoPublishedAt: String?

            enum CodingKeys: String, CodingKey {
                case videoID = "videoId"
                case videoPublishedAt
            }
            
            
            
            
            
        }
        
        // MARK: - Snippet
        struct Snippet: Decodable {
            let publishedAt: String
            let channelId, title, description: String
            let thumbnails: Thumbnails
            let channelTitle, playlistID: String
            let position: Int
            let resourceID: ResourceID
            let videoOwnerChannelTitle, videoOwnerChannelID: String

            enum CodingKeys: String, CodingKey {
                            case publishedAt
                            case channelId
                            case title
                            case description
                            case thumbnails, channelTitle
                            case playlistID = "playlistId"
                            case position
                            case resourceID = "resourceId"
                            case videoOwnerChannelTitle
                            case videoOwnerChannelID = "videoOwnerChannelId"
                        }
            
            
            
            // MARK: - ResourceID
            struct ResourceID: Decodable {
                let kind, videoID: String

                enum CodingKeys: String, CodingKey {
                    case kind
                    case videoID = "videoId"
                }
            }
            
            // MARK: - Thumbnails
            struct Thumbnails: Decodable {
                let thumbnailsDefault, medium, high: Default?
                let standard, maxres: Default?

                enum CodingKeys: String, CodingKey {
                    case thumbnailsDefault = "default"
                    case medium, high, standard, maxres
                }
                
                
                // MARK: - Default
                struct Default: Decodable {
     
               let url: String
                    let width, height: Int
                }
                
                
            }
            
            
        }
        
    }
    
    // MARK: - PageInfo
    struct PageInfo: Decodable {
        let totalResults, resultsPerPage: Int
    }
}







