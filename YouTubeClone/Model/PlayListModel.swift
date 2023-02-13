//
//  PlayListModel.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 9/06/22.
//

import Foundation

struct PlaylistModel: Decodable {
    let kind : String
    let etag : String
    let nextPageToken : String
    let pageInfo: PageInfo
    let items: [Item]
    
    struct PageInfo : Decodable{
        let totalResults: Int
        let resultsPerPage: Int
    }
    
    struct Item : Decodable{
        let kind : String
        let etag : String
        let id : String
        let snippet : Snippet
        let contentDetails : ContentDetails
        
        
        struct Snippet : Decodable {
            let publishedAt : String
            let channelId :String
            let title : String
            let description : String
            let thumbnails : Thumbnails
            let channelTitle : String
            let localized : Localized
            
            struct Thumbnails : Decodable {
                let medium : Medium
                
                struct Medium : Decodable {
                    let url : String
                    let width : Int
                    let height : Int
                    
                    
                    
                }
                
            }
            struct Localized : Decodable {
                let title : String
                let description: String
            }
        } //Snippet
     
        struct ContentDetails: Decodable{
        let itemCount : Int
        }
    } //items
}
