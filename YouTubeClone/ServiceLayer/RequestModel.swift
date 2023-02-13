//
//  RequestModel.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 2/07/22.
//

import Foundation

struct RequestModel {
    let endpoint : Endpoints
    var queryItems : [String:String]?
    let httpMethod : HttpMethod = .GET
    var baseUrl: URLBase = .youtube
    
     func getURL() -> String{
        return baseUrl.rawValue + endpoint.rawValue
     }
    
     enum HttpMethod : String{
        case GET
        case POST
     }
    
    enum Endpoints : String {
        case search = "/search"
        case empty = ""
        case channels = "/channels"
        case playlists = "/playlists"
        case playlistItems = "/playlistItems"
        case videos = "/videos"
     }

    enum URLBase : String{
       case youtube = "https://youtube.googleapis.com/youtube/v3"
       case google = "https://othereweb.com/v2"
    }
}
