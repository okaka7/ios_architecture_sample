//
//  AuthenticationClient.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/19.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol AuthenticationClient {
    func authenticate()
}


struct UnsplashAuthenticater: AuthenticationClient {
    private let clientID: String?
    private let redirectURL: String = {
        let scheme = R.string.localizable.appScheme()
        let host = R.string.localizable.appHost()
        let path = R.string.localizable.unsplashOauthCallBackPath()
        return "\(scheme)://\(host)\(path)"
    }()
    
    private let responseType = "code"
    
    private let scope: String = "public+read_user+read_photos+write_likes+write_followers+read_collections+write_collections"
    
    private let url: URL = {
        let baseURL: String = R.string.localizable.unsplashOauthBaseURL()
        let path: String = "/authorize"
        return URL(string: baseURL + path)!
    }()
    
    // private weak var authenticationView: UnsplashAuthenticationOutput?
    
    
    private var authenticationURL: URL? {
        guard var components = URLComponents(url: self.url, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        components.queryItems = {
            return [URLQueryItem(name: "client_id", value: clientID),
                    URLQueryItem(name: "redirect_uri", value: redirectURL),
                    URLQueryItem(name: "scope", value: scope),
                    URLQueryItem(name: "response_type", value: responseType)
            ]
        }()
        
        guard let url = components.url else {
            return nil
        }
        return url
    }
    
    //outputView: UnsplashAuthenticationOutput
    init() {
        let data = Bundle.main.infoDictionary!
        let unsplashAPIKeys = data["Unsplash API"] as? [String: String]
        self.clientID = unsplashAPIKeys?["Access Key"]
        // self.authenticationView = outputView
    }
    
    
    
    func authenticate(){
        guard let unsplashOauthURL = self.authenticationURL else {
            return
        }
        
        // self.authenticationView?.openAuthenticationURL(unsplashOauthURL)
    }
}
