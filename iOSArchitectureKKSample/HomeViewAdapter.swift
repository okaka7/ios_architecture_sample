//
//  HomeViewAdapter.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/20.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//
import Foundation

protocol HomeViewInputPort {
    func fetchTopPhotos()
    func selectPhoto(_ photo: PhotoUIEntity)
    func switchPhoto(_ photo: PhotoUIEntity)
}

struct HomeViewAdapter: HomeViewInputPort {
    let useCase: HomeUseCaseInputPort
    
    init(useCase: HomeUseCaseInputPort) {
        self.useCase = useCase
    }
    
    func selectPhoto(_ photo: PhotoUIEntity) {
        
    }
    
    func switchPhoto(_ photo: PhotoUIEntity) {
        
    }
    
    func fetchTopPhotos() {
        
    }
}
