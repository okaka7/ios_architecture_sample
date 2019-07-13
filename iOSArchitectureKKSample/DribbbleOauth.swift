//
//  DribbbleOauth.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/12.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit

struct DribbbleOauth {
    
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
    
    
    @discardableResult
    func authenticate() -> Bool {
        guard let dribbbleOauthURL = self.authenticationURL else {
            return false
        }
        
        let successs: Bool = UIApplication.shared.openURLIfPossible(dribbbleOauthURL, options: [:]) { result in
            if result {
                self.saveState()
            }
        }
        return successs
    }
    
    func saveState() {
        localCache[.dribbbleState] = DribbbleState(stringLiteral: self.state)
    }
}
