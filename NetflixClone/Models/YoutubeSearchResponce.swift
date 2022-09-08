//
//  YoutubeSearchResponce.swift
//  NetflixClone
//
//  Created by Test on 08/09/22.
//

import Foundation

struct YoutubeSearchResponce: Codable {
    
    let items: [VideoElement]
}

struct VideoElement: Codable {
    
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    
    let kind: String
    let videoId: String
}
