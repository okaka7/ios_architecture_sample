//
//  UserAccountUseCase.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/19.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift

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
    let disposeBag: DisposeBag = .init()
    
    init(repository: AccountRepository) {
        self.repository = repository
    }
    
    func getAccount() {
        self.repository
            .fetchAccount()
            .subscribe(onSuccess: ,
                    onError: )
    }
    
    func selectPhotos() {
        
    }
    
    func selectCollections() {
        
    }
    
    func selectLikes() {
        
    }
    
    func createCollection() {
        
    }
    
    func selectImage(id: String) {
        
    }
    
    func selectCollection(id: String) {
    }
    
    
}
