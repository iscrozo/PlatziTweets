//
//  LoginRequest.swift
//  PlatziTweets
//
//  Created by Camilo Rozo on 16/08/21.
//

import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
}
