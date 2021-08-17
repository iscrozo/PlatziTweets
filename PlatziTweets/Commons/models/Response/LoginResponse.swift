//
//  LoginResponse.swift
//  PlatziTweets
//
//  Created by Camilo Rozo on 16/08/21.
//

import Foundation

struct LoginResponse: Codable {
    let user: User
    let token: String
}
