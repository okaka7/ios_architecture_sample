//
//  AuthenticationPresenter.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/19.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol AuthenticationPresenter {
    func requestOpenAuthenticationURL()
}

protocol AuthenticationPresenterOutput {
    func openURL(url: URL)
}
