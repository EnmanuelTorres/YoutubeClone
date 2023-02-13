//
//  ChannelModel.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 21/06/22.
//

import Foundation

// MARK: - ChannelModel
struct ChannelModel: Codable {
    let kind: String
    let etag: String
    let pageInfo: PageInfo
    let items: [Items]
    
    // MARK: - Items
    struct Items: Codable {
        let kind, etag, id: String
        let snippet: Snippet
        let statistics: Statistics?
        let brandingSettings: BrandingSettings?
        
        
        // MARK: - BrandingSettings
        struct BrandingSettings: Codable {
            let channel: Channel
            let image: Image
            
         
            // MARK: - Channel
            struct Channel: Codable {
                let title, channelDescription, keywords, defaultLanguage: String
                let country: String

                enum CodingKeys: String, CodingKey {
                    case title
                    case channelDescription = "description"
                    case keywords, defaultLanguage, country
                }
            }
           
            // MARK: - Image
            struct Image: Codable {
                let bannerExternalURL: String

                enum CodingKeys: String, CodingKey {
                    case bannerExternalURL = "bannerExternalUrl"
                }
            }
            
        }
        // MARK: - Snippet
        struct Snippet: Codable {
            let title, description, customURL, publishedAt: String
            let thumbnails: Thumbnails
            let defaultLanguage: String
            let localized: Localized
            let country: String

            enum CodingKeys: String, CodingKey {
                case title
                case description
                case customURL = "customUrl"
                case publishedAt, thumbnails, defaultLanguage, localized, country
            }
            
            // MARK: - Localized
            struct Localized: Codable {
                let title, localizedDescription: String

                enum CodingKeys: String, CodingKey {
                    case title
                    case localizedDescription = "description"
                }
            }
            
            
            // MARK: - Thumbnails
            struct Thumbnails: Codable {
               let thumbnailsDefault: Default
                let medium : Default
                let high : Default

                enum CodingKeys: String, CodingKey {
                    case thumbnailsDefault = "default"
                    case medium, high
                }
                
                // MARK: - Default
                struct Default: Codable {
                    let url: String
                    let width, height: Int
                }
                
                
            }
            
            
            
        }

        // MARK: - Statistics
        struct Statistics: Codable {
            let viewCount, subscriberCount: String
            let hiddenSubscriberCount: Bool
            let videoCount: String
        }
        
        
        
    }
    
    
    // MARK: - PageInfo
    struct PageInfo: Codable {
        let totalResults, resultsPerPage: Int
    }
    
}









