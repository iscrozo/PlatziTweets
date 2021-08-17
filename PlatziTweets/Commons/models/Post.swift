//
//  Post.swift
//  PlatziTweets
//
//  Created by Camilo Rozo on 16/08/21.
//

import Foundation

struct Post: Codable {
    let id: String
    let author: User
    let imageUrl: String
    let text: String
    let videoUrl: String
    let location: PostLocation
    let hasVideo: Bool
    let hasImage: Bool
    let hasLocation: Bool
    let createdAt: String
}
