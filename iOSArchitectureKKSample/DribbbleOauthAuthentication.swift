//
//  DribbbleOauth.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/12.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit

protocol DribbbleAuthentication {
    func authenticate()
}

protocol DribbbleAuthenticationOutputView: class {
    func openAuthenticationURL(_ url: URL, completionHandler completion: @escaping (Bool)->())
}

struct DribbbleOauthAuthentication: DribbbleAuthentication {
    
    private let clientID: String = R.string.localizable.dribbbleAPIClientID()
    private let redirectURL: String = {
        let scheme = R.string.localizable.appScheme()
        let host = R.string.localizable.appHost()
        let path = R.string.localizable.dribbbleOauthCallBackPath()
        return "\(scheme)://\(host)\(path)"
    }()
    private let scope: String = "public"
    private let state: String = UUID().uuidString
    
    private let url: URL = {
        let baseURL: String = R.string.localizable.dribbbleOauthBaseURL()
        let path: String = "/authorize"
        return URL(string: baseURL + path)!
    }()
    
    private let localCache = LocalCache.shared
    private weak var authenticationView: DribbbleAuthenticationOutputView?
    
    private var authenticationURL: URL? {
        guard var components = URLComponents(url: self.url, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        components.queryItems = {
            return [URLQueryItem(name: "client_id", value: clientID),
                    URLQueryItem(name: "redirect_uri", value: redirectURL),
                    URLQueryItem(name: "scope", value: scope),
                    URLQueryItem(name: "state", value: state)
            ]
        }()
        
        guard let url = components.url else {
            return nil
        }
        return url
    }
    
    init(outputView: DribbbleAuthenticationOutputView) {
        self.authenticationView = outputView
    }
    
    func authenticate() {
        guard let dribbbleOauthURL = self.authenticationURL else {
            return
        }
        
        self.authenticationView?.openAuthenticationURL( dribbbleOauthURL, completionHandler: { success in
            if success {
                self.saveState()
            }
        })
      
    }
    
    private func saveState() {
        localCache[.dribbbleState] = DribbbleState(stringLiteral: self.state)
    }
}
