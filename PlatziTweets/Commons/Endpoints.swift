//
//  Endpoints.swift
//  PlatziTweets
//
//  Created by Camilo Rozo on 16/08/21.
//

import Foundation 

struct Endpoints {
    static let domain = "https://platzi-tweets-backend.herokuapp.com/api/v1"
    static let login = Endpoints.domain + "/auth"
    static let register = Endpoints.domain + "/register"
    static let getPosts = Endpoints.domain + "/posts"
    static let post = Endpoints.domain + "/posts"
    static let delete = Endpoints.domain + "/posts/"
}
