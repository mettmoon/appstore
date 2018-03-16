//
//  JSONStructure.swift
//  appStore
//
//  Created by Peter Moon on 15/03/2018.
//  Copyright © 2018 WEJOApps. All rights reserved.
//

import Foundation
struct Result: Codable {
    var feed:Feed
    private enum CodingKeys:String, CodingKey {
        case feed
    }
    static let endPoint = "https://itunes.apple.com/kr/rss/topfreeapplications/limit=50/genre=6015/json"

}
struct Feed: Codable {
    var entry:[AppListInfo]
    private enum CodingKeys:String, CodingKey {
        case entry
    }
}
struct Label: Codable {
    var text:String?
    var attributes:[String:String]?
    
    private enum CodingKeys:String, CodingKey {
        case text = "label"
        case attributes
    }
}
struct AppListInfo:Codable {
    var name:Label
    var image:[Label]
    var summary:Label?
    var price:Label
    var contentType:Label
    var rights:Label
    var title:Label
    var link:Label
    var id:Label
    var artist:Label
    var category:Label
    var releaseDate:Label
    
    private enum CodingKeys:String, CodingKey {
        case name = "im:name"
        case image = "im:image"
        case summary
        case price = "im:price"
        case contentType = "im:contentType"
        case rights
        case title
        case link
        case id
        case artist = "im:artist"
        case category
        case releaseDate = "im:releaseDate"
    }
    
}
