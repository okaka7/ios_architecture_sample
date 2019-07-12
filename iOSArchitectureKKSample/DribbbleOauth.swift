//
//  DribbbleOauth.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/12.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

struct DribbbleOauth {
    
    private let clientID: String
    private let redirectURL: String
    private let scope: String
    private let state: String
    
    private let baseURL: String = R.string.localizable.dribbbleOauthBaseURL()
    private let path: String = "/authorize"
    private var url: URL { return URL(string: baseURL + path)! }
    
    private var queryItems: [URLQueryItem] {
        return [URLQueryItem(name: "client_id", value: clientID),
                URLQueryItem(name: "redirect_uri", value: redirectURL),
                URLQueryItem(name: "scope", value: scope),
                URLQueryItem(name: "state", value: state)
        ]
    }
    
    var authenticationURL: URL? {
        guard var components = URLComponents(url: self.url, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        components.queryItems = self.queryItems
        
        guard let url = components.url else {
            return nil
        }
        return url
    }
    
    init(clientID: String = R.string.localizable.dribbbleAPIClientID(),
         redirectURL: String = R.string.localizable.appURLScheme(),
         scope: String = "public",
         state: String = UUID().uuidString) {
        self.clientID = clientID
        self.redirectURL = redirectURL
        self.scope = scope
        self.state = state
    }
}
