//
//  PostRequest.swift
//  PlatziTweets
//
//  Created by Camilo Rozo on 16/08/21.
//

import Foundation

struct PostRequest: Codable {
    let text: String
    let imageUrl: String?
    let videoUrl: String?
    let location: PostRequestLocation?
}
