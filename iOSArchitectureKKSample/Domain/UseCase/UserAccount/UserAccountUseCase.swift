//
//  UserAccountUseCase.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/19.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol UserAccountUseCaseInputPort: PhotoSelectable, CollectionSelectable {
    func getAccount()
    func selectPhotos()
    func selectCollections()
    func selectLikes()
    func createCollection()
}

protocol UserAccountUseCaseOutputPort: CollectionTransitionable {
    func selectPhotos()
    func selectCollections()
    func selectLikes()
    func createCollection()
}

final class UserAccountUseCase: UserAccountUseCaseInputPort {
    let repository: AccountRepository
    
    init(repository: AccountRepository) {
        self.repository = repository
    }
    
    func getAccount() {
        <#code#>
    }
    
    func selectPhotos() {
        <#code#>
    }
    
    func selectCollections() {
        <#code#>
    }
    
    func selectLikes() {
        <#code#>
    }
    
    func createCollection() {
        <#code#>
    }
    
    func selectImage(id: String) {
        <#code#>
    }
    
    func selectCollection(id: String) {
        <#code#>
    }
    
    
}
